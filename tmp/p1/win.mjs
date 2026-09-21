import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();
const theme=process.argv[2]||'light', w=+process.argv[3]||390;
const c = await b.newContext({viewport:{width:w,height:844}});
await c.addInitScript(t=>localStorage.setItem('gp-ds-theme',t),theme);
const p = await c.newPage();
await p.goto('http://localhost/academy/home/courses',{waitUntil:'networkidle'});
await p.click('.menu-offcanves .btn-bar'); await p.waitForTimeout(700);
const targets = JSON.parse(process.argv[4]);
const out = await p.evaluate((targets)=>{
  const res=[];
  for (const [sel,props] of targets){
    const el=document.querySelector(sel); if(!el){res.push(sel+' MISSING');continue}
    const cs=getComputedStyle(el);
    res.push('## '+sel+' :: '+props.map(pr=>pr+'='+cs.getPropertyValue(pr)).join('; '));
    const hits=[];
    for(const ss of document.styleSheets){let rs;try{rs=ss.cssRules}catch{continue}
      const file=(ss.href||'inline').split('/').pop().split('?')[0];
      const walk=(list,media)=>{for(const r of list){
        if(r.type===4){ if(matchMedia(r.conditionText).matches) walk(r.cssRules,r.conditionText)}
        else if(r.selectorText){let m=false;try{m=el.matches(r.selectorText)}catch{}
          if(m) for(const pr of props){const v=r.style.getPropertyValue(pr); if(v) hits.push('   '+pr+': '+v+(r.style.getPropertyPriority(pr)?' !important':'')+'  <- '+file+' | '+r.selectorText.slice(0,110)+(media?' @'+media:''))}}}};
      walk(rs,'')}
    res.push(...hits);
  }
  return res.join('\n')}, targets);
console.log(out);await b.close();
