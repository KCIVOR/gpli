import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const fn = `
// Phase 5: open the first non-destructive ajax modal, check it fits the screen, close it. Nothing is saved.
async function modalProbe(page, row, vp, baseUrl, path, outDir, tag) {
  const fail = (m) => row.failures.push('modal: ' + m);
  await page.goto(baseUrl + path, { waitUntil: 'networkidle' });
  const trigger = await page.evaluateHandle(() => {
    const bad = /delete|confirm|remove|status|approve|reject|logout|ban|suspend|payout|refund|update_|_update/i;
    return [...document.querySelectorAll('a[onclick*="showAjaxModal"], button[onclick*="showAjaxModal"]')]
      .find((e) => e.getBoundingClientRect().width > 0 && !bad.test(e.getAttribute('onclick') || '')) || null;
  });
  const el = trigger.asElement();
  if (!el) return;
  await el.click({ timeout: 5000 });
  try { await page.waitForSelector('.modal.show .modal-dialog', { timeout: 6000 }); } catch { fail('modal did not open'); return; }
  await page.waitForTimeout(700);
  const m = await page.evaluate(() => {
    const d = document.querySelector('.modal.show .modal-dialog');
    const c = document.querySelector('.modal.show .modal-content');
    const body = document.querySelector('.modal.show .modal-body');
    const r = d.getBoundingClientRect(), cr = c.getBoundingClientRect();
    return { l: r.left, r: r.right, top: cr.top, bottom: cr.bottom, vh: window.innerHeight, bodyScrolls: body ? body.scrollHeight > body.clientHeight + 1 : false, modalScrolls: document.querySelector('.modal.show').scrollHeight > window.innerHeight + 1 };
  });
  if (m.l < -1 || m.r > vp.width + 1) fail('dialog outside viewport (' + Math.round(m.l) + '..' + Math.round(m.r) + ')');
  if (m.bottom > m.vh + 1 && !m.modalScrolls && !m.bodyScrolls) fail('dialog taller than the screen and not scrollable');
  await page.screenshot({ path: outDir + '/' + tag + '-modal.png' });
  await page.keyboard.press('Escape');
  await page.waitForTimeout(300);
}
`;
s = s.replace('\nasync function adminShellProbes(', fn + '\nasync function adminShellProbes(');
s = s.replace("if (route.role !== 'public' && !args.includes('--no-shell')) await adminShellProbes(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);",
  "if (route.role !== 'public' && !args.includes('--no-shell')) await adminShellProbes(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);\n        if (route.role !== 'public' && args.includes('--modals')) await modalProbe(page, row, vp, baseUrl, route.path, outDir, `${route.name}-${theme}-${vp.width}`);");
writeFileSync(p, s);
