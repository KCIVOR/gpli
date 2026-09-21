import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const rep = (a, b) => { if (!s.includes(a)) throw new Error('anchor: ' + a.slice(0, 60)); s = s.replace(a, () => b); };
rep("    // search overlay\n    await page.click('.m-search-icon', { timeout: 5000 });\n    await page.waitForTimeout(500);",
`    // search overlay: opening it must not move the header's own buttons
    const iconsBefore = await page.evaluate(() => { const r = document.querySelector('.menu-offcanves').getBoundingClientRect(); return { l: r.left, r: r.right }; });
    await page.click('.m-search-icon', { timeout: 5000 });
    await page.waitForTimeout(500);
    const iconsAfter = await page.evaluate(() => { const r = document.querySelector('.menu-offcanves').getBoundingClientRect(); return { l: r.left, r: r.right }; });
    if (Math.abs(iconsAfter.r - iconsBefore.r) > 1 || Math.abs(iconsAfter.l - iconsBefore.l) > 1) fail('opening the search moves the header buttons (' + Math.round(iconsBefore.l) + ' -> ' + Math.round(iconsAfter.l) + ')');`);
writeFileSync(p, s);
