import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
const theme=process.argv[2]||'light';
for (const w of [1024,992]) {
const c = await b.newContext({viewport:{width:w,height:700}});
await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
const p = await c.newPage();
await p.goto('http://localhost/academy/home/courses',{waitUntil:'networkidle'});
await p.click('.menu_pro_cart_tgl'); await p.waitForTimeout(500);
await p.screenshot({path:`tmp/p1/${theme}-${w}-cart.png`,clip:{x:0,y:0,width:w,height:420}});
const r=await p.evaluate(()=>[...document.querySelectorAll('.path_pos_wish,.path_pos_wish-2,.menu_pro_wish')].map(e=>{const b=e.getBoundingClientRect();return e.className+' L'+Math.round(b.left)+' R'+Math.round(b.right)+' W'+Math.round(b.width)+' disp='+getComputedStyle(e).display}));
console.log(w,r.join('\n'));
await c.close();}
const c = await b.newContext({viewport:{width:768,height:900}});
await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
const p = await c.newPage();
await p.goto('http://localhost/academy/home/courses',{waitUntil:'networkidle'});
await p.evaluate(()=>{document.querySelector('.gp-site-footer').scrollIntoView()});await p.waitForTimeout(300);
await p.screenshot({path:`tmp/p1/${theme}-768-footer.png`});
await b.close();
