import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
for (const path of ['/admin/dashboard','/admin/courses']) for (const w of [768, 790, 1024, 1100, 1440]) {
  const c = await b.newContext({viewport:{width:w,height:800},storageState:'tmp/auth/admin.json'});
  const p = await c.newPage(); await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'}); await p.waitForTimeout(600);
  const st = () => p.evaluate(()=>{const s=document.querySelector('.left-side-menu').getBoundingClientRect(),cp=document.querySelector('.content-page').getBoundingClientRect();return `${document.body.classList.contains('enlarged')?'rail':'full'} sidebar=${Math.round(s.width)}px content=${Math.round(cp.left)}..${Math.round(cp.right)} pageOverflow=${document.documentElement.scrollWidth>innerWidth}`});
  const a = await st();
  await p.click('.gp-admin-topbar .button-menu-mobile'); await p.waitForTimeout(600);   // real mouse click
  const bst = await st();
  if (path==='/admin/dashboard' && (w===790||w===1440)) await p.screenshot({path:`tmp/p7/collapse-${w}.png`});
  await p.click('.gp-admin-topbar .button-menu-mobile'); await p.waitForTimeout(500);
  const cst = await st();
  console.log(path.padEnd(16),String(w).padEnd(5),'|',a,'| click ->',bst,'| click ->',cst.split(' ')[0]);
  await c.close();
}
await b.close();
