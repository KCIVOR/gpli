import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
const theme = process.argv[2]||'light';
for (const w of [1024,768,390,360]) {
  const c = await b.newContext({viewport:{width:w,height:844}});
  await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
  const p = await c.newPage();
  await p.goto('http://localhost/academy/home/courses',{waitUntil:'networkidle'});
  await p.screenshot({path:`tmp/p1/${theme}-${w}-header.png`,clip:{x:0,y:0,width:w,height:160}});
  const info = await p.evaluate(()=>{const q=s=>[...document.querySelectorAll(s)].map(e=>{const r=e.getBoundingClientRect(),cs=getComputedStyle(e);return s+' '+Math.round(r.left)+','+Math.round(r.top)+' '+Math.round(r.width)+'x'+Math.round(r.height)+' disp='+cs.display+' vis='+cs.visibility});
    return [...q('.gp-site-header'),...q('.navbar-collapse'),...q('.gp-header-search'),...q('.menu-offcanves'),...q('.btn-bar'),...q('.gp-theme-row'),...q('.gp-header-tools'),...q('.m-search-icon'),...q('.mobile-search'),...q('.menu_pro_cart_tgl'),...q('.wisth_tgl_2div')].join('\n')});
  console.log('== '+w+'\n'+info);
  await c.close();
}
await b.close();
