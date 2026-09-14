# Admin Newsletter Redesign — Implementation Plan

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Implement one phase at a time with spec + quality review. Do not skip the constraints in §2.

**Goal:** Restyle every live admin page under the Newsletter sidebar using Geese Project tokens and existing `gp_ds_*` helpers, without changing send, cron, subscriber, or DataTables logic.

**Architecture:** UI-only pass, same pattern as Message / Users / Enrol / Report / Courses. Shared chrome lives in `assets/design-system/gp-admin-newsletter.css` scoped under `.gp-ds .gp-newsletter-page`. Leftover Hyper markup is restructured; PHP queries, form `action` / `name` / `id`, and JS hooks stay. Do not remove features, actions, fields, buttons, dialogs, tabs, filters, or flows — restyle them in place.

**Tech stack:** CodeIgniter 3 views, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge` / `gp_ds_table`, `--gp-*` tokens, leftover Hyper accordion (`data-toggle="collapse"`), Select2, Summernote, server-side DataTables (hooks preserved).

**Source of truth:** `geeseprojdesignsystem.html` (cards §06, forms §07, badges §12, tables §14, accordion §16, alerts §18, empty states §22, admin stats language from dashboard). Reuse: `gp-accordion.css` tokens (do **not** convert leftover Hyper collapse to Bootstrap 5 `data-bs-toggle`), `gp-tables.css`, global Select2 in `gp-components-core.css`, dashboard `.gp-dash-stat` language for the four history counters.

**Recommended layout:** one shared Newsletter CSS + page wrapper; All newsletter stays stats row → template accordion + cron column; subscriber and history stay one card + server-side table.

---

## 1. Audit — page inventory

Audited from `application/views/backend/admin/navigation.php` (Newsletter submenu, `has_permission('newsletter')`), `Admin.php` `page_name` assignments, and the views those routes load.

Newsletter is a two-item submenu: **All newsletter** / **Subscribed user**. History is **not** in the nav; it is opened from the four stat cards.

### 1.1 Live sidebar pages (in scope)

| # | Nav label | URL | View | Current UI |
|---|-----------|-----|------|------------|
| 1 | All newsletter | `/admin/newsletters` | `newsletters.php` + include `newsletter_statistics.php` | `gp_ds_page_title` + leftover Hyper plus button, leftover `widget-inline` stat row, leftover Hyper `#accordion` / `custom-accordion`, leftover red/primary/green icon buttons, leftover `alert-info` + leftover green/red cron buttons |
| 2 | Subscribed user | `/admin/subscribed_user` | `subscribed_user.php` | `gp_ds_page_title` + leftover card + `#server_side_users_data` (same leftover id as Users / Instructors) |

### 1.2 Reached while Newsletter stays active (in scope)

| # | Surface | URL / trigger | View | Why |
|---|---------|---------------|------|-----|
| 3 | Add template modal | `showAjaxModal('admin/newsletter_add_form', …)` | `add_newsletter.php` | Loaded into `#scrollable-modal`. Keep `showAjaxModal`. |
| 4 | Edit template modal | `showAjaxModal('admin/newsletter_edit_form/{id}', …)` | `edit_newsletter.php` | Same modal. Edit redirects to `admin/newsletters?tab={id}`. |
| 5 | Send modal | `showAjaxModal('admin/newsletter_send_form/{id}', …)` | `send_newsletter.php` | Same modal. Select2 + server-side user picker + Summernote. |
| 6 | History (pending / sent / faild / unable) | `/admin/newsletter_history/{type}` | `newsletter_history.php` | Opened from the four stat cards. Parent nav already marks `newsletter_history` active. **Keep leftover URL segment `faild`.** |
| 7 | Statistics refresh | POST `admin/newsletter_statistics` | `newsletter_statistics.php` | `common_scripts.php` replaces `#newsletter_statistics` HTML every 60s while pending/faild rows exist. Do not edit that JS. |

### 1.3 Out of this plan unless requested

| View / surface | Why excluded |
|----------------|--------------|
| `navigation.php` item order / labels | Do not add History to the submenu. Do not reorder All newsletter / Subscribed user. |
| `Admin.php` `newsletters`, `subscribed_user`, `newsletter_history`, `newsletter_statistics`, `newsletter_*_form`, `cronjob`, `get_select2_user_data` | Logic / HTML emitted for table rows. CSS-only for controller-emitted cells. |
| `common_scripts.php` `sendEmailNewsletter` interval + `actionTo` / `refreshTable` | Do not edit. |
| `application/views/backend/user/**` | Instructor copies. Standing scope rule. |
| Public subscribe / frontend footer newsletter | Not this menu. |
| `uploads/cronjob/newsletter_cron.php` | Created/removed by `admin/cronjob/{start\|stop}`. Keep the hrefs and the printed `realpath`. |

---

## 2. Constraints (every phase)

### 2.1 UI only — restyle, do not remove

Never modify:

- Controllers listed above (including send-chunk assignment, cron file write/delete, history `send` JSON)
- Models / `crud_model` newsletter helpers / `assignEmailToSendList`
- Routes / URLs / GET `tab={id}` after edit
- Leftover history status key **`faild`** (DB + URL + poller). Do not “fix” the spelling
- Auth / `has_permission('newsletter')`
- DataTables JS in `common_scripts.php`
- Form `name` / `id` / `action`

Do not convert leftover Hyper accordion to Bootstrap 5 (`data-bs-toggle` / `.accordion-button`). That would drop `data-toggle="collapse"`, `#accordion`, `href="#collapseOne{id}"`, `data-parent="#accordion"`, and GET `tab`.

Do not rename `#server_side_users_data` on Subscribed user (leftover duplicate of Users / Instructors). Scope CSS under `.gp-newsletter-page`.

**Controller-emitted HTML:** subscriber status badges and dropright, plus history Send / Send Again links, are built in `Admin.php`. Do **not** edit that PHP. Restyle leftover classes under `.gp-newsletter-page` (`.badge-primary` / `.badge-success` / `.badge-warning`, `.btn-rounded.btn-icon`, `.btn-primary`, `.text-danger` / `.text-warning` / `.text-success`).

If a visual change appears to need a logic change or a removal: **stop** and report it.

### 2.2 Hooks that must stay

**All newsletter (`newsletters.php`)**

- Title action opens `showAjaxModal(site_url('admin/newsletter_add_form'), get_phrase('Newsletter template'))`
- `#newsletter_statistics` wrapper around the include (poller replaces its inner HTML)
- Stat hrefs: `admin/newsletter_history/pending`, `/sent`, `/faild`, `/unable`
- `#accordion` `class="custom-accordion"`
- Toggle: `data-toggle="collapse"` `href="#collapseOne{id}"` `aria-controls="collapseOne{id}"` `id="headingOne{id}"` `id="collapseOne{id}"` `data-parent="#accordion"`
- GET `tab` still expands that id (`collapsed` / `show`)
- `stopProp(event)` on the action span; `onclick="stopProp(event)"`
- Delete `confirm_modal('…/admin/newsletters/delete/{id}')`
- Edit `showAjaxModal('…/admin/newsletter_edit_form/{id}', …)`
- Send `showAjaxModal('…/admin/newsletter_send_form/{id}', …)`
- Cron existence check `is_file('uploads/cronjob/newsletter_cron.php')`
- Cron hrefs `admin/cronjob/stop` and `admin/cronjob/start`
- Printed `realpath(APPPATH . '..') . '/uploads/cronjob/newsletter_cron.php'`
- Hardcoded English heads-up paragraphs (do not invent phrase keys)

**Add / edit / send modals**

- Add form `action="admin/newsletters/add"` `method="post"`
- Edit form `action="admin/newsletters/edit/{id}"` `method="post"`
- Send form `action="admin/newsletters/send"` `method="post"`
- `name="subject"` `id="newsletter_subject"`
- `name="description"` `id="newsletter_description"`
- `initSummerNote(['#newsletter_description'])`
- Send: `name="send_to"` `id="send_to"` `class="form-control select2"` `onchange="is_selected_user(this)"`
- Send options: `selected_user`, `all`, `student`, `instructor`, `all_subscriber`, `registered_subscriber`, `non_registered_subscriber`
- `#select_newsletter_user`, `.server-side-select2` `action="admin/get_select2_user_data"` `name="user_id[]"` `multiple="multiple"`
- `is_selected_user()`, leftover `$(".select2").select2()`, leftover `placeholder: 'Search here'`
- Keep `showAjaxModal` loading these views into `#scrollable-modal` (not `modal/popup`)

**Subscribed user**

- Table id `#server_side_users_data`
- DataTables ajax POST `admin/subscribed_user` + CSRF
- Columns `key`, `email`, `user_status`, `action`
- `refreshServersideTable(tableId)`
- Row delete stays `confirm_modal('…/admin/subscribed_user/delete/{id}')` (emitted by the controller)

**History**

- Table id `#server_side_newsletter_data`
- Ajax URL `admin/newsletter_history/{type}` (`$type` from the route)
- Columns `key`, `subject`, `email`, `status`, `action`
- `refreshTable(tableId = "server_side_newsletter_data")` — history send JSON returns `run_function: refreshTable`
- Back href `admin/newsletters`
- Row Send / Send Again stay `actionTo('…/admin/newsletter_history/send/{id}')` (emitted by the controller)

**Statistics poller (do not edit `common_scripts.php`)**

- `setInterval` 60000 → `home/sendEmailToAssignedAddresses`
- If `#newsletter_statistics` exists → POST `admin/newsletter_statistics` and replace HTML
- Clear interval on `no_data_found`

**Global**

- `gp_ds_*` for new title / card / button / badge / table markup we own
- CSS only under `.gp-ds`
- Compose mashed `get_phrase()` labels with spaces, or use an existing complete key. Do not invent new phrase keys
- Do not edit `application/views/backend/user/**`
- Do not commit unless the user asks

### 2.3 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-admin-newsletter.css` (new, shared)
- `application/views/backend/includes_top.php` — one `<link>` after `gp-admin-message.css`
- Token / hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Admin.php`, `common_scripts.php`, models, `hyper-admin-theme.css` repo-wide edits, `navigation.php`, cron file contents.

---

## 3. What to replace (component map)

| Leftover Hyper | Replace with | Notes |
|----------------|--------------|--------|
| Title leftover `btn-outline-primary btn-rounded` plus | `gp_ds_button` outline | Compact. Keep `showAjaxModal`. Label is escaped — no `<i>` inside the helper. Use existing `Newsletter` phrase. |
| Leftover `widget-inline` stat tiles + leftover warning/success/danger text | Reuse dashboard `.gp-dash-stats` / `.gp-dash-stat` language | Keep the four hrefs and leftover `faild` URL. Counts stay the same queries. |
| Leftover `#accordion` / `custom-accordion` | Same markup + token restyle under `.gp-newsletter-page` | Do not switch to BS5 accordion. Keep `data-toggle` / `href` / `data-parent` / GET `tab`. |
| Leftover red / primary / green icon buttons | DS `icon-btn` (30×30 / 8px) | Keep `confirm_modal` / `showAjaxModal` / `stopProp` / tooltips. |
| Leftover `alert-info` heads-up | Token restyle; cron CTAs → `gp_ds_button` | Do **not** force this into `gp_ds_alert` (helper escapes body; cron path + buttons would break). |
| Leftover green Save / Send in modals | `gp_ds_button` primary `type="submit"` | Keep form actions. |
| Leftover Select2 / server-side Select2 | Existing global `.gp-ds` Select2 tokens | Keep `#send_to` and `.server-side-select2`. |
| Leftover Summernote | Token restyle only | Keep `#newsletter_description` + `initSummerNote`. |
| Leftover DataTables tables | `gp_ds_table` with `table_id` + `allow_empty` | Same extension used on Users. Keep `#server_side_users_data` and `#server_side_newsletter_data`. |
| Controller-emitted badges / dropright / Send links | CSS-only | Do not edit `Admin.php`. |
| History back leftover outline | `gp_ds_button` outline to `admin/newsletters` | Existing `Back` phrase. |
| Confirm dialogs | Already DS in `modal.php` | Keep `confirm_modal`. |

Do not invent a new helper. Button variants only: `primary`, `secondary`, `outline`, `quiet`.

---

## 4. Layout (per page type)

**All newsletter**  
Page title + compact outline “Newsletter” → four stat cards in one row (reuse dashboard stat grid) → two columns on desktop: templates accordion (`col-lg-8`) + cron notice (`col-lg-4`). Do not stack the cron column above the list on desktop. Do not drop the cron path or Create / Remove buttons.

**Subscribed user**  
Page title → one `gp_ds_card` → server-side table. No second filter card.

**History**  
Page title + Back outline → one `gp_ds_card` → server-side table. The `{type}` in the URL is the filter; do not add a second tab bar unless one already exists (it does not).

**Add / edit / send modals**  
Keep `#scrollable-modal`. Wrap each modal view in `.gp-newsletter-page.gp-newsletter-modal` so page CSS applies inside the dialog. Do not turn these into full pages.

---

## 5. Shared visual language

- Wrapper: `.gp-newsletter-page` on every in-scope view (including modal partials)
- Page title: `gp_ds_page_title`
- Cards: `gp_ds_card`
- Buttons: `gp_ds_button`; compact admin chrome (8px 16px / 38px)
- Accordion actions: DS `icon-btn`
- Tables: `gp_ds_table` (`table_id`, `allow_empty`)
- Stats: dashboard `.gp-dash-stat` tokens (surface, 14px radius, `--gp-fg` numbers; leftover Hyper color-on-label can become muted label + tone on a small caption)

New CSS file: `assets/design-system/gp-admin-newsletter.css`  
Cache query: bump `?v=newsletter-N` in `includes_top.php` each phase that changes it.

---

## 6. Phases

### Phase 0 — Lock CSS + constraints

**Files**

- Create: `assets/design-system/gp-admin-newsletter.css`
- Modify: `application/views/backend/includes_top.php` (link after `gp-admin-message.css`)

**Do**

- File header listing in-scope `page_name` values and forbidden hooks
- Empty scoped section `.gp-ds .gp-newsletter-page { }` plus compact-button, accordion, stat, alert, modal-form, icon-btn, and DataTables token rules

**Do not** change any Newsletter view yet.

**Test:** view-source `/admin/newsletters` contains `gp-admin-newsletter.css`

### Phase 1 — All newsletter (list + stats + cron)

**Files:** `newsletters.php`, `newsletter_statistics.php`, `gp-admin-newsletter.css`

**Do**

- Wrap in `.gp-newsletter-page`
- Title action → `gp_ds_button` outline; keep `showAjaxModal` + `Newsletter template` header
- Restyle `#newsletter_statistics` tiles to dashboard-stat language; **keep the four hrefs including `/faild`**
- Keep `#accordion`, `custom-accordion`, collapse hrefs, GET `tab`, `stopProp`
- Restyle delete / edit / send as `icon-btn`; keep tooltips
- Cron column: token restyle of the leftover alert; Create → compact primary; Remove → compact secondary or outline (not leftover red/green). Keep `realpath` + both cron hrefs

**Test:** Add modal still opens; accordion still expands; GET `?tab={id}` still opens that row; delete confirm still hits `newsletters/delete/{id}`; edit/send modals still open; cron Create/Remove still hit `admin/cronjob/start|stop`; if a pending row exists, the 60s poller still replaces `#newsletter_statistics`; Light + Dark

### Phase 2 — Add / edit / send modals

**Files:** `add_newsletter.php`, `edit_newsletter.php`, `send_newsletter.php`

**Do**

- Wrap each in `.gp-newsletter-page.gp-newsletter-modal`
- Keep every form `action` / `name` / `id`
- Save / Send → compact `gp_ds_button` primary `type="submit"`
- Keep `#send_to` options, `#select_newsletter_user` show/hide, `.server-side-select2` ajax, `initSummerNote`

**Test:** Add still POSTs `newsletters/add`; edit still POSTs `newsletters/edit/{id}` and returns with `?tab={id}`; send still POSTs `newsletters/send`; Select2 search still hits `get_select2_user_data`; switching Send To still toggles the user picker; Light + Dark

### Phase 3 — Subscribed user

**Files:** `subscribed_user.php`

**Do**

- `.gp-newsletter-page` + one `gp_ds_card`
- `gp_ds_table` `table_id` = `server_side_users_data`, `allow_empty` true
- Keep DataTables ajax URL, columns, `refreshServersideTable`
- CSS-only restyle of controller-emitted badges + dropright

**Test:** server-side search / page / sort; delete confirm still hits `subscribed_user/delete/{id}`; Light + Dark

### Phase 4 — Newsletter history

**Files:** `newsletter_history.php`

**Do**

- `.gp-newsletter-page` + Back outline to `admin/newsletters`
- One `gp_ds_card` + `gp_ds_table` `table_id` = `server_side_newsletter_data`, `allow_empty` true
- Keep ajax `admin/newsletter_history/{type}`, columns, `refreshTable`
- CSS-only restyle of leftover Send / Send Again + leftover status colors

**Test:** each of `/pending` `/sent` `/faild` `/unable` still loads the matching filter; Send still calls `actionTo(…/send/{id})` and `refreshTable` still reloads; Back returns to All newsletter; Light + Dark

---

## 7. Close-out

- Hard-refresh every URL in §1.1 and §1.2
- Confirm leftover Hyper cyan/green/red Save-Send-Delete chips and leftover `widget-inline` colors are gone on these pages
- Confirm Newsletter submenu still lists only All newsletter / Subscribed user
- Confirm `faild` URLs and the 60s `#newsletter_statistics` poller still work
- Confirm Users / Instructors tables were not broken by `#server_side_users_data` CSS (must stay scoped)
- Do not commit unless asked
