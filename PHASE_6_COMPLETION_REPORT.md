# Phase 6 — Shared-shell polish + regression record

**Date:** Saturday, September 12, 2026  
**Status:** Shared-shell visual polish shipped under `.gp-ds`. Regression is a **representative sample**, not a 100% claim.  
**Constraint:** UI-only. No JS behavior changes. Default theme remains light.

Phase 6 in the plan is: after pages are migrated, polish the shared header/footer/nav treatment deferred from Phase 0, then document a testing checklist. Payment / email / install stay with the Phase 5 agent. The whitelist was not emptied or rewritten.

---

## What changed

### New file

| File | Role |
|------|------|
| `assets/design-system/gp-shell.css` | Header / footer / nav typography, color, and spacing from the hard-rule file. Loaded **after** other `gp-*.css`. |

### Shell files touched

| File | Change |
|------|--------|
| `application/views/frontend/default-new/includes_top.php` | Link `gp-shell.css` after `gp-tooltip.css` |
| `application/views/backend/includes_top.php` | Same |
| `application/views/frontend/default-new/header.php` | Theme-toggle inline styles → `gp-theme-row` / `gp-theme-btn`. IDs `gp-theme-light` / `gp-theme-system` / `gp-theme-dark` unchanged. |
| `application/views/backend/header.php` | Same theme-toggle class swap. `data-toggle="dropdown"` and `button-menu-mobile` unchanged. |
| `application/views/frontend/default-new/footer.php` | **No markup change.** Shared footer is styled via `.gp-ds footer.lms2-footer-section` in `gp-shell.css`. |

### Not changed (on purpose)

- `header_lg_device.php` / `header_sm_device.php` — cart, wishlist, `navbarHover`, offcanvas hooks left intact
- `application/views/backend/admin/navigation.php` and `user/navigation.php` — MetisMenu class names and markup left intact
- `application/views/backend/footer.php` — file exists but is **not** included by `backend/index.php`. CSS for `footer.main` is present if it is ever wired; it is not a live shared include today
- Homepage-builder footers (`components/builder/*-footer.php`) — Phase 5d
- Install footer — Phase 5e
- No JS files. If polish had required cart/wishlist or MetisMenu behavior changes, this phase would have stopped.

---

## Visual treatment (`.gp-ds` only)

Hard-rule source: `C:\Users\Rovick\Downloads\geeseprojdesignsystem (1).html`

- Theme toggle matches hard-rule `.theme-btn` (12px Inter, 7px radius, active border)
- Frontend sub-header uses `--gp-accent-2` instead of `#0D0C23`
- Menubar uses `--gp-surface` / `--gp-border`, Manrope nav labels
- Cart/wishlist badge uses `--gp-secondary` (class `menu_number` unchanged)
- Footer titles Manrope uppercase; body Inter; always-dark bar (`#EDEBE6` / `#A7A4B0`) so light-theme tokens cannot wash out footer text
- Admin topbar title uses Manrope; sidebar link type only — **no** width, collapse, or `.menu-arrow` changes

Default theme stays light (`data-theme="light"` on whitelisted bodies; `gp-theme-toggle.js` still defaults to light).

---

## Representative regression sample

This is **not** a claim that all ~135 frontend + admin + instructor + lesson + builder + payment + email + install surfaces were tested.

### Automated / headless (this wrap)

| URL | HTTP | `.gp-ds` | Notes |
|-----|------|----------|-------|
| `/home/courses` | 200 | Yes, `data-theme="light"` | `gp-shell.css` + theme buttons + `menu_pro_cart_tgl` + `lms2-footer-section` |
| `/home/login` | 200 | Yes, `data-theme="light"` | Shell CSS + footer include |
| `/home/about_us` | 200 | (whitelisted) | Page loads |
| `/` (home) | 200 | Yes | Home variants are on the whitelist (Phase 5d leftover). **Not** a non-migrated control. |
| `/home/my_notifications` | 200 | **No** (`<body class="">`) | Non-migrated control: `gp-shell.css` still linked globally but rules do not apply |
| `/assets/design-system/gp-shell.css` | 200 | — | `Content-Type: text/css` |

Admin includes: no `app.min.css` / `app.min.js`; DataTables JS is `*.bootstrap5.min.js`. Cart/wishlist/nav hook classes in `header_lg_device.php` were not renamed.

### Manual sample still required (logged-in / interactive)

**Migrated frontend (whitelist — shell polish applies):**

- [ ] `http://localhost/academy/home/courses` — sub-header + menubar type/color; Courses mega-menu still opens on hover; cart icon still opens `#cartItems`
- [ ] `http://localhost/academy/home/login` — header/footer polish; login form still submits
- [ ] `http://localhost/academy/home/shopping_cart` — cart count + checkout path
- [ ] Wishlist hover (`#wishlistItems`) on a logged-in student page (`my_courses` / `my_wishlist`)

**Migrated admin (login required):**

- [ ] `http://localhost/academy/admin/categories` — topbar theme toggle; sidebar MetisMenu expand/collapse; DataTables search/sort/page
- [ ] `http://localhost/academy/admin/dashboard` — charts still render
- [ ] Topbar profile / notification / language dropdowns visible (Phase 4 dropdown fix — do not regress)

**Migrated instructor:**

- [ ] `http://localhost/academy/user/dashboard` — same topbar + sidebar type polish; Chart.js still works

**Non-migrated (must look unchanged — no `.gp-ds`):**

- [ ] `http://localhost/academy/home/my_notifications` — confirmed `<body class="">` (not on the frontend whitelist). Header/footer must look like pre-Phase-6 LMS chrome.
- [ ] One admin page **not** on `gp_ds_admin_pages` (sidebar/topbar must stay Hyper-as-before)
- [ ] Install wizard — still `app.min.*` (Phase 5e)

Do not use `/` as the non-migrated control: `home` / `home_1`… / `home_builder` are already on `gp_ds_frontend_pages`.

**Theme:**

- [ ] Light default with cleared `localStorage` (`gp-ds-theme` removed)
- [ ] Dark / System still usable from the polished toggle
- [ ] Desktop + a mobile width on courses (offcanvas `data-bs-toggle` still opens)

### Plan §9 checklist (use on the sample above, not the whole catalog)

**Functional:** page loads · nav works · links work · forms submit · AJAX still fires · modals · dropdowns · tabs · collapse · tables / DataTables · pagination · existing buttons.

**Visual:** type / color / spacing on header, footer, and nav match the hard-rule file on **whitelisted** pages only.

**Theme:** Light / System / Dark · toggle persists · toggle readable on the dark sub-header and admin topbar.

**Responsive:** desktop, tablet, mobile — nav, offcanvas, footer wrap.

**Regression:** at least one non-migrated page per tree (frontend home, an unlisted admin page, install if reachable).

---

## Leftover untested areas

Do **not** treat these as passed:

- Payment-global (20) and email (2) — Phase 5
- Install (11) — Phase 5e
- Homepage-builder sections (`components/main/` + builder header/footer variants) — Phase 5d
- Lesson player / mobile lesson chrome
- Add-on surfaces (ebook, bootcamp, team training, tutor booking, affiliate, customer support) when those menus are enabled
- Every remaining admin DataTable (users, instructors, enrol_history, revenue, coupons, …)
- Summernote course add/edit (still `summernote-bs4` filename — Phase 4 risk)
- FullCalendar pages
- RTL (`$language_dir == 'rtl'`)
- Cookie banner + homepage `is_permanent == 0` builder topbar/header (different includes; `gp-shell.css` still loads but those markup trees were not polished)
- Logged-in cart/wishlist hover and admin dropdowns — cannot be confirmed without a session in this wrap

---

## How to rollback

Shared-shell polish only:

1. Remove the `gp-shell.css` `<link>` from:
   - `application/views/frontend/default-new/includes_top.php`
   - `application/views/backend/includes_top.php`
2. Optional: restore the previous inline theme-toggle styles in both `header.php` files (IDs can stay). Not required for rollback — without `gp-shell.css` the buttons are unstyled but still work.
3. Optional: delete `assets/design-system/gp-shell.css`.

This does **not** roll back Phase 4 (Bootstrap 5 admin swap). To roll back Phase 4, restore `app.min.css` / `app.min.js` and the DataTables `bootstrap4` vendor files in the backend includes.

---

## Stop condition (not hit)

Polish did not require JS behavior changes. Cart/wishlist remain CSS hover (`.wisth_tgl_2div:hover .menu_pro_wish`). Admin sidebar remains MetisMenu. Theme toggle still binds by element ID.
