import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const w of [768, 790, 1024]) {
  const c = await b.newContext({viewport:{width:w,height:820},storageState:'tmp/auth/admin.json'});
  const p = await c.newPage(); const errs=[]; p.on('pageerror',e=>errs.push(e.message));
  await p.goto('http://localhost/academy/admin/dashboard',{waitUntil:'networkidle'}); await p.waitForTimeout(600);
  const items = p.locator('.left-side-menu .side-nav-item:has(> ul.side-nav-second-level) > a.side-nav-link');
  const st = (i) => p.evaluate((i)=>{const lis=[...document.querySelectorAll('.left-side-menu .side-nav-item')].filter(li=>li.querySelector(':scope > ul.side-nav-second-level'));const li=lis[i];const ul=li.querySelector(':scope > ul');const r=ul.getBoundingClientRect();const s=document.querySelector('.left-side-menu').getBoundingClientRect();return `${document.body.classList.contains('enlarged')?'rail':'full'} sidebar=${Math.round(s.width)}px | item ${i} dropdown ${getComputedStyle(ul).display} ${Math.round(r.height)}px tall, open=${ul.classList.contains('in')||ul.classList.contains('show')} | others open: ${lis.filter((x,j)=>j!==i&&x.querySelector(':scope > ul').classList.contains('in')).length}`},i);
  const before = await st(0);
  await items.nth(0).click(); await p.waitForTimeout(700);
  const after1 = await st(0);
  if (w===790) await p.screenshot({path:'tmp/p7/rail-opened-790.png',clip:{x:0,y:60,width:w,height:640}});
  await items.nth(1).click(); await p.waitForTimeout(700);   // now a normal click on another parent: accordion switch
  const after2 = await st(1);
  await items.nth(1).click(); await p.waitForTimeout(600);   // second click closes it
  const after3 = await st(1);
  // a plain link must still navigate
  await Promise.all([p.waitForNavigation({waitUntil:'load'}),p.locator('.left-side-menu .side-nav-item > a.side-nav-link[href*="admin/message"]').first().click()]);
  console.log(w,'\n  start     :',before,'\n  click #0  :',after1,'\n  click #1  :',after2,'\n  click #1 again:',after3,'\n  plain link navigated to:',new URL(p.url()).pathname,'| page errors:',errs.length);
  await c.close();
}
await b.close();
