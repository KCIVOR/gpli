# Phase 4 + Bugfix Report — 3 Confirmed Issues Resolved

**Date:** Saturday, September 12, 2026  
**Status:** Fixed — pending your browser confirmation on admin (requires login)

---

## Issue 1: Dual Bootstrap Load on Admin (Phase 4)

### Problem
`application/views/backend/includes_top.php` loaded **both** Bootstrap 5.3.1 and Bootstrap 4.3.1 (via `app.min.css`) on every admin page.

### Fix Applied
| Before | After |
|--------|-------|
| `app.min.css` (BS 4.3.1 + Hyper theme bundled) | `hyper-admin-theme.css` (Hyper theme only, BS4 core stripped) |
| `app.min.js` (jQuery + BS4 + Hyper plugins bundled) | `hyper-admin-plugins.js` (Hyper plugins only, BS4 JS stripped) |
| DataTables `*.bootstrap4.*` | DataTables `*.bootstrap5.*` (downloaded to vendor/) |
| BS5 bundle + BS4 from app.min.js | BS5 bundle only + `gp-bs5-admin-bridge.js` |

### New Files
- `assets/backend/css/hyper-admin-theme.css` — extracted from `app.css` lines 8105+ (4,428 lines)
- `assets/backend/js/hyper-admin-plugins.js` — extracted from `app.js` lines 21983+ (slimScroll, MetisMenu, Hyper App init)
- `assets/backend/js/gp-bs5-admin-bridge.js` — maps `data-toggle` → `data-bs-toggle`, jQuery `.modal()` / `.tooltip()` bridges

### Modified Files
- `application/views/backend/includes_top.php`
- `application/views/backend/includes_bottom.php`

### Rollback
Restore `app.min.css` / `app.min.js` links and bootstrap4 DataTables vendor files.

---

## Issue 2: Half-Dark Pages on OS Dark Mode

### Problem
Default theme was `system`, which silently applied dark CSS variables to migrated components while legacy page styling stayed light.

### Fix Applied (3 layers)
1. **`gp-theme-toggle.js`** — default changed from `'system'` to `'light'` when no localStorage value exists
2. **`gp-tokens.css`** — `@media (prefers-color-scheme: dark)` now applies **only** when `data-theme="system"` (not when attribute is absent)
3. **`index.php` (frontend + backend)** — whitelisted pages render with `data-theme="light"` on `<body>` before JS runs (prevents FOUC)

### Verified (curl)
```
http://localhost/academy/home/courses → <body class=" gp-ds" data-theme="light">
http://localhost/academy/home/login   → <body class=" gp-ds" data-theme="light">
```

**Manual test still needed:** Open courses page with OS dark mode, no localStorage — sidebar should stay light.

---

## Issue 3: Icon-Only `.btn` Buttons Broken

### Problem
`.gp-ds .btn` applied CTA pill styling (15px/26px padding, uppercase, flex) to legacy icon-only buttons like `.btn.list-btn`.

### Fix Applied
- **`gp-components-core.css`** — base button styles scoped to named variants only:
  - `.btn-primary`, `.btn-secondary`, `.btn-outline`, `.btn-quiet`
- **`gp-modal.css`** — modal footer button sizing scoped to named variants only
- Bare `.btn` (e.g. `.btn.list-btn`, upload labels) left to existing LMS CSS

### Verified (curl)
Courses page still renders:
```html
<button class="btn list-btn active" ...>
```
No longer receives design-system CTA pill treatment.

---

## Live Verification Checklist

### Frontend — `http://localhost/academy/home/courses` ✅ HTTP 200
- [ ] Grid/list toggle icons visible (not 2px wide)
- [ ] Category filter sidebar light with OS dark mode + cleared localStorage
- [ ] Theme toggle: Light default, System/Dark still work when chosen

### Admin — `http://localhost/academy/admin/categories` (login required)
- [ ] Page loads, sidebar/topbar layout intact
- [ ] DataTables sort/search/paging work
- [ ] Modals open (delete confirm, edit forms)
- [ ] DevTools Network: **no** `app.min.css` or `app.min.js`
- [ ] DevTools Network: **yes** `hyper-admin-theme.css`, `bootstrap.min.css`, `dataTables.bootstrap5.min.css`

### User — `http://localhost/academy/user/dashboard` (login required)
- [ ] Dashboard loads, stat cards render
- [ ] Chart.js still works
- [ ] Theme toggle visible and functional

### Clear localStorage before dark-mode test
```javascript
localStorage.removeItem('gp-ds-theme');
location.reload();
```

---

## Phase 4 Follow-up Fixes (Round 2)

### Bug A: `moment is not defined` (FullCalendar broken)

**Cause:** `moment.js` was bundled inside the removed `app.min.js` but not included in `hyper-admin-plugins.js`.

**Fix:**
- Extracted `assets/backend/js/vendor/moment.js` from original `app.js` bundle
- Loaded **before** `hyper-admin-plugins.js` in `includes_bottom.php`

### Bug B: Invisible admin dropdowns

**Cause:** `hyper-admin-theme.css` used BS4 selector `.show > .dropdown-menu` but BS5 adds `.show` directly on `.dropdown-menu`. Animated menus (`.dropdown-menu-animated`) stayed at `opacity: 0; visibility: hidden`.

**Fix:**
```css
.dropdown-menu.show,
.show > .dropdown-menu { visibility: visible; opacity: 1; ... }
```

**Manual verify (logged in):** topbar profile menu, notification bell, Students table row ⋮ menu.

### Bug C (round 3): Same menus still invisible + row ⋮ dead after AJAX

**Topbar — why the previous CSS selector fix was not enough:**
1. Hyper `.dropdown-menu-animated` used `display:block` + `opacity:0` and only faded when the *parent* had `.show`.
2. `.gp-ds .dropdown-menu { display:flex }` overrode Bootstrap `display:none`, so menus stayed in the layout.
3. `.notification-list .dropdown-menu { transform:none !important; top:100% !important }` cancelled Popper. With `position:fixed` that places the menu at the bottom of the viewport — still invisible even with `opacity: 1 !important` on the element.
4. Leftover Hyper demo `transform: translate3d(...)` inline styles in `header.php`.

**Row ⋮ — DataTables timing:** Students (and other server-side tables) inject `data-toggle="dropdown"` after the one-time migrate on page load.

**Fixes:** Hyper fade disabled; `.gp-ds` menus gated on `.show`; transform-kill rule removed; leftover inline styles stripped; bridge re-hydrates on `draw.dt` / `init.dt` and `onDomChange`.

**Headless check:** `assets/design-system/dropdown-bs5-verify.html` → `opacity: 1`, `visibility: visible`, `pass: true`.

---

## Risk Notes (Phase 4)

**Medium risk** — admin JS stack changed. Watch for:
- Dropdown menus in topbar (bridge handles `data-toggle`)
- AJAX modals (`showAjaxModal` uses jQuery `.modal('show')` — bridged)
- Summernote still loads `summernote-bs4` (editor plugin name; not Bootstrap CSS conflict)
- If any admin page breaks, rollback includes_top/bottom to `app.min.*` files

**Original `app.min.css` and `app.min.js` are NOT deleted** — still in repo for rollback.
