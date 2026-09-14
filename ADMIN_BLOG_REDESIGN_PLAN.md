# Admin Blog Redesign — Implementation Plan

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Implement one phase at a time with spec + quality review. Do not skip the constraints in §2.

**Goal:** Restyle every live admin page under the Blog sidebar using Geese Project tokens and existing `gp_ds_*` helpers, without changing publish, approve, category, or upload logic.

**Architecture:** UI-only pass, same pattern as Newsletter / Users. Shared chrome lives in `assets/design-system/gp-admin-blog.css` scoped under `.gp-ds .gp-blog-page`. Leftover Hyper markup is restructured; PHP queries, form `action` / `name` / `id`, and JS hooks stay. Do not remove features, actions, fields, buttons, dialogs, or flows — restyle them in place.

**Tech stack:** CodeIgniter 3 views, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge` / `gp_ds_table`, `--gp-*` tokens, leftover Hyper `#basic-datatable`, Select2, Summernote, tagsinput, image-preview (hooks preserved).

**Source of truth:** `geeseprojdesignsystem.html` (cards §06, forms §07, tables §14, badges §12, list groups §20). Reuse: `gp-tables.css`, `gp-list-group.css`, global Select2, Courses image-preview token language if already present.

**Recommended layout:** lists stay one card + table; categories stay a card grid (do not flatten to a DataTable); add/edit stay a single form card (`col-md-10`); settings stay one card (`col-md-8`).

---

## 1. Audit — page inventory

Audited from `application/views/backend/admin/navigation.php` (Blog submenu, `has_permission('blog')`), `Admin.php` `page_name` assignments, and the views those routes load.

Blog is a four-item submenu: **All blogs** / **Pending blog** / **Blog category** / **Blog settings**. Add and edit are not in the nav; they are reached from All blogs.

### 1.1 Live sidebar pages (in scope)

| # | Nav label | URL | View | Current UI |
|---|-----------|-----|------|------------|
| 1 | All blogs | `/admin/blog` | `blog.php` | `gp_ds_page_title` + leftover plus `add_new_blog` + leftover card + `#basic-datatable`. Status already uses `gp_ds_badge`. Leftover circular dropright. |
| 2 | Pending blog | `/admin/instructors_pending_blog` | `instructors_pending_blog.php` | `gp_ds_page_title` + leftover card + `#basic-datatable`. Approve / delete via `confirm_modal`. Pending count leftover badge is in the **nav**, not this view. |
| 3 | Blog category | `/admin/blog_category` | `blog_category.php` | `gp_ds_page_title` + leftover plus `add_new_category` + leftover numbered list-group tiles + leftover `badge-primary` counts + leftover white dots dropdown |
| 4 | Blog settings | `/admin/blog_settings` | `blog_settings.php` | No page title. Leftover card + leftover radios + leftover primary Save |

### 1.2 Reached while Blog stays active (in scope)

| # | Surface | URL / trigger | View | Why |
|---|---------|---------------|------|-----|
| 5 | Add blog | `/admin/add_blog` | `blog_add.php` | Already `gp_ds_page_title` + `gp_ds_card`. Leftover green submit + leftover `#F5F5F5` image previews. |
| 6 | Edit blog | `/admin/edit_blog/{blog_id}` | `blog_edit.php` | Leftover card. Same fields as add. |
| 7 | Add category modal | `showAjaxModal('admin/add_blog_category', …)` | `blog_category_add.php` | `#scrollable-modal`. Leftover primary Submit. |
| 8 | Edit category modal | `showAjaxModal('admin/edit_blog_category/{id}', …)` | `blog_category_edit.php` | Same modal. Leftover primary Update. |

### 1.3 Out of this plan unless requested

| View / surface | Why excluded |
|----------------|--------------|
| `application/views/backend/user/blog*.php` / `pending_blog.php` | Instructor copies. Standing scope rule. |
| Public `/blog` / `blog/details/{slug}/{id}` | Frontend. Title / instructor links on the admin list must **keep** those URLs. |
| `navigation.php` pending-count badge query | Do not edit the nav item or its count. |
| Nav parent `active` omit of `instructors_pending_blog` on the `<li>` | Leftover quirk. Do not rewrite nav unless asked. |

---

## 2. Constraints (every phase)

### 2.1 UI only — restyle, do not remove

Never modify:

- Controllers (`blog`, `add_blog`, `edit_blog`, `instructors_pending_blog`, `blog_category`, `add_blog_category`, `edit_blog_category`, `blog_settings`)
- Models / `add_blog` / `update_blog` / `approve_blog` / category uniqueness check
- Routes / URLs
- Auth / `has_permission('blog')`
- DataTables JS in `common_scripts.php` / `datatable-initializer.js` (`#basic-datatable`)
- Form `name` / `id` / `action`

If a visual change appears to need a logic change or a removal: **stop** and report it.

### 2.2 Hooks that must stay

**All blogs (`blog.php`)**

- Add href `admin/add_blog`
- Table id `#basic-datatable`
- Creator link `home/instructor_page/{user_id}` `target="_blank"`
- Title link `blog/details/{slug}/{blog_id}` `target="_blank"`
- Status badges stay (already `gp_ds_badge`)
- Dropright: edit `admin/edit_blog/{blog_id}`; status `confirm_modal('admin/blog/status/{blog_id}')`; delete `confirm_modal('admin/blog/delete/{blog_id}')`

**Pending (`instructors_pending_blog.php`)**

- Table id `#basic-datatable`
- Same creator / public-detail links
- Status `gp_ds_badge` with leftover `get_phrase($blog['status'])`
- Approve `confirm_modal('admin/instructors_pending_blog/approval_request/{blog_id}')`
- Delete `confirm_modal('admin/instructors_pending_blog/delete/{blog_id}')`
- Header mash `total_pending` + count + `blogs` (compose with spaces; do not invent a key)

**Add / edit blog**

- Add form `action="admin/blog/add"` `enctype="multipart/form-data"`
- Edit form `action="admin/blog/update/{blog_id}"` `enctype="multipart/form-data"`
- Fields: `#title` `name="title"`, `#blog_category_id` Select2 `data-toggle="select2"`, `#keywords` `data-role="tagsinput"` `bootstrap-tag-input`, `#summernote-basic` `name="description"`
- `#banner` / `#thumbnail` leftover `image-upload` + `.js--image-preview` + `.wrapper-image-preview`
- `#is_popular` `value="1"` `name="is_popular"` (edit keeps `checked` when popular)
- Keywords hint stays `site_phrase('click_the_enter_button_after_writing_your_keyword')`
- Leftover inline preview size notes `(2000 x 500)` / `(800 x 500)`

**Categories**

- Add button `showAjaxModal('admin/add_blog_category', add_a_new_category)`
- Edit `showAjaxModal('admin/edit_blog_category/{blog_category_id}', edit_category)`
- Delete `confirm_modal('admin/blog_category/delete/{blog_category_id}')`
- Add form `action="admin/blog_category/add"` — `#category_title` `name="title"`, `#category_subtitle` `name="subtitle"` `maxlength="80"`
- Edit form `action="admin/blog_category/update/{blog_category_id}"` — same fields

**Settings**

- Form `action="admin/blog_settings/update"` `enctype="multipart/form-data"`
- `name="blog_page_title"`, `name="blog_page_subtitle"` `id="blog_page_subtitle"`
- Radios `name="instructors_blog_permission"` `#yes` / `#no`
- Radios `name="blog_visibility_on_the_home_page"` `#enable` / `#disabled`
- `#blog_page_banner` `name="blog_page_banner"` `accept="image/*"`

**Global**

- `gp_ds_*` for new title / card / button / badge / table markup we own
- CSS only under `.gp-ds`
- Compose mashed `get_phrase()` labels with spaces, or use an existing complete key. Do not invent new phrase keys
- Do not edit `application/views/backend/user/**`
- Do not commit unless the user asks

### 2.3 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-admin-blog.css` (new)
- `application/views/backend/includes_top.php` — one `<link>` after contact (or after newsletter if Contact is not built yet)
- Token / hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Admin.php`, `common_scripts.php`, models, `hyper-admin-theme.css` repo-wide edits, `navigation.php`, public blog views.

---

## 3. What to replace (component map)

| Leftover Hyper | Replace with | Notes |
|----------------|--------------|--------|
| Title leftover plus `btn-rounded` | `gp_ds_button` outline | Compact. Keep hrefs / `showAjaxModal`. No icon inside escaped labels. |
| Leftover `.card` lists | `gp_ds_card` | Keep header-title phrases. |
| Leftover `#basic-datatable` | `gp_ds_table` `table_id` = `basic-datatable` + `body_html` | Keep the id. `datatable-initializer.js` still inits it. |
| Leftover circular dropright | Scoped `.btn-icon` → DS 30×30 / 8px | Do not remove the dropdown. |
| Leftover category list-group tiles | DS list-group / card tiles | Keep title, subtitle, count, dots menu. |
| Leftover `badge-primary` counts | `gp_ds_badge` | Count stays. |
| Leftover green add/update blog | `gp_ds_button` primary `type="submit"` | Keep form actions. |
| Leftover `#F5F5F5` image boxes | Token restyle (surface-sunk / border) | Keep `#banner` / `#thumbnail` / `.image-upload`. |
| Leftover settings radios | Same radios + token labels | Do not convert to a new control. |
| Leftover category modal submit | `gp_ds_button` primary | Keep `#category_title` / `#category_subtitle`. |
| Confirm dialogs | Already DS in `modal.php` | Keep `confirm_modal`. |

Do not invent a new helper. Button variants only: `primary`, `secondary`, `outline`, `quiet`.

---

## 4. Layout (per page type)

**Lists (all blogs / pending)**  
Page title + compact action (all blogs only) → one card → table. Do not add a second filter card.

**Categories**  
Page title + add outline → existing `col-md-4` tile grid. Do not convert to a DataTable.

**Add / edit blog**  
Page title → one card in `col-md-10`. Do not flatten image previews into a Dropzone.

**Settings**  
Page title (add `gp_ds_page_title` using existing `blog_settings` phrase) → one card in `col-md-8`.

**Category modals**  
Keep `#scrollable-modal`. Wrap in `.gp-blog-page.gp-blog-modal`.

---

## 5. Shared visual language

- Wrapper: `.gp-blog-page` on every in-scope view (including modal partials)
- Page title: `gp_ds_page_title`
- Cards: `gp_ds_card`
- Buttons: `gp_ds_button`; compact
- Tables: `gp_ds_table` with `table_id` / `body_html` where needed
- Categories: DS list-group tiles

New CSS file: `assets/design-system/gp-admin-blog.css`  
Cache query: bump `?v=blog-N` in `includes_top.php`.

---

## 6. Phases

### Phase 0 — Lock CSS + constraints

**Files:** create `gp-admin-blog.css`; link in `includes_top.php`

**Do:** header of forbidden hooks + scoped compact-button, table, dropright, list-group tile, image-preview, tagsinput, and form token rules.

**Do not** change any Blog view yet.

### Phase 1 — All blogs

**Files:** `blog.php`

**Do**

- `.gp-blog-page`
- Add → `gp_ds_button` outline to `admin/add_blog`
- One `gp_ds_card` + `gp_ds_table` `table_id` = `basic-datatable` + `body_html` for existing rows
- Keep creator / public-detail links, status badges, dropright URLs

**Test:** DataTables search/sort/page; edit / activate-deactivate / delete still hit the same URLs; public blog link still opens; Light + Dark

### Phase 2 — Pending blogs

**Files:** `instructors_pending_blog.php`

**Do**

- Same list chrome as Phase 1 (no add button)
- Keep approve / delete `confirm_modal` URLs
- Keep mashed pending-count heading

**Test:** approve / delete still work; Light + Dark

### Phase 3 — Categories + add/edit modals

**Files:** `blog_category.php`, `blog_category_add.php`, `blog_category_edit.php`

**Do**

- Tile grid restyled to DS list-group / cards; keep count + dots menu
- Add / edit stay `showAjaxModal` into `#scrollable-modal`
- Modal submits → compact primary

**Test:** add / edit / delete still post the same actions; Light + Dark

### Phase 4 — Add / edit blog

**Files:** `blog_add.php`, `blog_edit.php`

**Do**

- `.gp-blog-page`; edit uses `gp_ds_card` like add
- Keep every field id / Select2 / tagsinput / Summernote / image-preview / `#is_popular`
- Submit → compact primary

**Test:** add still POSTs `blog/add`; edit still POSTs `blog/update/{id}`; image preview still swaps; tagsinput still works; Light + Dark

### Phase 5 — Blog settings

**Files:** `blog_settings.php`

**Do**

- Add `gp_ds_page_title(get_phrase('blog_settings'))`
- One `gp_ds_card`; keep radios and banner file input
- Save → compact primary `type="submit"`

**Test:** Yes/No and Visible/Invisible still post the same names; banner still uploads; Light + Dark

---

## 7. Close-out

- Hard-refresh every URL in §1.1 and §1.2
- Confirm leftover Hyper plus chips, leftover green Save, leftover white category dots, and leftover `#F5F5F5` preview boxes are gone
- Confirm Blog submenu still lists All blogs / Pending blog / Blog category / Blog settings
- Confirm instructor `backend/user/blog*` was not touched
- Do not commit unless asked
