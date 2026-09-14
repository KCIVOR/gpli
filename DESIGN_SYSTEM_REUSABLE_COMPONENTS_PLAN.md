# Academy LMS — Reusable Components Implementation Plan (v3)

**Status:** Planning document. No production code has been changed by this document.
**Operating mode:** Surgical, incremental, reversible, evidence-driven, scoped, testable, trackable.
**Continues:** [`DESIGN_SYSTEM_IMPLEMENTATION_PLAN.md`](./DESIGN_SYSTEM_IMPLEMENTATION_PLAN.md) (v2). That plan’s Phases 0–6 already ran for tokens, CSS, shell activation, Bootstrap 5 admin work, and the previously broken routes. This plan does **not** redo that work. It extracts official reusable pieces from the same hard-rule file so pages stop hand-copying markup.
**Prerequisite reading:** [`UI_ARCHITECTURE_AUDIT.md`](./UI_ARCHITECTURE_AUDIT.md), v2 plan §§0–2 and §11, and tonight’s reusable-components audit (12 Sep 2026).
**Inventory date:** 12 Sep 2026 (evening). Every count below was re-derived from the live tree. Re-verify before acting, per §1.

---

## 0. Hard Rule — Source of Truth (non-negotiable)

```
C:\Users\Rovick\Downloads\geeseprojdesignsystem (1).html
```

This exact file — not a memory of it — is the **only** authority for colors, type, spacing, radius, shadow, motion, and every component pattern. Sections in that file, as they exist tonight:

| § | Heading in the file | Kind |
|---|---|---|
| 01 | Color | Foundation (tokens already in `gp-tokens.css`) |
| 02 | Typography | Foundation |
| 03 | Spacing & radius | Foundation |
| 04 | Motion | Foundation |
| 05 | Buttons | Component — extract helper |
| 06 | Cards & surfaces | Component — extract wrapper; navy/stat are extras |
| 07 | Form fields | Component — CSS / opt-in only, not a form builder |
| 08 | Navigation | Pattern — shared header, not a per-page helper |
| 09 | Section heads | Pattern — homepage/marketing only |
| 10 | Full token reference | Foundation |
| 11 | Status colors | Foundation (tokens already present) |
| 12 | Badges | Component — extract helper |
| 13 | Alerts | Component — extract helper |
| 14 | Tables | Component — static helper; DataTables stay CSS-only |
| 15 | Breadcrumbs & pagination | Component — CSS first; extract only if markup is uniform |
| 16 | Tabs & accordion | Component — CSS-only (JS hooks) |
| 17 | Dropdowns, tooltips & popovers | Component — CSS-only (JS hooks) |
| 18 | Modals & offcanvas | Component — CSS-only; shared `modal.php` already exists |
| 19 | Progress & loading | Component — CSS-only unless a uniform empty-state is found |
| 20 | List & button groups | Component — CSS-only |
| 21 | File upload | Component — Dropzone markup, CSS-only |
| 22 | Empty states | Component — extract only after reading real empty markup |
| 23 | Admin sidebar nav | Pattern — `navigation.php`, CSS-only this plan |
| 24 | Carousel | Component — CSS-only |

**Any phase that touches visual styling must open and re-read the matching section of that file before writing CSS.** No value is invented. If the LMS needs a value the file does not define, propose the closest token first; only add a new one with an explicit flag in that phase’s output.

**Still open (not assumed, not done here):** both reference files still live in a personal Downloads folder. Copying them into `assets/design-system/reference/` requires your decision. Phase R0 will stop and ask if the path is missing.

---

## 1. Never-Assume Rule (every phase, no exceptions)

Every number in this document was correct at inventory time. Code moves. Before a phase starts, re-verify live:

- The exact file list that phase will touch (re-grep the class/pattern; do not reuse the appendix).
- Whether a class is also a JS hook (`data-toggle`, `data-bs-toggle`, `confirm_modal`, `showAjaxModal`, DataTables `id`, Select2, Summernote, Dropzone, recaptcha).
- That the hard-rule file is still at the path in §0 and still contains that section.
- That a view file still exists before converting it.
- That `gp_ds_is_active()` and the helper still autoload (`application/config/autoload.php` already lists `'design_system'` — re-check).

If it cannot be determined from the code: write **cannot be determined — flagged for user decision.** Never guess.

---

## 2. Absolute Constraints (every phase, no exceptions)

**UI-only.** Never modify: database queries/schema, models, controller business logic, auth, permissions, payment, enrollment, course/lesson/quiz/scoring logic, AJAX behavior, API shapes, form processing, validation, sessions, cookies, routing, URLs, request parameters, JS business behavior, or third-party SDK logic.

**If a visual change appears to require a logic change: STOP.** Report it. Do not resolve it unilaterally.

**Never, in service of this plan:**

- Repo-wide find-and-replace.
- Unscoped Bootstrap redefinition (`.btn`, `.card`, `.table` outside `.gp-ds`).
- Renaming files, “cleanup,” or deleting unused code without proof **and** your authorization.
- Mass-converting buttons, fields, DataTables, dropdowns, or marketing homepage tiles into helpers.
- Changing a class that JS reads, unless the new class is **added alongside**.
- Rewriting `gp_ds_table` so DataTables must go through it.
- Building a form builder.
- Enforcing “new pages must use official pieces” before Phase R8 (that is the later to-do).

Every file changed in a phase must have a stated reason tied to that phase’s scope. This is an extraction, not a rewrite.

---

## 3. What Is Already True (re-verified 12 Sep 2026, not assumed from v2)

| Fact | Evidence |
|---|---|
| Tokens exist | `assets/design-system/gp-tokens.css` |
| Core CSS exists | `assets/design-system/gp-components-core.css` plus per-component CSS files |
| Theme toggle exists | `assets/design-system/gp-theme-toggle.js` |
| Shared shells apply `.gp-ds` unless excluded | `gp_ds_is_active()`; `$config['gp_ds_exclude_pages']` is empty |
| Helper is autoloaded | `application/config/autoload.php` line 92 includes `'design_system'` |
| Three partials exist | `card.php`, `table.php`, `page_title_card.php` |
| Those partials are barely used | `gp_ds_page_title` 9 files; `gp_ds_card` 6; `gp_ds_table` 3 |
| Button / badge / alert helpers do not exist | Grep of `application/` for `gp_ds_button`, `gp_ds_badge`, `gp_ds_alert` = 0 |
| Hard-rule button names are almost unused in LMS markup | `.btn-outline` in 4 files; `.btn-quiet` in 2. LMS uses `btn-outline-primary` (47), `btn-rounded` (51), `btn-success` (52) |

v2’s “184 duplicated cards” problem is still true: **189** unique view files contain `class="…card…"`.

---

## 4. Verified Page Inventory (re-derived tonight)

Method: distinct `page_data['page_name']` literals in controllers, then a file-exists check under the matching view tree. Home homepage variants are dynamic (`Home.php` ~46–52) and are listed separately because they are real `page_name`s when the DB setting resolves.

**Do not treat view-file counts as page counts.** Admin has 167 PHP files; only 75 of those are live `page_name`s. The rest are fragments (lesson-type editors, ajax partials, modals).

### 4.1 Frontend — live `page_name`s (Home.php, Blog.php, Login.php, Sign_up.php, Page.php)

Working views under `application/views/frontend/default-new/<name>.php` unless noted.

| page_name | Set at | View tonight |
|---|---|---|
| `shopping_cart` | Home.php:71, 1480, 1496, 1528 | exists |
| `courses_page` | Home.php:203, 1010 | exists |
| `course_page` | Home.php:253 | exists |
| `instructor_page` | Home.php:336 | exists |
| `my_courses` | Home.php:363 | exists |
| `my_messages` | Home.php:385 | exists |
| `my_notifications` | Home.php:392 | exists (built in v2 Phase 5a) |
| `my_wishlist` | Home.php:404 | exists |
| `purchase_history` | Home.php:427 | exists |
| `user_profile` | Home.php:439 | exists |
| `user_credentials` | Home.php:442 | exists |
| `update_user_photo` | Home.php:445 | exists (built in v2 Phase 5a) |
| `instructor_following` | Home.php:463 | exists |
| `about_us` | Home.php:1083 | exists |
| `terms_and_condition` | Home.php:1090 | exists |
| `refund_policy` | Home.php:1097 | exists |
| `privacy_policy` | Home.php:1104 | exists |
| `cookie_policy` | Home.php:1110 | exists (built in v2 Phase 5a) |
| `instructor_dashboard` | Home.php:1128 | exists (built in v2 Phase 5a) |
| `create_course` | Home.php:1140 | exists (built in v2 Phase 5a) |
| `manage_course_details` | Home.php:1156 | exists (built in v2 Phase 5a) |
| `lesson_edit` | Home.php:1241 | exists (built in v2 Phase 5a) |
| `login` | Home.php:1288, Login.php:30 | exists |
| `sign_up` | Home.php:1300, Login.php:42, Sign_up.php:36 | exists |
| `forgot_password` | Home.php:1312, Login.php:237 | exists |
| `invoice` | Home.php:1417 | exists |
| `compare` | Home.php:1429 | exists |
| `404` | Home.php:1443 | exists |
| `website_faq` | Home.php:1809 | exists |
| `contact_us` | Home.php:1856 | exists |
| `become_a_instructor` | Home.php:1974 | exists |
| `payout_settings` | Home.php:1998 | exists |
| `badges` | Home.php:2210 | exists |
| `community_index` | Home.php:2265 | exists |
| `community_shared_post` | Home.php:2310 | exists |
| `community_my_posts` | Home.php:2362 | exists |
| `community_saved_posts` | Home.php:2375 | exists |
| `blogs` | Blog.php:29, 90, 96 | exists |
| `blog_details` | Blog.php:112 | exists |
| `custom_page_viewer` | Page.php:40 | exists |
| `new_login_confirmation` | Login.php:105 | exists |
| `change_password_from_forgot_password` | Login.php:302 | exists |
| `verification_code` | Sign_up.php:46 | exists |

**Frontend mismatches — do not assume, do not invent a view this plan:**

| page_name | Set at | On-disk fact tonight | How this plan treats it |
|---|---|---|---|
| `lessons` | Home.php:952 | No `frontend/default-new/lessons.php`. Course player lives in `application/views/lessons/` (own shell). | Own-shell surface, §4.6. Not a default-new include. |
| `payment_gateway` | Home.php:1545 | No `frontend/default-new/payment_gateway.php`. Checkout lives in `application/views/payment-global/`. | Extended surface, §4.6. Wrapper only. |
| `live_class` | Home.php:1664 | No `live_class.php`. Closest file is `live_class_scadule.php` (different name). | **cannot be determined** which file the shell includes until that Home.php method is re-read at phase-open. Flag, do not invent. |
| homepage `$page_name` | Home.php:46–52 | Dynamic from DB (`html_file_names` or `home_builder`). | Each home_* file listed in §4.2 is in scope when that setting resolves to it. |

**Frontend view that loads without a `page_name`:**

| View | Loaded from | Treatment |
|---|---|---|
| `account_disable.php` | Home.php:2060–2083 (`load->view` of the file, no `page_name`) | In scope as a named view. Confirm at phase-open whether it uses the shared shell. |

### 4.2 Frontend homepage variants (dynamic `page_name`s)

These files exist tonight under `frontend/default-new/`. They are in scope when Home.php assigns them.

`home_builder`, `home`, `home_1`, `home_2`, `home_3`, `home_4`, `home_5`, `home_6`, `home_7`, `home_elegant`, `home_fitness`, `home_language`, `home_development`, `home_kindergarten`, `home_cooking2`, `home_university2`, `home_marketplace`

Whether `home` (no suffix) is a real file **cannot be determined from the glob of `home_*.php` alone** — re-check `frontend/default-new/home.php` at phase-open. Do not invent it.

### 4.3 Admin — live `page_name`s (Admin.php + addons/Certificate.php)

Each expects `application/views/backend/admin/<name>.php`.

`dashboard`, `categories`, `category_add`, `category_edit`, `sub_category_add`, `sub_category_edit`, `instructors`, `instructor_add`, `instructor_edit`, `users`, `user_add`, `user_edit`, `enrol_history`, `enrol_student`, `admin_revenue`, `instructor_revenue`, `invoice`, `purchase_history`, `system_settings`, `frontend_settings`, `payment_settings`, `notification_settings`, `social_login`, `instructor_settings`, `theme_settings`, `courses-server-side`, `pending_courses`, `course_add`, `course_edit`, `lessons`, `video_player`, `manage_language`, `message`, `manage_profile`, `about`, `available_addons`, `addon_add`, `addon_update`, `addons`, `application_list`, `instructor_payout`, `admins`, `admin_add`, `admin_edit`, `admin_permission`, `coupons`, `coupon_add`, `coupon_edit`, `blog_category`, `blog_add`, `blog_edit`, `blog`, `instructors_pending_blog`, `blog_settings`, `drip_content_settings`, `custom_page`, `add_custom_page`, `edit_custom_page`, `academy_cloud`, `data_center`, `open_ai_settings`, `subscribed_user`, `newsletters`, `newsletter_history`, `contact`, `wasabi_settings`, `bbb_live_class_settings`, `seo_settings`, `sitemap_settings`, `badges`, `home_page_builder`, `announcements`, `announcement_add`, `announcement_edit`, `certificate_settings`

**Count tonight:** 75 distinct admin `page_name`s.

**In the whitelist but not a live Admin.php `page_name` tonight** (do not treat as routes):

| Name | Note |
|---|---|
| `active_courses` | View exists. Courses list uses `courses-server-side`. |
| `sub_categories` | View exists. Not assigned as `page_name` in Admin.php tonight. |

**Admin fragment, not a `page_name`:** `student_academic_progress` is loaded by `Admin.php:2800–2806` via `$this->load->view('backend/admin/student_academic_progress', …)` — no `page_name`. In scope as a fragment when that phase’s grep hits it. Do not invent a page_name for it.

### 4.4 User / instructor — live `page_name`s (User.php)

Each expects `application/views/backend/user/<name>.php`.

`dashboard`, `courses-server-side`, `course_add`, `course_edit`, `payment_settings`, `sales_report`, `lessons`, `invoice`, `become_an_instructor`, `payout_report`, `blog_add`, `blog_edit`, `blog`, `pending_blog`

**Count tonight:** 14.

**In the whitelist but not a live User.php `page_name`:** `student_academic_progress` is loaded by `User.php:1014–1024` as a direct view, same as admin. Fragment, not a page.

### 4.5 Shared shells (own `<body>`)

| Shell | Path | `.gp-ds` tonight | This plan |
|---|---|---|---|
| Frontend | `application/views/frontend/default-new/index.php` | Yes, via `gp_ds_is_active()` | Do not re-wire. Convert page bodies only. |
| Admin / user | `application/views/backend/index.php` | Yes, via `gp_ds_is_active()` | Same. |
| Payment | `application/views/payment-global/index.php` | Yes | Wrapper only. Never change gateway form fields. |
| Install | `application/views/install/index.php` | Yes | Overlay only. Last among extended surfaces. |
| Lessons player | `application/views/lessons/index.php` | Yes | CSS + official atoms if a safe title/alert appears. No DataTables extract. |
| Mobile webview | `application/views/mobile/index.php` | Yes | Same as lessons. |
| Homepage builder tool | `application/views/backend/admin/home_page_builder/index.php` | Yes | Own tool UI. Do not restyle the builder chrome in an atom phase. |
| Certificate print | `application/views/certificate/index.php` | No | **Deferred on purpose.** Printable artwork. Dark would break it. State this every time; never silently skip. |
| Lesson PDF canvas | `application/views/lessons/pdf_canvas.php` | No | **Deferred on purpose.** Print/PDF. |
| Email | `application/views/email/common_template.php`, `static_common_template.php` | N/A (inlined tables) | Different medium. No `.gp-ds` stylesheet. Color translation only if a later email phase is approved. Not this plan’s atom phases. |

### 4.6 Extended surfaces (file counts tonight, `update/` excluded)

| Area | PHP files tonight | Constraint |
|---|---|---|
| `payment-global/` | 20 | Visual wrapper only. SDK fields never change. |
| `install/` | 11 | Lowest priority. Seen once per deploy. |
| `email/` | 2 | Inlined table CSS. Not a helper target. |
| `components/main/` | 105 | Homepage-builder sections. Already a reuse mechanism. **Do not** force them through `gp_ds_card`. Token/CSS only unless a later decision says otherwise. |
| `lessons/` | 12 | One player, own shell. |
| `mobile/` | 11 | Webview routes, own shell. |

### 4.7 Fragments that are not pages (in scope only when a phase’s grep hits them)

Admin 167 PHP files − 75 page_names ≈ lesson-type editors, quiz fields, ajax getters, modal bodies, shortcuts. User 74 PHP files − 14 page_names ≈ the same. Frontend 110 PHP files include headers, course-page slices, cart inners, community comments.

**Rule:** a fragment is converted only if it contains the exact component that phase is extracting (e.g. an inline `h4.page-title`, a standalone `.badge`, a standalone `.alert`). Never “migrate the fragment” as if it were a page.

---

## 5. Verified Component Footprint (unique view files, 12 Sep 2026)

Re-counted with PowerShell `Select-String -List` under `application/views`, excluding nothing except that `update/` copies were not used for the page-title list.

| Component | Unique files tonight | Hard-rule § | Official helper tonight | Safe extract? |
|---|---|---|---|---|
| Cards (`class="…card…"`) | 189 | 06 | `gp_ds_card` (6 callers) | Wrapper only. Five families — see §6. |
| Page-title `h4.page-title` leftover | 78 views + the partial itself | 06 (admin pattern) | `gp_ds_page_title` (9 callers) | **Yes. First convert.** |
| Badges | 94 | 12 | None | Yes, standalone only. Skip JS-built table cells. |
| Alerts | 36 | 13 | None | Yes, standalone only. |
| Tables (`class="…table…"`) | 53 | 14 | `gp_ds_table` (3 callers) | Static only. |
| `id="basic-datatable"` | 13 | 14 | Must not use `gp_ds_table` | CSS-only. |
| `DataTable(` init | 11 | 14 | Same | CSS-only. |
| Buttons (`class="…btn…"`) | 271 | 05 | None | Helper for **new** code starting Phase R8. No mass convert. |
| `btn-primary` | 124 | 05 | — | CSS already paints it. |
| `btn-outline-primary` | 47 | — (Hyper name) | — | CSS alias allowed. Do not rename the class. |
| `btn-outline` (hard-rule name) | 4 | 05 | — | Almost unused. |
| `btn-quiet` | 2 | 05 | — | Almost unused. |
| `form-control` | 214 | 07 | None | No extract. Opt-in `.gp-ds-form` only. |
| Select2 | 70 | plugin | — | CSS-only. |
| Summernote | 54 | plugin | — | CSS-only. |
| Dropdown menus | 27 | 17 | — | CSS-only. `data-toggle` / `confirm_modal`. |
| `data-toggle` | 126 | 17 | — | JS hook. Never strip. |
| `data-bs-toggle` | 67 | 17 | — | JS hook. Never strip. |
| `showAjaxModal` | 30 | 18 | — | Existing modal shell. |
| `confirm_modal` | 43 | 18 | — | Existing modal shell. |
| Accordion | 35 | 16 | — | CSS-only. |
| Tabs / pills | 25 | 16 | — | CSS-only. |
| Modal class | 4 | 18 | Shared `backend/modal.php`, `frontend/default-new/modal.php` | Do not re-wrap. |
| Breadcrumb | 42 | 15 | — | Re-read markup at phase-open. Extract only if uniform. |
| Pagination | 17 | 15 | — | Often DataTables-generated. CSS-only unless a static pager is found. |
| Tooltip (`data-*-toggle="tooltip"`) | 54 | 17 | — | CSS-only. |
| Progress | 10 | 19 | — | CSS-only. |
| List-group | 12 | 20 | — | CSS-only. |
| Btn-group | 8 | 20 | — | CSS-only. |
| Offcanvas | 13 | 18 | — | CSS-only. |
| Carousel | 7 | 24 | — | CSS-only. |
| `common-card` | 6 | frontend, not Hyper | — | Do not fold into `gp_ds_card` without a decision. |
| `course-item` | 16 | marketing tile | — | Out of `gp_ds_card`. Token/CSS only. |
| `widget-inline` | 7 | admin stats | — | Out of `gp_ds_card`. |

v2’s table (184 / 94 / 50 …) is **superseded** by this table for sequencing. Re-count again at each phase-open.

---

## 6. Why Cards Are Not One Component

Do not force one helper onto all 189 files.

| Family | Example tonight | Helper |
|---|---|---|
| Admin page title | `courses.php` lines 1–11: row → col → card → `h4.page-title` + `alignToTitle` button | `gp_ds_page_title` |
| Admin content wrapper | `users.php`: card → card-body → header-title + `#server_side_users_data` | `gp_ds_card` wrapper **around** the existing table. Table stays inline. |
| Admin stat widgets | `dashboard.php`, `courses.php` `widget-inline` nested cards | No helper. CSS only. |
| Frontend marketing tiles | 16 `course-item` files, `home_*`, `components/main/*` | No `gp_ds_card`. |
| Frontend account cards | `common-card` / wish-list (6) | Decision later. Not Phase R2–R4. |

`gp_ds_table` **cannot** replace DataTables. `users.php` initializes `$('#server_side_users_data').DataTable` with `serverSide`, columns, CSRF, and CSV export. The current partial has no `id`, no empty-`tbody` contract, and no action dropdowns.

---

## 7. JavaScript & PHP Safety (same as v2, restated)

**JS:** before changing any `class=""`, grep `.js` and inline `<script>` in that view for that class. Add a visual class alongside a hook class. Never substitute.

Known hook families (re-grep at phase-open; this is not a closed list): `on-hover-action`, `ajax_loader`, `confirm_modal`, `showAjaxModal`, `data-toggle`, `data-bs-toggle`, DataTables ids, Select2, Summernote, Dropzone, `g-recaptcha`.

**PHP:** touch `class=""` and, where unavoidable, a wrapper `<div>`. Never touch variables, loops, conditionals, `action`/`method`, input `name`, URLs, CSRF, session checks, or `data-*` that carry app state.

**CSS:** no `!important` unless a specific Bootstrap conflict is documented inline. No selector broader than `.gp-ds <specific-target>`.

---

## 8. Phase Structure

Each medium/high-risk phase waits for your explicit approval after that phase’s §10 brief.

Activation is already shell-level. **Rollback for a converted view = revert that view file**, not a whitelist edit. Rollback for a broken helper = remove the new function and restore callers.

---

### PHASE R0 — Freeze the source and lock the registry

**Objective:** Make the hard-rule file reachable from the repo (if you approve the copy), and write the living registry that later phases update. Convert **zero** pages.

**Files expected:**

- Create, only if you say yes: `assets/design-system/reference/geeseprojdesignsystem.html` (frozen copy of §0).
- Modify: this plan’s §12 as the working registry (or a sibling `DESIGN_SYSTEM_COMPONENT_REGISTRY.md` if you prefer the registry not live inside the plan — **ask before creating a second file**).
- Forbidden: any view markup change, any new helper.

**Validation:** open the hard-rule file; confirm sections 05–24 still match §0. Confirm `design_system` is still in `autoload.php`. Confirm the three existing partials still parse (`php -l` on each).

**Rollback:** delete the reference copy if added. Nothing else to revert.

**Risk:** LOW.

---

### PHASE R1 — Official atoms exist (helpers only)

**Objective:** Add the missing helpers that the hard-rule file already names. Still convert **zero** existing LMS pages except an optional scratch check against `assets/design-system/scratch-test.html` if that file is still present (re-check; do not recreate it unless missing).

**Create:**

- `application/views/components/design-system/button.php`
- `application/views/components/design-system/badge.php`
- `application/views/components/design-system/alert.php`

**Modify:**

- `application/helpers/design_system_helper.php` — add `gp_ds_button`, `gp_ds_badge`, `gp_ds_alert` only.

**API (do not invent extra options in this phase):**

```php
// variant: primary | secondary | outline | quiet  (hard-rule §05 only)
function gp_ds_button($label, $options = [], $return = false);

// $options keys allowed this phase: href, tag (a|button), type, extra_class, attrs (assoc array, escaped)
// Do not add onclick helpers. Callers that need confirm_modal keep writing that attribute themselves via attrs.

// tone: primary | secondary | success | warning | danger | neutral  (hard-rule §12)
function gp_ds_badge($label, $tone = 'neutral', $return = false);

// tone: success | warning | danger | info  (hard-rule §13)
function gp_ds_alert($title, $body = '', $tone = 'info', $return = false);
```

**CSS this phase (only if the live hard-rule file still says so):**

- Add aliases under `.gp-ds` so existing Hyper names **look** like the official variants without renaming classes: `.btn-outline-primary` may share the `.btn-outline` token treatment. Document the alias in §12. Do not rename any class in any view this phase.

**Forbidden:** converting any admin/frontend/user view. Enforcing helpers on new work (that is Phase R8). Touching DataTables, forms, dropdowns.

**Validation:** `php -l` on the four PHP files. Render the scratch page (or a one-off preview that is not a live route) next to the hard-rule file’s own buttons/badges/alerts. Light and Dark.

**Rollback:** delete the three new views; remove the three new functions.

**Risk:** LOW.

---

### PHASE R2 — Page titles (first real convert)

**Objective:** Every leftover admin/user `h4.page-title` card becomes `gp_ds_page_title(...)`. Same markup the partial already emits. Highest reuse, lowest behavior risk.

**Audit-time leftover list (78 views — re-grep `h4 class="page-title"` at phase-open; do not trust this list blindly):**

Admin: `about`, `academy_cloud`, `add_custom_page`, `addon_add`, `addon_update`, `addons`, `admin_add`, `admin_edit`, `admin_permission`, `admins`, `announcement_add`, `announcement_edit`, `announcements`, `application_list`, `available_addon`, `available_addons`, `badges`, `bbb_live_class_settings`, `blog`, `blog_add`, `blog_category`, `blog_edit`, `category_add`, `category_edit`, `certificate_settings`, `contact`, `coupon_add`, `coupon_edit`, `course_add`, `course_edit`, `courses`, `courses-server-side`, `custom_page`, `dashboard`, `data_center`, `drip_content_settings`, `edit_custom_page`, `enrol_student`, `frontend_settings`, `home_page_builder`, `instructor_add`, `instructor_edit`, `instructor_payout`, `instructor_revenue`, `instructor_settings`, `instructors_pending_blog`, `invoice`, `lessons`, `manage_language`, `manage_profile`, `message`, `newsletter_history`, `notification_settings`, `payment_settings`, `seo_settings`, `sitemap_settings`, `social_login`, `subscribed_user`, `system_settings`, `theme_settings`, `user_add`, `user_edit`, `wasabi_settings`.

User: `become_an_instructor`, `blog`, `blog_add`, `blog_edit`, `course_add`, `course_edit`, `courses`, `courses-server-side`, `dashboard`, `invoice`, `lessons`, `payment_settings`, `payout_report`, `pending_blog`, `sales_report`.

**Already converted tonight (do not redo unless the helper call is wrong):** `users`, `enrol_history`, `newsletters`, `instructors`, `coupons`, `purchase_history`, `admin_revenue`, `categories`, `open_ai_settings`.

**Process per file:** read the current title block → replace only that block with `gp_ds_page_title($title, $actions)` → leave the action HTML (including `btn-outline-primary`, `showAjaxModal`, `alignToTitle`) as the `$actions` string → do not restyle those buttons in this phase.

**Forbidden:** changing the action button’s classes; converting the content card below the title; touching frontend titles that are not this Hyper pattern.

**Validation:** open a sample of converted pages (at least `dashboard`, `courses-server-side`, `course_add`, `system_settings`, user `dashboard`). Title still shows. Action button still works. Light/Dark. One non-converted frontend page unchanged.

**Rollback:** revert the view files in that batch.

**Risk:** LOW. Approval still required because it touches many files.

**Batching:** convert in groups of ~15 files. Do not open all 78 in one commit-sized dump if a mid-batch title has extra markup (tabs, filters). Those extras stay in the view; only the title card is replaced. If a file’s title is not the 8-line pattern, **skip and list it**. Do not force it.

---

### PHASE R3 — Badges and alerts (standalone only)

**Objective:** Standalone `.badge` and `.alert` instances become `gp_ds_badge` / `gp_ds_alert`.

**Re-grep at phase-open.** Audit-time: 94 badge files, 36 alert files.

**Include:** a badge or alert that is a static PHP echo in the view (status text, flash notice).

**Exclude (leave CSS-painted):**

- Badges inside DataTables column renderers or JS-built HTML strings.
- Badges inside `dropdown-item` action menus if the helper would change the DOM JS expects.
- Alerts whose class is also a JS hook (re-grep before each file).

**Forbidden:** changing badge *wording* or alert *copy*. Tone must map from the existing class (`badge-success` → `success`, etc.). If a class has no hard-rule tone, stop and flag.

**Validation:** one admin list with row badges, one settings page with an alert, Light/Dark, DataTables on a **non-converted** page still render badges.

**Risk:** MEDIUM (because some badges live in action HTML). Approval required.

---

### PHASE R4 — Card wrappers (clean admin cards only)

**Objective:** Use `gp_ds_card` as a **wrapper** on admin/user pages whose markup is already `card > card-body > optional title + body`.

**Include:** a page where the card is a simple chrome around a form or a **static** table.

**Exclude:**

- `widget-inline` / nested `shadow-none` stat cards (`dashboard`, `courses`).
- Any card whose body is a DataTable — either leave the card hand-written, or wrap **only** the outer card and keep the `<table id="…">` exactly as it is. Never pass that table through `gp_ds_table`.
- Marketing `course-item`, `components/main/*`, homepage variants.
- `common-card` / wish-list until you explicitly approve a second card family.

**Forbidden:** buffering an entire DataTable + its `<script>` into `$body` “to use the helper.” That is worse than leaving it.

**Validation:** converted form pages still submit. One DataTable page that was only outer-wrapped still sorts/searches. Light/Dark.

**Risk:** MEDIUM. Approval required. Convert in small batches (5–10 pages), not 189 files.

---

### PHASE R5 — Static tables only

**Objective:** Static PHP-loop tables (no DataTables init) may use `gp_ds_table`.

**Include:** tables like the notifications page already does: headers + row arrays, no `id` JS depends on.

**Exclude:** every file with `id="basic-datatable"`, `DataTable(`, or `server_side_*`. Those stay hand-written. Mark them in §12 as **CSS-only, justified (JS id / init)**.

**Forbidden:** adding a table `id` option to `gp_ds_table` in order to “support DataTables.” That is a new abstraction and out of scope.

**Validation:** a converted static table still lists rows. A non-converted DataTable still pages/sorts/exports.

**Risk:** MEDIUM. Approval required.

---

### PHASE R6 — Remaining hard-rule components (resolve every row in §12)

**Objective:** Every component in the hard-rule file and in §12 is either extracted or explicitly justified as CSS-only. No silent skips.

Work one component at a time. For each: re-read the hard-rule section → re-grep live files → decide extract vs CSS-only using §5 → update §12.

| Component | Default decision tonight (re-confirm at phase-open) |
|---|---|
| Buttons | Helper exists (R1). No mass convert. CSS aliases for Hyper names. |
| Forms | CSS / `.gp-ds-form` opt-in. **Justified why not** as a helper. |
| Breadcrumbs | Extract only if frontend `breadcrumb.php` plus admin crumbs share one DOM. Otherwise CSS-only. |
| Pagination | CSS-only if DataTables-generated. |
| Tabs, accordion, collapse | CSS-only. |
| Dropdowns, tooltips, popovers | CSS-only. |
| Modals, offcanvas | CSS-only. Shared modal PHP already exists. |
| Progress, loading | CSS-only unless a single empty-state markup is found across ≥3 pages. |
| List-group, btn-group | CSS-only. |
| File upload | CSS-only (Dropzone). |
| Empty states | Extract **only** after reading three real empty views. If they differ, CSS-only. |
| Admin sidebar | CSS-only (`navigation.php`). |
| Section heads | Homepage/marketing only. Not an admin helper. |
| Carousel | CSS-only. |
| Navigation (§08) | Shared header. Not a per-page helper. |

**Forbidden:** inventing a helper “for completeness” when the live markup is not uniform.

**Risk:** MEDIUM per component. Approval per component, not one blanket yes.

---

### PHASE R7 — Remaining pages pass (every page listed, none silent)

**Objective:** Walk **every** page in §4.1–§4.6. For each, record one of:

- Converted (which helpers), or
- CSS-painted only (reason), or
- Deferred (reason: print, SDK, missing view, cannot be determined).

This phase does **not** mass-extract. It finishes leftovers from R2–R6 and closes gaps.

**Must visit (do not skip):**

- All frontend `page_name`s in §4.1
- All home variants in §4.2 that exist on disk
- `account_disable`
- The three mismatches (`lessons`, `payment_gateway`, `live_class`) — resolve by reading the controller method, not by guessing
- All 75 admin `page_name`s
- All 14 user `page_name`s
- Fragments only if they still contain an unconverted title/badge/alert from R2–R3
- payment-global, install, lessons shell, mobile shell, homepage-builder sections (CSS only)
- certificate + pdf_canvas (record as deferred)
- email (record as different medium)

**Forbidden:** inventing views for `live_class` / `payment_gateway` / frontend `lessons`. If the include target cannot be determined, flag it.

**Validation:** §9 checklist on a stated sample: at least one page from frontend, admin, user, lessons, mobile, payment-global, install. State the sample. Do not claim 100% manual coverage unless you actually opened every page.

**Risk:** MEDIUM.

---

### PHASE R8 — LATER: new work uses official pieces

**This is the later to-do.** It is **not** a rewrite of existing pages. It does **not** start until R1–R7 are done (or you explicitly pull it forward).

**Objective:** From the date this phase is executed, **new** view markup for buttons, badges, alerts, page titles, simple cards, and static tables must call `gp_ds_*`. Existing pages stay as they are unless a later convert phase touches them.

**What this phase actually changes (when you say go):**

1. A short comment block at the top of `application/helpers/design_system_helper.php` stating the new-work rule and pointing at this plan.
2. A one-paragraph addendum in `DESIGN_SYSTEM_IMPLEMENTATION_PLAN.md` §13 (already stubbed — see that file’s “Later to-do” note) marked done.
3. Optional, only if you ask: a checklist item in whatever process you use for new screens. **Do not create a CONTRIBUTING.md or extra process file unless you ask.**

**Forbidden in R8:**

- Grepping the repo and converting leftover historic buttons/fields “to comply.”
- Failing a page because it still has raw `<button class="btn btn-primary">`.
- Applying the rule to payment SDK markup, Dropzone, Summernote, or DataTables action HTML.

**Validation:** the helper comment exists; a newly added scratch example (not a live feature) uses `gp_ds_button`. No existing page required to change.

**Risk:** LOW. **Do not start this phase early.** It is later on purpose so we do not freeze a half-built API as policy.

---

### PHASE R9 — Registry close-out

**Objective:** §12 has no row left as “Not started.” Each row is Extracted, CSS-only (justified), or Deferred (justified). Every page in §4 has a R7 status line.

**Forbidden:** marking a row done without a file path or a written reason.

**Risk:** LOW.

---

## 9. Testing Checklist (every converting phase)

**Functional:** page loads · links work · forms submit · AJAX unchanged · modals/dropdowns/tabs/collapse unchanged · DataTables sort/search/page/export unchanged · every existing button still does what it did.

**Visual:** matches the hard-rule file’s own pattern for that component.

**Theme:** Light / System / Dark · toggle persists · no unreadable text.

**Responsive:** desktop, tablet, mobile for the pages that phase touched.

**Regression:** at least one page from each tree **not** touched that phase still looks the same.

---

## 10. Required Output Before Each Phase

```
Phase: R0–R9
Objective: ...
Pages: (re-verified list, not copied from this plan)
Components: ...
Shared Dependencies: ...
Files Expected To Change: ...
Files Explicitly Protected: DataTables ids, payment SDK forms, confirm_modal / showAjaxModal, certificate, pdf_canvas
Risks: LOW/MEDIUM/HIGH
Implementation Strategy: ...
Validation Plan: ...
Rollback Plan: ...
```

Medium/high-risk phases wait for your explicit approval.

---

## 11. Stop Conditions (any phase)

- A UI change appears to require a backend logic change.
- JS behavior would need to change, not just appearance.
- A helper cannot emit the same DOM a plugin requires (DataTables, Dropzone, Zoom, payment SDK).
- A class is both a style hook and a JS hook and the safe path is not obvious.
- The hard-rule file is missing or a section was removed.
- A leftover title/badge is not the expected pattern — skip and list, do not force.
- Correct behavior cannot be determined — mark **UNKNOWN**.

---

## 12. Component Registry (living — update as phases complete)

R9 completed 12 Sep 2026 — registry closed; every row resolved.

R0 completed 12 Sep 2026 — hard-rule frozen at `assets/design-system/reference/geeseprojdesignsystem.html`.

**R6 completed 12 Sep 2026** — remaining hard-rule rows resolved. No new PHP partials. No silent skips. Frontend breadcrumbs already reuse `application/views/frontend/default-new/breadcrumb.php` (`include 'breadcrumb.php'`); a `gp_ds_breadcrumb` helper is not needed. Empty-state DOMs differ across the three views read (cart, enrol history, manage-course empty); CSS-only.

Status values are closed as of R9. Allowed: **Extracted**, **CSS-only (justified)**, **Already shared include**, **Deferred (justified)**, or **In force for NEW markup only**. No row is Not started / TBD / Decide at R6.

| Component | Status tonight | CSS file | Helper / partial | Shared partial? | Notes |
|---|---|---|---|---|---|
| Tokens | **Extracted** | `gp-tokens.css` | N/A | N/A | Foundation from v2 / hard-rule §§01–04, 10–11. Not a PHP helper. Re-read file before any new token. |
| Theme toggle | **Extracted** | `gp-theme-toggle.js` | N/A | Already in shared shells | Official script from v2; not a per-page PHP helper. |
| Buttons | **Extracted** (R1 helper; no mass convert) | `gp-components-core.css` | `gp_ds_button` | R1 helper; no mass convert | Hard-rule §05 variants + Hyper alias `.btn-outline-primary` shares `.btn-outline` token treatment in gp-components-core.css. R6: do not invent more button helpers. |
| Cards | **Extracted** (wrapper helper; remaining families CSS-only justified) | same | `gp_ds_card` (16 callers) | Wrapper only | Helper exists. R4 converted 10 clean wrappers: admin `category_add`, `coupon_add`, `announcement_add`, `blog_add`, `coupon_edit`, `announcement_edit`, `addon_add`, `enrol_student`, `category_edit`; user `blog_add`. Remaining stay CSS-only (justified, §6): DataTables bodies, wizards, multi-card/stat widgets, marketing `course-item` / `components/main`. No second card helper. |
| Page title | **Extracted** (4 leftovers CSS-only justified) | same | `gp_ds_page_title` (83 callers) | **74 converted** | Helper exists. Skipped (not the 8-line Hyper card): `category_edit` (page-title-box); `contact` (Delete Selected widget in the same card); admin/user `lessons` (extra `#course_id` widget in the same h4). Post-R2 grep `h4 class="page-title"` = those 4 + `page_title_card.php`. Leftovers stay CSS-painted; no new helper. |
| Badges | **Extracted** (leftover 84 CSS-only justified) | same | `gp_ds_badge` (**11 files / 17 instances**) | Standalone 1:1 only | Helper exists. Converted: admin `announcements`, `admins`, `blog`, `addons`, `instructors_pending_blog`, `application_details`, `available_addons`; user `blog`, `pending_blog`, `payout_report` (pending only), `application_details`. Skipped leftover 84: unknown tone (`badge-light`/`info`/`dark`/`*-lighten`/`bg-*`, 64 files); not a simple span (`<small>`/`<div>`/`<a>`, 12 files); extra class/icon/style that helper cannot keep (8 files). DataTables cell HTML in controllers left untouched. No new helper. |
| Alerts | **Extracted** (leftover 31 CSS-only justified) | same | `gp_ds_alert` (**3 files / 4 instances**) | Standalone title-only only | Helper exists. Converted: install `step2`, `step3` (2), `step4` — title-only `<strong>` danger flash. Skipped leftover 31: `h4.alert-heading` (12, incl. newsletters / drip_content / course_edit / payment_settings); extra children/layout/icons/links/not title+p (18); JS-hooked `theme_settings.new-theme-alert` (1). Prefer-skip was correct; no lossy convert. No new helper. |
| Forms | **CSS-only (justified)** | same | None | **Justified why not** | 214 `form-control` files; Select2 70; Summernote 54. Not a form builder (hard-rule §07 / plan §2). Opt-in `.gp-ds-form` only. |
| Tables (static) | **Extracted** (leftovers CSS-only justified) | `gp-tables.css` | `gp_ds_table` (**5 files**) | Converted **2** this phase | Helper exists. Converted: admin `lessons`, user `lessons`. Already (untouched): `my_notifications`, `instructor_dashboard`, `manage_course_details`. Skipped static-but-complex: action dropdown / `confirm_modal` / JS row hooks (`enrol_history`, `course_enrol_list`, `frontend_settings` reviews, `badges`, `manage_language`, `notification_settings`); form switches (`admin_permission`); nested HTML (`dashboard`, `student_academic_progress` ×2, `purchase_history`, `shopping_cart_inner_view`, `compare`); key-value / invoice layout (`application_details` ×2, invoices ×3, install `success`). Prefer-skip was correct. No `id` option added. |
| Tables (DataTables) | CSS-only, **justified (JS id / init)** | `gp-tables.css` | None | **Justified why not** | Left alone. Re-counted: **13** `id="basic-datatable"` + **8** page files with `DataTable(` / `server_side_*` (`users`, `instructors`, `subscribed_user`, `contact`, `newsletter_history`, `application_list`, `instructor_payout`, `sales_report`) + `common_scripts.php`. Also left: `course-datatable` family (admin/user `courses`, `announcements`, `*-server-side`, `available_addons`) and legacy `id="table-1"`/`table-2` (`sub_categories`, `transaction`, `course_details`, `pending_courses`, `active_courses`). |
| Dropdowns | **CSS-only (justified)** | `gp-dropdown.css` | None | **Justified why not** | JS hooks (`data-toggle` / `data-bs-toggle`). Hard-rule §17. |
| Accordions / collapse | **CSS-only (justified)** | `gp-accordion.css`, `gp-collapse.css` | None | **Justified why not** | JS hooks. Hard-rule §16. |
| Modals | **CSS-only (justified)** | `gp-modal.css` | Existing `backend/modal.php`, `frontend/default-new/modal.php` | **Already shared include** | Shared shells + `showAjaxModal` / `confirm_modal`. Do not re-wrap. Hard-rule §18. |
| Tabs | **CSS-only (justified)** | `gp-nav-tabs.css` | None | **Justified why not** | JS tab hooks. Hard-rule §16. |
| Pagination | **CSS-only (justified)** | `gp-pagination.css` | None | **CSS-only (justified)** | Admin pagers are DataTables-generated. Frontend course/blog lists use `$this->pagination->create_links()` (CI HTML, not a static pager). Homepages also use Swiper bullets. No uniform static pager to extract. Hard-rule §15. |
| Breadcrumbs | **Already shared include** | `gp-breadcrumb.css` | None — do **not** add `gp_ds_breadcrumb` | **Already shared include** | Frontend already reuses `application/views/frontend/default-new/breadcrumb.php` via `include 'breadcrumb.php'` on many pages. That is already reuse. Admin crumbs are a different DOM (`ol.breadcrumb.bc-3` / `ul.breadcrumb`, e.g. `course_details.php`, `video_player.php`) and do not share one markup with the frontend include. CSS-only helper not needed. Hard-rule §15. |
| List-group | **CSS-only (justified)** | `gp-list-group.css` | None | **CSS-only (justified)** | Live markup is not uniform (numbered admin lists, flush hover lists, blog category actions, quiz options, marketing `brand-list-group*` / `list-group-card`). Hard-rule §20. |
| Btn-group | **CSS-only (justified)** | `gp-btn-group.css` | None | **Justified why not** | Hard-rule §20. |
| Offcanvas | **CSS-only (justified)** | `gp-offcanvas.css` | None | **Justified why not** | JS hooks. Hard-rule §18. |
| Progress | **CSS-only (justified)** | `gp-progress.css` | None | **Justified why not** | Hard-rule §19. |
| Popovers | **CSS-only (justified)** | `gp-popover.css` | None | **Justified why not** | JS hooks. Hard-rule §17. |
| Tooltips | **CSS-only (justified)** | `gp-tooltip.css` | None | **Justified why not** | JS hooks (`data-*-toggle="tooltip"`). Hard-rule §17. |
| Carousel | **CSS-only (justified)** | `gp-carousel.css` | None | **Justified why not** | Plugin/JS driven. Hard-rule §24. |
| Admin sidebar | **CSS-only (justified)** | `gp-shell.css` | None | **Already shared include** | Already `backend/admin/navigation.php` and `backend/user/navigation.php`. CSS-only this plan. Hard-rule §23. |
| Empty / loading | **CSS-only (justified)** | `gp-progress.css` (loading) | None | **CSS-only (justified)** | Three real empty views read; they differ — no helper. (1) `frontend/default-new/cart_items.php`: muted sentence in `path_pos_wish` wrappers, no icon/heading/CTA. (2) `backend/admin/enrol_history.php`: centered `file-search.svg` + `no_data_found` (same family as `announcements.php`, only 2). (3) `frontend/default-new/manage_course_details.php`: bare `<p>no_data_found</p>`. None match hard-rule §22 (`empty-state` + icon + h4 + p + CTA). Not 3+ identical DOMs. |
| File upload | **CSS-only (justified)** | Dropzone vendor CSS | None | **Justified why not** | Dropzone markup + JS. Hard-rule §21. |
| Section heads | **CSS-only (justified)** | `gp-homepage-builder.css` / frontend | None | Marketing only | Homepage/marketing pattern (hard-rule §09). Not an admin helper. |
| Navigation (§08) | **Already shared include** | `gp-shell.css` | None | **Already shared include** | Shared frontend `header.php` (`header_lg_device.php` / `header_sm_device.php`). Not a per-page helper. Hard-rule §08. |
| New-work mandate | **In force for NEW markup only (R8).** Existing pages not rewritten. | N/A | N/A | Phase R8 | **In force for NEW markup only (R8).** Existing pages not rewritten. |

---

## 13. Final Success Criteria

- Every component in §12 is Extracted, CSS-only with a written reason, or Deferred with a written reason. No silent skips.
- Every page and surface in §4 has a R7 status line. The three mismatches are resolved by reading the controller or flagged UNKNOWN — never invented.
- The 78 leftover page titles are converted or individually skipped with a reason.
- Standalone badges and alerts are converted or individually skipped with a reason.
- DataTables, payment SDK fields, Dropzone, Summernote, Select2, certificate print, and PDF canvas were not forced through helpers.
- Zero change to application logic, routing, permissions, or JS business behavior.
- Converted pages still work in Light, System, and Dark.
- **Phase R8 (new work uses official pieces) is recorded as later and is not treated as already in force.**
- Every phase has a §10 brief and is revertible by file revert.

---

## 14. What This Plan Will Not Do

- Rebuild the app.
- Convert 271 buttons or 214 fields.
- Put DataTables through `gp_ds_table`.
- Restyle payment gateway SDK markup.
- Apply Dark to printable certificates.
- Make “use the helper or it is wrong” a rule before Phase R8.

---

## 15. Phase R7 — Remaining pages pass (12 Sep 2026)

**Docs only.** No views converted this phase. Status is from live file-exists + `gp_ds_*` grep. Helpers mean R2 `title` (`gp_ds_page_title`), R3 `badge` / `alert`, R4 `card` (`gp_ds_card`), R5 `table` (`gp_ds_table`). Everyone else on a `.gp-ds` shell is **CSS-painted only**. UNKNOWN = 0 (three §4.1 mismatches resolved by reading Home.php).

**Sample verified on disk (not a browser §9 pass):** frontend `my_notifications` + `shopping_cart`; admin `dashboard` + `contact`; user `dashboard`; `lessons/index`; `mobile/payment_gateway.php`; `payment-global/index`; install `step2`.

### 15.1 Frontend `page_name`s (§4.1)

Views under `application/views/frontend/default-new/<name>.php` unless noted.

| page_name | Status | Helpers / reason |
|---|---|---|
| `my_notifications` | Converted | card, table |
| `instructor_dashboard` | Converted | card, table |
| `create_course` | Converted | card |
| `manage_course_details` | Converted | card, table |
| `lesson_edit` | Converted | card |
| `shopping_cart`, `courses_page`, `course_page`, `instructor_page`, `my_courses`, `my_messages`, `my_wishlist`, `purchase_history`, `user_profile`, `user_credentials`, `update_user_photo`, `instructor_following`, `about_us`, `terms_and_condition`, `refund_policy`, `privacy_policy`, `cookie_policy`, `login`, `sign_up`, `forgot_password`, `invoice`, `compare`, `404`, `website_faq`, `contact_us`, `become_a_instructor`, `payout_settings`, `badges`, `community_index`, `community_shared_post`, `community_my_posts`, `community_saved_posts`, `blogs`, `blog_details`, `custom_page_viewer`, `new_login_confirmation`, `change_password_from_forgot_password`, `verification_code` | CSS-painted only | Frontend shell; no R2–R5 helper |

**§4.1 mismatches (resolved from Home.php — views not invented):**

| page_name | Controller | View | Status |
|---|---|---|---|
| `lessons` | Home.php:952 → `lessons/index` | `application/views/lessons/index.php` (own shell, already `.gp-ds`) | CSS-painted only (own shell) |
| `payment_gateway` | Home.php:1542–1546 `payment_gateway_mobile` → `mobile/index` | `application/views/mobile/payment_gateway.php` | CSS-painted only (mobile shell). Wrapper only. |
| `live_class` | Home.php:1652–1665 `live_class_mobile_web_view` → `mobile/index` | `application/views/mobile/live_class.php` | CSS-painted only (mobile shell). Zoom SDK — do not extract. |

`live_class_scadule.php` exists and is an **include** from `my_courses.php` (line 67), not the `live_class` `page_name` target. CSS-painted fragment.

### 15.2 Homepage variants (§4.2)

`frontend/default-new/home.php` **exists**. All 17 variants exist on disk.

| Variants | Status | Reason |
|---|---|---|
| `home_builder`, `home`, `home_1`, `home_2`, `home_3`, `home_4`, `home_5`, `home_6`, `home_7`, `home_elegant`, `home_fitness`, `home_language`, `home_development`, `home_kindergarten`, `home_cooking2`, `home_university2`, `home_marketplace` | CSS-painted only | Marketing tiles; not `gp_ds_card` (§6) |

`home_*_assets.php` files are includes, not `page_name`s.

### 15.3 Admin `page_name`s (§4.3) — 75

Each view: `application/views/backend/admin/<name>.php`. All 75 exist.

**Converted — title + another helper (16) + table-only (1):**

| page_name | Helpers |
|---|---|
| `category_add` | title, card |
| `category_edit` | card (title skipped: not the 8-line Hyper card) |
| `enrol_student` | title, card |
| `open_ai_settings` | title, card |
| `available_addons` | title, badge |
| `addon_add` | title, card |
| `addons` | title, badge |
| `admins` | title, badge |
| `coupon_add` | title, card |
| `coupon_edit` | title, card |
| `blog_add` | title, card |
| `blog` | title, badge |
| `instructors_pending_blog` | title, badge |
| `announcements` | title, badge |
| `announcement_add` | title, card |
| `announcement_edit` | title, card |
| `lessons` | table (title skipped: extra `#course_id` widget) |

**Converted — title only (52):** `dashboard`, `categories`, `instructors`, `instructor_add`, `instructor_edit`, `users`, `user_add`, `user_edit`, `enrol_history`, `admin_revenue`, `instructor_revenue`, `invoice`, `purchase_history`, `system_settings`, `frontend_settings`, `payment_settings`, `notification_settings`, `social_login`, `instructor_settings`, `theme_settings`, `courses-server-side`, `course_add`, `course_edit`, `manage_language`, `message`, `manage_profile`, `about`, `addon_update`, `application_list`, `instructor_payout`, `admin_add`, `admin_edit`, `admin_permission`, `coupons`, `blog_category`, `blog_edit`, `drip_content_settings`, `custom_page`, `add_custom_page`, `edit_custom_page`, `academy_cloud`, `data_center`, `subscribed_user`, `newsletters`, `newsletter_history`, `wasabi_settings`, `bbb_live_class_settings`, `seo_settings`, `sitemap_settings`, `badges`, `home_page_builder`, `certificate_settings`.

**CSS-painted only (6):**

| page_name | Reason |
|---|---|
| `sub_category_add` | Legacy `h2` + Entypo breadcrumb/panel; never the Hyper title card |
| `sub_category_edit` | Same legacy panel markup |
| `pending_courses` | Legacy panel + table (`id="table-2"`); DataTables family — CSS-only |
| `video_player` | Legacy `ul.breadcrumb` + `h3`; player chrome, not a helper target |
| `blog_settings` | Form card, no leftover `h4.page-title`; CSS paints `.card` |
| `contact` | R2 skip (Delete Selected widget in the title card) + DataTable |

Whitelist views that are **not** live Admin.php `page_name`s: `courses` Converted (title); `available_addon` Converted (title); `active_courses` / `sub_categories` still not routes.

### 15.4 User `page_name`s (§4.4) — 14

All 14 exist under `application/views/backend/user/<name>.php`. All Converted.

| page_name | Helpers |
|---|---|
| `dashboard` | title |
| `courses-server-side` | title |
| `course_add` | title |
| `course_edit` | title |
| `payment_settings` | title |
| `sales_report` | title |
| `lessons` | table (title skipped: extra `#course_id` widget) |
| `invoice` | title |
| `become_an_instructor` | title |
| `payout_report` | title, badge |
| `blog_add` | title, card |
| `blog_edit` | title |
| `blog` | title, badge |
| `pending_blog` | title, badge |

### 15.5 Fragments (not `page_name`s)

| View | Status | Reason |
|---|---|---|
| `backend/admin/student_academic_progress.php` | CSS-painted only | Direct `load->view` (Admin.php:2800–2806). R5 skipped (nested HTML). |
| `backend/user/student_academic_progress.php` | CSS-painted only | Direct `load->view` (User.php:1014–1024). Same skip. |
| `frontend/default-new/account_disable.php` | **Deferred** | Home.php:2060–2083 loads the file **directly** (no frontend/index shell). Fragment/form; leftover inline `#fff` in a style block. Not a helper target this plan. |
| admin/user `application_details` | Converted | badge (R3). Not a live `page_name`. |

### 15.6 Shared shells (§4.5)

| Shell | Path | Status |
|---|---|---|
| Frontend | `frontend/default-new/index.php` | CSS-painted only (already `.gp-ds` via `gp_ds_is_active()`; do not re-wire) |
| Admin / user | `backend/index.php` | CSS-painted only (same) |
| Payment | `payment-global/index.php` | CSS-painted only (wrapper; `.gp-ds` present) |
| Install | `install/index.php` | CSS-painted only (overlay; `.gp-ds` present) |
| Lessons player | `lessons/index.php` | CSS-painted only (own shell; `.gp-ds` present) |
| Mobile webview | `mobile/index.php` | CSS-painted only (own shell; `.gp-ds` present) |
| Homepage builder tool | `backend/admin/home_page_builder/index.php` | CSS-painted only (own tool UI; `.gp-ds` present). Distinct from page_name `home_page_builder` (title). |
| Certificate print | `certificate/index.php` | **Deferred** — printable artwork; no `.gp-ds` |
| Lesson PDF canvas | `lessons/pdf_canvas.php` | **Deferred** — print/PDF; no `.gp-ds` |
| Email | `email/common_template.php`, `static_common_template.php` | **Deferred** — different medium; inlined tables |

### 15.7 Extended surfaces (§4.6)

Re-counted tonight (unique PHP; Windows path dupes ignored). `update/` excluded.

| Area | Count | Status |
|---|---|---|
| `payment-global/` | 20 | CSS-painted only — wrapper. Files: `index`, `includes_top`, `includes_bottom`, `payment_gateway`, `go_back_to_mobile_app`, plus 15 `*/payment_form.php` (`aamarpay`, `bkash`, `cashfree`, `doku`, `flutterwave`, `maxicash`, `pagseguro`, `paypal`, `payu`, `razorpay`, `skrill`, `sslcommerz`, `stripe`, `tazapay`, `xendit`). SDK fields never change. |
| `install/` | 11 | Overlay. **Converted (alert):** `main/step2`, `step3`, `step4`. **CSS-painted only:** `index`, `styles`, `footer`, `scripts`, `main/step0`, `step1`, `success`, `finalizing_setup`. |
| `components/main/` | 105 | CSS-painted only — homepage-builder sections. Not `gp_ds_card`. |
| `lessons/` | 12 | CSS-painted only except `pdf_canvas` **Deferred** (print). Player fragments: `includes_top`, `includes_bottom`, `sidebar`, `bottom_tabs`, `general_course_content_body`, `quiz_view`, `quiz_result`, `quiz_answer_sheet`, `certificate_progress`, `plyr_config`. |
| `mobile/` | 11 top-level | CSS-painted only (mobile shell). `live_class` Zoom / `payment_gateway` wrapper — do not extract. Also on disk tonight (not in the 11): `stripe/stripe_payment_gateway_form.php`, `razorpay/razorpay_checkout.php` — CSS wrapper / SDK. |

### 15.8 Rollup

| Bucket | Converted | CSS-painted | Deferred | UNKNOWN |
|---|---|---|---|---|
| Frontend §4.1 | 5 | 38 | 0 | 0 |
| Mismatches | 0 | 3 | 0 | 0 |
| Home §4.2 | 0 | 17 | 0 | 0 |
| Admin §4.3 | 69 | 6 | 0 | 0 |
| User §4.4 | 14 | 0 | 0 | 0 |
| Fragments (progress ×2 + account_disable) | 0 | 2 | 1 | 0 |
| **Page inventory** | **88** | **66** | **1** | **0** |
| Shells | 0 | 7 | 3 | 0 |
| Extended files (install alerts counted Converted) | 3 | 20+8+105+11+11 | 1 (`pdf_canvas`, also a shell) | 0 |

### 15.9 Concerns

- Leftover R2 titles (`contact`, admin/user `lessons` title block) and leftover R3 badges/alerts stay CSS-painted; R7 did not force them.
- Admin `sub_category_*` / `pending_courses` / `video_player` are pre-Hyper chrome on a `.gp-ds` backend shell — CSS only, not title-helper targets.
- `account_disable` is the only Deferred **page** (no shared shell + leftover `#fff`).
- Certificate / PDF / email remain Deferred print-or-email media.
- No browser Light/Dark pass this phase (documentation only).
