# Academy LMS — Design System Migration Plan

**Status:** Planning document. No production code has been changed by this document.
**Operating mode:** Surgical, incremental, reversible, evidence-driven, scoped, testable, trackable.
**Prerequisite reading:** [UI_ARCHITECTURE_AUDIT.md](./UI_ARCHITECTURE_AUDIT.md) (same directory) — the verified page/route/component inventory this plan is built on.

---

## 0. Source of Truth (do not re-derive, do not hallucinate)

**Design system source file (authoritative for all visual values):**
```
C:\Users\Rovick\Downloads\geeseprojdesignsystem (1).html
```
This exact file — not a memory of it, not a re-typed approximation — is the single visual authority for colors, typography, spacing, radius, shadows, motion, and the button/card/form/nav patterns it defines. Any AI or developer picking up this plan **must open and read that file directly** before implementing a phase that touches tokens or components. Do not proceed from a paraphrase of this plan alone.

**Codebase root (production copy):**
```
C:\Users\Rovick\Downloads\codecanyon-lS66VQha-academy-course-based-learning-management-system\Academy Learning Management System\Academy-LMS
```

**Local working copy (where implementation + testing happens):**
```
C:\xampp\htdocs\academy
```
Served at `http://localhost/academy`. This is a backed-up copy (user confirmed a separate zip backup exists) — this is the copy all phases below operate on.

**Prior audit (verified inventory this plan relies on):**
```
Academy-LMS\UI_ARCHITECTURE_AUDIT.md
```

---

## 1. Verified Scope (from the audit — do not re-guess these numbers)

| Category | Count | Source |
|---|---|---|
| Frontend routed pages (existing view file confirmed) | 22 | `Home.php`/`Blog.php`/`Login.php`/`Sign_up.php`/`Page.php` → `frontend/default-new/*.php` |
| Backend Admin routed pages | 72 | `Admin.php` → `backend/admin/*.php` |
| Backend Instructor/User routed pages | 13 | `User.php` → `backend/user/*.php` |
| Lesson/course-player page (own template tree) | 1 (11 files) | `Home.php` → `views/lessons/index` |
| Mobile webview pages | 3 (13 files) | `payment_gateway`, `quiz_view`, `live_class` → `views/mobile/index` |
| **Total verified real pages** | **111** | |
| Shared layout/shell files | 25 | 15 frontend infra + 10 backend infra |

**Excluded from this migration's scope entirely (do not touch, do not "fix" incidentally):**
- `application/views/payment-global/` (20 files — gateway callback templates, functional not design-system UI)
- `application/views/install/` (11 files — one-time installer, not seen by end users)
- `application/views/email/` (2 files — separate concern, email HTML)
- `application/views/components/main/` (105 files — page-builder partials; only in scope if/when the home-page builder feature is explicitly added to a phase)
- `update/` folder — unanalyzed duplicate/patch copies, live status unconfirmed (flagged UNKNOWN in the audit)

### 1.1 Broken routes — explicitly out of scope

The audit traced these to controller code that sets a `page_name` with **no corresponding view file on disk**. They are **not** to be built, fixed, or touched as part of this design-system migration, per instruction. Any future decision to repair them is a separate, explicitly authorized task.

```
Frontend (Home.php → frontend/default-new/index.php, file missing):
  - cookie_policy
  - create_course
  - instructor_dashboard
  - manage_course_details
  - lesson_edit

Admin (Admin.php → backend/index.php, file missing):
  - open_ai_settings
```

### 1.2 Verified component footprint (file-count, from audit)

Used to prioritize Phase 2 component work — order below is by actual usage, not assumption:

| Component | Files | Priority |
|---|---|---|
| Cards | 184 | Phase 1 |
| Badges | 94 | Phase 2a |
| Tables | 50 | Phase 2a |
| Alerts | 36 | Phase 2a |
| Collapse | 35 | Phase 2a |
| Accordions | 29 | Phase 2a |
| Dropdowns | 27 | Phase 2a |
| Popovers | 22 | Phase 2b |
| Tabs/tab-pane | 22 | Phase 2b |
| Progress | 10 | Phase 2b |
| Breadcrumbs | 9 | Phase 2b |
| Nav-tabs | 8 | Phase 2b |
| List-group | 7 | Phase 2b |
| Pagination | 6 | Phase 2b |
| Btn-group | 6 | Phase 2b |
| Offcanvas | 5 | Phase 2b |
| Modals | 4 | Phase 2b |
| Carousel | 2 | Phase 2c (as needed) |
| Tooltips | 1 | Phase 2c (as needed) |

These counts are file-presence counts (how many files contain the class), **not proof every instance behaves identically or needs the same treatment.** Before styling a component in a phase, the representative pages in that phase's scope are inspected individually — this table only sets sequencing, not final scope.

---

## 2. Absolute Constraints (apply to every phase, no exceptions)

**UI-only.** Never modify: database queries/schema, models, controllers' business logic, authentication, authorization, permissions, payment logic, enrollment logic, course/lesson/quiz logic, scoring, AJAX endpoint behavior, API response formats, form processing, validation rules, sessions, cookies, routing, URLs, request parameters, JS business logic/event behavior, or third-party integration logic.

**If a visual change appears to require a logic change: STOP.** Report the dependency in the phase output before making any change. Do not resolve it unilaterally.

**Never touch, in service of this migration:**
- Global/mass find-and-replace across the repo
- Blanket Bootstrap class redefinition (`.btn`, `.card`, `.table` unscoped)
- Repo-wide renaming, directory reorganization, "cleanup" of unrelated CSS
- Rewriting working JS or PHP that isn't the specific visual surface being migrated
- Removing anything (dependency, "unused" code, file) without proof of non-use and explicit authorization

This is a migration, not a refactor. Every file changed in a phase must have a stated reason tied to that phase's scope.

---

## 3. Isolation & Activation Mechanism

### 3.1 Namespace

All new design-system CSS lives under an explicit scope class, never bare Bootstrap selectors:

```css
.gp-ds .btn { }
.gp-ds .card { }
.gp-ds table.table { }
.gp-ds .modal { }
```

This means the new stylesheet(s) are **inert** on every page until that page carries the `gp-ds` class. Loading the stylesheet everywhere (cheap, no visual effect anywhere yet) is safe and happens in Phase 0; **applying** the class per page is a separate, deliberate, per-page act.

### 3.2 Activation whitelist

A new config file (added in Phase 0, empty at first) holds the explicit list of migrated pages:

```
application/config/design_system_pages.php
```
```php
<?php
defined('BASEPATH') or exit('No direct script access allowed');

// Explicit whitelist. A page_name must be listed here to receive
// the .gp-ds class. Adding an entry = migrating that page.
// Removing an entry = instant rollback for that page only.
$config['gp_ds_frontend_pages'] = [
    // e.g. 'about_us', 'login',
];
$config['gp_ds_admin_pages'] = [
    // e.g. 'dashboard',
];
$config['gp_ds_user_pages'] = [
    // e.g. 'dashboard',
];
```

**⚠ Verified correction (2026-09-12):** `application/config/autoload.php` has `$autoload['config'] = array();` (empty) and none of `Admin.php`/`Home.php`/`User.php` extend a shared base controller (no `MY_Controller`, no `application/core/` directory — confirmed by direct file check). This means a new config file is **never automatically loaded** by CodeIgniter — `$this->config->item(...)` would silently return `NULL` on every page, and the whole whitelist mechanism would be dead on arrival with no visible error. The fix below loads the config file explicitly, once, inside each `header.php` itself (CI's `Config::load()` is safe to call repeatedly and is a no-op if already loaded).

In each shell (`frontend/default-new/header.php`, `backend/header.php`), immediately before the `<body>` tag:

```php
<?php
$this->config->load('design_system_pages');
$gp_ds_whitelist = $this->config->item('gp_ds_frontend_pages'); // or gp_ds_admin_pages / gp_ds_user_pages depending on the shell
$gp_ds_active = is_array($gp_ds_whitelist) && in_array($page_name, $gp_ds_whitelist);
?>
<body class="<?= $gp_ds_active ? 'gp-ds' : '' ?>">
```

**No page ever receives `gp-ds` merely because it contains a styleable component.** It receives the class only when its `page_name` is explicitly added to the whitelist after that page's phase work is validated. Rollback for a single page = remove one array entry, redeploy the config file. No CSS is touched to roll back a page.

### 3.3 Shared shells — high-risk file handling

`header.php` (both trees) is the only shared file this mechanism requires touching, and only to add the conditional class expression above — no other change to those files in Phase 0. Before that edit:
1. Confirm every page in that tree passes through this one `header.php` (already verified in the audit — yes, both trees have exactly one shared header).
2. Confirm the conditional defaults to `''` (no class) when the whitelist is empty or the page isn't listed — i.e., Phase 0's shell edit, by itself, changes nothing visually anywhere, since the whitelist starts empty.
3. This is the **only** shared-shell edit in Phase 0. Any later shared-shell visual change (e.g., migrating the header's own appearance) is its own phase, scoped and validated separately, per Section 7 of the operating rules.

---

## 4. Design Token Layer (Phase 0 deliverable)

New file:
```
assets/design-system/gp-tokens.css
```

Values below are copied verbatim from the source file (`Downloads\geeseprojdesignsystem (1).html`, lines 5–19, 331–342, 152–156), re-namespaced with a `--gp-` prefix per the required token-layer convention, scoped under `.gp-ds`. **No value here is invented** — where the LMS needs a token the source file doesn't define, it is proposed and flagged explicitly in that phase's output rather than added silently.

```css
.gp-ds{
  /* Brand */
  --gp-color-primary:#003BA6;
  --gp-color-primary-2:#4772BF;
  --gp-color-primary-3:#809DD2;
  --gp-color-secondary:#CD182A;
  --gp-color-secondary-hover:#90111D;
  --gp-color-accent:#00215D;
  --gp-color-accent-2:#001946;
  --gp-color-gold:#FCD01C;
  --gp-color-gold-light:#D6E0F1;
  --gp-color-gold-deep:#00328B;
  --gp-color-blue-solid:#00328B;

  /* Neutrals / surfaces */
  --gp-color-paper:#F5F5F2;
  --gp-color-ink:#0d0d0c;
  --gp-color-text:#6B6B6B;
  --gp-color-line:#E7E5DF;
  --gp-color-bg:#FBFAF7;
  --gp-color-surface:#ffffff;
  --gp-color-surface-sunk:#F3F1EB;
  --gp-color-border:#E4E1D8;
  --gp-color-border-strong:#CFCBBE;
  --gp-color-fg:#171613;
  --gp-color-fg-muted:#6B6B65;
  --gp-color-fg-faint:#9C988D;

  /* Type */
  --gp-font-head:'Manrope',sans-serif;
  --gp-font-body:'Inter',sans-serif;
  --gp-font-mono:'JetBrains Mono',monospace;

  /* Radius / shadow */
  --gp-radius:10px;
  --gp-shadow-card:0 1px 2px rgba(20,20,15,.04), 0 8px 24px rgba(20,20,15,.05);

  /* Spacing (4px rhythm, source lines 331-342) */
  --gp-sp-1:4px;  --gp-sp-2:8px;  --gp-sp-3:12px; --gp-sp-4:16px;
  --gp-sp-5:20px; --gp-sp-6:24px; --gp-sp-7:28px; --gp-sp-8:32px;
  --gp-sp-10:40px; --gp-sp-12:48px; --gp-sp-15:60px; --gp-sp-20:80px;

  /* Motion (source lines 355-356) */
  --gp-ease-out:cubic-bezier(.22,1,.36,1);
  --gp-ease-io:cubic-bezier(.65,0,.35,1);
  --gp-dur-fast:150ms; --gp-dur-base:260ms; --gp-dur-slow:520ms;
}

@media (prefers-color-scheme: dark){
  .gp-ds:not([data-gp-theme="light"]){
    --gp-color-bg:#111015; --gp-color-surface:#17161c; --gp-color-surface-sunk:#0c0c10;
    --gp-color-border:#2b2a32; --gp-color-border-strong:#3c3a45;
    --gp-color-fg:#EDEBE6; --gp-color-fg-muted:#A7A4B0; --gp-color-fg-faint:#726f7c;
    --gp-color-paper:#1b1a20; --gp-color-line:#2b2a32;
    --gp-shadow-card:0 1px 2px rgba(0,0,0,.3), 0 8px 24px rgba(0,0,0,.35);
  }
}
.gp-ds[data-gp-theme="dark"]{
  --gp-color-bg:#111015; --gp-color-surface:#17161c; --gp-color-surface-sunk:#0c0c10;
  --gp-color-border:#2b2a32; --gp-color-border-strong:#3c3a45;
  --gp-color-fg:#EDEBE6; --gp-color-fg-muted:#A7A4B0; --gp-color-fg-faint:#726f7c;
  --gp-color-paper:#1b1a20; --gp-color-line:#2b2a32;
  --gp-shadow-card:0 1px 2px rgba(0,0,0,.3), 0 8px 24px rgba(0,0,0,.35);
}
```

**Note on `data-gp-theme`:** the source file's dark-mode toggle used `data-theme` on `<html>`. Renamed to `data-gp-theme` and scoped to `.gp-ds` here so it can never collide with any existing `data-theme` attribute or logic already in the LMS (none was found in the audit, but this keeps the namespace airtight regardless).

**Dark mode is IN SCOPE (added 2026-09-12, user-requested).** A Light / System / Dark toggle is a Phase 0 deliverable — see §7 Phase 0 scope below. It is **client-side only, per browser/device** via `localStorage` (key `academy-gp-theme`), mirroring the source file's own toggle script. It is explicitly **not** account-synced across a logged-in user's devices — doing so would require a new DB column + save endpoint, which is a backend/logic change outside the UI-only constraint (§2) and is not authorized here. If account-level sync is wanted later, it must be proposed and approved as its own explicit exception.

**Consequence for every later phase:** every component built from Phase 1 onward must define both its light values (already the default via `--gp-color-*`) **and** verify it reads correctly under `.gp-ds[data-gp-theme="dark"]` / the `prefers-color-scheme: dark` media block — not just be left to "inherit" dark tokens untested. This is now part of the Testing Checklist (§8) and the Component Registry (§9) for every row.

**Font loading:** the two `<link>` tags for Google Fonts (Manrope, Inter, JetBrains Mono — source lines 2–3) are added once in Phase 0, in both `includes_top.php` files, unconditionally (font loading itself is visually inert until `.gp-ds` elements exist to use the fonts).

---

## 5. Component Extension Rule

For every Bootstrap-driven component the LMS uses that the source file does **not** define (tables, modals, dropdowns, tabs, badges, alerts, pagination, accordions, popovers, progress, breadcrumbs, list-groups, btn-groups, offcanvas, tooltips, sidebar/admin nav, empty/loading states, file upload UI):

1. Inspect actual existing markup for that component in the pages being migrated that phase (not assumed markup).
2. Identify its Bootstrap CSS classes and any JS/data-attribute hooks (`data-bs-toggle`, `data-target`, DataTables `id`/init options, etc.).
3. Define a `.gp-ds .{bootstrap-class}` override using only `--gp-*` tokens already defined (color, spacing, radius, shadow, type, motion) — no new arbitrary colors/spacing.
4. If the LMS needs a value with no matching token (e.g., a specific table row-height not implied by the spacing scale), propose the closest existing token first; only introduce a new token if none fits, and document it explicitly in that phase's output under "Token extensions."
5. Preserve the DOM structure, JS hooks, and behavior exactly — only `class=""` presentation changes, per Section 6 below.
6. Document the new component override in this file's Section 9 (Component Registry) as it's built, phase by phase.

---

## 6. JavaScript & PHP Safety Rules

**JS safety:** Before changing any `class=""` attribute, grep the relevant `.js` files (and inline `<script>` blocks in the same view) for that exact class string. If it's used as a JS selector/hook (`$('.some-class')`, `data-bs-toggle`, DataTables `columnDefs` targeting a class, etc.), it is **never removed or renamed** — the `.gp-ds` visual class is **added alongside it**, not substituted for it.

**PHP safety:** Migration edits touch `class=""` attributes and, where unavoidable, wrapper `<div>`s for layout. They never touch: PHP variables, loops, conditionals, `$this->load->view()` calls, form `action`/`method`, input `name` attributes, URLs, CSRF fields, permission checks (`if ($this->session->userdata(...))` etc.), or any `data-*` attribute that carries application state rather than pure styling.

**CSS safety:** No `!important` unless the specific Bootstrap specificity conflict is documented inline as a comment explaining why. No global element resets (`* {}`, bare `body {}` outside `.gp-ds`). No selector broader than `.gp-ds <specific-target>`.

---

## 7. Phase Structure

### PHASE 0 — Infrastructure
**Objective:** Stand up the token layer, namespace, activation mechanism, and stylesheet loading. Migrate zero pages.

**Scope (files):**
- New: `assets/design-system/gp-tokens.css`
- New: `assets/design-system/gp-base.css` (typography/base rules scoped under `.gp-ds`, from source lines 40–50)
- New: `assets/design-system/gp-theme-toggle.js` — Light/System/Dark toggle logic, `localStorage` key `academy-gp-theme`, sets/removes `data-gp-theme` on the nearest `.gp-ds` ancestor. Inert (does nothing, throws nothing) on any page without a `.gp-ds` element, i.e. safe to load everywhere immediately.
- New: `application/config/design_system_pages.php` (empty whitelist arrays)
- Modified: `application/views/frontend/default-new/includes_top.php` — add font `<link>` tags + `<link>`/`<script>` for the new CSS/JS files (appended after existing stylesheets, per audit §3.1 ordering)
- Modified: `application/views/backend/includes_top.php` — same font/CSS/JS links
- Modified: `application/views/frontend/default-new/header.php` — conditional `gp-ds` class on `<body>`, defaulting to empty; **only when `gp-ds` is present**, also render the toggle markup (three buttons, matching the mockup's `.theme-toggle` pattern) — so it never appears on non-migrated pages
- Modified: `application/views/backend/header.php` — same conditional + toggle markup

**Dependencies:** Both `header.php` files are shared shells (§3.3 above) — this is their one sanctioned Phase 0 edit.

**Risk:** LOW. New files are additive. Shell edits are a no-op with an empty whitelist (verified by regression check in §7's validation step below) — the toggle markup itself is also gated behind the same whitelist check, so it cannot appear anywhere until a page is migrated.

**Changes allowed:** Exactly the files listed above, exactly the edits described.
**Changes forbidden:** Any page migration, any Bootstrap override, any component styling beyond the toggle control itself.

**Validation:** Load every one of the 111 pages (or a scripted sample if manual is impractical) and confirm zero visual difference from pre-Phase-0 baseline screenshots, since the whitelist is empty and neither the class nor the toggle control is ever rendered.

**Rollback:** Remove the `<link>`/`<script>` additions and the conditional class/toggle-markup expressions from the four modified files; delete the four new files.

**Completion criteria:** New files exist and validate as syntactically correct CSS/JS/PHP; `$this->config->load('design_system_pages')` + `$this->config->item(...)` confirmed to actually return the whitelist array (not `NULL`) via a temporary `var_dump()` check in one `header.php`, removed once confirmed; zero visual regression confirmed across a baseline sample; toggle verified functional (persists across reload, defaults to System) on a throwaway test page carrying `.gp-ds` manually, before any real page is whitelisted.

**Asset reference syntax (verified against existing code):** this codebase links assets via `base_url()`/`site_url()`, never a raw `APPPATH`-relative path in a view (confirmed in both `includes_top.php` files, e.g. `base_url('assets/backend/css/app.min.css')`). New Phase 0 assets follow the same pattern:
```php
<link rel="stylesheet" href="<?= base_url('assets/design-system/gp-tokens.css'); ?>">
<link rel="stylesheet" href="<?= base_url('assets/design-system/gp-base.css'); ?>">
<script src="<?= base_url('assets/design-system/gp-theme-toggle.js'); ?>"></script>
```

---

### PHASE 1 — Core Primitives
**Objective:** Build scoped styles for the foundational elements the source file directly defines: buttons, links, typography scale, form inputs, cards, badges, alerts. Still migrate zero pages — this phase only builds the CSS, validated in isolation (e.g., a scratch HTML file, not a live LMS page).

**Scope (files):**
- New: `assets/design-system/gp-components-core.css` — `.gp-ds .btn*`, `.gp-ds .card`, `.gp-ds .badge`, `.gp-ds .alert`, `.gp-ds .form-control`, `.gp-ds .form-select`, `.gp-ds .form-check`, heading/type rules.
- Modified: the two `includes_top.php` files — one more `<link>` added.

**Dependencies:** Section 4 tokens (must exist first).

**Risk:** LOW (still inert everywhere — no page has the class yet).

**Changes forbidden:** Touching any page's markup; touching any file outside the two listed.

**Validation:** Build a local `.gp-ds`-wrapped scratch HTML page (outside the app, in the scratchpad) reproducing real button/card/badge/alert/form markup pulled from actual LMS view files, confirm visual match to the source design system, confirm no console errors.

**Rollback:** Remove the one new `<link>`; delete the new CSS file.

**Completion criteria:** Every primitive in this phase visually matches the source file's own rendering of that primitive, verified side by side.

---

### PHASE 1-PILOT — Three Representative Pages
**Objective:** Prove the whole mechanism (tokens → scoped components → whitelist activation) against real, live pages before any wider rollout.

**Pages (chosen for highest component density, to surface gaps early):**
1. **Frontend:** one page confirmed (via the audit's file inventory) to contain a form + cards + badges — to be selected by inspecting actual page contents, not assumed. Candidate: `courses_page.php` (grid layout, filters/sidebar, cards) — confirm by reading the file before locking it in.
2. **Admin:** one page confirmed to contain a table + dropdown + modal or badge — candidate: a list page such as `categories.php` or `users.php` (both are DataTables-backed per the audit's admin page inventory) — confirm by reading the file before locking it in.
3. **Instructor/User:** one page confirmed to contain a form + card — candidate: instructor `dashboard`-equivalent page under `backend/user/` — confirm by reading the file before locking it in.

**Process per page:** record baseline (screenshot + list of interactive elements: which dropdowns, modals, tabs, DataTables config exist and what they currently do), add that one `page_name` to the whitelist, apply/extend `.gp-ds` component CSS as gaps appear, retest every interactive element against baseline, test desktop/tablet/mobile.

**Risk:** MEDIUM (first real-page contact; Bootstrap specificity conflicts most likely to surface here).

**Changes allowed:** The 3 pilot pages' `class=""` attributes; whitelist additions for exactly those 3 `page_name`s; component CSS extensions needed to cover gaps found (documented in Section 9 as built).

**Changes forbidden:** Any other page's whitelist entry; any JS file edit unless a class-rename dependency is found (in which case: STOP and report per Section 2, don't silently fix).

**Validation:** Full functional + visual + responsive checklist (Section 8) run against all 3 pilot pages. Full regression check that the other 108 pages are visually unchanged (they have no whitelist entry, so this should hold by construction — verify it anyway).

**Rollback:** Remove the 3 `page_name` entries from the whitelist.

**Completion criteria:** All 3 pilot pages pass every item in Section 8. Any component gap found is resolved and documented before proceeding to Phase 2.

**⚠ STOP condition:** Do not proceed past this phase until the pilot is explicitly confirmed stable by the user.

---

### PHASE 2 — High-Footprint Components + Rollout
Subdivided by the priority table in §1.2. Each sub-phase follows the exact same required-output structure as the pilot (Section 10), targets a specific slice of the 111-page inventory, and requires its own approval gate before starting per Section 12 (medium/high-risk phases).

- **Phase 2a:** tables, badges, alerts, collapse, accordions, dropdowns (covers the 6 highest-footprint components after cards). Target pages: to be listed explicitly when this phase is opened, drawn from the verified 111-page inventory, prioritized by which pages combine the most Phase-2a components (highest validation value per page migrated).
- **Phase 2b:** popovers, tabs, progress, breadcrumbs, nav-tabs, list-group, pagination, btn-group, offcanvas, modals.
- **Phase 2c:** carousel, tooltips — built only if/when a page actually being migrated needs them (both have a footprint of ≤2 files; no need to front-load work for components that may not appear in the migrated set).

### PHASE 3 — Remaining pages
Continue page-by-page (or small-batch) migration through the rest of the 111-page inventory using the checklist mechanism in Section 11, until all are whitelisted and validated, or until the user decides to stop at a partial rollout.

### PHASE 4 (optional, separately authorized) — Shared shell visual migration
Only after enough individual pages are migrated that the shared header/footer/nav's *current* (pre-migration) appearance becomes the visual odd-one-out. This phase is **not** scheduled by default — it requires explicit go-ahead, since a shared-shell visual change is the highest-risk category of edit in this whole plan (affects every page simultaneously, migrated or not, unless the shell itself is made conditional on `.gp-ds` — which needs its own design).

---

## 8. Testing Checklist (applies to every page in every phase)

**Functional:** page loads · navigation works · links work · forms submit · validation fires as before · AJAX calls fire and return as before · modals open/close · dropdowns open/close · tabs switch · collapse expands/collapses · tables render · DataTables sorting/searching/paging work · pagination works · every existing button/action does what it did before.

**Visual:** typography matches source design system · colors match token values · spacing matches scale · borders/radius/shadows match · buttons/forms/cards/tables/alerts/nav match source patterns.

**Theme:** page checked under all three toggle states (Light / System / Dark) · no unreadable text (a light-only color left on a dark surface, or vice versa) · toggle persists choice across reload · toggle control itself is visible/usable in both themes.

**Responsive:** desktop, tablet, mobile — nav, sidebar, tables (horizontal scroll where needed), cards, forms, modals, dropdowns, overflow, typography, spacing, buttons, long text, images all checked at each breakpoint.

**Regression:** a sample of non-migrated pages (at minimum: one from each of the other two trees not being touched this phase) re-checked to confirm zero visual change.

---

## 9. Component Registry (living document — updated as each component is built)

| Component | Status | File | `.gp-ds` selector(s) | Dark verified | Notes |
|---|---|---|---|---|---|
| Tokens (incl. dark palette) | Not started | `assets/design-system/gp-tokens.css` | `.gp-ds` | N/A | |
| Theme toggle | Not started | `assets/design-system/gp-theme-toggle.js` | `.gp-ds .theme-toggle` | N/A | Light/System/Dark, per-device `localStorage`, not account-synced (§4) |
| Base typography | Not started | `assets/design-system/gp-base.css` | `.gp-ds` | ☐ | |
| Buttons | Not started | `assets/design-system/gp-components-core.css` | `.gp-ds .btn*` | ☐ | |
| Cards | Not started | same | `.gp-ds .card` | ☐ | |
| Badges | Not started | same | `.gp-ds .badge` | ☐ | |
| Alerts | Not started | same | `.gp-ds .alert` | ☐ | |
| Forms | Not started | same | `.gp-ds .form-control`, `.form-select`, `.form-check` | ☐ | |
| Tables | Not started | TBD (Phase 2a) | `.gp-ds table.table` | ☐ | |
| Dropdowns | Not started | TBD (Phase 2a) | `.gp-ds .dropdown-menu` | ☐ | |
| Accordions | Not started | TBD (Phase 2a) | `.gp-ds .accordion` | ☐ | |
| Collapse | Not started | TBD (Phase 2a) | `.gp-ds .collapse` | ☐ | |
| Modals | Not started | TBD (Phase 2b) | `.gp-ds .modal` | ☐ | |
| Tabs | Not started | TBD (Phase 2b) | `.gp-ds .nav-tabs`, `.tab-pane` | ☐ | |
| Pagination | Not started | TBD (Phase 2b) | `.gp-ds .pagination` | ☐ | |
| Breadcrumbs | Not started | TBD (Phase 2b) | `.gp-ds .breadcrumb` | ☐ | |
| List-group | Not started | TBD (Phase 2b) | `.gp-ds .list-group` | ☐ | |
| Btn-group | Not started | TBD (Phase 2b) | `.gp-ds .btn-group` | ☐ | |
| Offcanvas | Not started | TBD (Phase 2b) | `.gp-ds .offcanvas` | ☐ | |
| Progress | Not started | TBD (Phase 2b) | `.gp-ds .progress` | ☐ | |
| Popovers | Not started | TBD (Phase 2b) | `.gp-ds .popover` | ☐ | |
| Tooltips | Not started | TBD (Phase 2c, if needed) | `.gp-ds .tooltip` | ☐ | |
| Carousel | Not started | TBD (Phase 2c, if needed) | `.gp-ds .carousel` | ☐ | |
| Admin sidebar nav | Not started | TBD | `.gp-ds` scoped, new pattern (not in source file) | ☐ | LMS-specific, extend from source's `.navbar-demo` pattern |
| Empty/loading states | Not started | TBD | `.gp-ds` scoped, new pattern | ☐ | LMS-specific, no source equivalent |
| File upload UI | Not started | TBD | `.gp-ds` scoped, new pattern | ☐ | LMS-specific (Dropzone-based, per audit) |

---

## 10. Required Output Before Each Phase

```
Phase: PHASE-XX
Objective: ...
Pages: (exact page_name list, drawn from the verified 111-page inventory)
Components: (exact components touched)
Shared Dependencies: ...
Files Expected To Change: ...
Files Explicitly Protected: ...
Risks: LOW/MEDIUM/HIGH, with reasoning
Implementation Strategy: ...
Validation Plan: ...
Rollback Plan: ...
```
Medium/high-risk phases wait for explicit approval before implementation begins.

## 11. Required Output After Each Phase

```
Completed: ...
Files Changed: ...
Pages Migrated: (page_name list)
Components Added/Modified: ...
Logic Changed: NONE (or exact explanation if not none)
Functional Validation: PASS/FAIL
Visual Validation: PASS/FAIL
Regression Validation: PASS/FAIL
Known Issues: ...
Rollback: (exact whitelist entries to remove)
Next Phase: ...
```

## 12. File Change Report Template

```
FILES ADDED: ...
FILES MODIFIED: ...
FILES DELETED: (should be NONE for this migration; explain if not)
FILES NOT TOUCHED: (confirm the 6 broken routes, payment-global, install, email, components/main, update/ remain untouched)
COMPONENTS CHANGED: ...
PAGES MIGRATED: ...
PAGES NOT MIGRATED: (remaining count out of 111)
```

## 13. Migration Checklist (populated as phases proceed)

```
FRONTEND (22 pages)
[ ] (populated during Phase 1-Pilot / Phase 2/3 as pages are selected)

ADMIN (72 pages)
[ ] (populated during Phase 1-Pilot / Phase 2/3)

USER/INSTRUCTOR (13 pages)
[ ] (populated during Phase 1-Pilot / Phase 2/3)

LESSON PLAYER (1 page)
[ ] lessons/index

MOBILE (3 pages)
[ ] payment_gateway
[ ] quiz_view
[ ] live_class

EXPLICITLY EXCLUDED (never checked off, not part of this migration)
[x] cookie_policy — broken route, out of scope
[x] create_course — broken route, out of scope
[x] instructor_dashboard — broken route, out of scope
[x] manage_course_details — broken route, out of scope
[x] lesson_edit — broken route, out of scope
[x] open_ai_settings — broken route, out of scope
```

---

## 14. Stop Conditions (apply at any point, any phase)

Stop and request explicit confirmation if:
- A UI change appears to require a backend logic change.
- A component's JS behavior would need to change, not just its appearance.
- Removing/altering Bootstrap JS seems necessary.
- A shared component cannot be safely scoped under `.gp-ds` without affecting non-migrated pages.
- A page cannot be isolated from non-migrated pages using the whitelist mechanism.
- Existing behavior appears broken independent of this migration (e.g., another undiscovered broken route).
- The design system conflicts with a third-party plugin's own required markup/CSS.
- A class is discovered to be both a styling hook and a JS hook and the safe path isn't obvious.
- Correct behavior can't be determined from the code — mark **UNKNOWN**, do not guess.

---

## 15. Final Success Criteria

- Design-system visual language consistently applied to every page explicitly whitelisted.
- Extended LMS-specific components (Section 9) visually align with the source file's language — verified, not assumed.
- Zero change to application logic, routing, permissions, or JS business behavior across the entire migration (verified per-phase).
- Bootstrap-dependent interactive behavior (modals, dropdowns, tabs, DataTables, collapse, offcanvas) continues to work on every migrated page.
- Non-migrated pages remain pixel-identical to pre-migration baseline throughout (verified per-phase regression check).
- All 111 verified pages and 25 shared shells are explicitly accounted for in the checklist (Section 13) — migrated, or explicitly deferred with a reason.
- The 6 broken routes remain documented and untouched unless separately authorized.
- Every migrated page renders correctly in Light, System, and Dark — every Component Registry (§9) row has its "Dark verified" box checked before that component is considered done, not just its light-mode appearance.
- The theme toggle works identically to the mockup's: per-browser/device via `localStorage`, no account-level sync, no backend changes.
- Every phase has a completed before/after record (Sections 10–12) and is individually revertible via the whitelist.
