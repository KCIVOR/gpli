# Student Account Pages Redesign — Implementation Plan

> **Superseded.** Use `STUDENT_PAGES_ENHANCEMENT_PLAN.md`. Do not implement the Phase 0 / Phase 1 split below — it shipped a DS sidebar on leftover marketing chrome and failed the live visual check.

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Implement one phase at a time with spec + quality review. Do not skip the constraints in §2. Stop after each phase for a visual check.

**Goal:** Restyle every live student-account page that uses the shared `profile_menus.php` sidebar, using Geese Project tokens and existing `gp_ds_*` helpers, without changing enrolments, wishlist, messages, follow, purchase, profile, or payout logic.

**Architecture:** UI-only pass, same pattern as Cart / Course detail / Settings. Shared chrome lives in `assets/design-system/gp-student.css` scoped under `.gp-ds .gp-student-page`. Leftover Hyper / default-new student markup is restructured; PHP queries, form `action` / `name` / `id`, and JS hooks stay. Do not remove features, actions, fields, buttons, dialogs, filters, or flows — restyle them in place.

**Tech stack:** CodeIgniter 3 frontend views (`application/views/frontend/default-new/`), `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge` / `gp_ds_alert` / `gp_ds_table`, `--gp-*` tokens, leftover default-new student CSS (`wish-list-body`, `btn-profile-menu`, `my-course-1-*`, `courses-card-body`, `enrollBtn`).

**Source of truth:** `assets/design-system/reference/geeseprojdesignsystem.html` (cards §06, forms §07, buttons §05, badges §12, alerts, list-group §20, progress §19, tables §14, empty states, icon-btn). Reuse: `gp-list-group.css`, `gp-progress.css`, `gp-pagination.css` §15, `gp-modal.css`, form tokens already on `.gp-ds`. Related-course card language already shipped in `gp-course-detail.css` (`.gp-related-card`) for wishlist / following grids.

**Recommended layout:** one shared student CSS + `.gp-student-page` wrapper on every in-scope view; sidebar is one `gp_ds_card` (avatar + DS list); content is page title + cards. Student chrome buttons stay **compact** (logged-in app, not marketing §05).

**Screenshot note:** The attached shot is `/home/my_courses` (above the fold only). The URL named in chat is `/home/instructor_following`. Both share the same leftover sidebar. This plan covers the full student nav section, not only the screenshot.

---

## 1. Audit — page inventory

Audited from `application/views/frontend/default-new/profile_menus.php`, `Home.php` `page_name` values, the views those routes load, leftover CSS in `assets/frontend/default-new/css/style.css` + `custom.css`, and the live My Courses screenshot.

### 1.1 Screenshot findings (My Courses, above the fold)

| Area | Leftover / broken | DS replacement |
|------|-------------------|----------------|
| Sidebar active | Leftover purple pill (`--color-4` `#754FFE` on `.btn-profile-menu.active`) | DS list-group / nav row: `--gp-primary` or `--gp-info-soft` + `--gp-primary` text. Not leftover purple. |
| Sidebar list | Flat leftover links, uneven icon+label, leftover unread `badge bg-danger` | One `gp_ds_card`; consistent icon+label gap; unread → `gp_ds_badge` |
| Sidebar identity | Leftover circular avatar + stacked name/email, leftover shadow card `.wish-list-search` | Same content inside a DS card; `--gp-surface` / `--gp-border` / `--gp-shadow` |
| Page title | Raw leftover `h1` "Courses"; mashed letters (`Coursess`) | `gp_ds_page_title` + `word-spacing` / `letter-spacing` reset. Phrase stays `get_phrase('Courses')`. Do not invent a key. |
| Course row | Leftover `.my-course-1-full-body-card` (unboxed flex row, leftover `#6479962e` divider) | One `gp_ds_card` per enrolment (or one list card with DS row items) |
| Ellipsis control | Leftover `.btn-secondary.dropdown-toggle` reads as a **red circle** | DS icon-btn 30×30 / 8px radius. Keep Bootstrap dropdown + both menu hrefs. |
| Progress | Leftover 5px bar `--color-4` purple + `%` | `gp-progress.css` (`.progress` + `.progress-bar` / `.progress-fill`) + `--gp-primary` |
| Start Now | Leftover `.btn.btn-primary` circular pill, mashed `STARTNOW` | `gp_ds_button` `primary` compact, `word-spacing: 0.16em`. Keep lesson href. |
| Meta row | Lectures / Quizzes / Hours smashed together | Keep the three stats; compose spaces (`get_phrase('Lectures').' '.$count`) |
| Expiry | Leftover `text-success` / `var(--bs-code-color)` | `--gp-success` / `--gp-danger` / `--gp-fg-muted` |
| Public header | Mashed `SearchCoursess` / `Coursess` | **Out of this plan.** Public header is `gp-public-shell.css`. Do not expand unless asked. |

The screenshot does not show empty state, expired / Join again, live-class schedule, or the dropdown open. Those exist in the PHP and stay in Phase 1.

### 1.2 Live sidebar pages — always on (in scope)

| # | Sidebar label | URL | `page_name` | View(s) | Current UI |
|---|---------------|-----|-------------|---------|------------|
| 1 | My Courses | `/home/my_courses` | `my_courses` | `my_courses.php`, `live_class_scadule.php` | Leftover title + leftover course rows. Leftover circular Start Now / Join again. Leftover purple progress. Leftover ellipsis dropdown (`Go to course page`, `Author profile`). Include `live_class_scadule.php` stays. **Join again** href is a leftover hardcoded `http://localhost/academy/academy_6.0/home/handle_buy_now/{id}` — report in Phase 1; restore `site_url('home/handle_buy_now/'.$id)` so the intended hook works. No empty state. |
| 2 | Wishlist | `/home/my_wishlist` | `my_wishlist` | `my_wishlist.php` | Leftover `.courses-card-body` + leftover `.enrollBtn` (`#754FFE`) + leftover heart `#coursesWishlistIcon{id}` + compare `redirectTo`. Same leftover catalog card that crushed Enroll on course-detail related rows. |
| 3 | My notifications | `/home/my_notifications` | `my_notifications` | `my_notifications.php` | Already `gp_ds_card` + `gp_ds_table`. Leftover `btn btn-primary` / `btn-outline` for Mark all / Remove all. Needs wrapper + helper buttons. |
| 4 | Messages | `/home/my_messages` | `my_messages` | `my_messages.php` | Leftover two-column messenger. Leftover plus / search / unread bubble / `btn-primary` Send. Hooks: `searchMessages()`, `redirectTo('home/my_messages/read_message/{code}')`, `.message-box-content` toggle, forms `send_reply` / `send_new`, `name="receiver"` `name="message"`, `.conversation-body-1.active`. |
| 5 | Purchase history | `/home/purchase_history` | `purchase_history` | `purchase_history.php` | Leftover `.purchase-body` table + leftover `.purchase-btn` Invoice. Course title → `/home/course/{slug}/{id}`. Invoice → `/home/invoice/{id}`. Controller paginates (10) but the view never prints links — do not invent pager markup. No empty state. |
| 6 | Badges | `/home/badges` | `badges` | `badges.php` | Leftover `.my-course-1-full-body` + leftover `#171347` / `.shadow-sm` tiles. Instructor vs student badge branches stay. Certificate tile stays `addon_status('certificate')`. No empty state. |
| 7 | Profile | `/home/profile/user_profile` | `user_profile` | `user_profile.php` | Leftover `.common-card` form. Photo: `#profile-photo-input` `name="user_image"`, leftover `btn-light` Upload + leftover `.purchase-btn` Save/Cancel + `$('.photo-upload-btn').toggleClass('d-hidden')`. Basics form `home/update_profile/update_basics`. Instructor-only `name="title"` + `#skills` `data-role="tagsinput"`. `.text_editor` biography. Social `twitter_link` / `facebook_link` / `linkedin_link`. Leftover `btn-primary` Save. |
| 8 | Instructor Followings | `/home/instructor_following` | `instructor_following` | `instructor_following.php` | Leftover `.courses-card-body` instructor tiles. Follow wrap `a#follow-btn-{id}` + leftover `span.btn.btn-primary` / `btn-fill`. JS `toggleFollow()` POSTs `home/toggle_following`, swaps those two leftover classes. No empty state. Same leftover Follow crush risk as course-detail (icon-btn 32px). |
| 9 | Account | `/home/profile/user_credentials` | `user_credentials` | `user_credentials.php` | Leftover credentials form `home/update_profile/update_credentials`. Disabled `#email`. `#current_password` `#new_password` `#confirm_password`. Leftover `btn-primary` save. Leftover `btn-danger` Account disable → `showAjaxModal('home/account_disable')` when `account_disable` setting is on. |

### 1.3 Reached while student chrome stays active (in scope)

| # | Surface | URL / trigger | View | Why |
|---|---------|---------------|------|-----|
| 10 | Invoice | `/home/invoice/{id}` from Purchase history | `invoice.php` | Leftover invoice table + leftover `badge bg-light` + leftover Print / Back. Keep `window.print()`, back `home/purchase_history`, billed fields. No student sidebar (standalone print layout). Wrap + token the chrome only. |
| 11 | Account disable modal | `showAjaxModal('home/account_disable')` | `account_disable.php` | Keep form `home/account_disable`, disabled `#email`, `#account_password`. Leftover `btn-danger` Confirm → `gp_ds_button` outline/quiet (no new red helper). Keep `showAjaxModal`. |

### 1.4 Same student sidebar — instructor extras (in scope, last)

These appear in `profile_menus.php` when `$user_details['is_instructor'] == 1` or affiliator. They are **frontend** views, not `application/views/backend/user/**`.

| # | Sidebar label | URL | `page_name` | View | Current UI |
|---|---------------|-----|-------------|---------|------------|
| 12 | Instructor dashboard | `/home/dashboard` | `instructor_dashboard` | `instructor_dashboard.php` | Already `gp_ds_card` + `gp_ds_table` + leftover `btn-primary` / `btn-outline` status filters (`/home/dashboard/{active\|pending\|draft}`). Create-course + `/user` links stay. Light wrap + helper buttons only. |
| 13 | Payout Settings | `/home/payout_settings` | `payout_settings` | `payout_settings.php` | Leftover `alert-warning` + leftover gateway loop + leftover `btn-primary`. Form `home/frontend_payout_settings/paypal_settings`. Keep every `gateways[{identifier}][{key}]` input and `d-none` skip when gateway off / addon off. |

### 1.5 Addon-gated sidebar items (out unless the addon view is in this workspace)

| Sidebar label | URL | Why excluded |
|---------------|-----|----------------|
| Course Bundles | `/home/my_bundles` | `addon_status('course_bundle')`. No `my_bundles` view in `frontend/default-new`. |
| Bootcamp | `/addons/bootcamp/my_bootcamp` | Addon package. Leftover SVG `fill="#1E293B"` lives in `profile_menus.php` — token that icon in Phase 0; do not invent the Bootcamp page. |
| My Teams | `/addons/team_training/my_teams` | Addon package. |
| Booked Tuition | `/my_bookings` | Addon package. |
| My Ebooks | `/home/my_ebooks` | Addon package. |
| Affiliate History | `/addons/affiliate_course/affiliate_course_history` | Addon package. |

If an addon view appears later, restyle it as an extra phase. Do not invent views.

### 1.6 Out of this plan unless requested

| Surface | Why excluded |
|---------|----------------|
| Public header / search / language / theme / cart / wishlist icons | Shared `gp-public-shell.css`. Mashed header labels are a known leftover on every public page. |
| Public `/home/courses` catalog | Standing scope rule. |
| `application/views/backend/user/**` | Standing scope rule. Instructor **backend** dashboard is `/user`, not this plan. |
| `create_course` / `manage_course_details` / `lesson_edit` | Instructor course builder. Linked from frontend dashboard; do not expand. |
| `update_user_photo` as its own page | Photo upload already lives on `user_profile`. Do not invent a second photo UI. |
| Nav item **order** | Keep leftover order. Visual grouping (section labels) is allowed in Phase 0 if it does not change hrefs or hide items. Do not reorder. |
| Public course detail / cart / payment | Already redesigned. |

### 1.7 Whitelist notes

`design_system_pages.php` already lists: `my_courses`, `my_wishlist`, `my_messages`, `user_profile`, `purchase_history`, `instructor_following`, `user_credentials`, `my_notifications`, `badges`, `payout_settings`, `instructor_dashboard`, `invoice`. Shell `.gp-ds` is on unless excluded. Not required for activation.

---

## 2. Constraints (every phase)

### 2.1 First constraint — design system over leftover / foreign UI

If a control is leftover Hyper, leftover default-new (`#754FFE`, `.enrollBtn`, `.btn-profile-menu`, leftover circular `.btn-primary`), Bootstrap-default, or any other foreign look, use the Geese Project design system equivalent. Do not keep the old skin. Do not invent a third style.

Helpers only: `gp_ds_button` (`primary` / `secondary` / `outline` / `quiet`), `gp_ds_badge`, `gp_ds_alert`, `gp_ds_card`, `gp_ds_table`, `gp_ds_page_title`.

`gp_ds_button` **html_escapes the label** — no raw `<i>` icons inside the label. Pass JS via `attrs`. Student chrome stays compact (8px 16px / 38px), not marketing §05.

### 2.2 UI only — restyle, do not remove

Never modify:

- Controllers (`Home.php` student methods, `toggle_following`, `toggleWishlistItems`, `handle_buy_now`, `update_profile`, `account_disable`, `frontend_payout_settings`)
- Models, queries, schema, enrolment / watch-history / rating math
- Routes, URLs (except the leftover hardcoded Join-again host — restore `site_url`, do not invent a new route)
- Form `action` / `name` / `id`
- Auth / session `user_login`
- DataTables JS in `common_scripts.php` (none of these pages should gain DataTables)
- Phrase files — do not invent keys. Compose mashed labels with spaces.

If a visual change appears to need a logic change or a removal: **stop** and report it.

### 2.3 Hooks that must stay

**Shared sidebar (`profile_menus.php`)**

- Unread query: `message` where `receiver` = session user and `read_status != 1`
- Every existing href and `page_name == '…'` active test
- Addon `if (addon_status(...))` blocks and affiliator / `is_instructor` extras
- Bootcamp SVG can change `fill="#1E293B"` → `currentColor`; do not remove the item

**My Courses**

- `$this->user_model->my_courses()`
- Dropdown: `home/course/{slug}/{id}`, `home/instructor_page/{creator}`
- Keep `data-bs-toggle="dropdown"` and both `<li>` items
- `include 'live_class_scadule.php'`
- Start Now: `home/lesson/{slug}/{id}`
- Join again: `actionTo` / `home/handle_buy_now/{id}` (not the leftover `academy_6.0` host)
- Expiry branches (`expiry_date == 0` / future / past) stay

**Wishlist**

- `json_decode($wishlist, true)` loop
- `#coursesWishlistIcon{id}` + `actionTo('home/toggleWishlistItems/{id}')`
- Compare `redirectTo('home/compare?course-1=…&course-id-1=…')` + `checkPropagation`
- Purchased → `redirectTo('home/lesson/…')`; else leftover Enroll span (card is an `<a>` to the course — do not nest `gp_ds_button` `<a>` inside it; use a `span.btn.btn-primary` like related-course cards)

**Followings**

- `a#follow-btn-{instructor_id}` `onclick="toggleFollow({id}, this)"`
- JS POST `home/toggle_following` with `instructor_id` + `user_id`
- Success still toggles leftover class names `btn-primary` ↔ `btn-fill` on the inner `span` (restyle both classes with `--gp-*` so the swap still works)
- Profile href `home/instructor_page/{id}`

**Messages**

- `searchMessages($(this).val())` and the existing DOM walk
- Thread click `redirectTo('home/my_messages/read_message/{code}')`
- `.conversation-body-1.active` when `$message_thread_code` matches
- Plus button `$('.message-box-content').toggleClass('d-hidden')`
- Reply form `home/my_messages/send_reply/{code}` `name="message"`
- New form `home/my_messages/send_new` `name="receiver"` `name="message"`
- `$_GET['instructor_id']` preselect / unhide new-message pane

**Notifications**

- `actionTo('home/get_my_notification/mark_all_as_read')`
- `actionTo('home/get_my_notification/remove_all')`

**Profile / Account**

- Photo form `home/update_profile/update_photo/true`, `name="user_image"`, `#profile-photo-input`, `.photo-upload-btn` / `[for=profile-photo-input]` `d-hidden` toggle
- Basics `home/update_profile/update_basics` — keep every field name, `#skills` tagsinput, `.text_editor`
- Credentials `home/update_profile/update_credentials` — `#email` disabled, the three password ids
- `showAjaxModal('home/account_disable', …)` + modal form `home/account_disable` `#account_password`

**Purchase / invoice**

- Course link `home/course/{slug}/{id}`
- Invoice `home/invoice/{id}`
- Print `window.print()`; Back `home/purchase_history`

**Payout**

- Form `home/frontend_payout_settings/paypal_settings`
- Gateway foreach + `d-none` skip + `name="gateways[{identifier}][{index}]"`

**Instructor dashboard**

- Filter hrefs `home/dashboard/{active|pending|draft}`
- Edit / section / lesson hrefs already in the table
- `home/create_course` and `site_url('user')` links stay (do not restyle `/user`)

**Global**

- Confirm / ajax modals: keep `showAjaxModal`, `confirm_modal` if a page already uses them
- CSS only under `.gp-ds`
- Do not edit `application/views/backend/user/**`
- Do not restyle `/home/courses`
- Do not commit unless the user asks

### 2.4 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-student.css` (new, shared)
- `application/views/frontend/default-new/includes_top.php` — one `<link>` for that CSS
- Token / hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Home.php`, `common_scripts.php`, models, leftover `style.css` / `custom.css` repo-wide edits, inventing addon views, public header, catalog, backend instructor views.

---

## 3. What to replace (component map)

| Leftover / foreign | Replace with | Notes |
|--------------------|--------------|--------|
| `.wish-list-search` + leftover shadow / `#f3f1f8` | `gp_ds_card` | Sidebar shell. |
| `.btn-profile-menu` / `.active` leftover purple `#754FFE` | DS nav row (list-group item or scoped `.gp-student-nav-link`) | Keep `<a href>` + `active` class. Active = `--gp-primary` fill or `--gp-info-soft` + `--gp-primary` text — pick one from list-group §20 and use it on every item. |
| Leftover `badge bg-danger` unread | `gp_ds_badge` | Count only. |
| Bootcamp SVG `#1E293B` | `currentColor` | Phase 0. |
| Raw leftover `h1` | `gp_ds_page_title` | Compact actions in `actions` if the page has any. |
| Leftover `.my-course-1-full-body` / `.common-card` / `.purchase-body` | `gp_ds_card` | |
| Leftover `.my-course-1-full-body-card` | DS card or DS list row | Keep thumbnail, stats, progress, expiry, CTA, dropdown. |
| Leftover `.btn-secondary.dropdown-toggle` (red circle) | Scoped icon-btn 30×30 | Do not remove the dropdown. |
| Leftover `.skill-bar` / `--color-4` | `gp-progress.css` | Keep inline `width: {progress}%`. Drop leftover `@keyframes fill-bar`. |
| Leftover `.btn-primary` Start Now / Send / Save | `gp_ds_button` `primary` | Compact. No raw `<i>` in the label. |
| Leftover Join again `var(--bs-code-color)` | `gp_ds_button` `outline` | Restore `site_url('home/handle_buy_now/'.$id)`. |
| Leftover `.courses-card-body` + leftover `.enrollBtn` `#754FFE` | `.gp-related-card` language (already in `gp-course-detail.css`) or a scoped `.gp-student-tile` using the same tokens | Do not nest `<a>` buttons inside the card `<a>`. |
| Leftover Follow `span.btn.btn-primary` / `btn-fill` | Token both leftover class names | JS still swaps `btn-primary` ↔ `btn-fill`. Exclude `a[id^="follow-btn-"]` from any icon-btn 32px rule. |
| Leftover `btn-danger` Account disable / Confirm | `gp_ds_button` `outline` or `quiet` | No new red helper. |
| Leftover `alert-warning` payout | `gp_ds_alert` | Same copy. |
| Leftover `badge bg-light` invoice | `gp_ds_badge` | |
| Leftover `.purchase-btn` Invoice / Print / Back | `gp_ds_button` `outline` | Keep hrefs / `window.print()`. |
| Leftover static `<table class="table">` | `gp_ds_table` | Purchase history + invoice line table. |
| Leftover notifications / dashboard `btn btn-primary` | `gp_ds_button` | Keep `actionTo` / filter hrefs. |
| Leftover `#171347` / `#000` / `#ddd` / `#6E798A` | `--gp-fg` / `--gp-fg-muted` / `--gp-border` | |
| Empty lists | DS empty-state copy using existing phrases | Do not hide the page. |

Do not invent a new helper. Button variants only: `primary`, `secondary`, `outline`, `quiet`.

---

## 4. Layout (per page type)

**Shared student shell (every page except invoice)**  
`breadcrumb.php` stays → `.gp-student-page` on the leftover `<section class="wish-list-body">` → `container` → `col-lg-3` sidebar card + `col-lg-9` content. Do not stack sidebar above content on desktop. Do not remove the breadcrumb.

**Sidebar**  
One `gp_ds_card`: avatar, name, email, then a vertical DS nav. Keep leftover link order. Icons stay; size them consistently (18px). Active item must be obvious in Light and Dark.

**My Courses**  
Page title → one card per enrolment (thumbnail left, copy + progress + CTA right). Dropdown top-right of the row. Empty: one card + DS empty-state (`get_phrase('Courses')` heading stays; body uses an existing phrase or composed sentence — do not invent a key).

**Wishlist / Followings**  
Page title → 3-column tile grid (`col-lg-4`) using related-card tokens. Empty: one empty-state card.

**Notifications / Purchase / Instructor dashboard**  
Page title → one `gp_ds_card` → table + actions.

**Messages**  
Page title → one full-width card → keep leftover `col-lg-4` thread list + `col-lg-8` pane. Do not flatten into a single column on desktop.

**Profile / Account / Payout**  
Page title → one form card. Profile photo row stays above the form. Account disable stays a header action when the setting is on.

**Invoice**  
No sidebar. One print-friendly DS card. Keep Print + Back.

**Badges**  
Page title → 3-column `gp_ds_card` tiles. Empty: empty-state card.

---

## 5. Shared visual language

- Wrapper: `.gp-student-page` on every in-scope frontend view (invoice may use `.gp-student-invoice` in the same CSS file)
- Page title: `gp_ds_page_title`
- Cards: `gp_ds_card`
- Buttons: `gp_ds_button`; compact
- Badges / alerts: `gp_ds_badge` / `gp_ds_alert`
- Tables: `gp_ds_table` when there is no DataTables id
- Progress: existing `gp-progress.css`
- Nav: existing `gp-list-group.css` **or** scoped rows that match list-group tokens — do not invent a third nav
- Mashed labels: `letter-spacing: normal; word-spacing: 0.16em;` on student titles, nav, and CTAs

New CSS file: `assets/design-system/gp-student.css`  
Cache query: bump `?v=student-N` in `application/views/frontend/default-new/includes_top.php` each phase that changes it. Link after `gp-course-detail.css`.

### 5.1 Light / Dark

Write student CSS as `var(--gp-*)` only. No hardcoded `#111015`, `#FBFAF7`, `#fff`, `#754FFE`, `#1E293B`, `#171347`, leftover Hyper hex (`#727cf5`, `#39afd1`, `#08c`, `#357ebd`).

Brand `--gp-primary` / `--gp-secondary` / `--gp-accent` stay the same in both modes.

| Role | Use this token | Light | Dark |
|------|----------------|-------|------|
| Page | `--gp-bg` | `#FBFAF7` | `#111015` |
| Card | `--gp-surface` | `#ffffff` | `#17161c` |
| Sunk / progress track | `--gp-surface-sunk` | `#F3F1EB` | `#0c0c10` |
| Text | `--gp-fg` | `#171613` | `#EDEBE6` |
| Muted | `--gp-fg-muted` | `#6B6B65` | `#A7A4B0` |
| Faint | `--gp-fg-faint` | `#9C988D` | `#726f7c` |
| Border | `--gp-border` | `#E4E1D8` | `#2b2a32` |
| Strong border | `--gp-border-strong` | `#CFCBBE` | `#3c3a45` |
| Active / CTA | `--gp-primary` | `#003BA6` | `#003BA6` |
| Soft active (if not solid fill) | `--gp-info-soft` | `#E7EEF9` | `#101f3d` |

Leftover hex map:

| Leftover | Token |
|----------|--------|
| `#754FFE` / `--color-4` (nav active, Start Now, progress, `.enrollBtn`) | `--gp-primary` |
| `#1E293B` bootcamp SVG / leftover borders | `currentColor` / `--gp-border` |
| `#171347` / `#000` badge / payout titles | `--gp-fg` |
| `#6E798A` / `#68768B` meta | `--gp-fg-muted` |
| `#FFD43B` stars | keep gold star as `--gp-warning` or existing star `.gold` restyled to `--gp-warning` |
| `#6E798A33` progress track | `--gp-surface-sunk` |
| `var(--bs-code-color)` expired | `--gp-danger` |
| Leftover `text-success` lifetime | `--gp-success` |

**Visual check** means toggle Light and Dark on the live page, not only the PHP. A leftover purple that looks fine in Light is a Phase fail.

---

## 6. Phases

Stop after each phase for a visual check (Light + Dark). Do not start the next phase until the user confirms.

### Phase 0 — Shared student chrome

**Files**

- Create: `assets/design-system/gp-student.css`
- Modify: `application/views/frontend/default-new/includes_top.php` (link after `gp-course-detail.css`)
- Modify: `application/views/frontend/default-new/profile_menus.php`

**Do**

- File header listing in-scope `page_name` values and forbidden hooks
- Scoped `.gp-ds .gp-student-page { }` plus compact-button, nav, card, progress, tile, follow-btn, icon-btn, mashed-label, and empty-state rules ready for later phases
- Restyle sidebar: `gp_ds_card` + DS nav rows; leftover purple active → `--gp-primary` / `--gp-info-soft`; unread → `gp_ds_badge`; bootcamp SVG `currentColor`
- Keep every href, `active` test, addon gate, and unread query
- Prove the CSS 404s not (view-source `/home/my_courses` contains `gp-student.css`)

**Do not** change My Courses / Followings / other content views yet (except wrapping the shared include).

**Test:** Open `/home/my_courses` and `/home/instructor_following`. Active item matches the route. Every leftover sidebar link still navigates. Unread badge still shows when messages are unread. Light + Dark.

### Phase 1 — My Courses (screenshot)

**Files:** `my_courses.php`, `gp-student.css`  
**Do not edit** `live_class_scadule.php` logic — keep the include. Token any leftover chrome it prints only if it is visible.

**Do**

- Wrap section in `.gp-student-page`
- `gp_ds_page_title` with `get_phrase('Courses')`
- One DS card per enrolment; leftover ellipsis → icon-btn dropdown (both items stay)
- Progress → `gp-progress.css`; Start Now → `gp_ds_button` primary; Join again → outline + `site_url('home/handle_buy_now/'.$course_details['id'])`
- Empty enrolments → DS empty-state
- Compose mashed stat labels with spaces

**Test:** Start Now opens the lesson; dropdown both links; expired Join again still posts `handle_buy_now`; live-class include still renders when addon on; empty list; Light + Dark; no leftover purple / circular CTA / red ellipsis.

### Phase 2 — Instructor Followings (named URL)

**Files:** `instructor_following.php`

**Do**

- Wrap + page title (`get_phrase('Instructor Followings')`)
- Replace leftover `.courses-card-body` tiles with DS tiles
- Keep `a#follow-btn-{id}`, `toggleFollow()`, inner `span` class swap
- Token `.btn-primary` + `.btn-fill` under `.gp-student-page` so Follow / Unfollow stay readable (`word-spacing: 0.16em`, not 32px icon-btn)
- Empty following list → empty-state

**Test:** Follow ↔ Unfollow AJAX still updates the label/class; instructor name still opens `instructor_page`; empty list; Light + Dark.

### Phase 3 — Wishlist

**Files:** `my_wishlist.php`

**Do**

- Same tile language as related-course / followings
- Keep heart id + `actionTo` wishlist toggle, compare `redirectTo`, purchased Start Now `redirectTo` lesson
- Leftover `.enrollBtn` → `span.btn.btn-primary` (no nested `<a>`)
- Empty wishlist → empty-state

**Test:** Heart still toggles; compare still redirects; card still opens course; Start Now still opens lesson when purchased; Light + Dark.

### Phase 4 — Notifications + Messages

**Files:** `my_notifications.php`, `my_messages.php`

**Do**

- Notifications: wrap; leftover Mark all / Remove all → `gp_ds_button` primary / outline; keep both `actionTo` URLs; keep `gp_ds_table`
- Messages: wrap + page title; keep two-column layout and every hook in §2.3; leftover Send / plus → `gp_ds_button` / icon-btn; leftover unread bubble → `gp_ds_badge`; token active thread

**Test:** Mark all / Remove all; open a thread; send reply; plus opens new message; `searchMessages` still filters; `?instructor_id=` still unhides new pane; Light + Dark.

### Phase 5 — Purchase history + Invoice

**Files:** `purchase_history.php`, `invoice.php`

**Do**

- History: wrap + page title + `gp_ds_table` (or leftover table + token CSS if `gp_ds_table` cannot hold the thumbnail cell cleanly — prefer helper)
- Invoice button → outline `gp_ds_button` keeping `home/invoice/{id}`
- Empty history → empty-state
- Invoice: token print chrome; leftover Print / Back → `gp_ds_button`; leftover payment badge → `gp_ds_badge`; do not break `window.print()`

**Test:** Invoice opens; Print dialog still fires; Back returns to history; course title still opens the public course; Light + Dark. Print preview once.

### Phase 6 — Profile + Account

**Files:** `user_profile.php`, `user_credentials.php`, `account_disable.php`

**Do**

- Wrap + page titles
- Photo upload: leftover Upload / Save / Cancel → `gp_ds_button`; keep `#profile-photo-input`, `name="user_image"`, `d-hidden` toggle
- Basics / credentials: leftover Save → primary; keep every name/id, tagsinput, `.text_editor`
- Account disable leftover danger → outline/quiet + `showAjaxModal`
- Modal Confirm → outline/quiet; keep `#account_password`

**Test:** Upload photo toggle still shows Save/Cancel; basics save; instructor title/skills still chip; password save; disable modal opens and still posts; Light + Dark.

### Phase 7 — Badges

**Files:** `badges.php`

**Do**

- Wrap + page title; drop leftover `#171347` / `.shadow-sm` tile CSS
- One `gp_ds_card` per earned badge; keep instructor vs student + certificate `addon_status` branches
- Empty → empty-state

**Test:** Student sees course-completed / certificate tiles only when those vars are set; instructor branches still hide those tiles; Light + Dark.

### Phase 8 — Instructor extras in this menu (last)

**Files:** `instructor_dashboard.php`, `payout_settings.php`

**Do**

- Dashboard: wrap; leftover status filters → `gp_ds_button` primary (active) / outline; keep filter hrefs and table links; do not restyle `/user` or `create_course` views
- Payout: wrap + page title; leftover warning → `gp_ds_alert`; leftover save → primary; keep gateway foreach, `d-none` skip, and every `gateways[…][…]` name

**Test:** Status filters still change the table; payout save still posts; hidden gateways stay hidden; Light + Dark.

**Do not** open `application/views/backend/user/**`.

---

## 7. Done when

- Every live always-on student sidebar page uses `.gp-student-page` + DS helpers / token restyles
- Shared sidebar no longer uses leftover purple `#754FFE` / leftover `badge bg-danger`
- No leftover circular Start Now, leftover `.enrollBtn`, leftover red ellipsis, leftover Hyper / default-new cyan-pink-purple CTAs on those pages
- All hooks in §2.3 still work
- Empty lists show a DS empty-state, not a blank leftover card
- Light + Dark checked per phase
- Public header, `/home/courses`, backend instructor views, addon packages, and course-builder pages untouched unless the user asks
