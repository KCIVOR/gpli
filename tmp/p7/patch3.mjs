import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const a = "      await page.screenshot({ path: outDir + '/' + tag + '-sidebar.png' });\n      await page.goto(baseUrl + path, { waitUntil: 'networkidle' });";
if (!s.includes(a)) throw new Error('anchor');
s = s.replace(a, () => `      // nothing on the page (rich-text toolbars, sticky headers, ...) may be drawn over the open sidebar,
      // at any scroll position
      const covered = await page.evaluate(async () => {
        const sb = document.querySelector('.left-side-menu');
        const bad = new Set();
        const maxY = document.documentElement.scrollHeight - window.innerHeight;
        for (const f of [0, 0.4, 0.8, 1]) {
          window.scrollTo(0, Math.max(0, maxY) * f);
          await new Promise((res) => setTimeout(res, 150));
          const r = sb.getBoundingClientRect();
          for (const y of [r.top + 60, r.top + r.height * 0.4, r.top + r.height * 0.75]) {
            const el = document.elementFromPoint(r.left + r.width / 2, Math.min(y, window.innerHeight - 2));
            if (el && !el.closest('.left-side-menu')) bad.add(el.tagName.toLowerCase() + '.' + String(el.className).trim().split(' ').slice(0, 2).join('.'));
          }
        }
        window.scrollTo(0, 0);
        return [...bad].slice(0, 3);
      });
      if (covered.length) fail('open sidebar is covered by page content: ' + covered.join(', '));
      await page.screenshot({ path: outDir + '/' + tag + '-sidebar.png' });
      await page.goto(baseUrl + path, { waitUntil: 'networkidle' });`);
writeFileSync(p, s);
