import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, theme='light', w='390', path='/'] = process.argv;
const b = await chromium.launch();
const mk = async () => { const c = await b.newContext({viewport:{width:+w,height:760},storageState:'tmp/auth/admin.json'}); await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme); const p = await c.newPage(); await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'}); await p.evaluate(()=>{const e=document.getElementById('cookieConsentContainer');if(e)e.style.display='none'}); return [c,p]; };
// 1. drawer only (logged in)
let [c,p] = await mk();
await p.click('.menu-offcanves .btn-bar'); await p.waitForTimeout(700);
await p.screenshot({path:`tmp/p7/${theme}-${w}-drawer.png`, clip:{x:0,y:0,width:+w,height:420}});
console.log('drawer profile:', await p.evaluate(()=>{const q=s=>document.querySelector('#offcanvasWithBothOptions '+s);const f=e=>{if(!e)return null;const cs=getComputedStyle(e);return cs.color};const top=q('.offcanves-top'),h=q('.user-details h4'),pp=q('.user-details p');let bg=null;for(let n=h;n;n=n.parentElement){const c=getComputedStyle(n).backgroundColor;if(c!=='rgba(0, 0, 0, 0)'){bg=c+' on '+n.className;break}}return {h4:f(h),p:f(pp),bg,topBg:top&&getComputedStyle(top).backgroundColor}}));
await c.close();
// 2. search only
[c,p] = await mk();
await p.click('.m-search-icon'); await p.waitForTimeout(600);
await p.screenshot({path:`tmp/p7/${theme}-${w}-search.png`, clip:{x:0,y:0,width:+w,height:420}});
console.log('search box:', await p.evaluate(()=>{const s=document.querySelector('.mobile-search');const r=s.getBoundingClientRect(),cs=getComputedStyle(s);return {top:Math.round(r.top),h:Math.round(r.height),w:Math.round(r.width),z:cs.zIndex,bg:cs.backgroundColor,pos:cs.position}}));
// 3. search open, then drawer
await p.click('.menu-offcanves .btn-bar'); await p.waitForTimeout(700);
await p.screenshot({path:`tmp/p7/${theme}-${w}-both.png`, clip:{x:0,y:0,width:+w,height:420}});
console.log('z: header', await p.evaluate(()=>{const g=s=>{const e=document.querySelector(s);if(!e)return null;const cs=getComputedStyle(e);return s+' z='+cs.zIndex+' pos='+cs.position};return [g('.gp-site-header'),g('.menubar'),g('.mobile-search'),g('#offcanvasWithBothOptions'),g('.offcanvas-backdrop'),g('.menu-offcanves')].join(' | ')}));
await b.close();
