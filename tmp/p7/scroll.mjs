import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const [w,name,path,theme] of [[730,'courses','/admin/courses','dark'],[393,'users','/admin/users','light']]) {
  const c = await b.newContext({viewport:{width:w,height:852},storageState:'tmp/auth/admin.json'});
  await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
  const p = await c.newPage(); await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'}); await p.waitForTimeout(700);
  const t = await p.$('table.dataTable'); await t.scrollIntoViewIfNeeded(); const box = await t.boundingBox();
  const clip={x:0,y:Math.max(0,box.y-60),width:w,height:330};
  await p.screenshot({path:`tmp/p7/scroll-${name}-a.png`,clip});
  await p.evaluate(()=>{const t=document.querySelector('table.dataTable');t.scrollLeft=t.scrollWidth});await p.waitForTimeout(300);
  await p.screenshot({path:`tmp/p7/scroll-${name}-b.png`,clip});
  await c.close();
}
await b.close();
