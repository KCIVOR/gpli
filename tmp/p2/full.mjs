import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, theme='light', w='390', ...paths] = process.argv;
const b = await chromium.launch();
for (const [name,path] of paths.map(x=>{const i=x.indexOf('=');return [x.slice(0,i),'/'+x.slice(i+1)]})) {
  const c = await b.newContext({viewport:{width:+w,height:1000}});
  await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
  const p = await c.newPage();
  await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'});
  await p.evaluate(()=>{const e=document.getElementById('cookieConsentContainer');if(e)e.style.display='none'});
  const h=await p.evaluate(()=>document.body.scrollHeight);await p.setViewportSize({width:+w,height:Math.min(h,2600)});await p.waitForTimeout(300);await p.screenshot({path:'tmp/p2/'+name+'-'+theme+'-'+w+'.png'});console.log(name,h);
  await c.close();
}
await b.close();
