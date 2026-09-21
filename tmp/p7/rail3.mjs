import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const w of [1440, 393]) {
  const c = await b.newContext({viewport:{width:w,height:820},storageState:'tmp/auth/admin.json'});
  const p = await c.newPage(); const errs=[]; p.on('pageerror',e=>errs.push(e.message));
  await p.goto('http://localhost/academy/admin/dashboard',{waitUntil:'networkidle'}); await p.waitForTimeout(600);
  if (w<768) { await p.click('.gp-admin-topbar .button-menu-mobile'); await p.waitForTimeout(500); }
  const link = p.locator('.left-side-menu .side-nav-item:has(> ul.side-nav-second-level) > a.side-nav-link').first();
  const st = () => p.evaluate(()=>{const li=document.querySelector('.left-side-menu .side-nav-item:has(> ul.side-nav-second-level)');const ul=li.querySelector(':scope > ul');const s=document.querySelector('.left-side-menu').getBoundingClientRect();return `${document.body.classList.contains('enlarged')?'rail':'full'} sidebar=${Math.round(s.width)}px dropdown=${getComputedStyle(ul).display}`});
  const a = await st(); await link.click(); await p.waitForTimeout(600); const bb = await st();
  console.log(w,'| before:',a,'| after one click:',bb,'| page errors:',errs.length);
  await c.close();
}
await b.close();
