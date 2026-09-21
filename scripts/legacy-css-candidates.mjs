// Read-only. Second stage of the Phase 7 retirement evidence. Deletes nothing.
// Input: tmp/responsive-audit/legacy-css-usage.json (from legacy-css-usage.mjs).
// A rule that matched no element on the audited routes is a *retirement candidate* only if every selector in it
// contains a class or id that appears nowhere in application/ (PHP) or assets/ (JS/HTML) - i.e. it cannot match
// markup the app can produce. Class names assembled at runtime (e.g. 'btn-' + x) would escape this search, so
// candidates still need a route reference, cascade evidence and a full matrix pass before any removal.
import { readFileSync, readdirSync, statSync, writeFileSync } from 'node:fs';
import { join, extname } from 'node:path';

const usage = JSON.parse(readFileSync('tmp/responsive-audit/legacy-css-usage.json', 'utf8'));
const roots = ['application', 'assets', 'index.php'];
const exts = new Set(['.php', '.js', '.html', '.htm', '.twig', '.json']);
const skipDirs = new Set(['node_modules', '.git', 'uploads', 'vendor', 'tmp']);
const tokens = new Set();
let files = 0;
const walk = (p) => {
  let st; try { st = statSync(p); } catch { return; }
  if (st.isDirectory()) { for (const n of readdirSync(p)) if (!skipDirs.has(n)) walk(join(p, n)); return; }
  if (!exts.has(extname(p)) || st.size > 6e6) return;
  if (/\.min\.css$/.test(p)) return;
  files++;
  const text = readFileSync(p, 'utf8');
  for (const m of text.matchAll(/[A-Za-z_][\w-]*/g)) tokens.add(m[0]);
};
roots.forEach(walk);

const refs = (sel) => [...sel.matchAll(/[.#]([A-Za-z_][\w-]*)/g)].map((m) => m[1]);
const summary = {};
const candidates = {};
for (const [file, rules] of Object.entries(usage)) {
  const unmatched = rules.filter((r) => !r.matched);
  const cand = unmatched.filter((r) => {
    const sels = r.sel.split(',').map((s) => s.trim());
    return sels.every((s) => refs(s).some((t) => !tokens.has(t)));
  });
  summary[file] = { total: rules.length, matchedOnAuditedRoutes: rules.length - unmatched.length, unmatchedOnAuditedRoutes: unmatched.length, unmatchedButNamesReferencedInSource: unmatched.length - cand.length, candidates: cand.length, candidatesInMedia: cand.filter((r) => r.media).length };
  candidates[file] = cand.map((r) => ({ sel: r.sel, media: r.media }));
}
writeFileSync('tmp/responsive-audit/legacy-css-candidates.json', JSON.stringify({ scannedFiles: files, tokens: tokens.size, summary, candidates }, null, 1));
console.log(`source files scanned: ${files}, distinct tokens: ${tokens.size}`);
console.table(summary);
