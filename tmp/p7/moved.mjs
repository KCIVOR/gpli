import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
const shot = async (name, w, h, theme, auth, fn) => {
  const c = await b.newContext({viewport:{width:w,height:h},...(auth?{storageState:'tmp/auth/admin.json'}:{})});
  await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
  const p = await c.newPage(); const errs=[]; p.on('pageerror',e=>errs.push(e.message));
  await p.goto('http://localhost/academy/',{waitUntil:'networkidle'});
  await p.evaluate(()=>{const e=document.getElementById('cookieConsentContainer');if(e)e.style.display='none'});
  await fn(p); await p.screenshot({path:`tmp/p7/${name}.png`, clip: p._clip||undefined}); if(errs.length)console.log(name,'pageerrors',errs);
  await c.close(); };
// desktop header, logged in and guest
await shot('hdr-desktop-admin',1100,90,'light',true,async p=>{});
await shot('hdr-desktop-guest',1100,90,'light',false,async p=>{});
// footer bottom row, desktop + mobile
for (const [w,h,n] of [[1100,700,'footer-desktop'],[390,700,'footer-mobile']]) await shot(n,w,h,'light',false,async p=>{await p.evaluate(()=>{document.querySelector('.gp-footer-bottom').scrollIntoView({block:'end'})});await p.waitForTimeout(300)});
// mobile search, both themes
for (const t of ['light','dark']) await shot('search-'+t,390,300,t,false,async p=>{await p.click('.m-search-icon');await p.waitForTimeout(500)});
// does the footer toggle work?
{const c=await b.newContext({viewport:{width:1100,height:700}});const p=await c.newPage();await p.goto('http://localhost/academy/',{waitUntil:'networkidle'});
 const before=await p.evaluate(()=>document.documentElement.getAttribute('data-theme'));
 await p.evaluate(()=>document.querySelector('.gp-footer-bottom').scrollIntoView());
 await p.click('.gp-footer-theme [data-gp-theme="dark"]');await p.waitForTimeout(300);
 const after=await p.evaluate(()=>[document.documentElement.getAttribute('data-theme'),localStorage.getItem('gp-ds-theme'),[...document.querySelectorAll('[data-gp-theme].active')].map(e=>e.closest('footer,header')?.tagName+':'+e.dataset.gpTheme).join(',')]);
 console.log('toggle: before',before,'-> after',JSON.stringify(after));
 console.log('counts: header toggles in desktop header =',await p.evaluate(()=>document.querySelectorAll('.navbar-collapse .gp-theme-row, .right-menubar .gp-theme-row').length),' total rows =',await p.evaluate(()=>document.querySelectorAll('.gp-theme-row').length),' ids:',await p.evaluate(()=>['gp-theme-light','gp-theme-dark'].map(i=>document.querySelectorAll('#'+i).length).join('/')));
 await c.close();}
await b.close();
