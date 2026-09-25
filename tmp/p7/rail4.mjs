import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, path='/admin/courses', w='790'] = process.argv;
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:+w,height:800},storageState:'tmp/auth/admin.json'});
const p = await c.newPage(); await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'}); await p.waitForTimeout(700);
const info = () => p.evaluate(()=>{const lis=[...document.querySelectorAll('.left-side-menu .side-nav-item')].filter(li=>li.querySelector(':scope > ul.side-nav-second-level'));return lis.slice(0,3).map((li,i)=>{const ul=li.querySelector(':scope > ul');return `#${i} ${li.querySelector('a span')?.textContent.trim().slice(0,12)} ul.class="${ul.className.replace(/\s+/g,' ').trim()}" display=${getComputedStyle(ul).display} li.mm-active=${li.classList.contains('mm-active')}`}).join('\n   ')+'\n   sidebar='+Math.round(document.querySelector('.left-side-menu').getBoundingClientRect().width)+'px'});
console.log('initial:\n   '+await info());
// click the parent of the CURRENT page's section (the one that is already open)
const idx = await p.evaluate(()=>{const lis=[...document.querySelectorAll('.left-side-menu .side-nav-item')].filter(li=>li.querySelector(':scope > ul.side-nav-second-level'));return lis.findIndex(li=>li.querySelector(':scope > ul').classList.contains('in'))});
console.log('parent with an already-open dropdown: index',idx);
if (idx>=0) { await p.locator('.left-side-menu .side-nav-item:has(> ul.side-nav-second-level) > a.side-nav-link').nth(idx).click(); await p.waitForTimeout(700); console.log('after clicking it in the rail:\n   '+await info()); }
await b.close();
