import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:390,height:760}});
const p = await c.newPage();
await p.goto('http://localhost/academy/',{waitUntil:'networkidle'});
await p.click('.m-search-icon'); await p.waitForTimeout(500);
console.log(await p.evaluate(()=>{const res=[];for(const [sel,props] of [['.mobile-search .form-control',['margin-left','margin','width','max-width']],['.mobile-search .search-btn',['left','right','top','position','width','margin']]]){const el=document.querySelector(sel);const cs=getComputedStyle(el);res.push('## '+sel+' '+props.map(p=>p+'='+cs.getPropertyValue(p)).join('; '));
 for(const ss of document.styleSheets){let rs;try{rs=ss.cssRules}catch{continue}const file=(ss.href||'inline').split('/').pop().split('?')[0];if(/bootstrap|app\.css/.test(file))continue;
 const walk=(list,m)=>{for(const r of list){if(r.type===4){if(matchMedia(r.conditionText).matches)walk(r.cssRules,r.conditionText)}else if(r.selectorText){let ok=false;try{ok=el.matches(r.selectorText)}catch{}if(ok)for(const pr of props){const v=r.style.getPropertyValue(pr);if(v)res.push('   '+pr+': '+v+(r.style.getPropertyPriority(pr)?' !important':'')+' <- '+file+' | '+r.selectorText.slice(0,80)+(m?' @'+m:''))}}}};walk(rs,'')}}
 return res.join('\n')}));
await b.close();
