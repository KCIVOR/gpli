import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const [,, w='390', path='/admin/message', targetsJson='[]'] = process.argv;
const b = await chromium.launch();
const c = await b.newContext({viewport:{width:+w,height:844},storageState:'tmp/auth/admin.json'});
await c.addInitScript(()=>localStorage.setItem('gp-ds-theme','light'));
const p = await c.newPage();
await p.goto('http://localhost/academy'+path,{waitUntil:'networkidle'});
const out = await p.evaluate((targets)=>{
  const res=[];
  const box=s=>{const e=document.querySelector(s);if(!e)return s+' MISSING';const r=e.getBoundingClientRect(),cs=getComputedStyle(e);return s.padEnd(34)+'L'+Math.round(r.left)+' R'+Math.round(r.right)+' T'+Math.round(r.top)+' W'+Math.round(r.width)+' H'+Math.round(r.height)+' disp='+cs.display+' pos='+cs.position+' vis='+cs.visibility};
  for(const s of ['.gp-admin-topbar','.gp-admin-topbar .container-fluid','.gp-admin-topbar-left','.button-menu-mobile','.topnav-logo','.gp-admin-topbar-right','.gp-admin-user-item','.left-side-menu','.content-page','.wrapper','body'])res.push(box(s));
  res.push('body classes: '+document.body.className+' | data-layout='+document.body.dataset.layout+' | sidebar-enable? '+document.body.classList.contains('sidebar-enable'));
  for(const [sel,props] of targets){const el=document.querySelector(sel);if(!el){res.push('## '+sel+' MISSING');continue}
    const cs=getComputedStyle(el);res.push('## '+sel+' :: '+props.map(pr=>pr+'='+cs.getPropertyValue(pr)).join('; '));
    for(const ss of document.styleSheets){let rs;try{rs=ss.cssRules}catch{continue}const file=(ss.href||'inline').split('/').pop().split('?')[0];
      const walk=(list,media)=>{for(const r of list){if(r.type===4){if(matchMedia(r.conditionText).matches)walk(r.cssRules,r.conditionText)}else if(r.selectorText){let m=false;try{m=el.matches(r.selectorText)}catch{}
        if(m)for(const pr of props){const v=r.style.getPropertyValue(pr);if(v)res.push('   '+pr+': '+v+(r.style.getPropertyPriority(pr)?' !important':'')+' <- '+file+' | '+r.selectorText.slice(0,100)+(media?' @'+media:''))}}}};walk(rs,'')}}
  return res.join('\n')},JSON.parse(targetsJson));
console.log(out);await b.close();
