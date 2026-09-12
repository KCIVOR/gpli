# UI Architecture & Design System Audit — Academy LMS

**Codebase root:** `C:\xampp\htdocs\academy`
**Audit date:** 2026-09-12
**Scope:** How the current UI is structured, routed, styled, and reused — as evidenced by the actual code. This document does not propose changes, redesigns, or fixes.

## Method & Evidence Rules

Every claim below is tagged:

- **VERIFIED** — directly confirmed by reading the code (file:line cited).
- **PARTIALLY VERIFIED** — mechanism confirmed in code, but full runtime behavior (e.g. a live database value) could not be confirmed from static files alone.
- **UNKNOWN** — insufficient evidence in the codebase; not guessed.
- **INFERRED** — a reasonable but unconfirmed interpretation, explicitly flagged as such.

No claim in this document is based on "typical framework conventions," visual similarity, or assumption. Where evidence was insufficient, the section says so plainly rather than filling the gap.

A repo-local planning document, `DESIGN_SYSTEM_MIGRATION_PLAN.md`, references a prior audit (`UI_ARCHITECTURE_AUDIT.md`) as its prerequisite source of truth. **That referenced file does not exist anywhere in this repository or its git history** (VERIFIED — `git log --all` for that filename returns only this audit's own future commit; no prior version exists). This document was produced independently, re-deriving every number from the code rather than trusting that plan's claims — and several discrepancies against that plan are noted explicitly in §7.

---

## 1. Framework & Stack Baseline

- **VERIFIED** — CodeIgniter 3 (PHP), per `composer.json` (`"name": "codeigniter/framework"`, `"php": ">=5.3.7"`) and the presence of `system/core`, `application/config`, `application/controllers` in the classic CI3 layout.
- **VERIFIED** — No JS build tooling exists: no `package.json` found at the project root or depth-2 scan; no `webpack.config.js`, `vite.config.js`, or `rollup.config.js` found anywhere in the repo.
- **VERIFIED** — Tailwind is not used anywhere: `grep -ril "tailwind"` (case-insensitive) across the entire repository returned zero hits.
- **VERIFIED** — No modern JS framework (React/Vue/Angular/Alpine/htmx) is used. Grep hits for these names are false positives: the literal string `"React-Js"` as a course-tag label (`application/views/components/main/software_section_university2.php:30`), the English word "reactivate" (`application/views/frontend/default-new/account_disable.php:12`), and Zoom's third-party Web SDK bundling its own internal React (`application/views/mobile/live_class.php:7,55-56,64-65`) — not app-authored usage. Zero `type="module"` script tags found anywhere in `application/views`.
- **Conclusion (VERIFIED):** This is a server-rendered PHP application using jQuery + Bootstrap-plugin architecture with vendored, hand-copied `<script>`/`<link>` tags — not a componentized front-end stack.

---

## 2. Routing & Page Dispatch Architecture

### 2.1 The dispatch mechanism (structural, not per-page files)

**VERIFIED** — Frontend, Admin, and User areas do not load a distinct view file per route. Each area loads one shared shell view carrying a `page_name` variable; the shell does a runtime `include`:

- **Frontend shell** — `application/views/frontend/default-new/index.php:85-89`:
  ```php
  if ($page_name === null) { include $path; } else { include $page_name . '.php'; }
  ```
  Invoked from controllers via `$this->load->view('frontend/' . get_frontend_settings('theme') . '/index', $page_data)` — 60+ call sites in `Home.php` alone, plus `Blog.php`, `Login.php`, `Sign_up.php`, `Page.php`.
  `get_frontend_settings('theme')` reads a DB-backed setting (`application/helpers/common_helper.php:351-366`, `frontend_settings` table). **INFERRED** (not DB-queried directly): the live value resolves to `default-new`, since that is the only theme directory that physically exists under `application/views/frontend/`.

- **Admin/User shell** — `application/views/backend/index.php:29`:
  ```php
  include $logged_in_user_role.'/'.$page_name.'.php';
  ```
  where `$logged_in_user_role = strtolower($this->session->userdata('role'))` (`backend/index.php:6`). Invoked via `$this->load->view('backend/index', $page_data)` from `Admin.php` (~76 call sites) and `User.php` (~14 call sites).

- **VERIFIED, notable architectural fact (not a fix, just an observation in scope for a UI/routing audit):** `application/controllers/Modal.php:32` builds an include path directly from session role + a `page_name` request parameter with no visible whitelist, and `application/controllers/View.php:20-24` (`load($path)`) passes a caller-supplied path (only `.`→`/` translated) straight into `$this->load->view()`. These are structural characteristics of the current routing/include mechanism, cited here because they materially affect how "a page" is defined in this app (there is no fixed enumerable list of view files reachable only via named routes).

### 2.2 Verified page inventory (re-derived independently, not taken from any prior document)

Distinct `page_name` literals assigned per controller, confirmed against on-disk files:

| Area | Distinct page_names found | Working (file exists) | Broken (file missing) |
|---|---|---|---|
| Frontend (`Home.php`, `Blog.php`, `Login.php`, `Sign_up.php`, `Page.php`) | ≈45 | 38 | **7** |
| Admin (`Admin.php`) | ≈76 | 75 | **1** |
| User/Instructor (`User.php`) | 14 | 13 | **1** |

**Total independently verified broken routes: 10** (page_name is assigned in a controller method, but no corresponding `.php` file exists in the target view directory).

#### Broken routes — Frontend (`frontend/default-new/<name>.php` missing)

| page_name | Set at | Missing file |
|---|---|---|
| `my_notifications` | `Home.php:392` | `frontend/default-new/my_notifications.php` |
| `update_user_photo` | `Home.php:445` | `frontend/default-new/update_user_photo.php` |
| `cookie_policy` | `Home.php:1110` | `frontend/default-new/cookie_policy.php` |
| `instructor_dashboard` | `Home.php:1128` | `frontend/default-new/instructor_dashboard.php` |
| `create_course` | `Home.php:1140` | `frontend/default-new/create_course.php` |
| `manage_course_details` | `Home.php:1156` | `frontend/default-new/manage_course_details.php` |
| `lesson_edit` | `Home.php:1241` | `frontend/default-new/lesson_edit.php` (exists only under `backend/admin/` and `backend/user/`) |

#### Broken routes — Admin / User

| page_name | Set at | Missing file |
|---|---|---|
| `lessons` | `Admin.php:1308` | `backend/admin/lessons.php` |
| `lessons` | `User.php:460` | `backend/user/lessons.php` |
| `open_ai_settings` | `Admin.php:2372` | `backend/admin/open_ai_settings.php` |

**Discrepancy flag (VERIFIED against the repo's own planning document):** `DESIGN_SYSTEM_MIGRATION_PLAN.md` (§1.1) lists only 6 broken routes and its page-count table (§1) claims 22 frontend / 72 Admin / 13 User pages. Independent re-derivation here finds **10** broken routes (that document's 6 plus `my_notifications`, `update_user_photo`, and both `lessons` entries it never discloses) and materially different totals (~45 frontend page_names vs. its claimed 22; ~76 Admin vs. 72). **This document's own historical claims should not be relied on without re-verification** — which is consistent with why this audit was commissioned independently.

### 2.3 Shared shell / layout files (loaded on every page routed through that shell)

**VERIFIED**, from direct reading of the shell files:

- **Frontend infra** (from `frontend/default-new/index.php`): `seo.php` (:20), `includes_top.php` (:27), `go_back_to_mobile_app.php` (:49, conditional), `header.php` (:56, conditional), `eu-cookie.php` (:82, conditional), `includes_bottom.php`, `footer.php`/`footer2.php` (conditional). Additionally, four builder-generated partials (`components/builder/{id}-topbar.php`, `-header.php`, `-footer.php`, `-footer2.php`) are `include`d when the active home page is a builder page — these are runtime-generated by the admin "home page builder" and currently **zero files exist** in `application/views/components/builder/` (VERIFIED empty directory).
- **Backend infra** (from `backend/index.php`): `metas.php` (:13), `includes_top.php` (:15), `header.php` (:19), `<role>/navigation.php` (:24, e.g. `backend/admin/navigation.php` or `backend/user/navigation.php`), `includes_bottom.php` (:37), `modal.php` (:38), `common_scripts.php` (:39).

### 2.4 Directory inventory (verified by direct listing, not assumed naming)

| Directory (actual, on-disk) | `.php` file count |
|---|---|
| `application/views/frontend/default-new/` | 103 |
| `application/views/backend/admin/` (incl. `home_page_builder/` subdir, 9 files) | 165 |
| `application/views/backend/user/` | 73 |
| `application/views/backend/` (top-level shared infra) | 10 |
| `application/views/lessons/` | 12 |
| `application/views/mobile/` (+ `razorpay/`, `stripe/` subdirs) | 13 |
| `application/views/payment-global/` (+ 15 one-file gateway subdirs) | 20 |
| `application/views/install/` (+ `main/`) | 11 |
| `application/views/email/` | 2 |
| `application/views/components/main/` | 105 |
| `application/views/components/builder/` | 0 (generated at runtime, currently empty) |
| `application/views/certificate/` | 1 |

---

## 3. Component Reuse — Cards, Badges, Tables, Modals, etc.

**VERIFIED verdict: no shared/reusable UI-atom components exist.** Bootstrap class markup (`card`, `card-body`, `badge`, `badge-success`, table markup, modal markup, etc.) is hand-duplicated per view file by convention only — there is no PHP partial, include, or helper function for any of: card, badge, table, alert, modal, dropdown, tab, accordion, collapse, pagination, or breadcrumb.

Evidence:
- `find application/views -iname "*partial*" -o -iname "*component*"` → only `application/views/components/`, which is not a UI-atom system (see below).
- `grep -rn "function.*card\|function.*badge" application/helpers/` → no matches.
- No `$this->load->view('partials/...')` or `$this->load->view('components/card', ...)`-style call found anywhere in `Admin.php` or across the views tree.
- Sampled card markup: `backend/admin/dashboard.php:8-16` and `backend/user/dashboard.php:14-22` use line-for-line identical `row > col-xl-12 > card > card-body > h4.page-title` HTML, independently typed in each file (not shared via include). `backend/admin/courses.php:1-9,14-20` and `backend/admin/instructors.php:1-16` repeat the same skeleton with their own retyped variations.
- Sampled badge markup: `backend/admin/course_edit.php:649`, `backend/admin/blog.php:56,58`, `backend/user/courses.php:181-212` (5 separate hand-typed badge variants in one file), and `frontend/default-new/home_marketplace.php:217,219` (using Bootstrap 5 utility class `bg-light`, vs. the backend's Bootstrap 4-style `badge-success`/`badge-secondary` — a second confirmation of the version split documented in §4). Status-badge if/else logic is independently reimplemented per file rather than centralized.

**The one genuine reuse mechanism that does exist** covers full homepage-builder *sections*, not UI atoms:
- `application/views/components/main/` holds ~105 full section templates (e.g. `hero_section_1.php`, `top_courses_1.php`, `faq_section_1.php`).
- `Admin.php:4089` reads from `views/components/main/<file_name>.php`; `Admin.php:4275` writes a copy to `views/components/builder/<id>-<file_name>.php`; `frontend/default-new/home_builder.php:3` includes the generated copy at render time.
- This is a real, verified copy-on-select mechanism for admin-configurable homepage sections — architecturally unrelated to, and not a substitute for, a shared Bootstrap-atom component system.

---

## 4. CSS / Styling Architecture

### 4.1 What is actually loaded, per tree (verified from full reads of each `includes_top.php`)

- **Frontend** (`frontend/default-new/includes_top.php`, 32 lines): `all.min.css`, `bootstrap.min.css`/`bootstrap.rtl.min.css`, `jquery.webui-popover.min.css` (loaded twice — lines 10 and 12), `h-2-carousel.css`, `nice-select.css`, `owl.carousel.min.css` + theme, `slick.css` + theme, `style.css`, `new-style.css`, `responsive.css`, `summernote-lite.min.css`, `tagify.css`, `toastr.css`, `animate.min.css`, `custom.css`, and `rtl.css` when RTL.
- **Backend** (`backend/includes_top.php`, 25 lines): jvectormap CSS, DataTables-Bootstrap4 CSS set, `summernote-bs4.css`, `fullcalendar.min.css`, then — at line 10 — **`assets/frontend/default-new/css/bootstrap.min.css`** (the backend pulls its Bootstrap file from the frontend asset folder, not a backend-specific one), `dropzone.css`, `assets/backend/css/app.min.css`, `icons.min.css`, `main.css`, FontAwesome sets, and a CDN-hosted `bootstrap-tagsinput.css`.
- **Lessons, mobile, payment-global trees** each have their own `includes_top.php` but all cross-reference `assets/frontend/default-new/css/` for shared assets (FontAwesome, Summernote, Bootstrap) rather than maintaining isolated asset sets.
- **Conclusion (VERIFIED):** no tree has a fully isolated CSS pipeline; backend, lessons, mobile, and payment-global all reach into the frontend's asset directory for shared vendor files.

### 4.2 Two different Bootstrap major versions are simultaneously loaded

- **VERIFIED** (header-comment confirmed): `assets/frontend/default-new/css/bootstrap.min.css` and `bootstrap.rtl.min.css` are **Bootstrap 5.3.1**.
- **VERIFIED**: `assets/backend/css/app.min.css` (an Adminto-style admin template bundle) is built on **Bootstrap 4.3.1**, with its own `:root` palette (`--blue:#2c8ef8; --indigo:#727cf5; ...`).
- Because backend's `includes_top.php:10` *also* loads the frontend's Bootstrap 5.3.1 file, **backend pages load both Bootstrap 4.3.1 and 5.3.1 CSS simultaneously** — a verified fact, not an inference. The same split shows up in markup: backend badges use Bootstrap-4-style classes (`badge-success`) while frontend uses Bootstrap-5-style utilities (`bg-light`).
- JS mirrors this: backend jQuery is **3.3.1** (`assets/backend/js/jquery-3.3.1.min.js`), frontend jQuery is **3.6.1** (`assets/global/js/jquery-3.6.1.min.js`); both trees load the same Bootstrap JS bundle, **5.3.1**, even though backend's DataTables plugins are explicitly the "bootstrap4" variants (`dataTables.bootstrap4.js`, `responsive.bootstrap4.min.js`) — a naming/version mismatch confirmed by file paths.

### 4.3 Design tokens: a partial, inconsistently-honored system exists — but only on the frontend

- **VERIFIED**: `assets/frontend/default-new/css/style.css:16-51` defines a real `:root` block with named custom properties (`--primary-color`, `--primary-color-2`, `--secondery-color`, `--bg-white` through `--bg-white-7`, `--color-1` through `--color-17`, `--hover-color`, `--border-color`, `--box-shadow`, etc.), plus a second page-scoped override block under `.home_1st{...}` from line 54 that redeclares many of the same names.
- **VERIFIED — not consistently honored:** `--color-4: #754FFE` is declared once in `style.css:31`, but the literal hex `#754FFE` (case-insensitive) also appears hardcoded, not via `var()`, **95 more times in `style.css` itself**, plus 45 times in `all.style.min.css`, 38 in `style.min.css`, 10 in `custom.css`, 8 in `responsive.css`, 7 in `responsive.min.css`, 9 in `assets/playing-page/css/style.css`, and 6 in `assets/global/plyr/plyr.css`.
- **VERIFIED**: `new-style.css` and `custom.css` contain **no `:root` block of their own** (grep confirmed) yet consume `var(--...)` 8 and 53 times respectively — meaning they depend on `style.css`'s load order for those variables to resolve, rather than declaring a self-contained token file.
- **VERIFIED — backend has no equivalent token system**: `main.css` and `app.min.css` (backend) define no project-authored `:root` variables; the only CSS custom properties present in the backend chain are Bootstrap 4's own template palette inside the vendor `app.min.css` file.
- **Conclusion (VERIFIED, per the audit's own rule against assuming a repeated color is a "design token"):** a real CSS-variable layer exists on the frontend only, is incompletely applied even there (partial token usage, majority hardcoded literals for the same color), and has no backend counterpart.

### 4.4 The `assets/design-system/` folder is scaffolded but empty and unused

- **VERIFIED** (via direct listing and byte-count): `assets/design-system/gp-base.css`, `gp-components-core.css`, and `scratch-test.html` are all **0 bytes**. `application/config/design_system_pages.php` is also **0 bytes**. All four share the same timestamp, consistent with having been created as empty stubs rather than populated with content.
- **VERIFIED**: a repo-wide grep for `design-system`, `gp-ds`, `gp-tokens`, `gp-base`, `gp-components` across `application/views` returns **zero matches** — no view file references any of these.
- **VERIFIED**: grep for `design_system_pages` across `application/` returns **zero matches** — nothing loads this config file.
- **Conclusion (VERIFIED): the `assets/design-system/` initiative described in `DESIGN_SYSTEM_MIGRATION_PLAN.md` exists only as empty file scaffolding. It is not wired into any live page and contains no actual CSS or token definitions at this time**, regardless of what that planning document describes as its intended content.

### 4.5 Inline styles and other CSS facts

- **VERIFIED**: 71 occurrences of `<style` tags directly inside `application/views/*.php` files (grep count). Sampled examples include per-page one-off rules (`backend/admin/admins.php:1`, `backend/admin/badges.php:1`, `backend/admin/course_add.php:548`) and, notably, `backend/admin/home_page_builder/css.php:15-17,34,157`, where one block **echoes an admin-supplied `custom_css` database value directly into a `<style>` tag** — a verified architectural fact about how custom CSS is injected, not a value judgment.
- **VERIFIED**: `@media` query counts by file — `bootstrap.min.css` (frontend): 109; `app.css` (backend): 100; `new-style.css`: 51; `responsive.css`: 17; `style.css`: 11; `custom.css`: 6; `main.css` (backend): 2. Sample breakpoints quoted directly: `@media (max-width: 1200px)`, `@media screen and (max-width: 767px)`, `@media (min-width: 992px)`.
- **VERIFIED**: a viewport meta tag is present in both main shells, with different policies — frontend (`frontend/default-new/index.php:18`) allows pinch-zoom (`maximum-scale=5.0, minimum-scale=0.86`); backend (`backend/metas.php:3`) sets `user-scalable=no`, disabling pinch-zoom.
- **Explicit limitation (per audit rule, not to be treated as a finding of "responsive" or "not responsive"):** the presence of a viewport tag and `@media` rules only proves those static declarations exist. **Whether pages actually render usably at each breakpoint cannot be determined from static code — this requires live browser/device testing, which was not performed as part of this audit.**

---

## 5. JavaScript Architecture

- **VERIFIED** — No modern framework, no bundler, no ES modules (§1). Classic vendored `<script>` tags loaded per shell, in the order listed in §4.1's counterpart JS-loading files (`includes_bottom.php` per tree).
- **VERIFIED versions:** backend jQuery 3.3.1; frontend jQuery 3.6.1; Bootstrap JS bundle 5.3.1 shared by both trees (backend's DataTables plugin files are still named/built for Bootstrap 4, a confirmed mismatch — see §4.2).
- **VERIFIED — class names are used as functional JS hooks in specific, named places, not merely for styling:**
  - `.on-hover-action` — hover-reveal toggle, `backend/admin/course_edit.php:843-849`; the same class is reused as a JS hook across 7 files total (`frontend_settings.php`, `badges.php`, `curriculum.php`, `course_add.php`, `quiz_questions.php`, `categories.php`, `course_edit.php` — confirmed by grep). Renaming this class in any one file without updating all seven would silently break hover behavior in some of them.
  - `.ajax_loader` — loading-spinner state flag toggled via `addClass`/`removeClass`, `backend/admin/course_edit.php:855,860,870,875,884,889`.
  - `.lms2-reviewSlider` and equivalent per-theme class names — gate Swiper carousel initialization in homepage theme files (e.g. `frontend/default-new/home_marketplace.php:524`); each homepage theme defines its own uniquely-named slider class, so a rename would silently disable that theme's carousel (no thrown error).
  - These are the only class-coupled-to-behavior instances found in the 5-file sample examined; two admin files checked in the same pass (`courses.php`, `coupons.php`) showed no such coupling, so this pattern should not be assumed universal across all view files — only where explicitly cited above.

---

## 6. Summary Table

| Area | Verdict | Classification |
|---|---|---|
| Framework | CodeIgniter 3, server-rendered PHP, no JS build tooling, no modern JS framework | VERIFIED |
| Page routing | Shell + `page_name` include pattern (not one file per route); role/theme resolved partly from session/DB | VERIFIED (mechanism) / PARTIALLY VERIFIED (live DB values) |
| Broken routes | 10 confirmed (`page_name` set, view file missing) | VERIFIED |
| Shared UI-atom components (card/badge/table/modal/etc.) | None exist; all hand-duplicated per file | VERIFIED |
| Homepage-builder section reuse | Real copy-on-select mechanism, but for full sections only | VERIFIED |
| CSS framework | Two Bootstrap versions loaded simultaneously (5.3.1 frontend, 4.3.1 backend, both present on backend pages) | VERIFIED |
| Design tokens | Partial CSS-variable system on frontend only (`style.css`), majority of matching colors still hardcoded; no backend equivalent | VERIFIED |
| `assets/design-system/` folder | Present but empty (0-byte files) and completely unreferenced | VERIFIED |
| Tailwind | Not used anywhere | VERIFIED |
| Responsiveness | Viewport meta + media queries present; actual rendered behavior unverified | VERIFIED (static) / UNKNOWN (dynamic) |
| JS-coupled class names | Confirmed in specific named instances; not proven universal | VERIFIED (where cited) / not generalized further |

---

## 7. Explicitly Cannot Be Determined From Available Code

- The live value of `get_frontend_settings('theme')` and any DB-driven `page_name` values (e.g. `home_pages.html_file_names`) — these depend on database rows not queried in this audit. **Cannot be determined from the available code alone.**
- Actual rendered/responsive behavior of any page at any breakpoint — static CSS/meta evidence only. **Cannot be determined from the available code; requires browser testing.**
- Whether the `assets/design-system/` scaffolding was ever populated in some other environment/backup outside this working copy. **Cannot be determined from this codebase.**
- Full extent of class-name-to-JS-behavior coupling across all 547 view files — only a targeted sample was verified (§5); a codebase-wide claim of "all class renames are safe" or "all are unsafe" would be unverified either way.
- Bootstrap versions of `assets/backend/login/bootstrap.min.css` and `assets/playing-page/css/bootstrap.min.css`/`bootstrap.rtl.min.css` were not individually checked. **UNKNOWN.**

---

*This document contains only findings, not recommendations. No code, configuration, or content in the codebase was modified in the course of producing it.*
