# Admin Message Redesign — Implementation Plan

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Implement one phase at a time with spec + quality review. Do not skip the constraints in §2.

**Goal:** Restyle the live admin Message inbox using Geese Project tokens and existing `gp_ds_*` helpers, without changing thread queries, send/reply posting, Select2, or read-status logic.

**Architecture:** UI-only pass, same pattern as Users / Enrol / Report / Courses. Shared chrome lives in `assets/design-system/gp-admin-message.css` scoped under `.gp-ds .gp-message-page`. Leftover Hyper markup is restructured; PHP queries, form `action` / `name` / `id`, and JS hooks stay. Do not remove features, actions, fields, buttons, dialogs, or flows — restyle them in place.

**Tech stack:** CodeIgniter 3 views, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge`, `--gp-*` tokens, leftover Hyper chat classes + Select2 (hooks preserved).

**Source of truth:** `geeseprojdesignsystem.html` (cards §06, forms §07, badges §12, list groups §20, empty states §22). Reuse: `gp-list-group.css`, global Select2 tokens in `gp-components-core.css`. There is no DS chat primitive — restyle leftover `.conversation-list` / `.ctext-wrap` / `.odd` with tokens only.

**Recommended layout:** one shared Message CSS + page wrapper; one card split into thread list (narrow) + pane (wide). Do not flatten the two-column inbox into a single stack on desktop.

---

## 1. Audit — page inventory

Audited from `application/views/backend/admin/navigation.php` (single Message item, `has_permission('messaging')`), `Admin::message()`, and the views that route loads.

`page_name` is always `message`. Compose and read are **inner includes**, not separate `page_name` values. `$message_inner_page_name` is `message_home` | `message_new` | `message_read`.

### 1.1 Live sidebar page (in scope)

| # | Nav label | URL | View | Current UI |
|---|-----------|-----|------|------------|
| 1 | Message | `/admin/message` | `message.php` + `message_home.php` | `gp_ds_page_title` + leftover Hyper card + leftover green New message + leftover `btn-light` thread list + empty SVG |
| 2 | (same nav) | `/admin/message/message_new` | `message.php` + `message_new.php` | Nested leftover card, Select2 `#receiver`, leftover green submit |
| 3 | (same nav) | `/admin/message/message_read/{thread_code}` | `message.php` + `message_read.php` | Nested leftover Hyper chat + leftover red Send |

### 1.2 Out of this plan unless requested

| View | Why excluded |
|------|----------------|
| `application/views/frontend/default-new/my_messages.php` | Public / student inbox. Standing scope rule. |
| `application/views/backend/user/**` | Instructor copies. Standing scope rule. |
| Newsletters / contact | Other sidebar menus. |
| Nav unread badge query | Lives in `navigation.php`. Do not edit the nav item or its count query. |

---

## 2. Constraints (every phase)

### 2.1 UI only — restyle, do not remove

Never modify:

- Controllers (`Admin.php` `message()`, `send_new`, `send_reply`, `message_read`, `mark_thread_messages_read`)
- Models / `crud_model` send + unread helpers
- Routes / URLs: `admin/message`, `admin/message/message_new`, `admin/message/message_read/{code}`, `admin/message/send_new`, `admin/message/send_reply/{code}`
- Auth / `check_permission('messaging')`
- Thread query (`sender` / `receiver` = current user)
- First-sender `odd` class logic

If a visual change appears to need a logic change or a removal: **stop** and report it.

### 2.2 Hooks that must stay

**Inbox shell (`message.php`)**

- Include `$message_inner_page_name.'.php'`
- New message href `admin/message/message_new`
- Thread href `admin/message/message_read/{message_thread_code}`
- `active` class when `$current_message_thread_code == $row['message_thread_code']`
- Unread count from `count_unread_message_of_thread()`
- Wrapper class `mail-sidebar-row` (keep; restyle)

**Compose (`message_new.php`)**

- `form` `method="post"` `enctype="multipart/form-data"` `action="admin/message/send_new"`
- Select `name="receiver"` `id="receiver"` `class="form-control select2"` `data-toggle="select2"` `required`
- Empty option + students `optgroup`
- Textarea `name="message"` `id="message"` `required`
- Submit `type="submit"`
- Keep unused `check_receiver()` script

**Read / reply (`message_read.php`)**

- `$first_sender` + `li.odd` when sender ≠ first sender
- Classes: `chat-conversation`, `conversation-list`, `slimscroll`, `chat-avatar`, `conversation-text`, `ctext-wrap`, `message_sending_time`, `chat-input`, `chat-send`
- Form `name="chat-form"` `id="chat-form"` `class="needs-validation"` `novalidate` `action="admin/message/send_reply/{thread_code}"`
- Reply input `name="message"` `class="form-control chat-input"` `required`
- Hardcoded placeholder `Enter your text` (do not invent a phrase key)
- Existing phrase `Please enter your messsage` (keep the leftover key / typo)

**Global**

- `gp_ds_*` for new title / card / button / badge markup
- CSS only under `.gp-ds`
- Compose mashed `get_phrase()` labels with spaces, or use an existing complete key. Do not invent new phrase keys.
- Do not edit `application/views/backend/user/**` or `my_messages.php`
- Do not commit unless the user asks

### 2.3 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-admin-message.css` (new, shared)
- `application/views/backend/includes_top.php` — one `<link>` for that CSS
- Token / hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Admin.php`, `common_scripts.php`, models, `hyper-admin-theme.css` repo-wide edits, `navigation.php`.

---

## 3. What to replace (component map)

| Leftover Hyper | Replace with | Notes |
|----------------|--------------|--------|
| Title only (no actions) | Keep `gp_ds_page_title`; New message stays in the sidebar | Do not add a second compose CTA. |
| Leftover `.card` shell | `gp_ds_card` | Keep the 3 / 9 column split. |
| Leftover green `btn-success` New message | `gp_ds_button` primary, full width | Keep href. Icon optional via CSS, not inside escaped button labels. |
| Leftover `btn btn-light` thread rows | DS list-group items (§20) | Keep href + `active`. |
| Leftover `badge-secondary` unread | `gp_ds_badge` `secondary` | Count stays. |
| Nested leftover compose / chat cards | Flatten into the right pane | Still one outer card. |
| Leftover green compose submit | `gp_ds_button` primary `type="submit"` | Keep form action. |
| Leftover red `btn-danger chat-send` | `gp_ds_button` primary, keep `chat-send` class | Keep `#chat-form`. |
| Leftover Hyper chat bubbles `#f1f3fa` / `#fef5e4` | Token restyle under `.gp-message-page` | Keep `.odd` / `.ctext-wrap`. |
| Empty SVG + leftover copy | DS empty-state (§22) | Keep `choose_an_option_from_the_left_side`. |
| Leftover Select2 | Existing global `.gp-ds` Select2 tokens | Keep `#receiver`. |

Do not invent a new helper. Button variants only: `primary`, `secondary`, `outline`, `quiet`.

---

## 4. Layout

**Inbox**  
Page title → one full-width `gp_ds_card` → left thread column (`col-md-3`) + right pane (`col-md-9`). Compose control stays above the thread list.

**Home pane**  
Centered empty state. Do not add a fake thread.

**Compose pane**  
Recipient Select2 + message textarea + submit. No second card.

**Read pane**  
Thread heading → scrollable conversation → reply row. No second card.

---

## 5. Shared visual language

- Wrapper: `.gp-message-page` on the inbox shell (covers inner includes)
- Page title: `gp_ds_page_title`
- Cards: `gp_ds_card`
- Buttons: `gp_ds_button`; compact admin chrome (8px 16px / 38px)
- Badges: `gp_ds_badge` for unread counts we own
- Thread list: DS `.list-group` / `.list-group-item`
- Chat: leftover class names + `--gp-*` (even = `--gp-surface-sunk`, odd = `--gp-info-soft`)

New CSS file: `assets/design-system/gp-admin-message.css`  
Cache query: bump `?v=message-N` in `includes_top.php` each phase that changes it.

---

## 6. Phases

### Phase 0 — Lock CSS + constraints

**Files**

- Create: `assets/design-system/gp-admin-message.css`
- Modify: `application/views/backend/includes_top.php` (link after `gp-admin-users.css`)

**Do**

- File header listing in-scope views and forbidden hooks
- Empty scoped section `.gp-ds .gp-message-page { }` plus compact-button, list, chat, form, and empty-state token rules

**Do not** change any Message view yet.

### Phase 1 — Inbox shell

**Files:** `message.php`, `gp-admin-message.css`

**Do**

- Wrap in `.gp-message-page`
- One `gp_ds_card`; keep 3 / 9 columns and the inner include
- New message → compact primary, keep `admin/message/message_new` and `mail-sidebar-row`
- Thread rows → list-group items; keep href + `active`
- Unread → `gp_ds_badge`

**Test:** New message still opens compose; thread click still opens that code; active thread is marked; Light + Dark

### Phase 2 — Home empty state

**Files:** `message_home.php`

**Do**

- DS empty-state; keep existing phrase
- Keep the leftover SVG or replace the graphic with the DS empty icon circle — do not drop the copy

**Test:** `/admin/message` empty pane; Light + Dark

### Phase 3 — Compose

**Files:** `message_new.php`

**Do**

- Flatten leftover nested card
- Keep `#receiver` Select2 + `#message` + `send_new` + `check_receiver()`
- Submit → compact `gp_ds_button` primary

**Test:** Select2 search; submit still POSTs `send_new`; Light + Dark

### Phase 4 — Read / reply

**Files:** `message_read.php`

**Do**

- Flatten leftover nested card
- Keep every chat class, `odd` logic, `#chat-form`, `chat-input`, `chat-send`
- Send → compact `gp_ds_button` primary with `extra_class` `chat-send`
- Token-restyle bubbles so leftover cream / gray is gone

**Test:** existing thread still lists messages; reply still POSTs `send_reply/{code}`; Light + Dark

---

## 7. Close-out

- Hard-refresh `/admin/message`, `/admin/message/message_new`, and one `message_read/{code}`
- Confirm leftover green New / Send and leftover red Send are gone
- Confirm Message stays a single sidebar item
- Confirm frontend `my_messages` and instructor user views were not touched
- Do not commit unless asked
