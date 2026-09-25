import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const [auth,theme] of [['guest','light'],['guest','dark'],['admin','light'],['admin','dark']]) {
  const c = await b.newContext({viewport:{width:390,height:640},...(auth==='admin'?{storageState:'tmp/auth/admin.json'}:{})});
  await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
  const p = await c.newPage(); await p.goto('http://localhost/academy/',{waitUntil:'networkidle'});
  await p.evaluate(()=>{const e=document.getElementById('cookieConsentContainer');if(e)e.style.display='none'});
  await p.click('.menu-offcanves .btn-bar'); await p.waitForTimeout(700);
  await p.screenshot({path:`tmp/p7/drawer4-${auth}-${theme}.png`,clip:{x:0,y:0,width:390,height:520}});
  await c.close();
}
await b.close();
