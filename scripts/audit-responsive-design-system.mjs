// Read-only responsive design-system audit. Navigates, inspects, screenshots only.
// Usage: npx -p playwright node scripts/audit-responsive-design-system.mjs --base-url http://localhost/academy --theme light
import { existsSync, mkdirSync, writeFileSync } from 'node:fs';
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


// ---- Phase 1: public shell probes (open/close UI only, nothing is submitted) ----
const LEGACY_PURPLE = 'rgb(117, 79, 254)'; // style.css var(--color-4), the old brand colour
const legacyScan = (rootSel) => {
  const hits = [];
  for (const el of document.querySelectorAll(rootSel + ', ' + rootSel + ' *')) {
    const cs = getComputedStyle(el);
    if (cs.display === 'none' || cs.visibility === 'hidden' || el.getBoundingClientRect().width === 0) continue;
    const bad = ['color', 'backgroundColor', 'borderTopColor'].filter((k) => cs[k] === 'rgb(117, 79, 254)' && (k !== 'borderTopColor' || parseFloat(cs.borderTopWidth) > 0));
    if (bad.length) hits.push(el.tagName.toLowerCase() + (typeof el.className === 'string' && el.className ? '.' + el.className.trim().split(/\s+/).slice(0, 2).join('.') : '') + ' ' + bad.join('/'));
  }
  return hits.slice(0, 6);
};
const contrastOf = (el) => {
  const parse = (c) => (c.match(/[\d.]+/g) || []).map(Number);
  const lum = ([r, g, b]) => { const f = (v) => { v /= 255; return v <= 0.03928 ? v / 12.92 : ((v + 0.055) / 1.055) ** 2.4; }; return 0.2126 * f(r) + 0.7152 * f(g) + 0.0722 * f(b); };
  let bg = null;
  for (let n = el; n; n = n.parentElement) { const c = parse(getComputedStyle(n).backgroundColor); if (c.length >= 3 && (c.length === 3 || c[3] > 0.9)) { bg = c; break; } }
  const fg = parse(getComputedStyle(el).color);
  if (!bg || fg.length < 3) return null;
  const [a, b] = [lum(fg), lum(bg)].sort((x, y) => y - x);
  return Math.round(((a + 0.05) / (b + 0.05)) * 100) / 100;
};

// Phase 2: legacy purple anywhere in page content (outside header, footer, drawer, cookie banner).
const contentLegacyScan = () => {
  const skip = '.gp-site-header, .gp-site-footer, .mobile-view-offcanves, .gp-cookie-banner, #cookieConsentContainer, .select2-container, .modal';
  const hits = new Map();
  for (const el of document.body.querySelectorAll('*')) {
    if (el.closest(skip)) continue;
    const cs = getComputedStyle(el);
    if (cs.display === 'none' || cs.visibility === 'hidden') continue;
    const r = el.getBoundingClientRect();
    if (r.width === 0 || r.height === 0) continue;
    const legacyTints = ['rgb(117, 79, 254)', 'rgb(248, 247, 255)', 'rgb(243, 241, 248)']; // old purple, its lavender surface and border
    const props = ['color', 'backgroundColor', 'borderTopColor', 'outlineColor'].filter((k) => legacyTints.includes(cs[k]) && (!k.startsWith('border') || parseFloat(cs.borderTopWidth) > 0) && (k !== 'outlineColor' || (cs.outlineStyle !== 'none' && parseFloat(cs.outlineWidth) > 0)));
    if (!props.length) continue;
    const cls = typeof el.className === 'string' ? el.className.trim().split(/\s+/).slice(0, 2).join('.') : '';
    const key = el.tagName.toLowerCase() + (cls ? '.' + cls : '') + ' ' + props.join('/');
    hits.set(key, (hits.get(key) || 0) + 1);
  }
  return [...hits].slice(0, 8).map(([k, n]) => k + (n > 1 ? ' x' + n : ''));
};


// ---- Phase 4: authenticated (admin/instructor) shell probes. Open/close only; nothing is saved. ----
// Phase 5: content that extends past the screen edge but does not register as page overflow because an
// ancestor clips it (e.g. `.content-page { overflow: hidden }`). Elements inside a deliberate horizontal
// scroller (overflow-x auto/scroll) are fine.
const clippedContentScan = () => {
  const vw = window.innerWidth;
  const hits = new Map();
  const skipSel = '.dropdown-menu:not(.show), .offcanvas:not(.show), .modal:not(.show), .select2-container--open, .tooltip, .popover, .swal2-container, .ajax_loaderBar, .gp-cookie-banner, script, style';
  for (const el of document.body.querySelectorAll('*')) {
    const cs = getComputedStyle(el);
    if (cs.display === 'none' || cs.visibility === 'hidden' || cs.position === 'fixed') continue;
    const r = el.getBoundingClientRect();
    if (r.width === 0 || r.height === 0) continue;
    if (r.right <= vw + 1 && r.left >= -1) continue;
    if (el.closest(skipSel)) continue;
    let scrolled = false;
    for (let a = el.parentElement; a && a !== document.body; a = a.parentElement) {
      const ox = getComputedStyle(a).overflowX;
      if (ox === 'auto' || ox === 'scroll') { scrolled = true; break; }
    }
    if (scrolled) continue;
    const cls = typeof el.className === 'string' ? el.className.trim().split(/\s+/).slice(0, 2).join('.') : '';
    const key = el.tagName.toLowerCase() + (cls ? '.' + cls : '') + ' right=' + Math.round(r.right);
    hits.set(key, (hits.get(key) || 0) + 1);
  }
  return [...hits].slice(0, 6).map(([k, n]) => k + (n > 1 ? ' x' + n : ''));
};

// Phase 5: open the first non-destructive ajax modal, check it fits the screen, close it. Nothing is saved.
async function modalProbe(page, row, vp, baseUrl, path, outDir, tag) {
  const fail = (m) => row.failures.push('modal: ' + m);
  await page.goto(baseUrl + path, { waitUntil: 'networkidle' });
  const trigger = await page.evaluateHandle(() => {
    const bad = /delete|confirm|remove|status|approve|reject|logout|ban|suspend|payout|refund|update_|_update/i;
    return [...document.querySelectorAll('a[onclick*="showAjaxModal"], button[onclick*="showAjaxModal"]')]
      .find((e) => e.getBoundingClientRect().width > 0 && !bad.test(e.getAttribute('onclick') || '')) || null;
  });
  const el = trigger.asElement();
  if (!el) { (row.notes = row.notes || []).push('modal probe: no safe ajax-modal trigger on this page'); return; }
  await el.click({ timeout: 5000 });
  try { await page.waitForSelector('.modal.show .modal-dialog', { timeout: 6000 }); } catch { fail('modal did not open'); return; }
  await page.waitForTimeout(700);
  const m = await page.evaluate(() => {
    const d = document.querySelector('.modal.show .modal-dialog');
    const c = document.querySelector('.modal.show .modal-content');
    const body = document.querySelector('.modal.show .modal-body');
    const r = d.getBoundingClientRect(), cr = c.getBoundingClientRect();
    return { l: r.left, r: r.right, top: cr.top, bottom: cr.bottom, vh: window.innerHeight, bodyScrolls: body ? body.scrollHeight > body.clientHeight + 1 : false, modalScrolls: document.querySelector('.modal.show').scrollHeight > window.innerHeight + 1 };
  });
  if (m.l < -1 || m.r > vp.width + 1) fail('dialog outside viewport (' + Math.round(m.l) + '..' + Math.round(m.r) + ')');
  if (m.bottom > m.vh + 1 && !m.modalScrolls && !m.bodyScrolls) fail('dialog taller than the screen and not scrollable');
  await page.screenshot({ path: outDir + '/' + tag + '-modal.png' });
  await page.keyboard.press('Escape');
  await page.waitForTimeout(300);
}

async function adminShellProbes(page, row, vp, baseUrl, path, outDir, tag) {
  const fail = (m) => row.failures.push('admin shell: ' + m);
  const t = await page.evaluate(() => {
    const bar = document.querySelector('.gp-admin-topbar');
    const items = [...document.querySelectorAll('.gp-admin-topbar-right > li')].filter((li) => li.getBoundingClientRect().width > 0);
    const btn = document.querySelector('.gp-admin-topbar .button-menu-mobile');
    const br = btn && btn.getBoundingClientRect();
    let covered = null;
    if (br && br.width > 0) { const hit = document.elementFromPoint(br.left + br.width / 2, br.top + br.height / 2); covered = !(hit && (hit === btn || btn.contains(hit))); }
    return { barRight: bar && bar.getBoundingClientRect().right, lastRight: items.length ? Math.max(...items.map((li) => li.getBoundingClientRect().right)) : 0, btnVisible: !!br && br.width > 0, covered };
  });
  if (t.lastRight > vp.width + 1) fail('topbar items extend past the viewport (' + Math.round(t.lastRight) + ')');
  if (vp.width < 768) {
    if (!t.btnVisible) fail('menu button not visible');
    else if (t.covered) fail('menu button is covered by another element');
    else {
      await page.click('.gp-admin-topbar .button-menu-mobile', { timeout: 5000 });
      await page.waitForTimeout(500);
      const sb = await page.evaluate(() => { const e = document.querySelector('.left-side-menu'); const r = e.getBoundingClientRect(); return { w: r.width, l: r.left, r: r.right, disp: getComputedStyle(e).display }; });
      if (sb.disp === 'none' || sb.w === 0) fail('sidebar does not open from the menu button');
      else if (sb.l < -1 || sb.r > vp.width + 1) fail('open sidebar outside viewport');
      await page.screenshot({ path: outDir + '/' + tag + '-sidebar.png' });
      await page.goto(baseUrl + path, { waitUntil: 'networkidle' });
    }
  }
  const toggles = await page.$$('.gp-admin-topbar .dropdown-toggle');
  for (let i = 0; i < toggles.length; i++) {
    if (!(await toggles[i].isVisible())) continue;
    await toggles[i].click({ timeout: 5000 });
    await page.waitForTimeout(300);
    const d = await page.evaluate((idx) => {
      const li = document.querySelectorAll('.gp-admin-topbar .dropdown-toggle')[idx].closest('li');
      const m = li && li.querySelector('.dropdown-menu.show');
      if (!m) return null;
      const r = m.getBoundingClientRect();
      return { l: r.left, r: r.right };
    }, i);
    if (d && (d.l < -1 || d.r > vp.width + 1)) fail('dropdown #' + i + ' outside viewport (' + Math.round(d.l) + '..' + Math.round(d.r) + ')');
    if (d) await page.screenshot({ path: outDir + '/' + tag + '-dropdown' + i + '.png' });
    await page.keyboard.press('Escape');
    await page.mouse.click(vp.width / 2, vp.height - 5);
    await page.waitForTimeout(150);
  }
}

async function shellProbes(page, row, vp, baseUrl, path, outDir, tag) {
  const fail = (m) => row.failures.push('shell: ' + m);
  const chrome = await page.evaluate(([legacyScanSrc]) => {
    const legacyScan = eval('(' + legacyScanSrc + ')');
    const q = (s) => document.querySelector(s);
    const box = (s) => { const e = q(s); if (!e) return null; const r = e.getBoundingClientRect(); return { l: r.left, r: r.right, w: r.width, h: r.height }; };
    return { header: box('.gp-site-header'), footer: box('.gp-site-footer'), bar: box('.menu-offcanves .btn-bar'), searchIcon: box('.m-search-icon'), headerLegacy: legacyScan('.gp-site-header'), footerLegacy: legacyScan('.gp-site-footer') };
  }, [legacyScan.toString()]);
  if (!chrome.header || chrome.header.r > vp.width + 1) fail('header missing or wider than viewport');
  if (!chrome.footer || chrome.footer.r > vp.width + 1) fail('footer missing or wider than viewport');
  if (chrome.headerLegacy.length) fail('legacy purple in header: ' + chrome.headerLegacy.join(', '));
  if (chrome.footerLegacy.length) fail('legacy purple in footer: ' + chrome.footerLegacy.join(', '));

  if (vp.width < 992) {
    if (!chrome.bar || chrome.bar.w === 0 || chrome.bar.r > vp.width) fail('menu trigger not visible inside viewport');
    // search overlay
    await page.click('.m-search-icon', { timeout: 5000 });
    await page.waitForTimeout(500);
    const s = await page.evaluate(([scanSrc]) => {
      const scan = eval('(' + scanSrc + ')');
      const f = document.querySelector('.mobile-search .form-control') || document.querySelector('.mobile-search input');
      const box = document.querySelector('.mobile-search');
      const r = box && box.getBoundingClientRect();
      const bg = box && getComputedStyle(box).backgroundColor;
      return { fieldVisible: !!f && f.getBoundingClientRect().width > 0, right: r && r.right, transparent: !bg || bg === 'rgba(0, 0, 0, 0)', legacy: scan('.gp-site-header') };
    }, [legacyScan.toString()]);
    if (!s.fieldVisible) fail('search field not visible after opening');
    if (s.right > vp.width + 1) fail('search overlay wider than viewport');
    if (s.transparent) fail('search overlay has no DS surface (floats over page text)');
    if (s.legacy.length) fail('legacy purple in open search: ' + s.legacy.join(', '));
    await page.screenshot({ path: outDir + '/' + tag + '-search.png', clip: { x: 0, y: 0, width: vp.width, height: 260 } });
    // drawer
    await page.goto(baseUrl + path, { waitUntil: 'networkidle' });
    await page.click('.menu-offcanves .btn-bar', { timeout: 5000 });
    await page.waitForTimeout(700);
    const d = await page.evaluate(([scanSrc, contrastSrc]) => {
      const scan = eval('(' + scanSrc + ')');
      const contrast = eval('(' + contrastSrc + ')');
      const dr = document.querySelector('#offcanvasWithBothOptions');
      const r = dr.getBoundingClientRect();
      const links = ['.offcanves-btn .signUp-btn', '.offcanves-btn .logIn-btn', '.btn-toggle-list', '.btn-toggle'].map((s) => document.querySelector('#offcanvasWithBothOptions ' + s)).filter(Boolean);
      return { l: r.left, r: r.right, w: r.width, legacy: scan('#offcanvasWithBothOptions'), low: links.map((e) => [e.className.split(' ')[0], contrast(e)]).filter(([, c]) => c !== null && c < 4.5) };
    }, [legacyScan.toString(), contrastOf.toString()]);
    if (d.r > vp.width + 1 || d.l < -1) fail('drawer outside viewport');
    if (d.legacy.length) fail('legacy purple in drawer: ' + d.legacy.join(', '));
    if (d.low.length) fail('drawer text contrast < 4.5: ' + d.low.map(([n, c]) => n + '=' + c).join(', '));
    await page.screenshot({ path: outDir + '/' + tag + '-drawer.png' });
  } else {
    // cart popover
    await page.click('.menu_pro_cart_tgl', { timeout: 5000 });
    await page.waitForTimeout(500);
    const c = await page.evaluate(() => { const e = document.querySelector('.menu_pro_wish'); const r = e && e.getBoundingClientRect(); return r && { l: r.left, r: r.right }; });
    if (!c || c.l < 0 || c.r > vp.width) fail('cart popover outside viewport');
  }
}

mkdirSync(outDir, { recursive: true });
const runThemes = themeArg === 'both' ? themes : [themeArg];
const rows = [];
const widthsOpt = opt('widths', null);
const vpList = widthsOpt ? widthsOpt.split(',').map((w) => ({ name: 'w' + w, width: +w, height: 900 })) : viewports;
const browser = await chromium.launch();

for (const theme of runThemes) {
  for (const route of routes.filter((r) => !onlyRoute || r.name === onlyRoute)) {
    const authFile = 'tmp/auth/' + route.role + '.json';
    if (route.role !== 'public' && !existsSync(authFile)) {
      rows.push({ route: route.name, role: route.role, theme, status: 'blocked', failures: ['manual authenticated check required (' + authFile + ' missing)'] });
      continue;
    }
    for (const vp of vpList) {
      const context = await browser.newContext({ viewport: { width: vp.width, height: vp.height }, ...(route.role !== 'public' ? { storageState: authFile } : {}) });
      await context.addInitScript((t) => { try { localStorage.setItem('gp-ds-theme', t); } catch {} }, theme);
      const page = await context.newPage();
      const consoleErrors = [];
      page.on('console', (m) => { if (m.type() === 'error') consoleErrors.push(m.text().slice(0, 160)); });
      page.on('pageerror', (e) => consoleErrors.push('pageerror: ' + e.message.slice(0, 160)));
      const row = { route: route.name, url: baseUrl + route.path, role: route.role, theme, viewport: vp.name, width: vp.width, wrapper: route.wrapper, stylesheet: route.stylesheet, failures: [] };
      try {
        const resp = await page.goto(baseUrl + route.path, { waitUntil: 'networkidle', timeout: 30000 });
        row.httpStatus = resp ? resp.status() : null;
        if (route.role !== 'public' && /\/login(\/|$)/.test(new URL(page.url()).pathname)) { row.status = 'blocked'; row.failures.push('session expired or wrong role (redirected to login); re-run save-auth-session'); rows.push(row); await context.close(); continue; }
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
        if (route.role === 'public' && !args.includes('--no-shell')) await shellProbes(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);
        if (route.role !== 'public' && !args.includes('--no-shell')) await adminShellProbes(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);
        if (route.role !== 'public' && args.includes('--modals')) await modalProbe(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);
        if (!args.includes('--no-content')) {
          const cl = await page.evaluate(`(${contentLegacyScan.toString()})()`);
          if (cl.length) row.failures.push('legacy purple in content: ' + cl.join(', '));
        }
        if (!args.includes('--no-clip')) {
          const cc = await page.evaluate(`(${clippedContentScan.toString()})()`);
          if (cc.length) row.failures.push('content clipped past screen edge: ' + cc.join(', '));
        }
        row.consoleErrors = consoleErrors;
        if (consoleErrors.length) row.failures.push('console errors: ' + consoleErrors.length + ' (' + consoleErrors[0] + ')');
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
