import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const BS = String.fromCharCode(92);
s = s.replace("split(/s+/)", "split(/" + BS + "s+/)");
s = s.replace("c.match(/[d.]+/g)", "c.match(/[" + BS + "d.]+/g)");
s = s.replace("if (cs.display === 'none' || cs.visibility === 'hidden') continue;", "if (cs.display === 'none' || cs.visibility === 'hidden' || el.getBoundingClientRect().width === 0) continue;");
s = s.replace("c.r > innerWidth", "c.r > vp.width");
writeFileSync(p, s);
