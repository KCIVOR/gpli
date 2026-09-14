# Admin Courses Redesign — Phase 9 Close-out

Status: **DONE** — all listed hooks PASS. No PHP/CSS edits in this pass.

## 1. Hook audit

| Hook | Result | Where |
|------|--------|--------|
| `#course-datatable-server-side` | **PASS** | `courses-server-side.php` table `id="course-datatable-server-side"` |
| `server-side-select2` + `get_select2_instructor_data` | **PASS** | Instructor select: class `server-side-select2`, `action=".../admin/get_select2_instructor_data/all"` |
| `name="button"` on courses filter submit | **PASS** | `gp_ds_button(..., ['attrs' => ['name' => 'button']])` — helper emits `name="button"` |
| `#basicwizard` in add **and** edit | **PASS** | `course_add.php` and `course_edit.php` both `id="basicwizard"` |
| `admin/course_actions/add` and `.../edit` | **PASS** | Add form action; edit form `admin/course_actions/edit/{id}` |
| `enrol_list(` / `student_academic_progress(` | **PASS** | Tab `onclick` + function defs in `course_edit.php` |
| `showAjaxModal` in `curriculum.php` | **PASS** | Section / lesson / quiz / resource popups |
| `#basic-datatable` in `coupons.php` | **PASS** | `id="basic-datatable"` |
| `generateARandomCouponCode` | **PASS** | `coupon_add.php` button + JS (`#code`). Edit form has no generate (unchanged) |
| `confirm_modal` on categories and coupons | **PASS** | Category delete + coupon delete |
| `checkRequiredFields` on category forms | **PASS** | `category_add.php` and `category_edit.php` submit attrs |
| `.ajaxFormSubmission` in lesson add/edit | **PASS** | Form class + `$('.ajaxFormSubmission').ajaxForm({` in both |

Bonus (plan §2.2, still present): `#category_id` / `#status` / `#instructor_id` / `#price`; `.on-hover-action` + `#category-edit-btn-{id}` / `#category-delete-btn-{id}`; coupon `#code` / `#discount_percentage` / `#expiry_date` / `data-toggle="date-picker"`.

## 2. Controller / DataTable freeze

`application/controllers/Admin.php` and `application/views/backend/common_scripts.php` have **no working-tree diff vs HEAD**. Last commit touching them is the initial codebase commit. The `get_courses()` JSON builder and the `#course-datatable-server-side` DataTable `ajax` / `columns` / POST payload block are intact.

## 3. CSS tokens

`assets/design-system/gp-admin-courses.css` uses `--gp-*` tokens for colors. **No leftover raw hex in properties.**

Hex strings exist only in comments (not applied):

- `#727cf5` — leftover Hyper date-picker note
- `#aae8d0` — leftover Hyper note
- `#0acf97` — leftover Hyper note

Keyword `transparent` is used once (background). Cache query in `includes_top.php`: `gp-admin-courses.css?v=courses-8`.

## 4. Instructor / user course views

Not redesigned in Phases 1–7. No `.gp-courses-page` / course-scoped classes.

Working-tree diffs are **page-title helper swaps only** (`gp_ds_page_title` replacing leftover Hyper title cards) on `user/course_add.php`, `user/course_edit.php`, `user/courses.php`, `user/courses-server-side.php`. `user/lessons.php` is leftover Hyper chrome + `gp_ds_table` (pre-existing DS work, not this plan).

## 5. Phase 8 addon tabs

**Not started.** Zoom / Jitsi / assignment / noticeboard / analytics / SCORM / H5P includes are still the original `include '…'` from `course_edit.php`. Those addon view files are not in-repo (addon off). No addon selectors in `gp-admin-courses.css`. BBB (`bbb_live_class.php`) was Phase 7 core, not Phase 8.

## How to visually test

1. **Manage courses** (`/admin/courses`) — Light then Dark: stat tiles, filter + instructor Select2 search, submit filter (`button=` in the URL), DataTable load / sort / CSV export, row status/mail actions.
2. **Add course** (`/admin/course_form/add_course`) — walk `#basicwizard` tabs, save (posts to `admin/course_actions/add`).
3. **Edit course** — tab scroll, Curriculum `showAjaxModal` (section/lesson/quiz), Enrol list and Academic progress AJAX tabs, then save (`admin/course_actions/edit/{id}`).
4. **Categories + coupons** — hover/edit/delete (`confirm_modal`), add/edit category (`checkRequiredFields`), coupons DataTable, add coupon **Generate random** + date picker.
5. **Negative checks** — instructor `/user/courses` still leftover (title only); public catalog unchanged; addon tabs (if enabled) still leftover Hyper, not DS-wrapped.

## Left for later

- Phase 8 addon tab visual wrap (optional)
- Instructor (`backend/user`) course pages
- Commits / PR (not done)
