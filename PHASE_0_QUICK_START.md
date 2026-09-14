# Phase 0 — Quick Start & Validation Guide

## ✅ What's Done

**Phase 0 Foundation is complete!** All files created, all modifications made. **Zero pages migrated** — everything is inert until you activate it.

---

## 🚀 Quick Validation (5 minutes)

### Step 1: Verify Config Loading
```
http://localhost/academy/assets/design-system/phase-0-validation.php
```
**Expected:** See 3 empty arrays and 4 files with sizes > 0

### Step 2: Visual Regression Check
Load these pages and verify **NO visual change**:

**Frontend:**
- http://localhost/academy/
- http://localhost/academy/home/login
- http://localhost/academy/home/courses

**Admin:**
- http://localhost/academy/admin
- http://localhost/academy/admin/categories

**User/Instructor:**
- http://localhost/academy/user
- http://localhost/academy/user/courses

**Expected:** All pages look exactly the same as before.

### Step 3: Browser Console Check
- Open DevTools (F12)
- Check Console tab: no errors
- Check Network tab: verify new CSS/JS files load (200 status)

### Step 4: Verify Theme Toggle Hidden
- Inspect any page's `<body>` tag
- Confirm NO `.gp-ds` class present
- Confirm theme toggle buttons NOT visible anywhere

---

## 📁 What Was Created

```
assets/design-system/
├── gp-tokens.css              ← All design tokens (colors, typography, spacing)
├── gp-base.css                ← Base typography and element styles
├── gp-components-core.css     ← Buttons, cards, badges, alerts, forms
└── gp-theme-toggle.js         ← Light/System/Dark theme switcher
```

**Config:**
```
application/config/design_system_pages.php  ← Empty whitelists (no pages active)
```

---

## 🔧 Modified Files (6 files)

1. `frontend/default-new/includes_top.php` — Added font links + CSS/JS
2. `backend/includes_top.php` — Added font links + CSS/JS
3. `frontend/default-new/index.php` — Conditional `.gp-ds` class on `<body>`
4. `backend/index.php` — Conditional `.gp-ds` class on `<body>`
5. `frontend/default-new/header.php` — Theme toggle markup (hidden until activated)
6. `backend/header.php` — Theme toggle markup (hidden until activated)

---

## 🎯 How It Works

### The Whitelist System
```php
// application/config/design_system_pages.php
$config['gp_ds_frontend_pages'] = []; // Empty = no frontend pages migrated
$config['gp_ds_admin_pages'] = [];    // Empty = no admin pages migrated
$config['gp_ds_user_pages'] = [];     // Empty = no user pages migrated
```

### The Activation Flow
1. Page loads → checks its `$page_name` against whitelist
2. If found → adds `.gp-ds` class to `<body>`
3. If not found → NO class added, design system stays inert

**Current state:** All whitelists empty → no pages have `.gp-ds` → zero visual impact

---

## 🧪 Test Activation (Optional)

Want to see it work? Add one page to test:

```php
// In application/config/design_system_pages.php
$config['gp_ds_frontend_pages'] = ['login']; // Activate design system on login page only
```

Then visit: `http://localhost/academy/home/login`

**You should see:**
- Theme toggle buttons in header (Light/System/Dark)
- Page can be toggled between light/dark modes
- Manrope/Inter fonts loading
- New button/form styles (if page uses `.btn` or form elements)

**To revert:** Remove `'login'` from array, reload page.

---

## 🛡️ Safety Guarantees

✅ **No blanket Bootstrap overrides** — All CSS scoped under `.gp-ds`  
✅ **No production pages affected** — Whitelists start empty  
✅ **No business logic touched** — UI-only changes  
✅ **Instant rollback** — Remove page from whitelist  
✅ **No breaking changes** — Existing CSS still loads, existing classes still work  

---

## 📊 File Sizes (Total: ~17.5 KB)

- `gp-tokens.css`: 5.2 KB
- `gp-base.css`: 2.1 KB
- `gp-components-core.css`: 8.4 KB
- `gp-theme-toggle.js`: 1.8 KB

**Impact:** ~18 KB added to every page load (minified/gzipped would be ~5 KB)

---

## 🔄 Rollback (if needed)

### Quick Rollback — Disable Everything
```php
// Empty the config arrays
$config['gp_ds_frontend_pages'] = [];
$config['gp_ds_admin_pages'] = [];
$config['gp_ds_user_pages'] = [];
```
**Result:** Design system completely disabled, zero visual change.

### Full Rollback — Delete Everything
```bash
# Remove new files
rm assets/design-system/gp-*.css
rm assets/design-system/gp-theme-toggle.js

# Revert modified files (if using git)
git checkout application/views/frontend/default-new/includes_top.php
git checkout application/views/backend/includes_top.php
git checkout application/views/frontend/default-new/index.php
git checkout application/views/backend/index.php
git checkout application/views/frontend/default-new/header.php
git checkout application/views/backend/header.php
```

---

## ✅ Validation Checklist

- [ ] `phase-0-validation.php` shows 3 empty arrays
- [ ] All 4 files show EXISTS with size > 0
- [ ] 8 sample pages load with zero visual change
- [ ] Browser console shows no errors
- [ ] Network tab shows new files load successfully (200)
- [ ] No `.gp-ds` class on any `<body>` tag
- [ ] Theme toggle buttons not visible anywhere
- [ ] PHP syntax check passes (already done ✅)

**When all checked:** Phase 0 is validated ✅

---

## 🚦 Next Steps

After validation:
1. **Phase 1:** Build primitives in isolation (scratch page)
2. **Phase 1-Pilot:** Migrate 3 representative pages
3. **Phase 2:** High-footprint component rollout

**Don't proceed until Phase 0 validation is complete.**

---

## 🆘 Troubleshooting

### "Config arrays not loading"
- Check file path: `application/config/design_system_pages.php`
- Verify file has `<?php` opening tag
- Clear CodeIgniter cache if enabled

### "Fonts not loading"
- Check browser console for CORS errors
- Verify Google Fonts URL in `includes_top.php`

### "Theme toggle not working"
- Normal! It's hidden because whitelist is empty
- Add a page to whitelist to test

### "Syntax error in modified files"
- Already checked — all files pass `php -l` ✅

---

**Questions? Check `PHASE_0_COMPLETION_REPORT.md` for full details.**

**Ready to proceed? Validate first, then request Phase 1.**
