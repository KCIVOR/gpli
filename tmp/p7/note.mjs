import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, w='480', path='/admin/manage_profile', theme='dark'] = process.argv;
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:+w,height:860},storageState:'tmp/auth/admin.json'});
await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
const p = await c.newPage(); await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'}); await p.waitForTimeout(800);
const ed = await p.$('.note-editor'); if(ed){await ed.scrollIntoViewIfNeeded();}
await p.click('.gp-admin-topbar .button-menu-mobile'); await p.waitForTimeout(600);
console.log(await p.evaluate(()=>{const g=s=>{const e=document.querySelector(s);if(!e)return s+' MISSING';const cs=getComputedStyle(e),r=e.getBoundingClientRect();return s.padEnd(30)+'z='+cs.zIndex+' pos='+cs.position+' L'+Math.round(r.left)+' R'+Math.round(r.right)+' T'+Math.round(r.top)+' B'+Math.round(r.bottom)};
 const chain=[];let e=document.querySelector('.note-toolbar');while(e&&e!==document.body){const cs=getComputedStyle(e);if(cs.position!=='static'||cs.zIndex!=='auto'||cs.transform!=='none')chain.push(e.tagName+'.'+String(e.className).slice(0,34)+' z='+cs.zIndex+' pos='+cs.position+(cs.transform!=='none'?' transform':''));e=e.parentElement}
 const side=document.querySelector('.left-side-menu').getBoundingClientRect();const pt=document.elementFromPoint(side.left+120,300);
 return [g('.left-side-menu'),g('.content-page'),g('.note-editor'),g('.note-toolbar'),g('.note-editing-area'),g('.gp-admin-topbar'),'toolbar ancestors with stacking: '+chain.join(' > '),'element at sidebar point (x='+Math.round(side.left+120)+',y=300): '+(pt?pt.tagName+'.'+String(pt.className).slice(0,40):'-')+' inside sidebar? '+(pt&&!!pt.closest('.left-side-menu'))].join('\n')}));
await p.screenshot({path:`tmp/p7/note-${w}-${theme}.png`});
await b.close();
