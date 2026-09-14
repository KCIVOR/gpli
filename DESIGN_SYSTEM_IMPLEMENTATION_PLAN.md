# Academy LMS — Design System Implementation Plan (v2)

**Status:** Planning document. No production code has been changed by this document.
**Operating mode:** Surgical, incremental, reversible, evidence-driven, scoped, testable, trackable.
**Supersedes:** `DESIGN_SYSTEM_MIGRATION_PLAN.md` (deleted — its page/route counts and broken-route list were independently found to be wrong; see `UI_ARCHITECTURE_AUDIT.md`).
**Prerequisite reading:** [`UI_ARCHITECTURE_AUDIT.md`](./UI_ARCHITECTURE_AUDIT.md) (same directory) — the verified, evidence-tagged inventory of pages, routes, styling, and component reuse this plan is built on. Every number in this plan traces back to that document or is flagged below as unverified.

---

## 0. Hard Rule — Source of Truth (non-negotiable)

```
C:\Users\Rovick\Downloads\geeseprojdesignsystem (1).html
```

This exact file — not a memory of it, not a re-typed approximation, not a paraphrase — is the **only** authority for colors, typography, spacing, radius, shadow, motion, and every component pattern (buttons, cards, forms, badges, alerts, tables, breadcrumbs, pagination, tabs, accordion, dropdowns, tooltips, popovers, modals, offcanvas, progress, loading states, list/button groups, file upload, empty states, admin sidebar nav, carousel). It was extended in this project (sections 11–24 are marked `extension` inline) specifically to cover every component this LMS needs. **Any phase that touches visual styling must open and re-read the live file directly before writing CSS for that phase.** No value is invented; if the LMS needs something the file doesn't define, it is proposed and flagged explicitly in that phase's output, never added silently.

**Secondary reference (concrete pattern example, not a token source):**
```
C:\Users\Rovick\Downloads\gplilmslandingpreview (1)\gpli-lms-landing-package\index.html
```
A full real page built from the same tokens — shows how components combine in practice (course cards, category cards, instructor cards, stat tiles, CTA bands). Used to resolve ambiguity about how a component should look assembled on a real page, never as a source of new colors/spacing not already in the hard-rule file.

**Risk flagged, not resolved here:** both files live outside this repository, in a personal Downloads folder. If either is moved, renamed, or edited outside this project's awareness, every phase that depends on it stalls silently. **Recommendation (requires your decision, not assumed):** copy both into `assets/design-system/reference/` at the start of Phase 0 so the repo carries its own frozen snapshot. Flagged as an open decision, not carried out unilaterally.

---

## 1. Never-Assume Rule (applies to every phase, no exceptions)

Every number, file list, and component count in this plan was correct **at audit time**. Code moves. Before acting on any of the following in a given phase, re-verify it live rather than trusting this document:

- The exact list of files a component touches (re-grep the specific class/pattern in the pages that phase actually targets — do not reuse a stale count).
- Whether a class used in markup is also a JS/behavior hook (re-grep the relevant `.js` files and inline `<script>` blocks in the same view before changing any `class=""`).
- The live value of database-driven settings (active theme, active homepage template, `custom_css` content) — these were traced in the audit as mechanisms, not queried live.
- Whether a "broken route" is still broken (re-check file existence immediately before building or removing anything for it).
- Whether the two hard-rule reference files above are still at the stated paths and still contain what this plan describes.

If something can't be determined from the code, the phase output says **"cannot be determined — flagged for user decision,"** never a guess.

---

## 2. Absolute Constraints (every phase, no exceptions)

**UI-only.** Never modify: database queries/schema, models, controllers' business logic, authentication, authorization, permissions, payment logic, enrollment logic, course/lesson/quiz logic, scoring, AJAX endpoint behavior, API response formats, form processing, validation rules, sessions, cookies, routing, URLs, request parameters, JS business logic/event behavior, or third-party integration logic (payment gateways, Zoom SDK, etc.).

**If a visual change appears to require a logic change: STOP.** Report the dependency in that phase's output before making any change. Do not resolve it unilaterally.

**Never, in service of this plan:**
- Repo-wide find-and-replace.
- Blanket Bootstrap class redefinition (`.btn`, `.card`, `.table` unscoped, outside `.gp-ds`).
- Renaming files/directories, or "cleanup" of unrelated code.
- Rewriting working JS or PHP that isn't the specific visual surface being migrated that phase.
- Removing anything (dependency, "unused" code, file) without proof of non-use **and** explicit authorization from you.
- Touching the two Bootstrap-version files' *content* outside of Phase 4 (the phase explicitly scoped to that problem).

Every file changed in a phase must have a stated reason tied to that phase's scope. This is a migration, not a refactor.

---

## 3. Isolation & Activation Mechanism

### 3.1 Namespace

All new CSS lives under an explicit scope class, never a bare Bootstrap selector:
```css
.gp-ds .btn { }
.gp-ds .card { }
.gp-ds table.data-table { }
.gp-ds .modal-demo { }
```
The stylesheet is **inert** on every page until that page carries the `gp-ds` class. Loading the stylesheet everywhere is safe (Phase 0); **applying** the class per page is a separate, deliberate act per phase.

### 3.2 Activation whitelist — corrected

The prior plan created `application/config/design_system_pages.php` but **never wired it up** — CodeIgniter's autoloader doesn't load it, and nothing calls `$this->config->load(...)`. The audit confirmed this file exists but is empty and referenced nowhere. Phase 0 must both create the whitelist **and** prove it actually loads (a temporary `var_dump()` check, removed once confirmed) before anything else depends on it.

```php
// application/config/design_system_pages.php
$config['gp_ds_frontend_pages'] = []; // e.g. 'about_us', 'login'
$config['gp_ds_admin_pages']    = [];
$config['gp_ds_user_pages']     = [];
```

In each shared shell (`frontend/default-new/header.php`, `backend/header.php`), immediately before `<body>`:
```php
<?php
$this->config->load('design_system_pages');
$gp_ds_whitelist = $this->config->item('gp_ds_frontend_pages'); // or admin/user variant
$gp_ds_active = is_array($gp_ds_whitelist) && in_array($page_name, $gp_ds_whitelist);
?>
<body class="<?= $gp_ds_active ? 'gp-ds' : '' ?>">
```
Rollback for any single page = remove one array entry. No CSS is touched to roll back a page.

### 3.3 Shared-shell edit scope (high-risk file handling)

`header.php` (both trees) is the only shared file this mechanism requires touching, and only for the conditional class expression above — confirmed via the audit that both trees have exactly one shared header each (`frontend/default-new/index.php`, `backend/index.php`). No other change to those files happens in Phase 0. Any later shared-shell *visual* change (e.g. the header's own look) is Phase 6, not Phase 0.

---

## 4. Verified Scope (from the audit — re-verify before relying on any count)

| Area | Distinct routable pages found | Working | Broken |
|---|---|---|---|
| Frontend (`Home.php`, `Blog.php`, `Login.php`, `Sign_up.php`, `Page.php`) | ~45 | 38 | 7 |
| Admin (`Admin.php`) | ~76 | 75 | 1 |
| User/Instructor (`User.php`) | 14 | 13 | 1 |
| **Total** | **~135** | **126** | **10** |

Plus, previously excluded by the old plan — **in scope now, per your instruction that every page must follow the new rule**, each with its own constraints (§9):

| Area | Files | Constraint |
|---|---|---|
| `payment-global/` (checkout/gateway callback pages, 20 files) | 20 | Visual wrapper only — the gateway SDK's own required markup/fields must not be altered, per Stop Condition in §11 |
| `install/` (one-time installer, 11 files) | 11 | Lowest priority — seen only during initial setup, not by end users post-launch |
| `email/` (transactional email templates, 2 files) | 2 | Different medium — email clients need inlined, table-based CSS; cannot reuse the `.gp-ds` scoped stylesheet approach as-is (flagged, own sub-phase) |
| `components/main/` (homepage-builder section templates, 105 files) | 105 | Feeds the homepage builder (`components/builder/`) — styled once as shared partials rather than per-instance, since they're already a real reuse mechanism (audit §3) |
| `lessons/` (course player) | 12 | 1 page, own template tree |
| `mobile/` (webview pages) | 13 | 3 routes, own template tree |

**Broken routes (10, exact citations in the audit) — none are touched until Phase 5, and only after investigation, never invented:**

Frontend: `my_notifications` (Home.php:392), `update_user_photo` (Home.php:445), `cookie_policy` (Home.php:1110), `instructor_dashboard` (Home.php:1128), `create_course` (Home.php:1140), `manage_course_details` (Home.php:1156), `lesson_edit` (Home.php:1241).
Admin/User: `lessons` (Admin.php:1308), `lessons` (User.php:460), `open_ai_settings` (Admin.php:2372).

**Component footprint (file-count) — carried forward from the prior plan's count, `NOT independently re-verified in this document`. Re-count before sequencing Phase 2's sub-phases, per §1:**

| Component | Files (unverified) | Provisional priority |
|---|---|---|
| Cards | 184 | 2a |
| Badges | 94 | 2a |
| Tables | 50 | 2a |
| Alerts | 36 | 2a |
| Collapse | 35 | 2a |
| Accordions | 29 | 2a |
| Dropdowns | 27 | 2a |
| Popovers | 22 | 2b |
| Tabs/tab-pane | 22 | 2b |
| Progress | 10 | 2b |
| Breadcrumbs | 9 | 2b |
| Nav-tabs | 8 | 2b |
| List-group | 7 | 2b |
| Pagination | 6 | 2b |
| Btn-group | 6 | 2b |
| Offcanvas | 5 | 2b |
| Modals | 4 | 2b |
| Carousel | 2 | 2c |
| Tooltips | 1 | 2c |

---

## 5. The Two Known High-Risk Facts This Plan Must Design Around

1. **Two Bootstrap versions load simultaneously on backend pages** (frontend's 5.3.1 file is loaded on top of the backend's own 4.3.1 template bundle — audit §4.2). **Decision already made with you: standardize the admin panel onto Bootstrap 5.3.1** (matching the frontend), removing the 4.3.1 template bundle's dependency. This is its own isolated phase (Phase 4) specifically because it's the one change in this whole plan that can alter *behavior*, not just appearance — DataTables, dropdowns, modals, and tabs all have version-specific JS/markup expectations.
2. **No shared UI-atom components exist anywhere in the codebase** (every card/badge/table/etc. is hand-duplicated — audit §3). This plan's Phase 2 doubles as the fix for that: instead of just overriding classes in place, each component is extracted into a real shared partial (or, where CodeIgniter's `load->view()` partial pattern doesn't fit cleanly, a documented, minimal set of consistent markup that every instance is converted to) so future changes stop requiring a per-file hunt.

---

## 6. Component Extension Rule

For every component the LMS uses that maps to a hard-rule pattern (badge, alert, table, modal, dropdown, tab, accordion, pagination, breadcrumb, list-group, btn-group, offcanvas, progress, tooltip, popover, carousel, admin sidebar nav, empty/loading state, file upload):

1. Inspect the **actual existing markup** for that component in the pages that phase targets — not assumed markup, not the prior plan's description of it.
2. Identify its Bootstrap classes and JS/data-attribute hooks (`data-bs-toggle`, DataTables `id`/init options, etc.) by reading the real file.
3. Re-read the matching section of the hard-rule file directly (§0) and translate its pattern into a `.gp-ds .{bootstrap-class}` override using only the tokens already defined there — no invented colors/spacing.
4. If the LMS needs a value the hard-rule file has no token for, propose the closest existing token first; only add a new one if none fits, and document it explicitly in that phase's output as a token extension.
5. Preserve DOM structure, JS hooks, and behavior exactly — only `class=""` (and, where unavoidable, wrapper `<div>`s for layout) change.
6. Document the finished component in §12 (Component Registry) as it's built.

---

## 7. JavaScript & PHP Safety Rules

**JS safety:** before changing any `class=""`, grep the relevant `.js` files and inline `<script>` blocks in the same view for that exact class string. The audit already found specific real examples of class-as-behavior-hook (`.on-hover-action` used across 7 admin files, `.ajax_loader`, `.lms2-reviewSlider` and its per-theme siblings) — these are never removed or renamed; the new visual class is **added alongside**, never substituted.

**PHP safety:** edits touch `class=""` attributes and, where unavoidable, wrapper `<div>`s. They never touch PHP variables, loops, conditionals, `load->view()` calls, form `action`/`method`, input `name` attributes, URLs, CSRF fields, session/permission checks, or any `data-*` attribute carrying application state rather than pure styling.

**CSS safety:** no `!important` unless a specific Bootstrap specificity conflict is documented inline explaining why. No global element resets outside `.gp-ds`. No selector broader than `.gp-ds <specific-target>`.

---

## 8. Phase Structure

### PHASE 0 — Foundation
**Objective:** Stand up the real token/component CSS (built from the hard-rule file, replacing the currently-empty `assets/design-system/` stub files), the namespace, and a whitelist mechanism that actually loads. Migrate zero pages.

**Files:**
- `assets/design-system/gp-tokens.css` — every token from the hard-rule file's `:root`, re-namespaced `--gp-*`, scoped under `.gp-ds`, including the extension tokens (success/warning/danger/info, ease/duration).
- `assets/design-system/gp-base.css` — typography/base rules.
- `assets/design-system/gp-components-core.css` — buttons, cards, badges, alerts, forms (matches hard-rule sections 05–07, 11–13).
- `assets/design-system/gp-theme-toggle.js` — Light/System/Dark, `localStorage`-based, inert on any page without `.gp-ds`.
- `application/config/design_system_pages.php` — empty whitelist arrays.
- Modified: both `includes_top.php` files (font links + new CSS/JS `<link>`/`<script>` tags, appended after existing stylesheets).
- Modified: both `header.php` files (conditional `gp-ds` class + toggle markup, gated behind the same whitelist check).

**Forbidden:** any page migration, any Bootstrap override beyond the toggle control, any component styling beyond what's listed.

**Validation:** confirm `config->item(...)` actually returns the whitelist array (temporary `var_dump`, removed after); load a sample of pages from all three areas and confirm **zero visual difference** from baseline, since the whitelist starts empty.

**Rollback:** delete the new files; remove the `<link>`/`<script>`/conditional-class additions from the four modified files.

---

### PHASE 1 — Core Primitives (isolated build)
**Objective:** Build and validate buttons, type scale, form fields, cards, badges, alerts against a scratch page — not a live LMS page. Still migrate zero pages.

**Validation:** a scratch HTML page (in the scratchpad, outside the app) reproducing real markup pulled from actual LMS files, checked side-by-side against the hard-rule file's own rendering.

**Forbidden:** touching any real page's markup.

---

### PHASE 1-PILOT — Three Representative Pages
**Objective:** Prove tokens → components → whitelist activation against real, live pages before any wider rollout.

**Pages (confirmed by reading the file first, not assumed):**
1. One frontend page with a form + cards + badges (candidate: `courses_page` — confirm by reading it).
2. One admin page with a table + dropdown + badge (candidate: `categories` or `users` — confirm by reading it; both are DataTables-backed per the audit).
3. One instructor/user page with a form + card (candidate: `backend/user/dashboard` — confirm by reading it).

**Process per page:** baseline screenshot + inventory of interactive elements (which dropdowns/modals/tabs/DataTables config exist) → whitelist that one `page_name` → apply component CSS, extending it where gaps appear → retest every interactive element against baseline → test desktop/tablet/mobile, light/dark.

**Forbidden:** any other page's whitelist entry; any JS file edit unless a class-rename dependency is found — in which case STOP and report, don't silently fix.

**⚠ STOP condition:** do not proceed past this phase until you've explicitly confirmed the pilot is stable.

---

### PHASE 2 — High-Footprint Component Rollout
Subdivided by the (re-verified) priority table in §4. Each sub-phase produces the §10 "before" output and needs your explicit approval before starting (medium/high risk).

- **2a:** cards, badges, tables, alerts, collapse, accordions, dropdowns — and, per §5.2, each of these is extracted into a real shared partial as it's touched, not just re-skinned in place.
- **2b:** popovers, tabs, progress, breadcrumbs, nav-tabs, list-group, pagination, btn-group, offcanvas, modals.
- **2c:** carousel, tooltips — built only if a page actually being migrated needs them.

Target pages for each sub-phase are listed explicitly when that sub-phase opens, drawn from the verified inventory (§4), prioritized by which pages combine the most components of that sub-phase.

---

### PHASE 3 — Remaining Pages
Continue page-by-page (or small-batch) through the rest of the ~135-page inventory using the Phase 1-Pilot checklist mechanism, until every page is whitelisted and validated, or you decide to stop at a partial rollout.

---

### PHASE 4 — Admin Panel Engine Unification (Bootstrap 4 → 5)
**Objective:** Remove the backend's Bootstrap 4.3.1 template dependency, standardizing the whole admin panel on the same Bootstrap 5.3.1 the frontend already uses — resolving the dual-version conflict identified in the audit.

**This is the highest-risk phase in this plan**, because unlike every other phase, it can change *behavior*, not just appearance: DataTables plugins (`dataTables.bootstrap4.js`, `responsive.bootstrap4.min.js`), the admin template's own JS (`app.min.js`), dropdown/modal/tab markup conventions, and grid class names (`.col-*`) all differ between the two versions.

**Required before this phase starts:**
- A full inventory (built at phase-open time, not assumed) of every Bootstrap-version-sensitive plugin/markup pattern in `backend/**` — DataTables init options, modal triggers, dropdown triggers, tab/accordion markup, grid classes.
- A decision, made explicitly with you at that time, on the DataTables/plugin replacement path (Bootstrap-5-compatible equivalents exist for all of these, but which specific replacement is used is a real choice, not assumed here).

**Validation:** every interactive admin page (dropdown, modal, tab, DataTable, accordion, collapse) retested individually against its pre-change behavior — not just visually, functionally (sorting/paging/search still work, modals still open/close, forms still submit).

**Rollback:** this phase is the one place in this plan where rollback is **not** a single whitelist-entry removal — it requires reverting the specific plugin/markup changes made. Each file touched in this phase is logged individually in that phase's output for exactly this reason.

**⚠ STOP condition:** if any admin page's interactive behavior cannot be reproduced identically under Bootstrap 5 without a JS logic change, stop and report — do not silently alter behavior to make it fit.

---

### PHASE 5 — Broken Routes & Extended Surfaces

**5a — Broken routes (10):** for each of the 10 broken `page_name`s, inspect what the controller method already prepares (session data, DB queries, variables passed to `page_data`) to infer what the page is expected to contain — build a real page consistent with what's already there. Where the controller gives no usable signal for what the page should contain, this is flagged explicitly as **"cannot be determined — needs your decision,"** not invented.

**5b — `payment-global/` (20 files):** visual wrapper styling only; the payment gateway SDK's own required form fields/markup are never altered (Stop Condition, §11).

**5c — `email/` (2 files):** different medium — cannot use the `.gp-ds` linked-stylesheet approach (email clients strip `<link>` tags and most CSS). Requires inlined, table-based styling matching the hard-rule file's colors/type by hand-translation, not a shared stylesheet. Own validation step: send-test in at least one real email client, not just browser preview.

**5d — `components/main/` (105 homepage-builder section templates):** styled as the shared partials they already architecturally are (audit §3 confirmed these feed a real reuse mechanism), so one style pass here propagates to every homepage section instance.

**5e — `install/` (11 files):** lowest priority, done last, since it's seen only once per deployment.

---

### PHASE 6 — Full-System Regression & Shared-Shell Polish
Only after every page above is migrated: revisit the shared header/footer/nav's own visual treatment (the one shared-shell change explicitly deferred from Phase 0), then run the full Testing Checklist (§9) across every one of the ~135+20+11+2+105 pages, or a rigorously representative sample if 100% manual coverage isn't feasible — stated explicitly either way in that phase's output, never silently assumed to be "probably fine."

---

## 9. Testing Checklist (every page, every phase)

**Functional:** page loads · navigation works · links work · forms submit · validation fires as before · AJAX calls fire/return as before · modals open/close · dropdowns open/close · tabs switch · collapse expands/collapses · tables render · DataTables sorting/searching/paging work · pagination works · every existing button/action does what it did before.

**Visual:** typography/colors/spacing/borders/radius/shadows match the hard-rule file's own patterns.

**Theme:** checked under Light / System / Dark · no unreadable text on any surface · toggle persists across reload · toggle itself visible/usable in both themes.

**Responsive:** desktop, tablet, mobile — nav, sidebar, tables, cards, forms, modals, dropdowns, overflow, typography, spacing, buttons, long text, images all checked at each breakpoint.

**Regression:** a sample of non-migrated pages (at minimum one from each of the other trees not being touched that phase) re-checked to confirm zero visual change.

---

## 10. Required Output Before Each Phase

```
Phase: PHASE-XX
Objective: ...
Pages: (exact page_name list, re-verified against the current inventory, not copied from this plan)
Components: (exact components touched)
Shared Dependencies: ...
Files Expected To Change: ...
Files Explicitly Protected: ...
Risks: LOW/MEDIUM/HIGH, with reasoning
Implementation Strategy: ...
Validation Plan: ...
Rollback Plan: ...
```
Medium/high-risk phases (Phase 2 sub-phases, Phase 4, Phase 5b/5c) wait for your explicit approval before implementation begins.

## 11. Stop Conditions (any phase, any point)

- A UI change appears to require a backend logic change.
- A component's JS behavior would need to change, not just its appearance.
- Removing/altering Bootstrap JS seems necessary outside Phase 4.
- A shared component can't be safely scoped under `.gp-ds` without affecting non-migrated pages.
- A page can't be isolated from non-migrated pages via the whitelist.
- Existing behavior appears broken independent of this plan (another undiscovered broken route, etc.).
- The design system conflicts with a third-party plugin's own required markup/CSS (payment gateway SDKs, Zoom SDK, DataTables, Dropzone).
- A class is both a styling hook and a JS hook and the safe path isn't obvious.
- A broken route's intended content can't be determined from the code.
- Correct behavior can't be determined from the code at all — mark **UNKNOWN**, do not guess.

## 12. Component Registry (living document — updated as each component is built)

| Component | Status | File | `.gp-ds` selector(s) | Dark verified | Shared partial extracted? | Notes |
|---|---|---|---|---|---|---|
| Tokens | Not started | `gp-tokens.css` | `.gp-ds` | N/A | N/A | |
| Theme toggle | Not started | `gp-theme-toggle.js` | `.gp-ds .theme-toggle` | N/A | N/A | |
| Buttons | Not started | `gp-components-core.css` | `.gp-ds .btn*` | ☐ | N/A | |
| Cards | R4 batch 1: this batch converted 10; remaining still hand-written; wrapper-only | same | `.gp-ds .card` | ☐ | wrapper-only | Converted 10 simple add/edit forms via `gp_ds_card`. Remaining still hand-written. |
| Badges | Not started | same | `.gp-ds .badge` | ☐ | ☐ | 94 files (unverified) |
| Alerts | Not started | same | `.gp-ds .alert` | ☐ | ☐ | 36 files (unverified) |
| Forms | Not started | same | `.gp-ds .form-control` etc. | ☐ | N/A | |
| Tables | Not started | TBD (2a) | `.gp-ds table.table` | ☐ | ☐ | 50 files (unverified) |
| Dropdowns | Not started | TBD (2a) | `.gp-ds .dropdown-menu` | ☐ | ☐ | |
| Accordions | Not started | TBD (2a) | `.gp-ds .accordion` | ☐ | ☐ | |
| Collapse | Not started | TBD (2a) | `.gp-ds .collapse` | ☐ | ☐ | |
| Modals | Not started | TBD (2b) | `.gp-ds .modal` | ☐ | ☐ | |
| Tabs | Not started | TBD (2b) | `.gp-ds .nav-tabs` | ☐ | ☐ | |
| Pagination | Not started | TBD (2b) | `.gp-ds .pagination` | ☐ | ☐ | |
| Breadcrumbs | Not started | TBD (2b) | `.gp-ds .breadcrumb` | ☐ | ☐ | |
| List-group | Not started | TBD (2b) | `.gp-ds .list-group` | ☐ | ☐ | |
| Btn-group | Not started | TBD (2b) | `.gp-ds .btn-group` | ☐ | ☐ | |
| Offcanvas | Not started | TBD (2b) | `.gp-ds .offcanvas` | ☐ | ☐ | |
| Progress | Not started | TBD (2b) | `.gp-ds .progress` | ☐ | ☐ | |
| Popovers | Not started | TBD (2b) | `.gp-ds .popover` | ☐ | ☐ | |
| Tooltips | Not started | TBD (2c) | `.gp-ds .tooltip` | ☐ | ☐ | |
| Carousel | Not started | TBD (2c) | `.gp-ds .carousel` | ☐ | ☐ | |
| Admin sidebar nav | Not started | TBD | new pattern | ☐ | N/A | LMS-specific, no source equivalent |
| Empty/loading states | Not started | TBD | new pattern | ☐ | N/A | LMS-specific |
| File upload UI | Not started | TBD | new pattern | ☐ | N/A | Dropzone-based |
| Admin Bootstrap unification | Not started | Phase 4 | N/A | N/A | N/A | Behavior-affecting, own risk tier |

---

## 13. Final Success Criteria

- Every page in the system — frontend, admin, instructor, lessons, mobile, payment-global, install, email, homepage-builder sections — is either migrated to the hard-rule design system, or explicitly deferred with a stated reason (never silently skipped).
- The 10 broken routes are either fixed (with content justified by what the controller already prepares) or explicitly resolved as intentionally removed, with your sign-off either way — never left ambiguous.
- The admin panel runs on a single, consistent Bootstrap version — the dual-version conflict is fully resolved, with every interactive component retested and confirmed working identically to before.
- Every component in §12 has its shared-partial status resolved (extracted, or explicitly justified why not) — the "184 hand-duplicated cards" problem does not still exist at the end of this plan.
- Zero change to application logic, routing, permissions, or JS business behavior anywhere (verified per-phase).
- Every migrated page renders correctly in Light, System, and Dark.
- Every phase has a completed before/after record (§10) and is individually revertible.

---

## 14. Later to-do — new work uses official pieces

**Status:** Later. Not in force yet. Do not start until the reusable-components plan’s Phases R1–R7 are done, or you explicitly pull it forward.

**What it is:** After the official helpers exist and the safe converts are finished, **new** view markup for buttons, badges, alerts, page titles, simple cards, and static tables must call `gp_ds_*`. Existing pages are not rewritten just to comply.

**What it is not:** A repo-wide conversion of historic buttons, fields, DataTables, payment SDK markup, or plugin widgets.

**R8 (12 Sep 2026):** Comment is in place on the helper. Historic pages were not rewritten.

**Owner document:** [`DESIGN_SYSTEM_REUSABLE_COMPONENTS_PLAN.md`](./DESIGN_SYSTEM_REUSABLE_COMPONENTS_PLAN.md) Phase R8.
