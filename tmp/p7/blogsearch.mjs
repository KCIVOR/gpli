import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const t of ['dark','light']) {
  const c = await b.newContext({viewport:{width:470,height:520}});
  await c.addInitScript(x=>localStorage.setItem('gp-ds-theme',x),t);
  const p = await c.newPage(); await p.goto('http://localhost/academy/blog',{waitUntil:'networkidle'});
  await p.evaluate(()=>{const e=document.getElementById('cookieConsentContainer');if(e)e.style.display='none'});
  await p.click('.m-search-icon'); await p.waitForTimeout(500);
  await p.screenshot({path:`tmp/p7/blogsearch-${t}.png`,clip:{x:0,y:0,width:470,height:300}});
  await c.close();
}
await b.close();
