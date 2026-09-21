import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const w=+process.argv[2]||390;
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:w,height:844},storageState:'tmp/auth/admin.json'});
const p = await c.newPage();
await p.goto('http://localhost/academy/admin/message',{waitUntil:'networkidle'});
console.log(await p.evaluate(()=>{const o=[];const bar=document.querySelector('.gp-admin-topbar');const br=bar.getBoundingClientRect();o.push('bar '+Math.round(br.width));
 const l=document.querySelector('.gp-admin-topbar-left').getBoundingClientRect();o.push('left L'+Math.round(l.left)+' R'+Math.round(l.right));
 for(const li of document.querySelectorAll('.gp-admin-topbar-right > li')){const r=li.getBoundingClientRect(),cs=getComputedStyle(li);o.push((li.className.slice(0,50)).padEnd(52)+'L'+Math.round(r.left)+' R'+Math.round(r.right)+' W'+Math.round(r.width)+' disp='+cs.display)}
 const off=[];for(const e of document.body.querySelectorAll('*')){const r=e.getBoundingClientRect();if(r.right>innerWidth+1&&r.width>0&&getComputedStyle(e).visibility!=='hidden')off.push(e.tagName+'.'+String(e.className).slice(0,40)+' R'+Math.round(r.right))}
 o.push('offenders: '+off.slice(0,8).join(' | '));return o.join('\n')}));
await b.close();
