# Phase 4 — Admin Bootstrap 5 Swap — COMPLETE

**Date:** Saturday, September 12, 2026  
**Status:** Complete (asset swap already in place; leftover DataTables BS4 JS links closed in this wrap)  
**Scope:** Admin/instructor shared shell only (`application/views/backend/includes_top.php`, `includes_bottom.php`)

Phase 4 does **not** reintroduce Bootstrap 4. Original `app.min.css` / `app.min.js` remain in the repo for rollback only.

---

## Confirmation (this wrap)

| Check | Result |
|-------|--------|
| `includes_top.php` loads `app.min.css` | No |
| `includes_bottom.php` loads `app.min.js` | No |
| DataTables Bootstrap 4 CSS | No — `*.bootstrap5.min.css` |
| DataTables Bootstrap 4 JS | **Was still present** — swapped to `*.bootstrap5.min.js` in this wrap |
| Bootstrap 5.3.1 | Yes — `assets/frontend/default-new/css/bootstrap.min.css` + `bootstrap.bundle.min.js` |
| Hyper theme without BS4 core | Yes — `hyper-admin-theme.css` + `hyper-admin-plugins.js` |
| Dropdown / moment follow-up fixes | Left in place (not reverted) |

`application/views/install/` still loads `app.min.*` and DataTables bootstrap4. That is Phase 5e, not Phase 4.

---

## Files Phase 4 added

| File | Role |
|------|------|
| `assets/backend/css/hyper-admin-theme.css` | Hyper admin chrome extracted from `app.css` (BS4 core stripped) |
| `assets/backend/js/hyper-admin-plugins.js` | Hyper plugins extracted from `app.js` (BS4 JS stripped) |
| `assets/backend/js/gp-bs5-admin-bridge.js` | Maps `data-toggle` → `data-bs-toggle`; jQuery `.modal()` / `.tooltip()`; re-hydrates on `draw.dt` / `init.dt` / `onDomChange` |
| `assets/backend/js/vendor/moment.js` | Was bundled inside `app.min.js`; required by FullCalendar / daterangepicker |
| `assets/backend/css/vendor/dataTables.bootstrap5.min.css` | DataTables BS5 styling |
| `assets/backend/css/vendor/responsive.bootstrap5.min.css` | Responsive extension BS5 styling |
| `assets/backend/css/vendor/buttons.bootstrap5.min.css` | Buttons extension BS5 styling |
| `assets/backend/css/vendor/select.bootstrap5.min.css` | Select extension BS5 styling |
| `assets/backend/js/vendor/dataTables.bootstrap5.min.js` | DataTables BS5 integration |
| `assets/backend/js/vendor/responsive.bootstrap5.min.js` | Responsive extension BS5 integration |
| `assets/backend/js/vendor/buttons.bootstrap5.min.js` | Buttons extension BS5 integration |
| `assets/design-system/dropdown-bs5-verify.html` | Headless check for admin dropdown visibility after BS5 `.show` |

---

## Files Phase 4 changed

| File | Change |
|------|--------|
| `application/views/backend/includes_top.php` | Replaced `app.min.css` with `hyper-admin-theme.css`; DataTables CSS `bootstrap4` → `bootstrap5`; keeps BS5 + design-system CSS |
| `application/views/backend/includes_bottom.php` | Replaced `app.min.js` with `moment.js` + `hyper-admin-plugins.js`; DataTables JS `bootstrap4` → `bootstrap5`; loads `bootstrap.bundle.min.js` then `gp-bs5-admin-bridge.js` |
| `application/views/backend/header.php` | Removed leftover Hyper demo `transform: translate3d(...)` inline styles that cancelled Popper (dropdown bugfix). Theme-toggle IDs unchanged. |
| `assets/backend/css/hyper-admin-theme.css` | Dropdown visibility: `.dropdown-menu.show` in addition to `.show > .dropdown-menu`; Hyper fade / transform-kill adjustments |
| `assets/design-system/gp-dropdown.css` | Gate `.dropdown-menu` `display` on `.show` so menus are not always in layout |

Related (not the asset swap itself, but required so admin dropdowns stay visible after the swap):

- `assets/design-system/gp-dropdown.css` — `.gp-ds .dropdown-menu:not(.show) { display: none }`
- `assets/backend/js/gp-bs5-admin-bridge.js` — DataTables `draw.dt` re-hydrate

---

## Load order (admin)

**CSS (`includes_top.php`):** vendor (jvectormap, DataTables BS5, Summernote-bs4 *filename*, FullCalendar, Dropzone) → Bootstrap 5.3.1 → `hyper-admin-theme.css` → icons → `main.css` → Font Awesome → tagsinput → design-system CSS (tokens → components → `gp-shell.css` last).

**JS (`includes_bottom.php`):** `moment.js` → `hyper-admin-plugins.js` → Chart / jvectormap / DataTables core + **BS5** integrations → Summernote-bs4 *filename* → FullCalendar → Dropzone → `datatable-initializer.js` → `bootstrap.bundle.min.js` → `gp-bs5-admin-bridge.js` → remaining plugins / `custom.js`.

---

## Remaining known risks

| Risk | Why it remains |
|------|----------------|
| **Summernote still named `summernote-bs4`** | Editor plugin filename, not a second Bootstrap CSS. Not a BS4 reintroduction. Watch editor toolbar / dropdowns on course add/edit. |
| **jQuery `.modal()` / `.tooltip()` callers** | Bridged in `gp-bs5-admin-bridge.js`. AJAX modals (`showAjaxModal`) and confirm dialogs need a logged-in pass. |
| **DataTables server-side row ⋮ menus** | Bridge re-hydrates `data-toggle` after `draw.dt`. Students / users / courses-server-side still need a logged-in check. |
| **Topbar dropdowns** | Language, quick actions, help, notifications, profile. CSS + bridge; do not revert the moment / dropdown fixes. |
| **FullCalendar + moment** | `moment.js` is loaded before Hyper plugins. Calendar pages still need a logged-in check. |
| **bootstrap-tagsinput / form-wizard / dragula / Dropzone** | Pre-existing plugins, not rewritten. Visual or init failures would be leftover Hyper/jQuery, not a missing `app.min.js` bundle item we already extracted (moment was the known one). |
| **Install tree still on `app.min.*`** | `application/views/install/styles.php` — Phase 5e. Leave it. |
| **Payment / email** | Phase 5. Not touched. |
| **`select.bootstrap5.min.css` loaded; no matching Select JS swap** | There was no `select.bootstrap4.js` in `includes_bottom.php`. CSS-only alignment. |
| **Original `app.min.css` / `app.min.js` not deleted** | Rollback copies. Do not delete. |

**Medium risk overall** — the admin JS stack changed. If a page breaks, restore `app.min.*` links and the bootstrap4 DataTables vendor files in `includes_top.php` / `includes_bottom.php`.

---

## What this wrap did *not* do

- Did not re-extract Hyper from `app.css` / `app.js`
- Did not revert dropdown or moment fixes
- Did not reintroduce Bootstrap 4 on admin
- Did not empty or rewrite the design-system whitelist
- Did not migrate payment, email, or install
