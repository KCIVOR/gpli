# Responsive Design-System Remediation — Final Report (2026-09-22)

Plan: `docs/superpowers/plans/2026-09-21-responsive-design-system-remediation-plan.md`. Phase reports: baseline, phase 1 (public shell), 2 (commerce), 3 (public content), 4 (admin shell), 5 (admin pages), 6 (isolated surfaces) in this folder.

Legacy CSS is untouched and still loaded; nothing was deleted. Commits: Phase 0 `8f970e1`, Phase 1 `45cd1ee`, audit tooling `640a516`, Phase 2 `4b11100`, Phase 3 `210ccbb`, Phase 4 `b030ca6`, Phase 5 `786ee53`; Phase 6 changed no code (report only). Each phase commit reverts independently (the Phase 5 commit builds on Phase 4's `gp-admin-shell.css`).

## 1. Coverage matrix (5 widths × light/dark)

| Area | Routes | Result |
|---|---|---|
| Public | 18: home, catalog, course detail, FAQ, About, Contact, Blog, cart (empty), compare (empty + populated), login, sign-up, forgot password, privacy, terms, refund, cookie policy, community posts | **170 of 180 rows pass** (overflow, clipped content, legacy colours, shell probes, console). The 10 failing rows are all `course-detail`, for a pre-existing page-script error (below). Catalog also passes at 991/576/420. |
| Admin (session provided) | 19: dashboard, courses, users, enrolment history, message, categories, instructors, coupons, course edit (view), system + payment settings, profile, admin + instructor revenue, blog category, badges, newsletters, blog, frontend settings | **190 of 190 rows pass** overflow, clipped-content and legacy-colour checks; sidebar/dropdown fit on dashboard and users; modals fit on blog category, badges, newsletters. `admin-users` reports console errors only when a top-bar dropdown is opened (below). |
| Instructor | 2 (`user/dashboard`, `user/courses`) | **Blocked** — no instructor session. |
| Student | become-an-instructor; learner dashboard, wishlist, my courses | **Blocked** — no student session. |
| Isolated surfaces | payment, payout checkout, installer, lesson player, mobile webview | **Blocked** — see Phase 6 report (evidence per surface). Homepage builder, course-builder curriculum/lesson forms, Select2, wizards, message threads not walked through. |

Screenshots and JSON are local only (`tmp/responsive-audit/`, `tmp/p2..p4/`). Sessions are in `tmp/auth/` (git-excluded). Blocked routes are reported as *blocked*, never *passed*.

## 2. What changed (all CSS, all reversible per phase)

| Phase | Files | Cache version |
|---|---|---|
| 1 | `gp-public-shell.css` | frontend `includes_top.php` responsive-1 |
| 2 | `gp-courses.css`, `gp-compare.css` | catalog-13, compare-4 |
| 3 | `gp-legal-pages.css`, `gp-community.css` | legal-3, community-2 |
| 4 | `gp-admin-shell.css` | backend `includes_top.php` admin-shell-responsive-10 |
| 5 | `gp-tables.css`, `gp-admin-shell.css` | tables-8, admin-shell-responsive-10 |
| Tooling | `scripts/audit-responsive-design-system.mjs`, `scripts/responsive-route-manifest.mjs`, `scripts/save-auth-session.mjs`, `scripts/legacy-css-usage.mjs`, `scripts/legacy-css-candidates.mjs` | — |

No controller, model, route, migration, permission, JavaScript, SDK, form/field, DataTables/Select2 initialisation, modal URL, course-builder hook or legacy stylesheet was modified. Rollback: revert one phase's files (or bump the cache version back). Emergency per-page opt-out remains `gp_ds_exclude_pages`; none was needed.

## 3. Exceptions
`!important` added (each with a comment naming the legacy rule it counters):
1. `gp-admin-shell.css` `.nav-user { padding-right: 4px !important }` (≤399px) — counters this file's own `.nav-user` rule, itself countering `hyper-admin-theme.css`.
2. `gp-community.css` `.courses-list-view .course-all-category { border-color, box-shadow !important }` — counters `custom.css` `.course-all-category`.
3. `gp-compare.css` `.compare-card .courses-card-body { border-color !important }` — counters `custom.css` `.courses-card-body`.
4. `gp-legal-pages.css` `.privacy-policy .row { margin-block: 0 !important }` — counters the view's `.my-5`.
Selector-specificity choices worth knowing: admin table/DataTables rules add `.content-page .content` to outrank page-level owners; admin topbar rules repeat `.navbar-custom.topnav-navbar`.

## 4. Open blockers and known issues
1. **Course detail page JavaScript** (pre-existing, reproduces with CSS stashed): inline script throws `Unexpected token '}'` and `VenoBox is not defined` (around line 1479 of the rendered page).
2. **Admin users page**: opening any top-bar dropdown logs `Bootstrap doesn't allow more than one instance per element. Bound instance: bs.tooltip.` (`gp-bs5-admin-bridge.js` re-initialising tooltips; out of scope).
3. Uploaded image assets: blog hero (`uploads/blog/page-banner/blog-page.png`) is purple; backend `small_logo` renders as a thin outline on the light topbar — content, not CSS.
4. Blockers for instructor/student/payment/lesson/installer/mobile/homepage-builder/course-builder surfaces (needs approved fixtures; Phase 6 report lists each).
5. Untested state: populated cart and wishlist, blog cards (empty locally), DataTable pages beyond page 1, dropdown/Select2 fit on pages other than the two probed.

## 5. Selector-retirement decision (decided: **do not retire anything now**)
`scripts/legacy-css-usage.mjs` + `scripts/legacy-css-candidates.mjs` (read-only) tested every rule in the four legacy frontend stylesheets against the 18 audited public routes, then searched all PHP/JS source for each unmatched rule's class/id names:

| File | Rules | Match ≥1 audited route | Unmatched | …names still referenced in source | Candidates (no name anywhere in source) | of which in @media |
|---|---|---|---|---|---|---|
| `style.css` | 2560 | 305 | 2255 | 1428 | 827 | 6 |
| `new-style.css` | 457 | 1 | 456 | 313 | 143 | 17 |
| `responsive.css` | 589 | 35 | 554 | 400 | 154 | 152 |
| `custom.css` | 391 | 104 | 287 | 157 | 130 | 3 |

How to read it: 445 legacy rules are demonstrably live on audited routes (their DS overrides are documented in phases 1–5). 2255+456+554+287 rules match nothing on audited routes; **about 1,250 of those name a class/id found nowhere in `application/` or `assets/` source** and are the only retirement candidates. Everything else that is unmatched is referenced by source and belongs to unaudited or conditional surfaces (student area, payments, lessons, add-ons, popups, themed home pages, print/email) and must stay.

Why no removal yet: (a) student, payment, lesson, instructor and mobile surfaces are unaudited, so "not matched" is not "dead"; (b) class names built at runtime would escape the source search; (c) the plan requires per-rule route reference, cascade evidence and a full matrix pass, and the candidates have no cascade evidence yet; (d) all work is uncommitted, so a clean baseline commit should come first. **A later retirement plan needs your approval.** Suggested order for it: `new-style.css` (1 of 457 rules live), then the `responsive.css` candidates (152 in @media), each as a separately reversible commit.

## 6. Verification record
Consistency guard on all changed DS CSS: passed. Final regression: public (all 18 routes, both themes, all widths, with shell probes) and admin (19 routes, both themes) run after the last CSS edit (tables-8 / admin-shell-responsive-10).
