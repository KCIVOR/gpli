# GPLI.tech system-wide color refresh implementation plan

**Goal:** Apply the GPLI.io reference palette to the entire GPLI.tech interface, with a verified disposition for every page, partial and reachable visual state.

**Architecture:** Use shared color roles in `assets/design-system/gp-tokens.css`, then connect each shell and component to those roles. Keep contextual and semantic colors on their own tokens. Use targeted color overrides where a legacy template does not yet consume the shared roles.

**Stack:** CodeIgniter PHP views, CSS custom properties, Bootstrap 5, jQuery, existing responsive audit tooling.

**Execution:** Perform this plan on `develop` after review. Execute task by task using the executing-plans workflow. This is a planning deliverable.

## Audit findings and scope

The shared token file is included by the public/student, admin/instructor, lesson, mobile, installer and payment asset loaders. Standalone instructor payout checkout views load it independently. The homepage builder has a separate HTML shell and renders generated PHP sections. Error pages, certificate output, emails, gateway fragments and embedded SCORM content need separate verification because their rendering contexts differ.

`gp-components-core.css` uses `--gp-primary` for filled actions, outlines, focus rings and accents. The legacy frontend styles still contain purple `#754FFE`. A global replacement risks changing unrelated meanings and missing hardcoded declarations. `gp-theme-boot.js` also sets the root background directly before first paint. Its light background must agree with the new light token. Frontend custom CSS and builder content can override computed colors even when the source tokens are correct.

Use the [coverage ledger](2026-11-05-gpli-color-coverage.md) as the acceptance inventory. It covers checked-in source and identifies runtime discovery work. The September screenshots are historical. The prior audit encountered a local HTTP 500 and found that the old documented deployment URL served a separate marketing site. Establish a working GPLI.tech preview before collecting current computed styles or claiming visual coverage.

**Allowed diff:** CSS color values, color variable references, SVG fill/stroke values on UI elements, color literals in existing chart/theme configuration where the role calls for it, and presentation-only stylesheet wiring/cache keys. Preserve layout, typography, sizing, spacing, copy, navigation, focus mechanics, state logic, APIs, controllers, data, payment integrations, and deployment configuration. Keep photographs, course thumbnails, and image-based logos intact. Apply navy to a text logo only where rendered as text. Treat externally owned frames and gateway UI as integration boundaries and record the visible outcome.

## Color contract

| Role | Light target | Dark treatment |
|---|---|---|
| Filled primary action | `#2563EB` background, `#FFFFFF` text | Same pair where it passes the state contrast check |
| Standard links and headline highlights | `#2563EB` | Use a lighter link token, candidate `#93B4FF` |
| Headings and text logo | `#1B2A4A` | Use existing light foreground `#EDEBE6` |
| Body, nav, inputs | `#1F2937` | Keep existing theme foreground |
| Supporting and footer text | `#6B7280` | Keep existing muted foreground |
| Page / navigation, cards and inputs | `#F8FAFC` / `#FFFFFF` | Keep existing dark page and surface tokens |
| Login input | `#E5E7EB` border, `rgb(29 33 37 / 75%)` placeholder | Use dark border and muted foreground tokens |
| Outline action | Transparent with `#2563EB` hero or `#1B2A4A` lower callout text and border | Use a readable accent/foreground on the actual surface |
| Footer help | `#39B3E6` with white icon | Verify the icon boundary and accessible visual treatment |
| Status, ratings, charts, destructive actions | Retain role-specific colors | Retain the corresponding dark variants |

Reference values describe default public states. Proposed hover for filled blue is `#1D4ED8`, with a visible focus ring in the theme's link color. Check disabled, selected, hover and focus states against their actual backgrounds. White on cyan and a light gray field edge on white can be low contrast. If the icon or edge is the only identifying cue, document a color-only contrast correction and keep the reference color in its contextual role where possible.

## Implementation checklist

### 1. Establish a complete baseline

- [x] Verify `git status --short --branch` reports `develop` and record the commit and test origin.
- [ ] Resolve ledger controller methods and configured aliases to visual routes, redirects, actions, APIs, or nonvisual outputs. Capture real IDs/slugs for parameterized routes and name every role/permission variant.
- [ ] Expand active and selectable homepage variants, builder previews, generated sections, custom pages, enabled add-ons, supported payment modes and lesson types from the intended environment.
- [ ] Use safe fixtures for guest, student, instructor and administrator, including empty, populated, error, expired and disabled cases. Record every popup, modal, drawer and AJAX fragment under its opener.
- [ ] Capture baseline screenshots and computed colors for each visual entry. Use `scripts/responsive-route-manifest.mjs` and `scripts/audit-responsive-design-system.mjs` where they cover the route. Extend the verification inventory for omissions, including roles and frames. Example invocation from the repo root: `npx -p playwright node scripts/audit-responsive-design-system.mjs --base-url http://localhost/academy --theme both` once that origin is healthy. Expected output includes route/viewport results and screenshots. Inspect results, including blocked/auth redirects, individually.

#### Phase 1 execution record, 5 November 2026

- Baseline branch confirmed as `develop` at `3432251`.
- Static inventory completed. `2026-11-05-gpli-color-coverage.md` lists every one of the 577 tracked application view files, 542 public controller method candidates, explicit route aliases and 31 update or standalone HTML candidates.
- The local preview was restored on 5 November 2026. Apache and MySQL are running, `http://localhost/academy/` returns HTTP 200, and the homepage is the active GPLI variant in the `default-new` theme. The guest computed baseline is `#003BA6` primary, `#171613` body/headings, and `#FBFAF7` page background. Browser screenshot capture timed out at the automation layer; computed style evidence is retained. Database discovery confirms the GPLI homepage, Certificate and SCORM as active. Fresh local test sessions confirm administrator dashboard, instructor dashboard and student My Courses all return HTTP 200, render `.gp-ds`, and expose `#003BA6` as the primary token. Full per-route and per-state verification remains open.
- Existing `tmp/responsive-audit` output is historical. It contains a passed 360px public home capture and failed 768px/1024px admin-instructor captures from September 2026. The failures cite duplicate Bootstrap tooltip instances. It is retained as prior evidence and does not close a current baseline check.
- Only `tmp/auth/admin.json` exists. Student and instructor fixture sessions remain required for the role baseline.

### 2. Implement shared roles

- [ ] In `assets/design-system/gp-tokens.css` define action, action hover, on-action, link, heading, field border and placeholder roles. Reuse the existing page/surface/foreground roles where their meaning matches. Define light/dark defaults in the existing theme selectors. Keep status colors independent.
- [ ] In `assets/design-system/gp-base.css` and `gp-components-core.css`, map shared headings, text, links, primary and outline buttons, focus colors, fields and surfaces to the roles. Inspect badges and alerts to confirm they still resolve to semantic tokens.
- [ ] In `assets/design-system/gp-theme-boot.js` and the existing token loader references, align the initial page background and cache versions. Verify first paint, theme toggle and refresh in both themes.

#### Phase 2 execution record, 5 November 2026

- [x] Added GPLI action, hover, on-action, link, heading, field-border, placeholder, outline and focus roles to `gp-tokens.css`. The light palette now uses `#2563EB`, `#1D4ED8`, `#FFFFFF`, `#1B2A4A`, `#1F2937`, `#6B7280`, `#F8FAFC` and `#E5E7EB` in their corresponding roles. Semantic status tokens remain independent.
- [x] Mapped shared headings, links, selected text, primary/outline actions, focus states, Bootstrap fields, native fields, Select2 fields and placeholders to the new roles in `gp-base.css` and `gp-components-core.css`.
- [x] Aligned first paint with `#F8FAFC` and advanced the shared CSS/theme-script cache keys to `gpli-palette-2` across public, backend, lesson, mobile, payment, installer and standalone payout shells.
- [x] Added `scripts/verify-gpli-palette.mjs`. It passes 18 token/mapping/cache assertions; all changed PHP views pass `php -l`, `gp-theme-boot.js` passes `node --check`, and `git diff --check` reports no whitespace errors.
- [x] Runtime verification: the local homepage renders `#F8FAFC` first paint, `#2563EB` primary actions with white text, and `#1B2A4A` heading tokens. Theme toggle reloads into the dark page background with the `#93B4FF` dark link role. Login fields inherit the new foreground; their visible bottom border is still overridden to `#D1D5DB` by the auth page-family stylesheet and is a Phase 3 auth-surface correction.

#### Phase 3 execution record, public and role shells

- [x] Public landing, catalog, course-detail and cart headings map to the GPLI heading role; authentication fields, focus states and links map to the new field/focus/link roles.
- [x] Student headings map to the GPLI heading role while preserving the white text of course-level chips. Admin and instructor content-page headings map to the same heading role; dashboard action links map to the shared link role.
- [x] Live local checks returned HTTP 200 for administrator dashboard, instructor dashboard and student My Courses. Their verified primary headings compute to `rgb(27, 42, 74)`.
- [x] Lesson player and the shared mobile bridge now map player headings to the GPLI heading role. PDF lesson-canvas actions use the GPLI action role, and their stylesheet cache key is advanced to `gpli-palette-3`.
- [x] Payment checkout headings and actions now use the GPLI heading/action/hover/on-action roles. Payment and standalone instructor-payout shells use the `gpli-palette-3` cache key.
- [x] The palette contract now passes 37 assertions. All six changed lesson, mobile, payment and payout PHP views pass `php -l`; `git diff --check` reports no whitespace errors.
- [x] Certificate download CTA, installer, standard HTML error shells, email templates and preview now use GPLI presentation roles. Certificate artwork and semantic error states remain unchanged; installer brand contrast was independently reviewed and corrected to the on-primary role.
- [x] Remaining app-owned authoring surfaces (blog, course media, sections, certificate settings, custom fields and homepage builder/editor) now map their non-semantic UI colors to shared roles. Active admin and instructor dashboard chart primary series use GPLI blue; distinct pending/status series remain unchanged.
- [x] Safe runtime verification covered 19 reachable guest/add-on pages plus a 390px catalog pass: all render the design-system shell, `#F8FAFC` page background, `#1F2937` foreground and `#2563EB` primary actions with white text, without horizontal overflow.
- [ ] Fixture- or external-boundary verification remains open: enrolled lesson/SCORM content, live or test-mode gateway returns, authenticated populated/error/modal states, dynamic certificate output and custom/generated pages require controlled fixtures. One stale course-detail probe returns HTTP 500 and `/tutors` renders the app 404 page; neither is changed by this UI-only work.

### 3. Apply roles by rendering shell

For each family, check its computed defaults and interactive states, locate the winning declaration, and change only the color declaration that owns it. Mark every view/route in the ledger as inherited or explicitly adjusted, and attach its verification evidence.

| Checklist | Scope | Primary owners |
|---|---|---|
| [ ] | Public shell, home variants, builder output, search/catalog, course detail, compare, instructor profiles, blogs, FAQ, contact, legal, community and custom pages | `application/views/frontend/default-new/`, `application/views/components/main/`, `assets/design-system/gp-public-shell.css`, `gp-landing.css`, `gp-courses.css`, `gp-course-detail.css` |
| [ ] | Login, signup, recovery, verification, student account, wishlist, history, messages, invoices and enrollment/cart | `application/views/frontend/default-new/`, `assets/design-system/gp-auth.css`, `gp-student.css`, `gp-cart.css` |
| [ ] | Admin and instructor, including dashboards, tables, authoring, editors, settings, reports, dynamic modals, builder preview and payout | `application/views/backend/`, `assets/design-system/gp-admin-shell.css`, `gp-dashboard.css`, `gp-admin-*.css`; verify separate builder `home_page_builder/css.php` and payout pages |
| [ ] | Lesson player, quizzes, SCORM launch/navigation, completion and certificate | `application/views/lessons/`, `application/views/certificate/`, `assets/playing-page/`, `application/controllers/addons/Scorm.php` and `Certificate.php` as read-only route references |
| [ ] | Mobile bridge and app-owned gateway checkout, pending/success/failure screens | `application/views/mobile/`, `application/views/payment-global/`, gateway partials and standalone payout views |
| [ ] | Installer, error fallbacks, emails and upgrade overlays | `application/views/install/`, `application/views/errors/`, `application/views/email/`, `update/` view overlays that replace active files; verify inline/email color separately |
| [ ] | Configured add-ons, generated pages and externally supplied themes | Runtime ledger entries. Verify every enabled surface and classify unavailable or externally styled entries with ownership and evidence |

### 4. Verify and close the ledger

- [ ] Verify each browser route at desktop and mobile widths in light and dark where supported. Cover 360/390/768/1024/1440 widths for shared shells and any responsive-specific controls. Record supported fixed-theme surfaces and verify their actual theme.
- [ ] Verify text, foreground/background combinations, links, controls, icons and borders. Inspect default, hover, focus, pressed/selected, disabled, loading, validation and error colors where present. Compare against reference values and check contrast against the actual background.
- [ ] Open dynamic modals, drawers and embedded content. Verify an enrollment, course resume/completion and checkout return in a test environment using fixtures or gateway test mode. Check that colors preserve status meanings and chart series remain distinguishable.
- [ ] Review `git diff --check` and `git diff --name-only` for whitespace errors and scope drift. Inspect the diff for color/presentation-only changes. Run `php -l` on any changed PHP view and verify no syntax errors. Keep route, behavior, schema and integration changes out of the branch.
- [ ] Reconcile source ledger, runtime routes and role menus. Record one evidence-backed disposition per row. **Acceptance requires zero unidentified pages, zero app-owned pages without verification, and explicit classification of third-party, disabled and nonvisual entries.** Blocked reachable pages keep the coverage claim open.

#### Hover/focus/active-state purple sweep, 5 November 2026

- [x] Audited every `:hover`, `:focus`/`:focus-visible` and `.active`/`[aria-expanded=true]` rule in `assets/frontend/default-new/css/style.css`, `custom.css` and the themed vendor file `assets/global/plyr/plyr.css` for leftover legacy brand colors. Found and corrected 42 interactive-state rules still hardcoded to `#754FFE`, its `var(--color-4)` alias, and three additional unmapped purple variants (`#6941C6`, `#7B60FF`, `#6f42c1`) that the original Phase 3 sweep had not covered because those rules target hover/focus/active pseudo-states and selector-combined `.active` rules rather than resting-state declarations.
- [x] Filled buttons/chips/tabs on hover or active (background + white text, e.g. `.btn-fill`, `.purchase-btn`, `.page-link`, `.community-menu li a`, `.pagenation .active`, Plyr player controls) now use `var(--gp-action-hover)` for background/border, matching the Color contract's `#1D4ED8` hover value. Text/icon/border-only accents (nav items, footer links, card headings, instructor icons, dropdown items, course tags) now use `var(--gp-link)`. Input/field focus borders (`:focus-visible` on form controls) now use `var(--gp-focus-ring)`.
- [x] Resting-state (non-hover/focus/active) usages of `var(--color-4)` were deliberately left untouched — that is a separate, larger legacy-stylesheet sweep (~68 declarations) outside this task's scope and carries its own blast radius.
- [x] Verified brace balance (open == close) on all three edited files after each patch pass and confirmed zero remaining `#754FFE` / `var(--color-4)` / `#6941C6` / `#7B60FF` / `#6f42c1` matches inside any `:hover`, `:focus`, `.active`, or `[aria-expanded=true]` rule.
- [ ] Not yet done: live/visual re-verification of these corrected hover states in the browser (needs the running local preview), and the still-open resting-state `var(--color-4)` legacy sweep if the user wants that addressed too.
