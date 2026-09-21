import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
// content-wide legacy scan (everything except shell chrome/overlays)
s = s.replace("async function shellProbes(", `// Phase 2: legacy purple anywhere in page content (outside header, footer, drawer, cookie banner).
const contentLegacyScan = () => {
  const skip = '.gp-site-header, .gp-site-footer, .mobile-view-offcanves, .gp-cookie-banner, #cookieConsentContainer, .select2-container, .modal';
  const hits = new Map();
  for (const el of document.body.querySelectorAll('*')) {
    if (el.closest(skip)) continue;
    const cs = getComputedStyle(el);
    if (cs.display === 'none' || cs.visibility === 'hidden') continue;
    const r = el.getBoundingClientRect();
    if (r.width === 0 || r.height === 0) continue;
    const props = ['color', 'backgroundColor', 'borderTopColor', 'outlineColor'].filter((k) => cs[k] === 'rgb(117, 79, 254)' && (!k.startsWith('border') || parseFloat(cs.borderTopWidth) > 0) && (k !== 'outlineColor' || parseFloat(cs.outlineWidth) > 0));
    if (!props.length) continue;
    const cls = typeof el.className === 'string' ? el.className.trim().split(/\s+/).slice(0, 2).join('.') : '';
    const key = el.tagName.toLowerCase() + (cls ? '.' + cls : '') + ' ' + props.join('/');
    hits.set(key, (hits.get(key) || 0) + 1);
  }
  return [...hits].slice(0, 8).map(([k, n]) => k + (n > 1 ? ' x' + n : ''));
};

async function shellProbes(`);
s = s.replace("        row.consoleErrors = consoleErrors;", "        if (!args.includes('--no-content')) {\n          const cl = await page.evaluate(`(${contentLegacyScan.toString()})()`);\n          if (cl.length) row.failures.push('legacy purple in content: ' + cl.join(', '));\n        }\n        row.consoleErrors = consoleErrors;");
// optional custom widths
s = s.replace("const rows = [];", "const rows = [];\nconst widthsOpt = opt('widths', null);\nconst vpList = widthsOpt ? widthsOpt.split(',').map((w) => ({ name: 'w' + w, width: +w, height: 900 })) : viewports;");
s = s.replace("for (const vp of viewports) {", "for (const vp of vpList) {");
writeFileSync(p, s);
