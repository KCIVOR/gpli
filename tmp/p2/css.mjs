import { readFileSync, writeFileSync } from 'node:fs';
let f = 'assets/design-system/gp-courses.css', s = readFileSync(f, 'utf8');
s = s.replace(`@media (max-width: 991px) {
  .gp-ds .gp-catalog-layout {
    grid-template-columns: 1fr;
  }`, `@media (max-width: 991px) {
  .gp-ds .gp-catalog-layout {
    /* minmax(0, 1fr), not 1fr: a bare 1fr track is minmax(auto, 1fr) and grew
       to its content's min-content width (342px in a 336px box at 360px). */
    grid-template-columns: minmax(0, 1fr);
  }`);
s = s.replace(`.gp-ds .gp-catalog .form-check-input {
  float: none;
  margin: 0;
  accent-color: var(--gp-primary);
}`, `.gp-ds .gp-catalog .form-check-input {
  float: none;
  margin: 0;
  accent-color: var(--gp-primary);
}

/* style.css \`.form-check-input:checked\` paints the old purple (var(--color-4))
   over Bootstrap's appearance:none radio; accent-color above does not reach it. */
.gp-ds .gp-catalog .form-check-input:checked {
  background-color: var(--gp-primary);
  border-color: var(--gp-primary);
}`);
writeFileSync(f, s);
f = 'assets/design-system/gp-compare.css'; s = readFileSync(f, 'utf8');
s += `
/* custom.css \`.compare-empty-state i\` paints the placeholder icon with the old
   purple (var(--color-4)). */
.gp-ds .compare-card .compare-empty-state i {
  color: var(--gp-fg-faint);
}
`;
writeFileSync(f, s);
f = 'scripts/audit-responsive-design-system.mjs'; s = readFileSync(f, 'utf8');
s = s.replace("(k !== 'outlineColor' || parseFloat(cs.outlineWidth) > 0)", "(k !== 'outlineColor' || (cs.outlineStyle !== 'none' && parseFloat(cs.outlineWidth) > 0))");
writeFileSync(f, s);
