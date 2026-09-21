import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const scan = `
// Phase 5: content that extends past the screen edge but does not register as page overflow because an
// ancestor clips it (e.g. \`.content-page { overflow: hidden }\`). Elements inside a deliberate horizontal
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
`;
s = s.replace('\nasync function adminShellProbes(', scan + '\nasync function adminShellProbes(');
s = s.replace("        row.consoleErrors = consoleErrors;", "        if (!args.includes('--no-clip')) {\n          const cc = await page.evaluate(`(${clippedContentScan.toString()})()`);\n          if (cc.length) row.failures.push('content clipped past screen edge: ' + cc.join(', '));\n        }\n        row.consoleErrors = consoleErrors;");
writeFileSync(p, s);
