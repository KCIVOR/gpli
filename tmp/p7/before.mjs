import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, w='393', path='/admin/courses'] = process.argv;
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:+w,height:852},storageState:'tmp/auth/admin.json'});
const p = await c.newPage(); const errs=[]; p.on('pageerror',e=>errs.push(e.message)); p.on('console',m=>{if(m.type()==='error')errs.push(m.text().slice(0,140))});
await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'}); await p.waitForTimeout(800);
console.log(await p.evaluate(()=>{const t=document.querySelector('table.dataTable');const tr=t.querySelector('tbody tr');const td=tr.firstElementChild;const cs=getComputedStyle(td,'::before');
 return ['tr role='+tr.getAttribute('role')+' td classes='+td.className,'::before content='+cs.content+' display='+cs.display+' w='+cs.width+' h='+cs.height+' bg='+cs.backgroundColor+' color='+cs.color+' pos='+cs.position+' left='+cs.left,
 'DataTables version: '+(window.jQuery&&jQuery.fn.dataTable?jQuery.fn.dataTable.version:'?')+' | Responsive: '+(window.jQuery&&jQuery.fn.dataTable&&jQuery.fn.dataTable.Responsive?jQuery.fn.dataTable.Responsive.version:'none'),
 'table style attr: '+t.getAttribute('style'),'th2 style: '+t.querySelectorAll('thead th')[1].getAttribute('style'),'td2 style: '+tr.children[1].getAttribute('style')].join('\n')}));
console.log('errors:',JSON.stringify(errs.slice(0,4)));
await b.close();
