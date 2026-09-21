import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';
const bin = execSync('where playwright',{encoding:'utf8'}).split(/\r?\n/)[0].trim();
const { chromium } = createRequire(import.meta.url)(join(dirname(bin),'..','playwright'));
const b = await chromium.launch();const p=await b.newPage({viewport:{width:390,height:844}});
await p.goto('http://localhost/academy/home/courses',{waitUntil:'networkidle'});
console.log(await p.evaluate(()=>[document.documentElement.scrollHeight,document.body.scrollHeight,getComputedStyle(document.documentElement).overflowY,getComputedStyle(document.body).overflowY,getComputedStyle(document.body).height]));
await b.close();
