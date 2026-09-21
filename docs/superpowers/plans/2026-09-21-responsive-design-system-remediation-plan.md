# Responsive Design-System Remediation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` (recommended) or `superpowers:executing-plans` to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make every active Academy LMS surface retain the Geese Project design system at mobile and tablet widths without changing routes, business logic, JavaScript behavior, database data, authentication, or payment integrations.

**Architecture:** Keep legacy CSS loaded during this rollout. Each phase adds only later-loaded, wrapper-scoped `.gp-ds` responsive overrides in the existing owner stylesheet, tied to a baseline-recorded legacy conflict. A read-only browser matrix verifies DS activation, no page overflow, computed-style ownership, and screenshots at desktop, tablet, and mobile widths.

**Tech Stack:** CodeIgniter/PHP views; Bootstrap 5; existing `assets/design-system/gp-*.css` token layer; Playwright via `npx -p playwright`.

---

## Non-negotiable constraints

1. **Responsive DS is mandatory.** Every changed route passes at 1440x900, 1024x768, 768x1024, 390x844, and 360x800 in light and dark themes. Desktop-only validation never passes a phase.
2. **New brand only.** Use current `--gp-*` tokens, Manrope/Inter, existing `gp_ds_*` helpers, and established DS component patterns. Never copy values from legacy CSS.
3. **Surgical file scope.** A phase may edit only its named DS stylesheet(s), its named include file for a cache bump, the audit tooling/manifest, and its report. No opportunistic work from another phase.
4. **CSS-first, UI-only.** Do not modify controllers, models, routes, migrations, permissions, JavaScript handlers, SDK tags, payment fields, form actions, names, IDs, DataTables, Select2, Bootstrap bridge code, or course-builder hooks.
5. **Do not delete/reorder legacy CSS.** `style.css`, `new-style.css`, `responsive.css`, and `custom.css` remain loaded. Retiring selectors requires a separately approved plan after complete coverage.
6. **Scope all new rules.** Frontend: `.gp-ds` plus the page wrapper. Backend: `.gp-ds` plus page/shell wrapper. No global `.btn`, `.row`, `.card`, `.form-control`, `*`, or `body *` mobile reset.
7. **Use `!important` only as a documented exception.** It may counter one recorded legacy `!important` declaration and must include a comment naming that selector. It is never a bulk override strategy.
8. **Theme-safe tokens.** Default remains light; dark stays opt-in. Text/icons use `--gp-fg`, `--gp-fg-muted`, `--gp-fg-faint`, or `--gp-info`; do not add hardcoded hex, `--gp-ink`, or `--gp-text`.
9. **Per-phase rollback.** Revert only the phase commit. An emergency page opt-out may use `gp_ds_exclude_pages`, documented and removed with the correction.
10. **Authenticated evidence is mandatory.** Admin, instructor, course-builder, modal, payment, and lesson flows are blocked—not passed—until safely checked using a non-production role/fixture.
11. **QA must not mutate data.** Navigate, inspect, screenshot, and open/close UI only. Never submit, save, enroll, buy, send, create, or delete.
12. **Cache bust narrowly.** Bump only a changed DS stylesheet's `?v=` value; do not change unrelated include ordering.

## Acceptance matrix

| Tier | Viewport | Required result |
|---|---:|---|
| Desktop | 1440x900 | Existing DS desktop presentation remains correct. |
| Landscape tablet | 1024x768 | No page overflow; shell and actions remain usable. |
| Portrait tablet | 768x1024 | Intentional stacking; no legacy visual system returns. |
| Mobile | 390x844 | No overflow; navigation, forms, cards, drawers, and dialogs fit. |
| Narrow mobile | 360x800 | Long labels/actions wrap or deliberate component scrolling occurs; no clipping. |

At every matrix point capture URL, role, wrapper, theme, width, `scrollWidth <= innerWidth`, screenshot, winning legacy selector (if any), and DS counterpart.

## File ownership

| File | Responsibility |
|---|---|
| `scripts/responsive-route-manifest.mjs` | Fixed routes, role requirement, route wrapper, owning DS file. |
| `scripts/audit-responsive-design-system.mjs` | Read-only matrix and CSS-cascade audit. |
| `assets/design-system/gp-public-shell.css` | Public header, menu, search, cart/wishlist popovers, footer. |
| `gp-courses.css`, `gp-course-detail.css`, `gp-cart.css`, `gp-compare.css` | Discovery, learning, and commerce layouts. |
| `gp-landing.css`, `gp-landing-lms.css`, `gp-homepage-builder.css` | Active landing and builder modules only. |
| `gp-blog.css`, `gp-community.css`, `gp-contact-us.css`, `gp-legal-pages.css`, `gp-faq.css`, `gp-instructor-page.css`, `gp-auth.css`, `gp-student.css` | Matching public page family only. |
| `gp-admin-shell.css` | Shared admin/instructor mobile chrome only. |
| `gp-admin-*.css`, `gp-dashboard.css`, `gp-modal.css`, `gp-tables.css`, `gp-nav-tabs.css` | Corresponding authenticated page family only. |
| Frontend/backend `includes_top.php` | Changed DS CSS cache version only. |

## Phase 0 — Baseline and responsive ownership guard

**Purpose:** Create repeatable, read-only evidence before changing visuals.

**Files:**
- Create: `scripts/responsive-route-manifest.mjs`
- Create: `scripts/audit-responsive-design-system.mjs`
- Create: `docs/superpowers/reports/2026-09-21-responsive-baseline.md`

- [ ] **Step 1: Create a public-route manifest.** Start only with routes proven locally accessible: home, catalog, known fixture course detail, FAQ, About, Contact, and Blog. Each entry has `name`, `path`, `wrapper`, `stylesheet`, and `role: 'public'`.
- [ ] **Step 2: Implement a read-only Playwright audit script.** For each route, theme, and acceptance-matrix viewport it must assert body contains `gp-ds`, owner wrapper exists, and `document.documentElement.scrollWidth <= window.innerWidth`; write JSON and screenshots to `tmp/responsive-audit/`. It must not click, type, submit, or call mutating APIs.
- [ ] **Step 3: Run light baseline.**

  ~~~powershell
  npx -p playwright node scripts/audit-responsive-design-system.mjs --base-url http://localhost/academy --theme light
  ~~~

  Expected: one JSON row per route/viewport; explicit failed assertion for absent DS class, wrapper, or overflow.

- [ ] **Step 4: Run dark baseline.**

  ~~~powershell
  npx -p playwright node scripts/audit-responsive-design-system.mjs --base-url http://localhost/academy --theme dark
  ~~~

- [ ] **Step 5: Write the baseline report.** Each failure includes computed property, winning legacy file/selector, intended DS file/selector, smallest triggering width, and its exact later phase. Do not fix it in Phase 0.
- [ ] **Step 6: Commit Phase 0 only.**

  ~~~powershell
  git add scripts/responsive-route-manifest.mjs scripts/audit-responsive-design-system.mjs docs/superpowers/reports/2026-09-21-responsive-baseline.md
  git commit -m "test: add responsive design-system baseline audit"
  ~~~

## Phase 1 — Public shell and mobile navigation

**Purpose:** Remove old-brand responsive leakage from public header/footer chrome.

**Files:**
- Modify: `assets/design-system/gp-public-shell.css`
- Modify: `assets/design-system/gp-shell.css` only if the conflict is truly shared shell behavior
- Modify: `application/views/frontend/default-new/includes_top.php` only for changed CSS cache version
- Test: audit script

**Allowed routes:** home, catalog, course detail, Blog, Contact.

- [ ] **Step 1: Add failing audit probes** for header, menu trigger/drawer, search, cart/wishlist popovers, footer, and theme control at 390px and 360px.
- [ ] **Step 2: Record the competing legacy selector before CSS changes.** Target `responsive.css`, `style.css`, `new-style.css`, or `custom.css`; do not infer from screenshots.
- [ ] **Step 3: Add minimal, wrapper-scoped rules in `gp-public-shell.css`.** Cover only observed header size, navigation visibility, drawer width, search location, popover bounds, and footer wrapping. Do not edit legacy CSS.
- [ ] **Step 4: Run all Phase 1 routes at all widths and both themes.** Manually open/close shell controls only; record JavaScript issues as blockers rather than changing JS.
- [ ] **Step 5: Run the consistency guard and commit only Phase 1.**

  ~~~powershell
  git diff -- assets/design-system/gp-public-shell.css assets/design-system/gp-shell.css | bash scripts/check-design-system-consistency.sh
  git add assets/design-system/gp-public-shell.css assets/design-system/gp-shell.css application/views/frontend/default-new/includes_top.php scripts/audit-responsive-design-system.mjs scripts/responsive-route-manifest.mjs
  git commit -m "fix: preserve public design system on mobile shell"
  ~~~

## Phase 2 — Course discovery and commerce

**Purpose:** Make catalog, detail, compare, cart, and wishlist responsive in the new brand without changing commerce behavior.

**Files:**
- Modify: `assets/design-system/gp-courses.css`
- Modify: `assets/design-system/gp-course-detail.css`
- Modify: `assets/design-system/gp-cart.css`
- Modify: `assets/design-system/gp-compare.css` only for a compare-specific baseline failure
- Modify: frontend `includes_top.php` only for cache versions
- Test: audit script

**Forbidden:** payment-global templates, gateway SDKs, add-to-cart/wishlist JS, form fields/actions, hidden inputs, cart counters, controllers.

- [ ] **Step 1: Add failing probes** for catalog filters, grid/list controls, card image/text order, price/action rows, detail aside, tabs, related grid, cart/wishlist controls, compare table overflow, and old-brand buttons.
- [ ] **Step 2: Run the full theme/viewport matrix and capture breakpoint-specific conflicts** at 991px, 768px, 576px, 420px, and 360px.
- [ ] **Step 3: Add only baseline-linked DS overrides in the matching owner file.** Preserve every existing JS selector/ID and use contained component scrolling for intentionally wide tables, never page-level overflow.
- [ ] **Step 4: Re-run all assertions; manually open but never submit cart/wishlist panels.**
- [ ] **Step 5: Guard and commit only Phase 2.**

  ~~~powershell
  git diff -- assets/design-system/gp-courses.css assets/design-system/gp-course-detail.css assets/design-system/gp-cart.css assets/design-system/gp-compare.css | bash scripts/check-design-system-consistency.sh
  git add assets/design-system/gp-courses.css assets/design-system/gp-course-detail.css assets/design-system/gp-cart.css assets/design-system/gp-compare.css application/views/frontend/default-new/includes_top.php scripts/audit-responsive-design-system.mjs scripts/responsive-route-manifest.mjs
  git commit -m "fix: align course and commerce mobile layouts with design system"
  ~~~

## Phase 3 — Active public marketing, content, and account surfaces

**Purpose:** Complete responsive DS ownership for active public routes, one family at a time.

**Files:** Modify only the appropriate owner(s) among `gp-landing.css`, `gp-landing-lms.css`, `gp-homepage-builder.css`, `gp-blog.css`, `gp-community.css`, `gp-contact-us.css`, `gp-legal-pages.css`, `gp-faq.css`, `gp-instructor-page.css`, `gp-instructor-apply.css`, `gp-auth.css`, `gp-student.css`, and `gp-dark-surfaces.css`; modify frontend includes only for changed versions.

**Excluded:** `home_2.php`–`home_7.php`, inactive themed homes, dead templates, and add-on routes until database/controller evidence proves an active route.

- [ ] **Step 1: Add only verified-active routes to the manifest** with exact wrapper and owner CSS.
- [ ] **Step 2: Add a failing responsive assertion for each unique primitive:** hero, grid, article/sidebar, comments, policy prose, contact form, instructor profile, auth/verification form, learner dashboard.
- [ ] **Step 3: Fix one route family per commit, in its existing owner CSS.** Every rule begins with `.gp-ds` plus the route wrapper and records the baseline breakpoint.
- [ ] **Step 4: For auth, verify labels, fields, password toggles, resend controls, validation messages, and submit controls remain visible/keyboard reachable at 360px.** Do not submit or change credentials.
- [ ] **Step 5: For blog/community, use populated safe fixtures before closing the family.** Empty state does not prove cards, comments, menus, or tag rows.
- [ ] **Step 6: Run the full matrix, consistency guard, and one focused commit per family.**

## Phase 4 — Admin/instructor shared shell

**Purpose:** Correct shared authenticated mobile chrome before individual backend pages.

**Files:**
- Modify: `assets/design-system/gp-admin-shell.css`
- Modify: `assets/design-system/gp-shell.css` only for truly shared theme-control behavior
- Modify: `application/views/backend/includes_top.php` only for cache version
- Test: audit script

**Precondition:** non-production admin and instructor sessions plus safe test routes. Credentials never enter the repository/audit script.

- [ ] **Step 1: Add authenticated manifest entries** with `role: 'admin'` or `role: 'instructor'`. Without an existing test session the script returns “manual authenticated check required,” never pass.
- [ ] **Step 2: Capture failures** for topbar, sidebar/drawer, dropdowns, notifications, profile menu, theme toggle, and shell spacing at 768px/390px/360px.
- [ ] **Step 3: Implement only `gp-admin-shell.css` overrides.** Preserve Bootstrap 5 markup and all `gp-bs5-admin-bridge.js` assumptions; do not edit bridge, Hyper/Bootstrap assets, or JS.
- [ ] **Step 4: Open/close navigation and dropdowns without saving data; then run public smoke routes** to prove no shell bleed.
- [ ] **Step 5: Guard and commit only Phase 4.**

## Phase 5 — Admin/instructor page families and AJAX fragments

**Purpose:** Fix responsive backend content while preserving DataTables, Select2, wizards, modals, and course-builder behavior.

**Files:** Modify only the named owner for the current family among `gp-dashboard.css`, `gp-admin-courses.css`, `gp-admin-users.css`, `gp-admin-enrol.css`, `gp-admin-report.css`, `gp-admin-message.css`, `gp-admin-settings.css`, `gp-admin-blog.css`, `gp-admin-contact.css`, `gp-admin-newsletter.css`, `gp-admin-profile.css`, `gp-admin-addons.css`, `gp-admin-announce.css`, `gp-admin-themes.css`, `gp-admin-custom-field.css`, `gp-user-custom-field.css`, `gp-student.css`, `gp-modal.css`, `gp-nav-tabs.css`, and `gp-tables.css`.

**Forbidden:** `application/views/backend/common_scripts.php`, controller/action code, DataTables/Select2 initialization, modal URLs, course-builder IDs, dragula selectors, payment logic.

- [ ] **Step 1: Split work/commits by family:** dashboard; course builder/curriculum; users/enrol/reports; settings/content; messages/newsletters; shared modals/tables/tabs.
- [ ] **Step 2: Add failing assertions per family:** no title/action overlap; filters stack; DataTables have contained scrolling; forms collapse safely; modal body fits; tabs and menus remain usable.
- [ ] **Step 3: Run all widths/themes as the correct role and record winning legacy selector before each change.**
- [ ] **Step 4: Add smallest CSS-only override in that family owner.** Do not add generic `gp-components-core.css` rules unless the baseline proves identical markup/behavior across every consumer.
- [ ] **Step 5: Use non-mutating interactions only:** open/close modal/Select2/dropdown, switch tabs, sort/page DataTable only if it does not mutate, expand/collapse accordion. Check browser console.
- [ ] **Step 6: Re-run family matrix plus public smoke matrix, guard, and commit one family unit.**

## Phase 6 — Isolated conversion-critical surfaces

**Purpose:** Handle nonstandard shells without changing their sensitive logic.

**Files:** Only after route inventory confirms ownership: `gp-payment.css`, `gp-payout-checkout.css`, `gp-install.css`, `gp-modal.css`, `gp-offcanvas.css`, and the corresponding payment/install/lesson/mobile include only for a changed version.

**Precondition:** test environment and safe fixture. Payment/payout, installer, lesson player, mobile webview, and homepage-builder are isolated sub-phases.

- [ ] **Step 1: Inventory one surface before editing:** route, shell, CSS order, data sensitivity, and reachable safe fixture.
- [ ] **Step 2: Add it to the manifest only once reachable and safe to inspect.**
- [ ] **Step 3: For payments, validate fit/hierarchy without submitting.** Never alter SDK tags, callbacks, payment fields/tokens, hidden inputs, or gateway JS.
- [ ] **Step 4: For lesson/mobile/installer, add only owner-scoped responsive DS CSS.** Exclude print/PDF certificate/canvas and email media from this plan.
- [ ] **Step 5: Run all widths/themes, document blockers, and commit each isolated surface separately.**

## Phase 7 — Full regression gate and selector-retirement decision

**Purpose:** Create the honest completion record; decide, but do not perform, legacy CSS retirement.

**Files:**
- Modify: audit script and manifest
- Create: `docs/superpowers/reports/2026-09-21-responsive-final-report.md`
- Modify: `DESIGN_SYSTEM_STANDARDIZATION_PLAN.md` only to link the report/decision

- [ ] **Step 1: Run all public routes across both themes and all viewports.**
- [ ] **Step 2: Run every accessible authenticated route by role; mark missing access/fixtures as blocked with exact evidence.** Never pass from source inspection.
- [ ] **Step 3: Categorize every active legacy responsive selector:** required by unconverted active surface; documented DS override; dead/unreachable markup; or third-party/print/email out of scope.
- [ ] **Step 4: Do not delete a selector.** Produce a candidate list where every removal has a route reference, cascade evidence, and full matrix pass. Require user approval for a later retirement plan.
- [ ] **Step 5: Write final coverage, screenshot, console, blocker, rollback, and exception report.**
- [ ] **Step 6: Run final guard and status check.**

  ~~~powershell
  git diff -- 'assets/design-system/*.css' | bash scripts/check-design-system-consistency.sh
  git status --short
  ~~~

- [ ] **Step 7: Commit final tooling/report only when every non-blocked route passes.**

## Completion criteria

- Every active reachable route has an owning responsive DS stylesheet and audit evidence at all five widths in both themes.
- No audited route has page-level horizontal overflow or a legacy visual system at mobile/tablet widths.
- Authenticated, payment, and isolated surfaces are passed with live safe-flow evidence or explicitly blocked with a concrete missing access/fixture reason.
- All new rules are scoped, tokenized, minimal, and independently reversible.
- No unrelated controllers, models, routes, business JS, forms, payment SDKs, database schema, or legacy stylesheet removal changed.
- Legacy CSS stays loaded; its deletion is deferred to a separately approved selector-retirement plan.
