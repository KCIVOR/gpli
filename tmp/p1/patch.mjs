import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');

// 1. shell probe helpers, inserted before the run loop
const helpers = `
// ---- Phase 1: public shell probes (open/close UI only, nothing is submitted) ----
const LEGACY_PURPLE = 'rgb(117, 79, 254)'; // style.css var(--color-4), the old brand colour
const legacyScan = (rootSel) => {
  const hits = [];
  for (const el of document.querySelectorAll(rootSel + ', ' + rootSel + ' *')) {
    const cs = getComputedStyle(el);
    if (cs.display === 'none' || cs.visibility === 'hidden') continue;
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
    if (!c || c.l < 0 || c.r > innerWidth) fail('cart popover outside viewport');
  }
}
`;
s = s.replace('mkdirSync(outDir, { recursive: true });', helpers + '\nmkdirSync(outDir, { recursive: true });');

// 2. console capture + run probes (shell probes only on the first route: header/footer are shared chrome, plus every route's own footer scan)
s = s.replace("const page = await context.newPage();\n      const row =", "const page = await context.newPage();\n      const consoleErrors = [];\n      page.on('console', (m) => { if (m.type() === 'error') consoleErrors.push(m.text().slice(0, 160)); });\n      page.on('pageerror', (e) => consoleErrors.push('pageerror: ' + e.message.slice(0, 160)));\n      const row =");
s = s.replace("        row.screenshot = shot;\n", "        row.screenshot = shot;\n        if (!args.includes('--no-shell')) await shellProbes(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);\n        row.consoleErrors = consoleErrors;\n        if (consoleErrors.length) row.failures.push('console errors: ' + consoleErrors.length + ' (' + consoleErrors[0] + ')');\n");
writeFileSync(p, s);
