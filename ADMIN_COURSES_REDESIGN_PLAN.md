# Admin Courses Redesign — Implementation Plan

> **For agentic workers:** Implement one phase at a time. Stop after each phase for a visual check. Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Do not skip the constraints in §2.

**Goal:** Restyle every live admin page under the Courses sidebar using Geese Project tokens and existing `gp_ds_*` helpers, without changing course, lesson, coupon, category, or DataTables logic.

**Architecture:** UI-only pass, same pattern as the admin dashboard. Shared chrome lives in `assets/design-system/gp-admin-courses.css` scoped under `.gp-ds`. Each phase touches only the listed views. Leftover Hyper markup is restructured; PHP queries, form `action`/`name`/`id`, and JS hooks stay.

**Tech stack:** CodeIgniter 3 views, existing `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge` / `gp_ds_table` / `gp_ds_alert`, `--gp-*` tokens, leftover Hyper + DataTables + Select2 (hooks preserved).

**Source of truth:** `geeseprojdesignsystem.html` (tokens, cards §06, forms, tables, tabs, badges, empty states, dropdowns). Admin dashboard reference: `application/views/backend/admin/dashboard.php` + `assets/design-system/gp-dashboard.css`.

---

## 1. Audit — page inventory

Audited from `application/views/backend/admin/navigation.php` (Courses menu), `Admin.php` `page_name` assignments, and the views those pages include.

### 1.1 Live sidebar pages (in scope)

| # | Nav label | URL | View | Current UI |
|---|-----------|-----|------|------------|
| 1 | Manage courses | `/admin/courses` | `application/views/backend/admin/courses-server-side.php` | Leftover Hyper `widget-inline` stat row + GET filter form + `#course-datatable-server-side`. Title already uses `gp_ds_page_title`. |
| 2 | Add new course | `/admin/course_form/add_course` | `application/views/backend/admin/course_add.php` + `course_media_add.php` | Leftover Hyper wizard (`#basicwizard`, `.nav-pills`, `.form-wizard-header`). Tabs: basic, info, pricing, media, seo, finish. |
| 3 | Course category | `/admin/categories` | `application/views/backend/admin/categories.php` | Leftover Hyper image cards + hover-reveal edit/delete. |
| 4 | Add category | `/admin/category_form/add_category` | `application/views/backend/admin/category_add.php` | Already wrapped in `gp_ds_page_title` + `gp_ds_card`; leftover Hyper form/Select2/icon-picker. |
| 5 | Edit category | `/admin/category_form/edit_category/{id}` | `application/views/backend/admin/category_edit.php` | Same as add. |
| 6 | Coupons | `/admin/coupons` | `application/views/backend/admin/coupons.php` | `gp_ds_page_title` + leftover Hyper `#basic-datatable` + dropright actions. |
| 7 | Add coupon | `/admin/coupon_form/add_coupon_form` | `application/views/backend/admin/coupon_add.php` | Already `gp_ds_card`; leftover date-picker + generate-code button. |
| 8 | Edit coupon | `/admin/coupon_form/edit_coupon_form/{id}` | `application/views/backend/admin/coupon_edit.php` | Same as add. |

### 1.2 Reached from Manage / Edit course (in scope)

| # | Surface | URL / trigger | View | Current UI |
|---|---------|---------------|------|------------|
| 9 | Edit course (shell + tabs) | `/admin/course_form/course_edit/{id}` | `application/views/backend/admin/course_edit.php` | Leftover Hyper scrollable wizard. Many tabs. |
| 10 | Curriculum tab | included by edit | `curriculum.php` | Accordion sections + `showAjaxModal` / `confirm_modal`. |
| 11 | Enrol list tab | AJAX into `#enrol_list` | `course_enrol_list.php` | Leftover table filled by `enrol_list()`. |
| 12 | Academic progress tab | AJAX into `#academic_progress` | (loaded by `student_academic_progress()`) | Do not change the JS loader; restyle the returned markup if it is a view we own. |
| 13 | BBB live class tab | included by edit | `bbb_live_class.php` | Settings form. |
| 14 | Media tab partial | included by add/edit | `course_media_add.php`, `course_media_edit.php` | Upload / preview widgets. |
| 15 | Custom field tab | included by edit | `custom_field.php` | Dynamic fields. |
| 16 | Lessons index | `/admin/lessons/{course_id}` | `application/views/backend/admin/lessons.php` | Already uses `gp_ds_table`; leftover page-title card. |
| 17 | Change author modal | `showAjaxModal` from edit | `change_course_author.php` | Small form. |
| 18 | Status-change mail modal | row actions | `mail_on_course_status_changing_modal.php` | Inform-instructor form. |
| 19 | Add-course shortcut modal | header Quick Actions | `course_add_shortcut.php` | Shortcut form (`showAjaxModal`). |

### 1.3 Curriculum popups (in scope, Phase 6)

Opened only from curriculum / header lesson shortcut. UI restyle only.

| View | Hook to keep |
|------|----------------|
| `section_add.php`, `section_edit.php` | `showAjaxModal`, form `action` |
| `lesson_types.php` | `#course_id_for_lesson`, radio `name="lesson_type"`, `server-side-select3`, `showAjaxModal` |
| `lesson_add.php`, `lesson_edit.php` | `.ajaxFormSubmission`, `#lesson_summary`, `#free_lesson`, `ajax_get_video_details` |
| `quiz_add.php`, `quiz_edit.php`, `quiz_questions.php`, `quiz_fields_type_wize.php` | existing quiz JS |
| `resource_files.php`, `resource_file_edit.php` | existing resource JS |

### 1.4 Addon tabs inside course edit (Phase 8 only — visual wrap)

Do **not** start these in Phases 1–7. If the addon is off, the tab is absent.

| Addon | Include |
|-------|---------|
| Zoom live class | `live_class.php` |
| Jitsi | `jitsi_live_class.php` |
| Assignment | `assignment.php` |
| Noticeboard | `noticeboard.php` |
| Course analytics | `course_analytics.php` |
| SCORM | `scorm_curriculum.php` |
| H5P | `h5p_curriculum.php` |
| Course bundle (sidebar submenu) | addon views under `addons/bundle` — **out of this plan** |

### 1.5 Not in the live Courses nav (out of this plan unless requested)

| View | Why excluded |
|------|----------------|
| `courses.php` | `Admin::courses()` loads `courses-server-side`, not this file. |
| `pending_courses.php` | Legacy Entypo page. Route `/admin/pending_courses` exists but is not in the sidebar. |
| `active_courses.php` | Leftover; not a live `page_name`. |
| `application/views/backend/user/courses*.php` | Instructor copies. Separate later. |
| Public catalog `/home/courses` | Already restyled. |

---

## 2. Constraints (every phase — do not break unrelated code)

### 2.1 UI only

Never modify:

- Controllers (`Admin.php` methods: `courses`, `get_courses`, `course_form`, `course_actions`, `categories`, `coupons`, `lessons`, status change, enrol loaders)
- Models, queries, schema, validation, file-upload processing
- Routes, URLs, GET/POST parameter names
- Auth, permissions (`has_permission('course'|'category'|'coupon')`)
- Payment / enrolment / scoring / quiz correctness
- AJAX response JSON from `get_courses` or Select2 instructor search

If a visual change appears to need a logic change: **stop** and report it. Do not “fix” it in the same pass.

### 2.2 Hooks that must stay (name, id, and behavior)

**Manage courses**

- Form `action="<?php echo site_url('admin/courses'); ?>"` `method="get"`
- Selects: `#category_id`, `#status`, `#instructor_id`, `#price` (and `name=` for each)
- `#instructor_id` class `server-side-select2` and `action=".../get_select2_instructor_data/all"`
- Table `#course-datatable-server-side` and thead column **order** (DataTables `columns` in `application/views/backend/common_scripts.php`)
- Do **not** rewrite `common_scripts.php` DataTable init, buttons, or POST payload
- Filter links on stat tiles must keep the same query strings

**Add / edit course**

- `form.required-form` actions: `admin/course_actions/add` and `admin/course_actions/edit/{id}`
- `#basicwizard`, `data-toggle="tab"`, tab hrefs (`#curriculum`, `#basic`, `#info`, `#pricing`, `#media`, `#seo`, `#customField`, `#finish`, `#enrol_list`, `#academic_progress`, `#bbb-live-class`, …)
- `.scrollable-tab-btn-left` / `.scrollable-tab-btn-right`
- `.ajax_loader` / `.ajax_loaderBar`
- `onclick="enrol_list(...)"`, `student_academic_progress(...)`, `load_assignment_list()`, `load_notic_list()`, `load_analytics_chart()`
- Field `name` attributes on every input (course save depends on them)
- `#go-to-instructor-revenue` is dashboard-only — do not copy that pattern here

**Categories**

- `.on-hover-action` and ids `#category-edit-btn-{id}`, `#category-delete-btn-{id}`
- Existing mouseenter/mouseleave script (or keep those ids if hover is restyled to always-visible actions)
- `confirm_modal('.../admin/categories/delete/{id}')`
- `#parent`, `checkCategoryType`, `.icon-picker`, `#font_awesome_class`, `#thumbnail-picker-areas`

**Coupons**

- `#basic-datatable` (or keep that id even if we only restyle)
- `generateARandomCouponCode()`, `#code`, `#discount_percentage`, `#expiry_date`, `data-toggle="date-picker"`

**Curriculum / lessons / quizzes**

- Every `showAjaxModal(...)` and `confirm_modal(...)` URL
- `.ajaxFormSubmission` + `ajaxForm({...})`
- Radio `name="lesson_type"` values
- Select2 inits already in those files

**Global**

- `data-toggle="dropdown"` / `data-bs-toggle` as already used
- `gp_ds_*` helpers for **new** title/card/button/badge/table markup
- CSS only under `.gp-ds` — no unscoped `.btn` / `.card` / `.table` rewrites
- No `!important` unless beating leftover Hyper that already uses it
- Compose labels with `' ' . get_phrase('word')` so phrases do not mash
- Do not edit `application/views/backend/user/**` in this plan
- Do not edit public frontend course pages
- Do not commit unless the user asks

### 2.3 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-admin-courses.css` (new, shared)
- `application/views/backend/includes_top.php` — one `<link>` for that CSS
- Token/hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Admin.php`, `common_scripts.php` DataTable block, models, `hyper-admin-theme.css` repo-wide edits, addon PHP logic.

---

## 3. Shared visual language (reuse, do not invent)

Match the admin dashboard:

- Page title: `gp_ds_page_title`
- Stat tiles: `.gp-dash-stat` pattern (surface, 14px radius, `--gp-border`, `--gp-shadow-card`, navy icon chip)
- Cards: `.card` / `gp_ds_card` with 14px radius
- Buttons: `gp_ds_button` variants only (`primary` / `outline` / `quiet` / `secondary`)
- Badges: `gp_ds_badge` tones (`success` / `warning` / `neutral` / `danger`)
- Empty states: dashed `--gp-border` panel, not leftover SVG-only dumps
- Tabs: existing `gp-nav-tabs.css` language; keep Bootstrap tab JS
- Forms: leftover `.form-control` + Select2; restyle under `.gp-ds`, do not replace Select2
- Tables: leftover DataTables markup; restyle chrome only (`gp-tables.css` + course-scoped overrides)

New CSS file: `assets/design-system/gp-admin-courses.css`  
Cache query: bump `?v=courses-N` in `includes_top.php` each phase that changes it.

---

## 4. Phases

### Phase 0 — Lock CSS + constraints (no page redesign yet)

**Files**

- Create: `assets/design-system/gp-admin-courses.css`
- Modify: `application/views/backend/includes_top.php` (add stylesheet after `gp-admin-shell.css`)

**Do**

- File header listing in-scope `page_name` values and forbidden hooks
- Empty scoped section `.gp-ds .gp-courses-page { }` ready for later phases
- Prove the CSS 404s not (hard-refresh `/admin/courses`)

**Do not** change any course view yet.

**Test:** view source on `/admin/courses` contains `gp-admin-courses.css`. Dashboard and catalog unchanged.

---

### Phase 1 — Manage courses (`/admin/courses`)

**Files**

- Modify: `application/views/backend/admin/courses-server-side.php`
- Modify: `assets/design-system/gp-admin-courses.css`

**Do**

- Wrap content in `.gp-courses-page`
- Replace leftover `widget-inline` with a 5-tile stat grid (Active, Upcoming, Pending, Free, Paid) — same links and counts
- Restyle filter row as a toolbar card; keep GET form and Select2 ids
- Keep `#course-datatable-server-side` and column order
- Fix mashed labels (`Active courses`, `Course list`, `Add new course`)
- Style DataTables wrapper under `.gp-ds` (search, length, buttons, pagination) without touching `common_scripts.php`

**Do not** edit `courses.php` (unused by this route) or `Admin::get_courses`.

**Test**

1. Hard-refresh `/admin/courses`
2. Each stat tile still filters the table
3. Category / status / instructor / price + Filter still works
4. Table pages, searches, and “Export as CSV” still work
5. Row ⋮ menu: view, edit, mark pending/active, delete still fire the same modals
6. Light + Dark

---

### Phase 2 — Categories

**Files**

- `categories.php`, `category_add.php`, `category_edit.php`
- `gp-admin-courses.css`

**Do**

- Category grid: DS cards (image, title, sub-count, always-visible or clearly styled actions)
- Keep `.on-hover-action` ids **or** keep the ids and show actions without relying on hover-only (preferred for usability) without renaming ids
- Add/edit forms: DS card + `gp_ds_button`; keep `select2`, `icon-picker`, thumbnail inputs, `checkCategoryType`

**Test**

- List → edit → save → back
- Add parent and child category
- Delete confirm still uses `confirm_modal`
- Icon picker and thumbnail fields still work

---

### Phase 3 — Coupons

**Files**

- `coupons.php`, `coupon_add.php`, `coupon_edit.php`
- `gp-admin-courses.css`

**Do**

- List: DS card + keep `#basic-datatable` and dropright / `confirm_modal`
- Add/edit: already on `gp_ds_card`; restyle date picker + generate button with tokens
- Fix mashed titles

**Test**

- Generate random code fills `#code`
- Date picker still sets `#expiry_date`
- Submit add/edit/delete unchanged
- DataTables sort/search on the list still works

---

### Phase 4 — Add course wizard

**Files**

- `course_add.php`, `course_media_add.php`
- `gp-admin-courses.css`

**Do**

- Keep `#basicwizard` and every tab href / pane id
- Restyle tab bar (no leftover Hyper purple pills)
- Restyle form fields, cards, and footer actions with `gp_ds_button`
- Keep `.required-form`, `enctype`, every input `name`
- Keep scroll buttons and ajax loader

**Test**

- Walk every tab; scroll arrows still move the tab strip
- Submit still posts to `admin/course_actions/add`
- Validation / required fields still behave
- Media upload widgets still attach files

---

### Phase 5 — Edit course shell + core form tabs

**Files**

- `course_edit.php` (shell, `#basic`, `#info`, `#pricing`, `#media`, `#seo`, `#customField`, `#finish` only)
- `course_media_edit.php`, `custom_field.php`
- `gp-admin-courses.css`

**Do**

- Same tab chrome as Phase 4
- Header actions: View on frontend / Back to list via `gp_ds_button` (keep hrefs)
- Do **not** restyle curriculum / enrol / progress / addon tab **bodies** yet (tab labels may be styled)

**Test**

- Open an existing course
- Switching tabs still works; `data-toggle="tab"` unchanged
- Save edit still posts to `admin/course_actions/edit/{id}`
- Change-author modal still opens
- Frontend preview link still works

---

### Phase 6 — Curriculum + lesson / section / quiz popups

**Files**

- `curriculum.php`
- `section_add.php`, `section_edit.php`
- `lesson_types.php`, `lesson_add.php`, `lesson_edit.php`
- `quiz_add.php`, `quiz_edit.php`, `quiz_questions.php`, `quiz_fields_type_wize.php`
- `resource_files.php`, `resource_file_edit.php`
- `gp-admin-courses.css`

**Do**

- Restyle section list as DS cards / accordion (existing `gp-accordion.css` if already used)
- Keep every `showAjaxModal` / `confirm_modal` URL
- Restyle modal forms only (tokens, spacing, buttons)
- Do not rewrite `.ajaxFormSubmission` or video-detail AJAX

**Test**

- Add section, edit section, delete section
- Add lesson (each type radio still leads to the same add form)
- Edit / delete lesson
- Add / edit quiz and questions
- Resource files modal
- Header Quick Action “Add lesson” still opens `lesson_types`

---

### Phase 7 — Remaining core edit surfaces

**Files**

- `course_enrol_list.php`
- `bbb_live_class.php`
- `lessons.php`
- `change_course_author.php`
- `mail_on_course_status_changing_modal.php`
- `course_add_shortcut.php`
- Academic-progress markup **only if** it is a view under `application/views/backend/admin/` (re-grep before editing)

**Do**

- Tables / forms to DS cards
- Keep AJAX target ids `#enrol_list`, `#academic_progress`
- Shortcut modal: keep fields the header already posts

**Test**

- Enrol list tab populates
- Academic progress tab still loads
- BBB fields still save
- `/admin/lessons/{id}` still lists lessons
- Mark as pending/active from the course table still opens the mail modal

---

### Phase 8 — Addon tabs (optional, visual wrap only)

Only if the addon is enabled on this install. Restyle container/card/buttons. Do not touch addon controllers or SDK markup (Zoom, Jitsi, SCORM packages).

**Stop** if an addon file mixes SDK markup with layout and a clean wrap is not possible.

---

### Phase 9 — Close-out

- Re-grep hooks from §2.2 and confirm they still exist
- Light + Dark on Phases 1–7
- Confirm dashboard, public catalog, and instructor courses pages were not edited
- Write a short completion note (what changed / what was left)

---

## 5. Suggested order and why

1. **List page first** — highest traffic, same stat-tile pattern as the dashboard.
2. **Categories + coupons** — smaller forms/tables; prove helpers + CSS before the wizard.
3. **Add course, then edit shell** — share tab CSS.
4. **Curriculum last among core** — most JS hooks; isolate risk.
5. **Addons last** — optional, easy to skip.

---

## 6. Explicitly out of scope

- Instructor (`backend/user`) course pages
- Public `/home/courses`
- Course bundle addon
- Rewriting DataTables JS or `Admin::get_courses`
- Deleting leftover `courses.php` / `pending_courses.php`
- Navigation reorder (sidebar already has Manage → Add → Category → Coupons)
- Commits / PRs unless asked

---

## 7. Phase 1 starting sketch (do not implement until this plan is approved)

Manage-courses wrapper and stat tile — **same counts and hrefs as today**:

```php
<?php gp_ds_page_title(
    get_phrase('Courses'),
    gp_ds_button(get_phrase('Add') . ' ' . get_phrase('course'), [
        'href' => site_url('admin/course_form/add_course'),
        'variant' => 'outline',
    ], true)
); ?>
<div class="gp-courses-page">
  <div class="gp-dash-stats">
    <a class="gp-dash-stat" href="<?php echo site_url('admin/courses?category_id=all&status=active&instructor_id=all&price=all&button='); ?>">
      ...
    </a>
    <!-- upcoming, pending, free, paid — identical query strings -->
  </div>
  <form action="<?php echo site_url('admin/courses'); ?>" method="get">
    <!-- keep #category_id #status #instructor_id #price -->
  </form>
  <table id="course-datatable-server-side" class="table table-striped dt-responsive nowrap" width="100%" data-page-length="25">
    <!-- same 8 columns, same order -->
  </table>
</div>
```

---

## 8. Self-review

| Requirement | Covered by |
|-------------|------------|
| List all Courses pages | §1 |
| Phase-by-phase plan | §4 |
| UI only | §2.1 |
| Constraints / hooks | §2.2 |
| Design system / tokens | §3 |
| Avoid unrelated breakage | §2.3, §6 |
| DataTables safety | Phase 1 + `common_scripts.php` freeze |
| Addons isolated | Phase 8 |
| Leftover unused views flagged | §1.5 |
