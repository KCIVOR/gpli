# Responsive Phase 5 — Admin page families (2026-09-22)

Owner CSS: `gp-tables.css` (tables-8, shared DataTables/table behaviour) and `gp-admin-shell.css` (admin-shell-responsive-10, shared admin content components). Cache versions bumped in backend `includes_top.php`. No JS, DataTables/Select2 initialisation, modal URL, course-builder ID, controller or payment code touched.
Session: non-production admin (`tmp/auth/admin.json`, local, git-excluded). Instructor session not provided.

## Routes covered (19 admin routes, read-only)
dashboard, courses, users, enrolment history, message, categories, instructors, coupons, course edit (`course_edit/75`, viewed only), system settings, payment settings, profile, admin revenue, instructor revenue, blog category, badges, newsletters, blog, frontend settings.

## Key finding: page overflow did not reveal these defects
`.content-page { overflow: hidden }` (hyper-admin-theme.css) clips wide content, so the page-level overflow check read 0 while columns, toolbars and buttons were unreachable. A new **clipped-content probe** flags any visible element extending past the screen edge that is not inside a deliberate horizontal scroller.

## Conflicts fixed

| # | Symptom (≤991px unless noted) | Cause | DS fix |
|---|---|---|---|
| 1 | DataTables pages (courses, users, instructors, coupons, categories, revenue): 304px wrapper but toolbar/info/pagination 640–970px and a 640px-min table, all clipped — columns and controls unreachable | Page owners lay the wrapper out as a 2-column grid; base table `min-width: 640px`; content area clips | Wrapper collapses to one column, children `min-width: 0; max-width: 100%`, pagination wraps, export group natural width, table becomes its own horizontal scroller (`gp-tables.css`). Selector adds `.content-page .content` to beat page-level owners (users ties otherwise and loads later). Scoped to `[data-layout="detached"]`, so the public site is unaffected. |
| 2 | Plain tables (blog list) and static `.table-responsive-sm` tables (enrolment history at 768px): clipped | Bootstrap `.table-responsive-sm` only scrolls below 576px; the collapsed sidebar rail narrows content well above that | `[class*="table-responsive-"]` scroll; `table.table` self-scrolls with `min-width: 0` |
| 3 | ≤575px: page-title action buttons (e.g. course edit, 348px in a 304px card) clipped | `gp-components-core.css` `.gp-page-title-actions` is no-wrap | Title row and action group wrap (`gp-admin-shell.css`; shared component, same markup on every admin page) |
| 4 | ≤575px: profile/settings file pickers ~7–72px past the card | Flex-grow child cannot shrink below its content; Bootstrap 4 `.custom-file-input` styling gone under BS5, leaving the native input at intrinsic width | `.flex-grow-1 { min-width: 0 }`, `.custom-file` and `.custom-file-input` `max-width: 100%` |

## Audit additions
Clipped-content probe (all routes); `--modals` open-only probe: opens the first non-destructive `showAjaxModal` trigger (skips delete/confirm/status/payout etc.), checks dialog width/height and closes it without saving; pages without a safe trigger report a note instead of passing silently.

## Result
All 19 admin routes × 5 widths × 2 themes: pass (overflow, clipped content, legacy colours, sidebar/dropdown fit on dashboard and users). Modals opened and fit on blog categories, badges and newsletters (40 screenshots). Public smoke (catalog, cart, home at 1440/768/390, both themes): pass. Consistency guard: pass.

## Open items
- **admin-users** rows fail only on `Bootstrap doesn't allow more than one instance per element. Bound instance: bs.tooltip.` (8 console errors when a top-bar dropdown is opened; from `gp-bs5-admin-bridge.js`, out of scope).
- Not verified: instructor pages (no session); pages with sortable/paged data beyond page 1; course builder curriculum tab and lesson modals (`curriculum`, `showAjaxModal` lesson forms) — needs a safe fixture and a per-lesson-type walkthrough; Select2 dropdown fit; wizard step forms; message thread view; home page builder.
- The clipped-content probe ignores elements inside any `overflow-x: auto/scroll` ancestor, so a scroller that is itself too narrow to be useful would not be flagged (checked visually on users/courses only).
