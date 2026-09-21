import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const [name,path,theme] of [['courses','/admin/courses','light'],['users','/admin/users','dark']]) {
  const c = await b.newContext({viewport:{width:393,height:852},storageState:'tmp/auth/admin.json'});
  await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
  const p = await c.newPage(); await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'}); await p.waitForTimeout(700);
  const t = await p.$('table.dataTable'); await t.scrollIntoViewIfNeeded();
  const box = await t.boundingBox();
  await p.screenshot({path:`tmp/p7/dtclosed-${name}-${theme}.png`,clip:{x:0,y:Math.max(0,box.y-70),width:393,height:430}});
  await c.close();
}
await b.close();
