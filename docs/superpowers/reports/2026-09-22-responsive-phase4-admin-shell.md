# Responsive Phase 4 — Admin/instructor shared shell (2026-09-22)

Owner CSS: `assets/design-system/gp-admin-shell.css`; cache version bumped in `application/views/backend/includes_top.php` (`admin-shell-responsive-8`). No JS, bridge, Hyper/Bootstrap asset, controller or view changed.
Session: non-production **admin** session saved by the person running the audit (`tmp/auth/admin.json`, local only, git-excluded via `.git/info/exclude`). **Instructor** session not provided: instructor routes are reported as blocked.

## Baseline (before)
All five admin routes failed at 390/360 (page overflow 441>390) and at 768 (771>768); 1024/1440 passed. 30 of 50 rows failing.

## Conflicts fixed (shared shell only)

| # | Symptom | Cause | DS fix |
|---|---|---|---|
| 1 | Phone: menu button and logo covered by the right-hand topbar menu, so the sidebar could not be opened; topbar 441px in a 390px screen | `.gp-admin-topbar-left` allowed to shrink to 0 while `.gp-admin-topbar-right` (theme, language, apps, bell, user; 393px) did not; wide logo, 60px menu button, 20px logo padding, user name text | ≤767px: left group `flex: 0 0 auto`, right group `min-width: 0`, user name text hidden (avatar stays); ≤575px: compact logo, trimmed menu-button/logo/icon padding; ≤399px: extra trims (one documented `!important` against this file's own `.nav-user` rule). No control is hidden except the name text beside the avatar. |
| 2 | Phone: hamburger bars invisible (80% white on the white topbar) | Hyper dark-topbar `.lines span` colour | `.lines span { background-color: var(--gp-fg) }` |
| 3 | 768px: page 3px wider than screen | `hyper-admin-theme.css` `body[data-layout="detached"] .content-page { width: 100%; margin-right: -15px }` | `margin-right: 0` at ≤991px |
| 4 | Collapsed icon rail (768–1024px) starts 80px below the topbar | `hyper-admin-theme.css` forces `position: relative` in `.enlarged`, so the DS `top: 80px` (meant for sticky) offset it | `.enlarged .wrapper .left-side-menu { position: sticky }` |

Selectors of the phone rules repeat `.navbar-custom.topnav-navbar` to outrank this file's existing topbar group (`.gp-ds .navbar-custom.topnav-navbar-dark`, specificity 0,4,0).

## Audit additions
Authenticated routes load `tmp/auth/<role>.json`; missing file → **blocked**; redirect to login → **blocked** (session expired). New open-only probes: topbar items within viewport, menu button visible and not covered, sidebar opens from the button and fits, each topbar dropdown fits the viewport. Nothing is submitted.

## Result
Admin dashboard, courses, users, enrolment history, message × 5 widths × 2 themes: overflow, legacy-colour, sidebar and dropdown probes pass. Consistency guard passes. The admin shell stylesheet is only linked from the backend `includes_top.php`, so the public site cannot be affected.

## Open items
- **admin-users console errors (pre-existing JS)**: opening any topbar dropdown triggers `Bootstrap doesn't allow more than one instance per element. Bound instance: bs.tooltip.` (8 errors). Not present when nothing is opened. Comes from `assets/backend/js/gp-bs5-admin-bridge.js` re-initialising tooltips (untouched, out of scope). Users route rows therefore report `fail` because of this console error only.
- Instructor pages (`/user/dashboard`, `/user/courses`) not verified: need an instructor session.
- Backend logo: the uploaded `small_logo` renders as a thin outline on the light topbar — an uploaded image asset, not CSS.
- Sidebar as an open overlay on phones was checked visually at 360px (light); dark theme checked for the closed topbar only.
