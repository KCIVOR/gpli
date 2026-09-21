import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, path='/', auth='0'] = process.argv;
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:390,height:760},...(auth==='1'?{storageState:'tmp/auth/admin.json'}:{})});
const p = await c.newPage();
await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'});
await p.click('.m-search-icon'); await p.waitForTimeout(500);
console.log(await p.evaluate(()=>{const o=[];let e=document.querySelector('.mobile-search');while(e){const r=e.getBoundingClientRect(),cs=getComputedStyle(e);o.push((e.tagName+'.'+String(e.className).slice(0,40)).padEnd(46)+'L'+Math.round(r.left)+' R'+Math.round(r.right)+' W'+Math.round(r.width)+' pos='+cs.position+' ovX='+cs.overflowX+' disp='+cs.display);e=e.parentElement}
 o.push('clientWidth='+document.documentElement.clientWidth+' innerWidth='+innerWidth+' scrollW='+document.documentElement.scrollWidth);
 const s=document.querySelector('.mobile-search .form-control, .mobile-search input');const sr=s.getBoundingClientRect();o.push('input L'+Math.round(sr.left)+' R'+Math.round(sr.right));
 const f=document.querySelector('.mobile-search form, .mobile-search .inline-form');if(f){const fr=f.getBoundingClientRect();o.push('form L'+Math.round(fr.left)+' R'+Math.round(fr.right)+' '+f.className)}
 return o.join('\n')}));
await b.close();
