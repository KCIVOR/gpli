# Frontend redesign context audit

Audit date: 5 November 2026. Workspace: `C:/xampp/htdocs/academy`.

## Evidence and limits

This is a current source architecture review plus a review of saved visual evidence, not a completed live acceptance test. No application behavior, database records, accounts, or production files were changed.

- Read the current routing, frontend and backend shells, design-system activation helper and config, tokens/theme boot, key catalog/auth/student/course templates, homepage composition, shared AJAX response handler, lesson and payment shells, deployment documentation, and responsive audit tooling.
- Inspected four saved screenshots directly: `tmp/responsive-audit/catalog-light-1440.png`, `catalog-light-390.png`, `home-light-1440.png`, and `course-detail-dark-390.png`. These are September 2026 artifacts, not new captures. References below labeled historical require rechecking in the running application.
- Browser navigation to `http://localhost/academy/` returned HTTP 500. The inspected Apache log did not establish its cause. No diagnosis of database availability or PHP compatibility is claimed.
- `DEPLOYMENT.md` names `https://lms.startuplab.cc/`, but the currently served page is “Born to Soar | The Geese Project,” loads `/assets/site.css`, and has no `.gp-ds` root. It is a different frontend from the local LMS. Do not use it as an LMS visual baseline. The attempted screenshot also timed out; its page structure and stylesheet references were readable.
- Saved role session artifacts exist under `tmp/auth`; they were not read or reused against any remote origin. Logged-in student, instructor, administrator, payment completion, SCORM completion, and certificate journeys were not exercised live.
- Existing planning and completion documents are historical context. Their claims are not accepted as current verification.

## Executive assessment

This is a server-rendered CodeIgniter 3 LMS with an established project design system layered over a legacy Academy template. The redesign should begin with the existing token/component and page-family structure. A framework migration is a separate architectural decision, not a prerequisite for changing the interface.

The main risks are styling layers loaded together, markup coupled to global JavaScript selectors, data fetching inside templates, multiple independent shells, and incomplete current runtime verification. There are valuable foundations already in place: semantic color variables, explicit light/dark modes, reusable PHP atoms, page-family stylesheets, and a route/viewport audit manifest.

The highest-priority prerequisite is restoring a trustworthy LMS preview. Without it, design judgments about current spacing, responsive behavior, content, and interaction states remain provisional.

## Current architecture

| Area | Current source and responsibility |
|---|---|
| Framework | `system/core/CodeIgniter.php` declares CodeIgniter 3.1.9. `composer.json` is the old framework manifest; its PHP minimum and PHPUnit declarations do not establish what actually runs or passes. |
| Entry/routing | `.htaccess` rewrites into `index.php`; `application/config/routes.php` defaults to `Home` and includes blog, custom-page, certificate and optional-product aliases. Most controller methods use conventional CI routes. |
| Public/student frontend | `application/views/frontend/default-new/index.php`; theme directory selected through `get_frontend_settings('theme')`. |
| Admin/instructor | `application/views/backend/index.php`, role navigation and role-specific views. Separate visual shell and asset loader. |
| Learning player | `application/views/lessons/index.php`, separate head, styles and player controls. Must be included in the redesign scope explicitly. |
| Payment | `application/views/payment-global/index.php`, separate shell and gateway integration. |
| Homepage | `Home::home()` selects the active `home_pages` database row. Permanent pages use the configured template; custom builder pages render generated sections. The source alone cannot identify the currently active database selection. |
| Shared atoms | `application/helpers/design_system_helper.php` and `application/views/components/design-system/`: button, badge, alert, card, page title, table. |
| Styling | Legacy frontend styles plus Bootstrap plus `assets/design-system/gp-*.css`; classic script tags, jQuery and inline page scripts. No application frontend build manifest was found at the repository root. |
| Deployment | Repository documentation describes automatic deployment on pushes to main, with database changes handled separately. The documented origin now differs from this LMS; verify the actual target before any future release. |

Current recursive inventory (all files, not equivalent to routable screens): 24 controller files, 17 model files, 116 frontend theme files, 182 admin view files, 80 instructor/user view files, 112 main section files, 14 lesson view files, and 81 design-system assets/reference files. Do not estimate redesign scope by these counts alone: partials, vendor material and optional surfaces are included.

## Corrections to the earlier audit

`UI_ARCHITECTURE_AUDIT.md` is materially stale:

1. The design system is populated and loaded, rather than empty scaffolding.
2. Shared UI atoms now exist through `gp_ds_*` helpers and six PHP partials.
3. Activation is shell-wide unless a page is excluded. The page arrays in `design_system_pages.php` are inventories, not the actual allowlist decision; `gp_ds_is_active()` checks the exclusion array.
4. Backend `includes_top.php` now loads `hyper-admin-theme.css` in place of `app.min.css`, with a comment recording Bootstrap 4 core removal. DataTables assets in that loader are Bootstrap 5 variants. The earlier simultaneous Bootstrap-core claim cannot be carried forward from that report.
5. Missing-page and component counts in old documents need fresh route-by-route verification before being reused.

## Product surfaces and behavior to preserve

| Journey | Templates and dependencies | Redesign contract |
|---|---|---|
| Discover learning | Homepage sections, `courses_page.php`, sidebar, sorting, grid/list layouts | Search, category hierarchy, level/price/language/rating filters, sort, pagination, session-selected layout and empty results. |
| Evaluate a course | `course_page.php` and its description/curriculum/instructor/reviews partials | Price/free/discount states, preview, instructor, curriculum, ratings, enrollment status, course type and metadata. |
| Save and compare | Wishlist/cart partials, `Home::toggleWishlistItems`, compare query parameters | Existing selectors and returned HTML fragments must continue to update the right UI. |
| Purchase/enroll | Cart inner view, coupons, buy-now/session state, payment shell | Guest versus signed-in behavior, free enrollment, paid checkout, gifts where enabled, success/failure/cancellation. |
| Learn | `Home::lesson()`, lesson shell, quizzes, optional SCORM/H5P/live content | Access restrictions, progress, resume position, expiry, navigation, completion and certificates. |
| Manage learning | `my_courses.php`, profile menus, wishlist/history/messages/profile pages | In-progress/not-started/completed/expired status ordering and filtering; account navigation and empty states. |
| Authenticate | Login/signup/recovery/verification templates | Server validation, password visibility, optional reCAPTCHA/social login and public-signup settings. |
| Teach/administer | Frontend instructor pages plus backend user/admin trees | Role-specific permissions, authoring, rich-text editors, tables, uploads, AJAX modals and reporting. |
| Inform/support | FAQ, legal, contact, blogs, community and custom pages | Database-controlled content, translations, conditional navigation and form feedback. |

Optional add-ons affect navigation and available journeys: bundles, ebooks, team training, tutor booking, bootcamps and others. Source availability does not mean the feature is enabled. Capture the actual enabled-feature matrix from the intended preview before simplifying navigation.

## Existing visual language

The current token file uses blue `#003BA6`, red `#CD182A`, deep-blue accents, warm off-white surfaces, Manrope headings, Inter body text, JetBrains Mono accents, a 10px base radius, subtle card shadows, semantic status colors and motion tokens. Foreground/surface variables have explicit dark variants. Deprecated `--gp-ink` and `--gp-text` are documented as unsuitable for new themed text.

Theme boot reads `gp-ds-theme`, applies `light` or `dark` to the document root and body, and bridges some legacy variables. Token CSS still contains a system-mode branch even though the current boot script accepts only light/dark. Treat theme behavior as a coordinated change across boot, toggle, tokens and legacy overrides.

The September screenshots show a warm neutral LMS with blue actions, white rounded course cards, a desktop category sidebar, image-heavy homepage hero, and condensed mobile navigation. They also show a generic “academy” logo despite Geese design-system naming. Branding decisions need the intended product identity, not assumptions based on folder names.

## Findings and redesign implications

### High: no reliable current runtime baseline

Local HTTP 500 and a different frontend at the documented public origin prevent a trustworthy live audit. Establish the correct LMS preview, active homepage/theme and role access before approving page designs or claiming responsiveness. Existing saved reports are useful historical evidence only.

### High: mobile discovery places filters before results (historical visual)

The 390px catalog screenshot spends the first viewport on category filters; no course is visible. The cookie banner further obscures the lower filter controls. A mobile design should prioritize result access, with an explicit filter control and a compact active-filter summary. Confirm current behavior before treating this as an unfixed runtime defect.

### High: interaction markup needs an accessibility pass (current source)

`courses_page_grid_layout.php` makes the card an anchor while wishlist and compare are click handlers on an icon/span inside it. These are not independent keyboard buttons and rely on propagation behavior. Card images in that template lack alt attributes. `my_courses.php` has an ellipsis icon button without an accessible name. Mobile header search controls include clickable spans. These are concrete markup concerns even without a running application.

Use semantic links and buttons, accessible names, visible keyboard focus, and explicit state announcements. Preserve course navigation separately from wishlist/compare actions. Check all headers, drawers, tabs, filters and dialogs by keyboard and screen reader in the running version.

### High: presentation and data access are intertwined

Course detail queries course, lessons, instructor, duration, enrollment and ratings in the view. Catalog grid and student-course lists query related data inside loops; the category sidebar fetches counts and subcategories while rendering. This creates repeated-query risk and makes visual templates harder to reuse. Actual performance impact requires measurement; no query timing is claimed.

For redesigned page families, prepare a stable display-data contract in the controller/model layer and keep templates focused on presentation. Avoid changing enrollment/price/access business rules while extracting markup.

### High: selectors are part of the application contract

`common_scripts.php` dispatches server instructions such as `html`, `text`, `addClass`, `show`, redirect and reload against selectors. Home endpoints return view fragments for cart/wishlist/reviews. Inline handlers and IDs therefore carry behavior, not just appearance. Maintain a selector/endpoint inventory per redesigned page; changing class names alone can break flows with no PHP error.

The `actionTo()` POST helper constructs JSON by repeatedly replacing separators in a URL string. This is fragile for encoded values and should be replaced by structured parameters during an explicitly scoped behavior refactor. AJAX failures also need visible recovery states; the inspected helper has a success callback without a matching error callback.

### Medium: every public page loads many unrelated assets

`frontend/default-new/includes_top.php` loads legacy styles and dozens of design-system component/page files, including catalog, course detail, community, auth, student and instructor styles regardless of the route. Popover CSS is linked twice. Bottom includes globally load several carousel libraries, rich text, tagging and animation plugins.

Use shared tokens/base/components plus page-family assets once the preview can verify dependencies. Do not delete a legacy file merely because its rules appear redundant. Cache-version strings are manually embedded in loaders and should have a consistent policy. These are static loading findings, not measured page-speed scores.

### Medium: search parameter handling is inconsistent

In `Home::courses()`, a `query` value is assigned and then reset to an empty string when `title` is absent. The sidebar preserves `query` but submits a `title` field; header/home search routes also need comparison with `Home::search()`. This is a source-level inconsistency, not a confirmed failure of every search entry point. Normalize the search contract and test entry from header, hero, sidebar, pagination and filters.

### Medium: design-system reuse is partial

Reusable atoms coexist with hand-authored cards, raw Bootstrap elements, inline styles and legacy classes. The helper's own mandate says new markup should use the shared atoms while excluding special integration markup. Some helpers explicitly guard against CodeIgniter view-variable leakage. Preserve those protections if components are rewritten.

A reusable course card, filter group, empty state, account navigation and form feedback pattern would provide more redesign consistency than adding further page-specific overrides.

### Medium: homepage content and brand promises need reconciliation (historical visual)

The saved homepage shows “75+” courses in the hero and “100+ Online Courses” in the following feature section. Its hero is generic SME learning messaging, whereas the currently documented origin is a separate leadership/book marketing experience. Agree the LMS audience, value proposition and verified content counts before rewriting the landing page.

### Medium: dark-mode readability and cookie overlay need live checks

The saved dark mobile course image has subdued metadata/link colors and a cookie banner overlapping course facts. Contrast cannot be certified from screenshots alone. Check computed contrast and backgrounds, cookie-banner opacity/height, zoom, focus visibility, and dismiss/accept persistence in both themes. Do not declare WCAG compliance from token presence.

### Cross-cutting security/configuration observations

`application/config/config.php` sets `csrf_protection` to false and `cookie_httponly` to false. State-changing wishlist behavior is called through a GET-style AJAX helper. Templates also echo dynamic database values and embed dynamic content into scripts, while custom CSS/embed code are intentional settings features. These need a dedicated output-encoding, request-protection and trust-boundary review before changing form/AJAX infrastructure. They are risk observations, not demonstrated exploit findings or a completed security audit. Enabling CSRF globally without adapting legacy forms could break the application.

## Verification assets and gaps

`scripts/responsive-route-manifest.mjs` defines public/admin/instructor routes, five base viewports (1440, 1024, 768, 390, 360), and both themes. `scripts/audit-responsive-design-system.mjs` collects page/console/overflow/style evidence and screenshots. Related legacy-CSS inspection scripts also exist. This is a useful starting point rather than an assurance that current routes pass.

`tmp/responsive-audit/results-both.json` contains historical admin-instructor failures reporting duplicate Bootstrap tooltip instances. Current reproducibility was not established. The saved report filename does not prove a complete whole-application run.

Missing fresh evidence: all current rendered pages, keyboard interactions, screen-reader names, mobile filters/drawers, long translated text/RTL, slow/error states, populated and empty commerce states, student expiry/progress, instructor authoring, gateway return paths and SCORM/certificate completion. No automated application test suite was run during this context audit.

## Recommended redesign sequence

1. Restore the correct LMS preview; verify active theme/homepage, enabled add-ons and representative role accounts. Record a new route/screenshot baseline.
2. Agree product identity and audience, navigation hierarchy, homepage goals, and whether admin/instructor/player/payment surfaces are in scope.
3. Define typography, spacing, surface hierarchy, responsive containers, semantic colors and interaction states by extending/revising the existing tokens.
4. Design shared public header/footer, mobile navigation, course cards, filters, feedback and empty states. Prototype catalog and course detail first because they exercise the major patterns.
5. Implement by page family: discovery/detail, auth/commerce, student account, learning player, then instructor/admin as agreed. Preserve selectors, routes and server-side business rules until deliberately refactored.
6. Verify the complete route/state/role/theme matrix, including keyboard and mobile flows, before releasing. Confirm the deployment target independently of stale documentation.

## Working context for subsequent design work

- Primary public shell: `application/views/frontend/default-new/index.php`.
- Public styling owners: `gp-public-shell.css`, `gp-landing.css`, `gp-courses.css`, `gp-course-detail.css`, `gp-auth.css`, `gp-cart.css`, `gp-student.css`.
- Foundation: `gp-tokens.css`, `gp-base.css`, `gp-components-core.css`, `design_system_helper.php`.
- Data/business owners: `Home.php`, `Crud_model.php`, `User_model.php`, `Payment_model.php` and add-on-specific controllers/models.
- Keep source findings, dated screenshots and fresh runtime tests separate. This document supersedes the earlier audit only for the specific areas inspected here; it does not certify every route or integration.
