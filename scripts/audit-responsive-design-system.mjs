// Read-only responsive design-system audit. Navigates, inspects, screenshots only.
// Usage: npx -p playwright node scripts/audit-responsive-design-system.mjs --base-url http://localhost/academy --theme light
import { mkdirSync, writeFileSync } from 'node:fs';
import { createRequire } from 'node:module';
import { routes, viewports, themes } from './responsive-route-manifest.mjs';

const args = process.argv.slice(2);
const opt = (k, d) => { const i = args.indexOf(`--${k}`); return i >= 0 ? args[i + 1] : d; };
const baseUrl = opt('base-url', 'http://localhost/academy').replace(/\/$/, '');
const themeArg = opt('theme', 'both');
const onlyRoute = opt('route', null);
const outDir = 'tmp/responsive-audit';

// Under `npx -p playwright`, the package's .bin dir is on PATH; resolve the module from there.
async function loadChromium() {
  const { execSync } = await import('node:child_process');
  const { dirname, join } = await import('node:path');
  const req = createRequire(import.meta.url);
  try { return req('playwright').chromium; } catch {}
  const cmd = process.platform === 'win32' ? 'where playwright' : 'which playwright';
  const bin = execSync(cmd, { encoding: 'utf8' }).split(/\r?\n/)[0].trim();
  return req(join(dirname(bin), '..', 'playwright')).chromium;
}
const chromium = await loadChromium();

mkdirSync(outDir, { recursive: true });
const runThemes = themeArg === 'both' ? themes : [themeArg];
const rows = [];
const browser = await chromium.launch();

for (const theme of runThemes) {
  for (const route of routes.filter((r) => !onlyRoute || r.name === onlyRoute)) {
    if (route.role !== 'public') {
      rows.push({ route: route.name, role: route.role, theme, status: 'blocked', failures: ['manual authenticated check required'] });
      continue;
    }
    for (const vp of viewports) {
      const context = await browser.newContext({ viewport: { width: vp.width, height: vp.height } });
      await context.addInitScript((t) => { try { localStorage.setItem('gp-ds-theme', t); } catch {} }, theme);
      const page = await context.newPage();
      const row = { route: route.name, url: baseUrl + route.path, role: route.role, theme, viewport: vp.name, width: vp.width, wrapper: route.wrapper, stylesheet: route.stylesheet, failures: [] };
      try {
        const resp = await page.goto(baseUrl + route.path, { waitUntil: 'networkidle', timeout: 30000 });
        row.httpStatus = resp ? resp.status() : null;
        const m = await page.evaluate((sel) => {
          const de = document.documentElement;
          const offenders = [];
          if (de.scrollWidth > window.innerWidth) {
            for (const el of document.body.querySelectorAll('*')) {
              const r = el.getBoundingClientRect();
              if (r.width > 0 && r.right > window.innerWidth + 1) {
                offenders.push((el.tagName.toLowerCase() + (el.id ? '#' + el.id : '') + (typeof el.className === 'string' && el.className ? '.' + el.className.trim().split(/\s+/).slice(0, 3).join('.') : '')) + ' right=' + Math.round(r.right));
                if (offenders.length >= 8) break;
              }
            }
          }
          return {
            dsClass: document.body.classList.contains('gp-ds') || de.classList.contains('gp-ds'),
            wrapperFound: !!document.querySelector(sel),
            scrollWidth: de.scrollWidth,
            innerWidth: window.innerWidth,
            theme: de.getAttribute('data-theme'),
            title: document.title,
            offenders,
          };
        }, route.wrapper);
        Object.assign(row, m);
        if (!m.dsClass) row.failures.push('gp-ds class absent');
        if (!m.wrapperFound) row.failures.push(`wrapper ${route.wrapper} missing`);
        if (m.scrollWidth > m.innerWidth) row.failures.push(`page overflow ${m.scrollWidth}>${m.innerWidth}`);
        if (m.theme !== theme) row.failures.push(`theme mismatch (${m.theme})`);
        const shot = `${outDir}/${route.name}-${theme}-${vp.width}.png`;
        await page.screenshot({ path: shot, fullPage: false });
        row.screenshot = shot;
      } catch (e) {
        row.failures.push('error: ' + e.message.split('\n')[0]);
      }
      row.status = row.failures.length ? 'fail' : 'pass';
      rows.push(row);
      await context.close();
    }
  }
}
await browser.close();

const file = `${outDir}/results-${themeArg}.json`;
writeFileSync(file, JSON.stringify(rows, null, 2));
const bad = rows.filter((r) => r.status !== 'pass');
console.log(`${rows.length} rows, ${bad.length} not passing -> ${file}`);
for (const r of bad) console.log(`${r.status.toUpperCase()} ${r.route} ${r.theme} ${r.width ?? ''}: ${r.failures.join('; ')}${r.offenders?.length ? ' | ' + r.offenders.slice(0, 3).join(', ') : ''}`);
