import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, theme='light', w='390', ...paths] = process.argv;
const b = await chromium.launch();
for (const x of paths) { const i=x.indexOf('='); const name=x.slice(0,i), path='/'+x.slice(i+1);
  const c = await b.newContext({viewport:{width:+w,height:1000},storageState:'tmp/auth/admin.json'});
  await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
  const p = await c.newPage();
  await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'});
  const h = await p.evaluate(()=>Math.max(document.body.scrollHeight,document.documentElement.scrollHeight));
  await p.setViewportSize({width:+w,height:Math.min(h,2400)}); await p.waitForTimeout(300);
  await p.screenshot({path:`tmp/p4/${name}-${theme}-${w}.png`});
  console.log(name,h); await c.close(); }
await b.close();
