import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const w of [790, 1100, 1440]) {
  const c = await b.newContext({viewport:{width:w,height:800},storageState:'tmp/auth/admin.json'});
  const p = await c.newPage(); await p.goto('http://localhost/academy/admin/dashboard',{waitUntil:'networkidle'}); await p.waitForTimeout(600);
  const st = () => p.evaluate(()=>{const s=document.querySelector('.left-side-menu').getBoundingClientRect(),btn=document.querySelector('.gp-admin-topbar .button-menu-mobile'),bb=btn.getBoundingClientRect();return `body.enlarged=${document.body.classList.contains('enlarged')} sidebarW=${Math.round(s.width)} buttonVisible=${bb.width>0} (display=${getComputedStyle(btn).display})`});
  console.log(w,'initial :',await st());
  // what the theme's own toggle does if the button were visible: click it through the DOM
  await p.evaluate(()=>document.querySelector('.gp-admin-topbar .button-menu-mobile').click()); await p.waitForTimeout(500);
  console.log(w,'after click:',await st());
  await c.close();
}
await b.close();
