// Opens a VISIBLE browser so a person can log in themselves, then saves the session
// (cookies only, no password) to tmp/auth/<role>.json for read-only audit runs.
// Credentials are never typed by, passed to, or stored by this script.
// Usage: npx -p playwright node scripts/save-auth-session.mjs --role admin --base-url http://localhost/academy
import { mkdirSync } from 'node:fs';
import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { dirname, join } from 'node:path';

const args = process.argv.slice(2);
const opt = (k, d) => { const i = args.indexOf(`--${k}`); return i >= 0 ? args[i + 1] : d; };
const role = opt('role', 'admin');
const baseUrl = opt('base-url', 'http://localhost/academy').replace(/\/$/, '');
const landing = { admin: '/admin/', instructor: '/user/', student: '/home/my_courses' };
if (!landing[role]) { console.error('role must be admin, instructor or student'); process.exit(1); }

const req = createRequire(import.meta.url);
let chromium;
try { chromium = req('playwright').chromium; } catch {
  const bin = execSync('where playwright', { encoding: 'utf8' }).split(/\r?\n/)[0].trim();
  chromium = req(join(dirname(bin), '..', 'playwright')).chromium;
}

const browser = await chromium.launch({ headless: false });
const context = await browser.newContext();
const page = await context.newPage();
await page.goto(baseUrl + '/login');
console.log(`Log in as a NON-PRODUCTION ${role} in the browser window. Waiting up to 5 minutes...`);
try {
  await page.waitForURL((u) => u.pathname.includes(landing[role].replace(/\/$/, '')) && !u.pathname.endsWith('/login'), { timeout: 300000 });
} catch {
  console.error('Did not reach the ' + role + ' area in time; nothing saved.');
  await browser.close();
  process.exit(2);
}
mkdirSync('tmp/auth', { recursive: true });
await context.storageState({ path: `tmp/auth/${role}.json` });
console.log(`Saved tmp/auth/${role}.json (session cookies only). You can close the window.`);
await browser.close();
