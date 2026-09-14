# Admin Contact Redesign — Implementation Plan

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Implement one phase at a time with spec + quality review. Do not skip the constraints in §2.

**Goal:** Restyle the live admin Contact inbox using Geese Project tokens and existing `gp_ds_*` helpers, without changing read-status, reply, delete, or DataTables logic.

**Architecture:** UI-only pass, same pattern as Newsletter / Users. Shared chrome lives in `assets/design-system/gp-admin-contact.css` scoped under `.gp-ds .gp-contact-page`. Leftover Hyper markup is restructured; PHP queries, form `action` / `name` / `id`, and JS hooks stay. Do not remove features, actions, fields, buttons, dialogs, or flows — restyle them in place.

**Tech stack:** CodeIgniter 3 views, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_table`, `--gp-*` tokens, leftover Hyper server-side DataTables + `#scrollable-modal` (hooks preserved).

**Source of truth:** `geeseprojdesignsystem.html` (cards §06, forms §07, tables §14, badges §12). Reuse: `gp-tables.css`, Users DataTables token language (copy under `.gp-contact-page` only).

**Recommended layout:** page title (Delete Selected stays in the title actions, hidden until rows are checked) → one card → server-side table.

---

## 1. Audit — page inventory

Audited from `application/views/backend/admin/navigation.php` (single Contact item, `has_permission('contact')`), `Admin::contact()`, and the views that route loads.

Contact is a **single** sidebar item. There is no submenu.

### 1.1 Live sidebar page (in scope)

| # | Nav label | URL | View | Current UI |
|---|-----------|-----|------|------------|
| 1 | Contact | `/admin/contact` | `contact.php` | Leftover Hyper title card (not `gp_ds_page_title`) + leftover red `#delete_selected` (hidden) + leftover card + `#server_side_users_data` (same leftover id as Users / Instructors / Newsletter subscribers). Ajax is **GET** `admin/contact/data-table`. |

### 1.2 Reached while Contact stays active (in scope)

| # | Surface | URL / trigger | View | Why |
|---|---------|---------------|------|-----|
| 2 | Reply modal | `showAjaxModal('admin/contact/contact_reply_form/{id}', …)` | `contact_reply_form.php` | Loaded into `#scrollable-modal`. Leftover green Send reply. |

### 1.3 Out of this plan unless requested

| View / surface | Why excluded |
|----------------|--------------|
| `navigation.php` unread badge query (`has_read` is null) | Do not edit the nav item or its count query. |
| `Admin.php` `contact()` including `data-table` row HTML | Controller-emitted checkbox / badges / dropright. CSS-only. |
| Public frontend contact form | Not this menu. |
| Customer Support addon (`tickets`) | Different sidebar item. |

---

## 2. Constraints (every phase)

### 2.1 UI only — restyle, do not remove

Never modify:

- `Admin::contact()` (list, `data-table`, `delete`, `delete_selected_contact`, `contact_reply_form`, `send_reply`)
- Opening `data-table` still marks unread rows `has_read = 1` (do not “fix” that)
- Models / `get_contacts` / SMTP reply
- Routes / GET `selected_ids` on bulk delete
- Auth / `has_permission('contact')`
- DataTables JS in `common_scripts.php`
- Form `name` / `id` / `action`

Do not rename `#server_side_users_data`. Scope CSS under `.gp-contact-page` so Users / Instructors / Newsletter tables are not restyled twice.

**Controller-emitted HTML:** checkbox `data-row-id`, Student / Instructor / Not registered leftover badges, reply-sent check icon, mailto/tel links, dropright Reply / Delete. Do **not** edit `Admin.php`. Restyle leftover classes under `.gp-contact-page`.

If a visual change appears to need a logic change or a removal: **stop** and report it.

### 2.2 Hooks that must stay

**List (`contact.php`)**

- `#delete_selected` — starts `display: none`; JS shows it when `selectedRows.length > 0`
- `#delete_selected` click → `confirm_modal('admin/contact/delete_selected_contact?selected_ids=' + selected_ids)`
- `#select_all` in the header
- Table id `#server_side_users_data`
- DataTables: `ajax.url` `admin/contact/data-table`, **type GET**, CSRF, `order: [[0, 'desc']]`
- Columns `checkbox`, `key`, `name`, `contact`, `message`, `action`
- `selectedRows` array + `#select_all` click + row checkbox `data-row-id` + `table.on('draw')` re-check
- `toggleDeleteButton()`

**Reply modal**

- Form `action="admin/contact/send_reply/{id}"` `method="post"`
- Textarea `name="reply_message"`
- Submit `type="submit"`
- Keep `showAjaxModal` loading this view into `#scrollable-modal`

**Row actions (controller-emitted)**

- Reply `showAjaxModal('admin/contact/contact_reply_form/{id}', …)`
- Delete `confirm_modal('admin/contact/delete/{id}')`

**Global**

- `gp_ds_*` for new title / card / button / table markup we own
- CSS only under `.gp-ds`
- Compose mashed `get_phrase()` labels with spaces, or use an existing complete key. Do not invent new phrase keys
- Do not edit `application/views/backend/user/**`
- Do not commit unless the user asks

### 2.3 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-admin-contact.css` (new)
- `application/views/backend/includes_top.php` — one `<link>` after `gp-admin-newsletter.css`
- Token / hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Admin.php`, `common_scripts.php`, models, `hyper-admin-theme.css` repo-wide edits, `navigation.php`.

---

## 3. What to replace (component map)

| Leftover Hyper | Replace with | Notes |
|----------------|--------------|--------|
| Leftover title card + leftover red `#delete_selected` | `gp_ds_page_title` + `gp_ds_button` secondary (or outline) with `id="delete_selected"` | Keep hidden-until-selected. Keep the click handler. |
| Leftover `.card` / header-title | `gp_ds_card` | Keep “Contact Users” title via existing phrase. |
| Leftover table | `gp_ds_table` `table_id` = `server_side_users_data` `allow_empty` | First header cell stays `#select_all` checkbox HTML. |
| Leftover green Send reply | `gp_ds_button` primary `type="submit"` | Keep `reply_message`. |
| Controller-emitted badges / dropright / check icon | CSS-only | Do not edit `Admin.php`. |
| Confirm dialogs | Already DS in `modal.php` | Keep `confirm_modal`. |

Do not invent a new helper. Button variants only: `primary`, `secondary`, `outline`, `quiet`.

---

## 4. Layout

**Inbox**  
Page title + hidden Delete Selected → one full-width card → table. Do not add a filter card. Do not split into a side panel.

**Reply modal**  
Keep `#scrollable-modal`. Wrap `contact_reply_form.php` in `.gp-contact-page.gp-contact-modal`.

---

## 5. Shared visual language

- Wrapper: `.gp-contact-page`
- Page title: `gp_ds_page_title`
- Cards: `gp_ds_card`
- Buttons: `gp_ds_button`; compact
- Table: `gp_ds_table`

New CSS file: `assets/design-system/gp-admin-contact.css`  
Cache query: bump `?v=contact-N` in `includes_top.php`.

---

## 6. Phases

### Phase 0 — Lock CSS + constraints

**Files:** create `gp-admin-contact.css`; link in `includes_top.php`

**Do:** header of forbidden hooks + scoped compact-button / table / DataTables / checkbox / dropright rules.

**Do not** change Contact views yet.

### Phase 1 — Contact list

**Files:** `contact.php`

**Do**

- `.gp-contact-page`
- Title: `gp_ds_page_title` + Delete Selected as `gp_ds_button` with `id="delete_selected"` (keep `display:none` via CSS or inline)
- One `gp_ds_card`; `gp_ds_table` with `#select_all` in the first header
- Keep every DataTables option, GET ajax URL, `selectedRows`, `confirm_modal` bulk delete

**Test:** search / sort / page; header and row checkboxes still fill `selectedRows`; Delete Selected appears and still hits `delete_selected_contact?selected_ids=`; row Reply / Delete still work; Light + Dark

### Phase 2 — Reply modal

**Files:** `contact_reply_form.php`

**Do**

- `.gp-contact-page.gp-contact-modal`
- Keep `reply_message` + `send_reply/{id}`
- Submit → compact primary

**Test:** Reply modal still opens; submit still POSTs `send_reply/{id}`; Light + Dark

---

## 7. Close-out

- Hard-refresh `/admin/contact`
- Confirm leftover Hyper title card and leftover green Send are gone
- Confirm Contact stays a single sidebar item
- Confirm Users / Instructors / Newsletter `#server_side_users_data` CSS was not leaked
- Do not commit unless asked
