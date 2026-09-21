// Read-only evidence for the selector-retirement decision (Phase 7). Deletes nothing.
// For each rule in the four legacy frontend stylesheets, records whether its selector matches at least one
// element on any audited public route. "Unmatched" means unmatched on the audited routes only - never proof
// that the rule is dead (student, payment, lesson, add-on and print/email surfaces are not audited).
// Usage: npx -p playwright node scripts/legacy-css-usage.mjs --base-url http://localhost/academy
import { mkdirSync, writeFileSync } from 'node:fs';
import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
import { routes } from './responsive-route-manifest.mjs';

const args = process.argv.slice(2);
const opt = (k, d) => { const i = args.indexOf(`--${k}`); return i >= 0 ? args[i + 1] : d; };
const baseUrl = opt('base-url', 'http://localhost/academy').replace(/\/$/, '');
const req = createRequire(import.meta.url);
let chromium;
try { chromium = req('playwright').chromium; } catch {
  const bin = execSync('where playwright', { encoding: 'utf8' }).split(/\r?\n/)[0].trim();
  chromium = req(join(dirname(bin), '..', 'playwright')).chromium;
}
const LEGACY = ['style.css', 'new-style.css', 'responsive.css', 'custom.css'];

const collect = (legacy) => {
  const strip = (sel) => sel.replace(/::?(hover|focus(-within|-visible)?|active|visited|checked|disabled|before|after|placeholder|first-line|first-letter|selection|-webkit-[\w-]+|-moz-[\w-]+|-ms-[\w-]+|not\([^)]*\))/g, '').replace(/\s+/g, ' ').trim();
  const out = {};
  for (const ss of document.styleSheets) {
    const href = ss.href || '';
    const file = legacy.find((f) => href.split('?')[0].endsWith('/' + f));
    if (!file) continue;
    let rules; try { rules = ss.cssRules; } catch { continue; }
    const list = [];
    const walk = (rs, media) => {
      for (const r of rs) {
        if (r.type === 1) {
          const sels = r.selectorText.split(',').map((x) => x.trim());
          let matched = false;
          for (const s of sels) { const q = strip(s); if (!q) { matched = true; break; } try { if (document.querySelector(q)) { matched = true; break; } } catch { matched = true; break; } }
          list.push([r.selectorText.slice(0, 120), media, matched ? 1 : 0]);
        } else if (r.cssRules && (r.type === 4 || r.type === 12)) walk(r.cssRules, r.type === 4 ? r.conditionText : media);
      }
    };
    walk(rules, '');
    out[file] = list;
  }
  return out;
};

const browser = await chromium.launch();
const agg = {};
const pages = routes.filter((r) => r.role === 'public');
for (const route of pages) {
  const ctx = await browser.newContext({ viewport: { width: 1440, height: 900 } });
  const page = await ctx.newPage();
  try {
    await page.goto(baseUrl + route.path, { waitUntil: 'networkidle', timeout: 30000 });
    const res = await page.evaluate(`(${collect.toString()})(${JSON.stringify(LEGACY)})`);
    for (const [file, list] of Object.entries(res)) {
      agg[file] = agg[file] || list.map(([sel, media]) => ({ sel, media, matched: 0 }));
      list.forEach(([, , m], i) => { if (agg[file][i]) agg[file][i].matched += m; });
    }
    console.log('scanned', route.name);
  } catch (e) { console.log('skipped', route.name, e.message.split('\n')[0]); }
  await ctx.close();
}
await browser.close();

mkdirSync('tmp/responsive-audit', { recursive: true });
writeFileSync('tmp/responsive-audit/legacy-css-usage.json', JSON.stringify(agg, null, 1));
console.log('\nfile | rules | in @media | matched on >=1 audited route | unmatched | unmatched inside @media');
for (const [file, list] of Object.entries(agg)) {
  const inMedia = list.filter((r) => r.media);
  const un = list.filter((r) => !r.matched);
  console.log(`${file} | ${list.length} | ${inMedia.length} | ${list.length - un.length} | ${un.length} | ${un.filter((r) => r.media).length}`);
}
