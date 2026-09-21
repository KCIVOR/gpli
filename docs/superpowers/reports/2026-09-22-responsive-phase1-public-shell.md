# Responsive Phase 1 — Public shell (2026-09-22)

Scope: `assets/design-system/gp-public-shell.css` (+ cache bump in frontend `includes_top.php`). Routes: home, catalog, course detail, FAQ, About, Contact, Blog.

## Conflicts fixed (all at ≤991px, both themes)

| # | Symptom | Winning legacy selector | DS override (gp-public-shell.css) |
|---|---|---|---|
| 1 | Search/close toggle keep the old purple border; close button turns solid purple after tap | `style.css` `.m-cross-icon, .m-search-icon` (border), `.search-item span:hover` (fill) | `.gp-ds header.gp-site-header .m-search-icon/.m-cross-icon` border + radius; `.search-item span:hover` surface-sunk |
| 2 | Mobile search field floats over page text with no surface | `style.css` `.inline-form .mobile-search` (transparent, left-anchored), z-index from `responsive.css` | `@media (max-width: 991px)` surface, bottom border, card shadow, `right: 0` |
| 3 | Drawer "Login" text is white on a near-white fill (contrast 1.06:1); "Sign up" is old purple | `style.css` `.logIn-btn` (`--bg-white-2`), `.signUp-btn` (`--color-4`, `color !important`) | Drawer-scoped `.signUp-btn` white/navy (one documented `!important`), `.logIn-btn` transparent with light border |
| 4 | Drawer chevron nearly invisible on navy | `custom.css:1114` `.btn-toggle::after` dark SVG | `filter: invert(1)` on drawer `.btn-toggle::after` |

Header layout, menu trigger, cart/wishlist popover bounds and footer already fit at all widths (no change).

## Audit additions

`scripts/audit-responsive-design-system.mjs` now also runs, per route/viewport: header/footer within viewport; legacy-purple scan of header, footer, open search and open drawer; search-overlay surface; drawer bounds and text contrast ≥ 4.5; menu-trigger visibility (<992px); cart popover bounds (≥992px); browser console/page errors. Interaction is open-only. `--no-shell` skips the shell probes.

Probes were verified to **fail on the pre-change CSS** (catalog 768/390/360: purple border, no overlay surface, purple Sign up, Login contrast 1.06).

## Result after fix

70 rows (7 routes × 5 widths × 2 themes): **all shell probes pass**. Remaining non-passing rows are outside this phase:

- **catalog @360 overflow (Phase 0 F1)** — `gp-courses.css:98`; Phase 2.
- **course-detail console errors (blocker, pre-existing)** — inline page script throws `Unexpected token '}'` and `VenoBox is not defined` (`/home/course/...:1479`). Reproduces with this phase's CSS stashed. JavaScript is out of scope; needs its own fix.

Consistency guard: passed. Not covered: logged-in header/drawer (needs a non-production student session), language dropdown (hidden <1200px).
