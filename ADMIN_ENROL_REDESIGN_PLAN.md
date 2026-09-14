# Admin Enrollments Redesign — Implementation Plan

> **For agentic workers:** Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html`. UI only. Restyle, do not remove. Design system only — no leftover Hyper look.

**Goal:** Restyle every live admin page under the Enrollments sidebar using Geese Project tokens and `gp_ds_*` helpers, without changing enrolment logic.

**Architecture:** Same pattern as Report. Shared chrome in `assets/design-system/gp-admin-enrol.css` under `.gp-ds .gp-enrol-page`.

**Tech stack:** CodeIgniter 3 views, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button`, leftover Select2 + daterangepicker hooks preserved.

---

## 1. Audit

From `navigation.php` (`has_permission('enrolment')`) and `Admin.php`.

| # | Nav label | URL | View |
|---|-----------|-----|------|
| 1 | Course enrollment | `/admin/enrol_student` | `enrol_student.php` |
| 2 | Enrol history | `/admin/enrol_history` | `enrol_history.php` |

Reached from history (no extra view): `admin/enrol_history_delete/{id}` via `confirm_modal`; CSV via `export_csv()` → `admin/export_enrol_history_csv`.

**Out of scope:** `shortcut_enrol_student.php` (header Quick Action, not this menu). Instructor user views. Course-edit enrol tab (Courses plan).

---

## 2. Hooks that must stay

**Enrol student**

- `form.required-form` `action="admin/enrol_student/enrol"` `method="post"` `enctype="multipart/form-data"`
- Users select: `class="server-side-select2"` `action="admin/get_select2_user_data"` `name="user_id[]"` `multiple`
- Course select: `name="course_id[]"` `id="multiple_course_id"` `data-toggle="select2"` `select2-multiple`
- Submit stays `type="button"` `onclick="checkRequiredFields()"`

**Enrol history**

- Form `action="admin/enrol_history/filter_by_date_range"` `method="get"`
- `#reportrange` `data-toggle="date-picker-range"` `data-target-display="#selectedValue"` `data-cancel-class="btn-light"`
- `#selectedValue`, `#date_range` `name="date_range"`
- `#submit-button` `onclick="update_date_range();"`
- `update_date_range()`, `export_csv()`, `#export-button`
- `tr.gradeU` `data-enrol-id`
- Delete `confirm_modal('.../admin/enrol_history_delete/{id}')`
- Course edit links `admin/course_form/course_edit/{id}`
- Photo `get_user_image_url`

Do not edit `Admin.php` or `common_scripts.php`. Do not invent phrase keys. Do not commit unless asked.

---

## 3. Phases

### Phase 0 — CSS + link

- Create `gp-admin-enrol.css`, link after report CSS (`?v=enrol-1`)

### Phase 1 — Course enrollment

- `.gp-enrol-page` + `gp_ds_card` + `gp_ds_button` for enrol
- Restyle Select2 (single/multiple) with tokens

### Phase 2 — Enrol history

- Date toolbar + Filter/Export as compact DS buttons (keep ids/onclick)
- Keep static table (not DataTables). Delete → `action-icon` (keep confirm_modal)
- Empty: DS `.empty-state`, keep `no_data_found`

---
