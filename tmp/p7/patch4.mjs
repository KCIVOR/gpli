import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const a = "  if (vp.width < 768) {\n    if (!t.btnVisible) fail('menu button not visible');";
if (!s.includes(a)) throw new Error('anchor');
s = s.replace(a, () => `  // Icon rail (tablet / narrow desktop): a click on an item with sub-pages must expand the sidebar and open its dropdown.
  if (vp.width >= 768) {
    const inRail = await page.evaluate(() => document.body.classList.contains('enlarged'));
    const parent = inRail ? await page.$('.left-side-menu .side-nav-item:has(> ul.side-nav-second-level) > a.side-nav-link') : null;
    if (parent && (await parent.isVisible())) {
      await parent.click({ timeout: 5000 });
      await page.waitForTimeout(700);
      const r = await page.evaluate(() => {
        const sb = document.querySelector('.left-side-menu').getBoundingClientRect();
        const open = document.querySelector('.left-side-menu .side-nav-item > ul.side-nav-second-level.in, .left-side-menu .side-nav-item > ul.side-nav-second-level.show');
        return { w: sb.width, openVisible: !!open && getComputedStyle(open).display !== 'none' && open.getBoundingClientRect().height > 0 };
      });
      if (r.w < 150) fail('clicking a sidebar item with sub-pages in the icon rail does not expand the sidebar');
      else if (!r.openVisible) fail('sidebar expanded but the dropdown did not open');
      await page.screenshot({ path: outDir + '/' + tag + '-rail-click.png' });
      await page.goto(baseUrl + path, { waitUntil: 'networkidle' });
    }
  }
` + a);
writeFileSync(p, s);
