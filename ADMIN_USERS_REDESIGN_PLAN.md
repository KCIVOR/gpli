# Admin Users Redesign — Implementation Plan

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Implement one phase at a time with spec + quality review. Do not skip the constraints in §2.

**Goal:** Restyle every live admin page under the Users sidebar using Geese Project tokens and existing `gp_ds_*` helpers, without changing user, admin, instructor, payout, permission, or DataTables logic.

**Architecture:** UI-only pass, same pattern as Enrol / Report / Courses. Shared chrome lives in `assets/design-system/gp-admin-users.css` scoped under `.gp-ds .gp-users-page`. Leftover Hyper markup is restructured; PHP queries, form `action` / `name` / `id`, and JS hooks stay. Do not remove features, actions, fields, buttons, dialogs, tabs, filters, or flows — restyle them in place.

**Tech stack:** CodeIgniter 3 views, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge`, `--gp-*` tokens, leftover Hyper + DataTables + Select2 + daterangepicker + `#progressbarwizard` (hooks preserved).

**Source of truth:** `geeseprojdesignsystem.html` (cards §06, forms §07, tables §14, tabs, badges §12, switches, icon-btn). Reuse: `gp-nav-tabs.css`, course wizard in `gp-admin-courses.css`, date-range toolbar in `gp-admin-report.css` / `gp-admin-enrol.css`.

**Recommended layout:** one shared Users CSS + page wrapper; lists and tabbed lists stay one card; settings stay a two-column card grid; add/edit stay the existing wizard (restyled, not flattened).

---

## 1. Audit — page inventory

Audited from `application/views/backend/admin/navigation.php` (Users menu, `has_permission('user')`), `Admin.php` `page_name` assignments, and the views those routes load.

Users is a three-level menu: **Admins** / **Instructors** / **Students**.

### 1.1 Live sidebar pages (in scope)

| # | Nav group | Nav label | URL | View | Current UI |
|---|-----------|-----------|-----|------|------------|
| 1 | Admins | Manage admins | `/admin/admins` | `admins.php` | `gp_ds_page_title` + leftover Hyper card + `#basic-datatable` + leftover cyan Export CSV + leftover circular dropright |
| 2 | Admins | Add new admin | `/admin/admin_form/add_admin_form` | `admin_add.php` | Leftover `#progressbarwizard` (basic / login / social / finish) |
| 3 | Instructors | Manage instructors | `/admin/instructors` | `instructors.php` | `gp_ds_page_title` + leftover card + `#server_side_users_data` + DataTables CSV button. Row HTML comes from `Admin::server_side_instructors_data()` |
| 4 | Instructors | Add new instructor | `/admin/instructor_form/add_instructor_form` | `instructor_add.php` | Same wizard as student add (includes `#payment_info`) |
| 5 | Instructors | Instructor payout | `/admin/instructor_payout` | `instructor_payout.php` | Leftover `nav-tabs` (`#completed-b1` / `#pending-b1`), leftover `#reportrange`, leftover cyan Filter, leftover `#completed-payout` / `#pending-payout`, leftover green Pay, leftover circular print |
| 6 | Instructors | Instructor settings | `/admin/instructor_settings` | `instructor_settings.php` | Two leftover cards (public settings + commission). Select2 + `calculateAdminRevenue()` |
| 7 | Instructors | Applications | `/admin/instructor_application` | `application_list.php` | Leftover `nav-tabs` (`#pending-b1` / `#approved-b1`), leftover DataTables, leftover primary/info buttons, leftover Hyper status badges, leftover circular dropright |
| 8 | Students | Manage students | `/admin/users` | `users.php` | Same server-side table pattern as instructors. Row HTML from `Admin::server_side_users_data()` |
| 9 | Students | Add new student | `/admin/user_form/add_user_form` | `user_add.php` | Leftover `#progressbarwizard` (basic / login / social / payment / finish) |

### 1.2 Reached while Users stays active (in scope)

| # | Surface | URL / trigger | View | Why |
|---|---------|---------------|------|-----|
| 10 | Edit admin | `/admin/admin_form/edit_admin_form/{id}` | `admin_edit.php` | Admins submenu marks `admin_edit` active. Wizard plus `#short-title` / `#skills`. Login tab is email only (no password). |
| 11 | Assign permission | `/admin/permissions?permission_assing_to={id}` | `admin_permission.php` | Admins submenu marks `admin_permission` active. Leftover Hyper `data-switch="bool"` table. |
| 12 | Edit instructor | `/admin/instructor_form/edit_instructor_form/{id}` | `instructor_edit.php` | Instructors submenu marks `instructor_edit` active. Same extra `#short-title` / `#skills` as admin edit. |
| 13 | Edit student | `/admin/user_form/edit_user_form/{id}` | `user_edit.php` | Students submenu marks `user_edit` active. |
| 14 | Applicant details modal | `showAjaxModal('modal/popup/application_details/{id}')` | `application_details.php` | Opened from Applications. Keep `showAjaxModal`. |

### 1.3 Linked but already redesigned / not a Users view

| Surface | Why excluded from this plan |
|---------|-----------------------------|
| `/admin/invoice/{payout_id}` | Already redesigned in Report. Print icon on payout must keep this URL. |
| `/admin/instructor_payment/{user_id}` | Redirects to the payment gateway (`Payment_model`). Not a Users view. Keep the Pay href. |

### 1.4 Out of this plan unless requested

| View | Why excluded |
|------|----------------|
| `application/views/backend/user/**` | Instructor copies. Standing scope rule. |
| `shortcut_add_student.php` | Header Quick Action, not this menu. |
| `student_academic_progress.php` / `student_academic_quiz_result.php` | Loaded from course edit (`showLargeModal`), not Users. |
| Offline payment / newsletter / messages | Other sidebar menus. |
| Nav structure / item order | Do not reorder Users. Restyle count badges with CSS only if leftover Hyper leaks. |

---

## 2. Constraints (every phase)

### 2.1 UI only — restyle, do not remove

Never modify:

- Controllers (`Admin.php` methods: `admins`, `admin_form`, `permissions`, `assign_permission`, `instructors`, `instructor_form`, `instructor_payout`, `instructor_settings`, `instructor_application`, `instructor_payment`, `users`, `user_form`, `server_side_users_data`, `server_side_instructors_data`, `export_admins_csv`)
- Models, queries, schema, `add_user` / `edit_user` / `delete_user`, payout / application status updates
- Routes, URLs, GET `date_range` format (`d F, Y - d F, Y`), GET `permission_assing_to` (keep the leftover typo in the query key)
- Auth / `check_permission` / `has_permission` / `is_root_admin`
- Payment / Stripe checkout / `instructor_payment` redirect
- DataTables JS in `common_scripts.php`

Do not flatten wizard tabs into a single form. Do not extract a shared wizard partial in this pass (six copy-pasted views — restyle each in place). Do not drop Previous / Next. Do not drop `#short-title` / `#skills` on admin/instructor edit, payment-gateway fields, commission calculator, pending-count badges, or unused `$payment_keys` / `$paypal_keys` / `$stripe_keys` / `$razorpay_keys` assignments.

Applications table: leftover headers say document / details but the cells are details-button / download. **Do not swap columns.** Restyle the cells as they are.

If a visual change appears to need a logic change or a removal: **stop** and report it.

**Controller-emitted HTML:** student and instructor row photo / unverified badge / dropright are built in `Admin.php`. Do **not** edit that PHP. Restyle those leftover classes under `.gp-users-page` (`.btn-rounded.btn-icon`, `.badge-danger-lighten`, `.img-thumbnail`, `.dropdown-menu`).

### 2.2 Hooks that must stay

**Manage admins**

- `#basic-datatable`, `tr.gradeU` `data-admin-id`
- `#export-csv-button` `onclick="export_csv()"`
- `export_csv()` POST `admin_ids` → `admin/export_admins_csv`
- Dropright: permissions `admin/permissions?permission_assing_to={id}`, edit `admin/admin_form/edit_admin_form/{id}`, delete `confirm_modal('.../admin/admins/delete/{id}')`
- Root-admin badge (no dropright)

**Assign permission**

- Checkbox `id="{userId}-{module}"` `data-switch="bool"` `onchange="setPermission('{userId}-{module}')"`
- Matching `<label for="{userId}-{module}" data-on-label="On" data-off-label="Off">`
- `setPermission()` POST `arg` → `admin/assign_permission`
- `$.NotificationApp.send(...)` success toast
- `$modules` list unchanged

**Admin / instructor / student add + edit**

- `form.required-form` `method="post"` `enctype="multipart/form-data"`
- Actions: `admin/admins/add`, `admin/admins/edit/{id}`, `admin/instructors/add`, `admin/instructors/edit/{id}`, `admin/users/add`, `admin/users/edit/{id}`
- `#progressbarwizard`, tab hrefs `#basic_info` `#login_credentials` `#social_information` `#payment_info` (student + instructor only) `#finish`
- `#bar` / `.bar.progress-bar`
- Field `name` / `id`: `first_name`, `last_name`, `biography`, `#summernote-basic`, `phone`, `address`, `user_image`, `email`, `password` (add forms only; admin/instructor/student **edit** login tab is email only), `facebook_link`, `twitter_link`, `linkedin_link`, `gateways[{identifier}][{index}]`
- Admin edit + instructor edit only: `#short-title` `name="title"`, `#skills` `name="skills"` `data-role="tagsinput"` class `bootstrap-tag-input`
- `#user_image` `onchange="changeTitleOfImageUploader(this)"`
- Submit `type="button"` `onclick="checkRequiredFields()"` `name="button"`
- Wizard `.previous` / `.next` anchors (`href="javascript:;"`). Add forms use icon-only leftover `btn-info`; edit forms use leftover text Previous/Next. Restyle both; do not change the existing label markup into a new phrase key.

**Manage instructors / students**

- Table id `#server_side_users_data` on **both** `users.php` and `instructors.php` (leftover duplicate). Do not rename either. Scope CSS under `.gp-users-page`; do not write page-global `#server_side_users_data` JS that assumes only one table exists.
- `refreshServersideTable(tableId)`
- DataTables `ajax.url` `admin/server_side_users_data` / `admin/server_side_instructors_data`, POST CSRF
- CSV Buttons config (`extend: 'csv'`, `exportOptions` excluding photo + actions)
- Row actions stay `confirm_modal('.../admin/users/delete/{id}')` and `confirm_modal('.../admin/instructors/delete/{id}')` (emitted by the controller)

**Instructor payout**

- Stripe script tag `https://js.stripe.com/v3/`
- Tabs `href="#completed-b1"` `href="#pending-b1"` `data-toggle="tab"`
- Form `action="admin/instructor_payout/filter_by_date_range"` `method="get"`
- `#reportrange` `data-toggle="date-picker-range"` `data-target-display="#selectedValue"` `data-cancel-class="btn-light"`
- `#selectedValue`, `#date_range` `name="date_range"`
- `#submit-button` `onclick="update_date_range();"`
- `update_date_range()`, `stripe_checkout(...)`
- `#completed-payout`, `#pending-payout`, `initDataTable([...])`, `tr.gradeU`
- Invoice `admin/invoice/{id}`, Pay `admin/instructor_payment/{user_id}`
- Keep `$payment_keys` / `$paypal_keys` / `$stripe_keys` / `$razorpay_keys` assignments

**Instructor settings**

- Both forms `action="admin/instructor_settings/update"` `method="post"` `enctype="multipart/form-data"`
- `name="allow_instructor"` Select2 `data-toggle="select2"`
- `name="instructor_application_note"`
- `#instructor_revenue` `name="instructor_revenue"` `onkeyup="calculateAdminRevenue(this.value)"`
- `#admin_revenue` stays `disabled`
- `calculateAdminRevenue()`

**Applications**

- Tabs `href="#pending-b1"` `href="#approved-b1"` `data-toggle="tab"`
- `#pending-application`, `#approved-application`, `initDataTable([...])`, `tr.gradeU`
- Details `showAjaxModal('modal/popup/application_details/{id}', ...)`
- Document `href` `uploads/document/{file}` `download`
- Approve `confirm_modal('.../admin/instructor_application/approve/{id}')`
- Delete `confirm_modal('.../admin/instructor_application/delete/{id}')`

**Applicant details modal**

- Photo + existing fields (applicant, email, phone, address, message, status)
- Do not change how `modal/popup` loads the view

**Global**

- `gp_ds_*` for new title / card / button / badge markup
- CSS only under `.gp-ds`
- Compose mashed `get_phrase()` labels with spaces, or use an existing complete key. Do not invent new phrase keys.
- Do not edit `application/views/backend/user/**`
- Do not commit unless the user asks

### 2.3 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-admin-users.css` (new, shared)
- `application/views/backend/includes_top.php` — one `<link>` for that CSS
- Token / hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Admin.php`, `common_scripts.php`, models, `hyper-admin-theme.css` repo-wide edits, payment views.

---

## 3. What to replace (component map)

| Leftover Hyper | Replace with | Notes |
|----------------|--------------|--------|
| Title `btn btn-outline-primary btn-rounded` / `btn-info btn-rounded` | `gp_ds_button` `outline` / `primary` | Compact admin chrome (8px 14px / 38px). Keep ids / onclick. |
| Leftover `.card` / `.card-body` | `gp_ds_card` | Keep inner `h4.header-title` text. |
| Leftover `nav-tabs nav-bordered` | Same markup + `gp-nav-tabs.css` / scoped tokens | Keep `href` + `data-toggle="tab"`. Looks like DS `.tabs-nav`. |
| Leftover `#progressbarwizard` pills + cyan Previous/Next | Same markup + `.gp-user-wizard` (copy course-wizard tokens) | Keep `#progressbarwizard`, tab hrefs, `.previous` / `.next`. |
| Leftover cyan Filter | `gp_ds_button` primary, keep `#submit-button` | Same as Enrol history. |
| Leftover green Pay / leftover circular print | `gp_ds_button` primary + `icon-btn` | Keep Pay href and invoice URL. |
| Leftover `badge-danger` / `badge-success` / `badge-danger-lighten` | `gp_ds_badge` in views we own; CSS-only for controller-emitted unverified | Emails stay leftover (DS badges are uppercase). |
| Leftover circular dropright | Scoped `.btn-icon` → DS 30×30 / 8px radius | Do not remove the dropdown. |
| Leftover Hyper `data-switch="bool"` | CSS to match DS `.switch` | Keep checkbox id / `data-switch` / `onchange`. |
| Leftover DataTables search / pager / Buttons CSV | Token restyle under `.gp-users-page` | Do not wrap those tables in `gp_ds_table`. |
| Leftover Select2 | Existing global `.gp-ds` Select2 tokens | Settings only. |
| Leftover daterangepicker | Token restyle like Report §17 | Keep `#reportrange` hooks. |
| Leftover `custom-file` / Summernote | Token restyle only | Keep ids and `changeTitleOfImageUploader`. |
| Confirm dialogs | Already DS in `modal.php` | Keep `confirm_modal`. |

Do not invent a new helper. Button variants only: `primary`, `secondary`, `outline`, `quiet`.

---

## 4. Layout (per page type)

**Lists (admins / instructors / students)**  
Page title + compact actions → one full-width `gp_ds_card` → table. Do not add a second filter card. Do not split into a side panel.

**Tabbed lists (payout / applications)**  
Page title → one card → DS underline tabs → toolbar (payout completed tab only) → table. Pending count badge stays on the tab label.

**Settings**  
Page title → existing two-column grid (`col-xl-6` + `col-xl-6`). Two cards. Do not stack them on desktop.

**Permission**  
Page title + back outline → one medium card (`col-xl-8` centered) → feature / switch table.

**Add / edit wizards**  
Page title + back outline (add back buttons on instructor/student if missing, using existing phrase keys) → one card → restyled `#progressbarwizard`. Do not convert to a single scrolling form.

**Applicant modal**  
Keep the definition table. Restyle borders / type / badges. Photo stays.

---

## 5. Shared visual language

- Wrapper: `.gp-users-page` on every in-scope view
- Wizard extra class: `.gp-user-wizard` on add/edit forms
- Page title: `gp_ds_page_title`
- Cards: `gp_ds_card`
- Buttons: `gp_ds_button`; compact
- Badges: `gp_ds_badge` (`success` / `danger` / `neutral`) for status chips we own
- Tables: leftover DataTables ids stay; static permission table may stay a leftover `<table>` restyled (do not use `gp_ds_table` on DataTables)
- Empty rows: leftover DataTables empty, not a new empty-state unless the view already has one

New CSS file: `assets/design-system/gp-admin-users.css`  
Cache query: bump `?v=users-N` in `includes_top.php` each phase that changes it.

---

## 6. Phases

### Phase 0 — Lock CSS + constraints

**Files**

- Create: `assets/design-system/gp-admin-users.css`
- Modify: `application/views/backend/includes_top.php` (link after `gp-admin-enrol.css`)

**Do**

- File header listing in-scope `page_name` values and forbidden hooks
- Empty scoped section `.gp-ds .gp-users-page { }` plus compact-button, table, dropright-as-icon-btn, date-range, tabs, wizard, switch, and DataTables token rules ready for later phases
- Prove the CSS 404s not (view-source `/admin/admins` contains `gp-admin-users.css`)

**Do not** change any Users view yet.

### Phase 1 — Manage admins + assign permission

**Files:** `admins.php`, `admin_permission.php`, `gp-admin-users.css`

**Do**

- Wrap in `.gp-users-page`
- Title actions: Add = `gp_ds_button` outline to `admin/admin_form/add_admin_form`; Export CSV keeps `id="export-csv-button"` `onclick="export_csv()"` as `gp_ds_button` primary
- One `gp_ds_card`; keep `#basic-datatable`, `data-admin-id`, dropright links, root-admin `gp_ds_badge`
- Permission: back outline to `admin/admins`; keep every switch hook; restyle leftover Hyper switch + table with tokens

**Test:** DataTables search/sort/page; Export still downloads `admins.csv`; permission / edit / delete still work; toggling a switch still toasts `permission_updated`; Light + Dark

### Phase 2 — Add / edit admin

**Files:** `admin_add.php`, `admin_edit.php`

**Do**

- `.gp-users-page.gp-user-wizard`
- Keep `#progressbarwizard` and all four tab hrefs
- Keep `#short-title` / `#skills` on edit
- Previous / Next become compact outline (keep `.previous` / `.next`)
- Finish submit stays `checkRequiredFields()`
- Back outline to `admin/admins`

**Test:** tab clicks + Previous/Next; submit still posts `admin/admins/add` or `edit/{id}`; Summernote + image uploader; Light + Dark

### Phase 3 — Manage instructors

**Files:** `instructors.php`

**Do**

- Same list chrome as Phase 1
- Keep `#server_side_users_data`, ajax URL, CSV Buttons, `refreshServersideTable`
- Restyle leftover controller HTML (circular dots, unverified badge, photo) with CSS only

**Test:** server-side search / page / sort; CSV export; View courses / Edit / Delete still work; Light + Dark

### Phase 4 — Add / edit instructor

**Files:** `instructor_add.php`, `instructor_edit.php`

**Do**

- Same wizard restyle as Phase 2
- Keep `#payment_info` and `gateways[...]` fields
- Keep `#short-title` / `#skills` on instructor edit
- Add back outline to `admin/instructors` using `get_phrase('instructors')` or an existing complete key (do not invent keys)

**Test:** all five tabs; submit still posts instructors add/edit; Light + Dark

### Phase 5 — Instructor payout

**Files:** `instructor_payout.php`

**Do**

- One card + leftover tabs restyled to DS underline tabs
- Keep pending-count leftover badge on the tab (or `gp_ds_badge` if it does not break the count)
- Date toolbar + Filter as compact primary (`#submit-button` + `update_date_range`)
- Invoice control → `icon-btn` (keep `admin/invoice/{id}`)
- Pay → compact `gp_ds_button` primary (keep `admin/instructor_payment/{user_id}`)
- Keep Stripe script + `stripe_checkout` + gateway key assignments
- Tables stay `#completed-payout` / `#pending-payout`

**Test:** tab switch; date Filter still GETs `date_range`; DataTables on both tables; invoice opens; Pay still hits `instructor_payment`; Light + Dark

### Phase 6 — Instructor settings

**Files:** `instructor_settings.php`

**Do**

- Keep the two-column layout
- Two `gp_ds_card`s; Select2 + percent input-groups restyled
- Both Update buttons → compact `gp_ds_button` primary `type="submit"` (not leftover `btn-block` look)
- Keep `calculateAdminRevenue`

**Test:** Yes/No Select2; typing instructor % updates admin %; both forms still POST `update`; Light + Dark

### Phase 7 — Applications + details modal

**Files:** `application_list.php`, `application_details.php`

**Do**

- One card + DS tabs; keep `#pending-b1` / `#approved-b1` and table ids
- Details / Download become compact outline / quiet (keep `showAjaxModal` and `download`)
- Status → `gp_ds_badge`
- Dropright approve/delete stay; restyle the trigger as DS icon-btn
- Modal: token table + existing status badges

**Test:** both tabs; details modal opens; download; approve/delete confirm still hits the same URLs; Light + Dark

### Phase 8 — Manage students

**Files:** `users.php`

**Do**

- Same list chrome as Phase 3
- Keep `#server_side_users_data`, `admin/server_side_users_data`, CSV Buttons, `refreshServersideTable`
- CSS-only restyle of controller-emitted row HTML

**Test:** server-side search / page; CSV; Edit / Delete; Light + Dark

### Phase 9 — Add / edit student

**Files:** `user_add.php`, `user_edit.php`

**Do**

- Same wizard restyle as Phase 4 (includes `#payment_info`)
- Add back outline to `admin/users` using an existing phrase key

**Test:** all five tabs; submit still posts users add/edit; Light + Dark

---

## 7. Close-out

- Hard-refresh every URL in §1.1 and §1.2
- Confirm leftover Hyper cyan Filter, leftover circular action chips, leftover green Pay, leftover Hyper switches, and leftover wizard cyan Previous/Next are gone on these pages
- Confirm Users submenu still lists the same Admins / Instructors / Students items
- Confirm instructor user views and header shortcut add-student were not touched
- Do not commit unless asked
