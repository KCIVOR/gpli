import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, w='390', path='/admin/courses'] = process.argv;
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:+w,height:900},storageState:'tmp/auth/admin.json'});
const p = await c.newPage();
await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'});
console.log(await p.evaluate(()=>{const o=[];const B=(e)=>{const r=e.getBoundingClientRect(),cs=getComputedStyle(e);return String(e.tagName+'.'+e.className).slice(0,52).padEnd(54)+'L'+Math.round(r.left)+' R'+Math.round(r.right)+' W'+Math.round(r.width)+' ovX='+cs.overflowX+' disp='+cs.display};
 const card=document.querySelector('.content .card .card-body')||document.querySelector('.card-body');
 o.push('card-body: '+B(card));
 for(const s of ['.dataTables_wrapper','.dt-buttons','.dataTables_filter','.dataTables_length','.dataTables_info','.dataTables_paginate','.table-responsive','table.dataTable','table.table']){document.querySelectorAll(s).forEach((e,i)=>{if(i<2)o.push(B(e))})}
 const t=document.querySelector('table.dataTable, table.table');if(t){o.push('table: thead cols='+t.querySelectorAll('thead th').length+' colsVisible='+[...t.querySelectorAll('thead th')].filter(th=>th.getBoundingClientRect().left<innerWidth).length+' | class='+t.className)}
 // ancestor overflow chain of table
 let e=t;while(e&&e!==document.body){const cs=getComputedStyle(e);if(cs.overflowX!=='visible')o.push('overflow-x '+cs.overflowX+' on '+e.tagName+'.'+String(e.className).slice(0,40));e=e.parentElement}
 return o.join('\n')}));
await b.close();
