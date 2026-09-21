import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, w, path, targetsJson] = process.argv;
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:+w,height:900},storageState:'tmp/auth/admin.json'});
const p = await c.newPage();
await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'});
console.log(await p.evaluate((targets)=>{const res=[];
 for(const [sel,props] of targets){const el=document.querySelector(sel);if(!el){res.push('## '+sel+' MISSING');continue}
  const r=el.getBoundingClientRect(),cs=getComputedStyle(el);res.push('## '+sel+' L'+Math.round(r.left)+' R'+Math.round(r.right)+' W'+Math.round(r.width)+' :: '+props.map(pr=>pr+'='+cs.getPropertyValue(pr)).join('; '));
  res.push('   parent: '+el.parentElement.tagName+'.'+String(el.parentElement.className).slice(0,40)+' R'+Math.round(el.parentElement.getBoundingClientRect().right)+' W'+Math.round(el.parentElement.getBoundingClientRect().width));
  for(const ss of document.styleSheets){let rs;try{rs=ss.cssRules}catch{continue}const file=(ss.href||'inline').split('/').pop().split('?')[0];
   const walk=(list,media)=>{for(const r of list){if(r.type===4){if(matchMedia(r.conditionText).matches)walk(r.cssRules,r.conditionText)}else if(r.selectorText){let m=false;try{m=el.matches(r.selectorText)}catch{}
    if(m)for(const pr of props){const v=r.style.getPropertyValue(pr);if(v&&!/bootstrap|app\.css|app-dark/.test(file))res.push('   '+pr+': '+v+(r.style.getPropertyPriority(pr)?' !important':'')+' <- '+file+' | '+r.selectorText.slice(0,90)+(media?' @'+media:''))}}}};walk(rs,'')}}
 return res.join('\n')},JSON.parse(targetsJson)));
await b.close();
