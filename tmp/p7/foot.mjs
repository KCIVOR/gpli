import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const [w,t] of [[1100,'light'],[390,'light'],[390,'dark'],[820,'light']]) {
  const c = await b.newContext({viewport:{width:w,height:800}});
  await c.addInitScript(x=>localStorage.setItem('gp-ds-theme',x),t);
  const p = await c.newPage();
  await p.goto('http://localhost/academy/home/faq',{waitUntil:'networkidle'});
  await p.evaluate(()=>{const e=document.getElementById('cookieConsentContainer');if(e)e.style.display='none'});
  const el = await p.$('.gp-footer-bottom'); await el.scrollIntoViewIfNeeded(); await p.waitForTimeout(300);
  await el.screenshot({path:`tmp/p7/foot-${w}-${t}.png`});
  await c.close();
}
await b.close();
