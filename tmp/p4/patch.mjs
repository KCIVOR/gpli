import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const fn = `
// ---- Phase 4: authenticated (admin/instructor) shell probes. Open/close only; nothing is saved. ----
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
`;
s = s.replace('async function shellProbes(', fn + '\nasync function shellProbes(');
s = s.replace("if (route.role === 'public' && !args.includes('--no-shell')) await shellProbes(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);",
 "if (route.role === 'public' && !args.includes('--no-shell')) await shellProbes(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);\n        if (route.role !== 'public' && !args.includes('--no-shell')) await adminShellProbes(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);");
writeFileSync(p, s);
