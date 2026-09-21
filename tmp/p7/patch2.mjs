import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const rep = (a, b) => { if (!s.includes(a)) throw new Error('anchor missing: ' + a.slice(0, 60)); s = s.replace(a, () => b); };
rep('\n// Phase 5: open the first non-destructive ajax modal',
`
// DataTables Responsive hides columns that do not fit (display: none) and expects a visible expand control
// (a "+" / arrow drawn by the first cell's ::before) so the rest of the row can be opened. If columns are hidden
// and there is no visible control, the data is unreachable. Only tables that already have rows are checked.
const collapsedTableScan = () => {
  const out = [];
  document.querySelectorAll('table.dataTable').forEach((t, i) => {
    const heads = [...t.querySelectorAll('thead th')];
    const hidden = heads.filter((th) => getComputedStyle(th).display === 'none').length;
    if (!hidden) return;
    const row = t.querySelector('tbody tr:not(.child)');
    const cell = row && row.querySelector('td, th');
    if (!cell || cell.classList.contains('dataTables_empty')) return;
    const cs = getComputedStyle(cell, '::before');
    const visible = cs.content !== 'none' && cs.content !== 'normal' && cs.display !== 'none' && parseFloat(cs.width) > 0;
    if (!visible) out.push('table #' + (t.id || i) + ': ' + hidden + ' of ' + heads.length + ' columns hidden, no expand control');
  });
  return out;
};
` + '\n// Phase 5: open the first non-destructive ajax modal');
rep("        row.consoleErrors = consoleErrors;", "        if (!args.includes('--no-tables')) {\n          const ct = await page.evaluate(`(${collapsedTableScan.toString()})()`);\n          if (ct.length) row.failures.push('table: ' + ct.join('; '));\n        }\n        row.consoleErrors = consoleErrors;");
writeFileSync(p, s);
