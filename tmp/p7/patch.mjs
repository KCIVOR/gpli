import { readFileSync, writeFileSync } from 'node:fs';
const p = 'scripts/audit-responsive-design-system.mjs';
let s = readFileSync(p, 'utf8');
const rep = (a, b) => { if (!s.includes(a)) throw new Error('anchor missing: ' + a.slice(0, 60)); s = s.replace(a, () => b); };

// 1. run public routes logged in with --as <role>
rep("const onlyRoute = opt('route', null);", "const onlyRoute = opt('route', null);\nconst asRole = opt('as', null); // run public routes with tmp/auth/<role>.json (logged-in header and drawer)");
rep("...(route.role !== 'public' ? { storageState: authFile } : {}) }", "...(route.role !== 'public' ? { storageState: authFile } : asRole ? { storageState: 'tmp/auth/' + asRole + '.json' } : {}) }");
rep("const shot = `${outDir}/${route.name}-${theme}-${vp.width}.png`;", "const shot = `${outDir}/${route.name}${asRole ? '-as-' + asRole : ''}-${theme}-${vp.width}.png`;");

// 2. search overlay must span the viewport and sit below the drawer; field and button inside it
rep("return { fieldVisible: !!f && f.getBoundingClientRect().width > 0, right: r && r.right, transparent: !bg || bg === 'rgba(0, 0, 0, 0)', legacy: scan('.gp-site-header') };",
    "const fr = f && f.getBoundingClientRect(); const btn = document.querySelector('.mobile-search .search-btn'); const br = btn && btn.getBoundingClientRect(); return { fieldVisible: !!f && f.getBoundingClientRect().width > 0, left: r && r.left, right: r && r.right, fieldRight: fr && fr.right, fieldLeft: fr && fr.left, btnRight: br && br.right, z: box && Number(getComputedStyle(box).zIndex), transparent: !bg || bg === 'rgba(0, 0, 0, 0)', legacy: scan('.gp-site-header') };");
rep("if (s.right > vp.width + 1) fail('search overlay wider than viewport');",
    "if (s.right > vp.width + 1) fail('search overlay wider than viewport');\n    if (s.left < -1 || s.right < vp.width - 1) fail('search overlay does not span the screen (' + Math.round(s.left) + '..' + Math.round(s.right) + ' of ' + vp.width + ')');\n    if (s.fieldLeft < 0 || s.fieldRight > vp.width || s.btnRight > vp.width) fail('search field or button outside the screen');\n    if (s.z >= 1045) fail('search overlay z-index ' + s.z + ' would sit above the navigation drawer (1045)');");

// 3. with search still open, opening the drawer must cover the overlay; then run the drawer probe
rep("    // drawer\n    await page.goto(baseUrl + path, { waitUntil: 'networkidle' });\n    await page.click('.menu-offcanves .btn-bar', { timeout: 5000 });\n    await page.waitForTimeout(700);",
    "    // drawer opened on top of an open search panel\n    await page.click('.menu-offcanves .btn-bar', { timeout: 5000 });\n    await page.waitForTimeout(700);\n    const covered = await page.evaluate(() => { const hit = document.elementFromPoint(20, 100); return !!hit && !!hit.closest('#offcanvasWithBothOptions'); });\n    if (!covered) fail('open search panel sits on top of the navigation drawer');\n    await page.screenshot({ path: outDir + '/' + tag + '-search-and-drawer.png', clip: { x: 0, y: 0, width: vp.width, height: 420 } });\n    // drawer alone\n    await page.goto(baseUrl + path, { waitUntil: 'networkidle' });\n    await page.click('.menu-offcanves .btn-bar', { timeout: 5000 });\n    await page.waitForTimeout(700);");

// 4. logged-in drawer profile text contrast
rep("['.offcanves-btn .signUp-btn', '.offcanves-btn .logIn-btn', '.btn-toggle-list', '.btn-toggle']", "['.offcanves-btn .signUp-btn', '.offcanves-btn .logIn-btn', '.btn-toggle-list', '.btn-toggle', '.user-details h4', '.user-details p']");
writeFileSync(p, s);
