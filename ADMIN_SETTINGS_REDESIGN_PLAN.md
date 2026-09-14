# Admin Settings Redesign — Implementation Plan

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Implement one phase at a time with spec + quality review. Do not skip the constraints in §2. Stop after each phase for a visual check.

**Goal:** Restyle every live admin page under the Settings sidebar using Geese Project tokens and existing `gp_ds_*` helpers, without changing settings, payment, language, builder, backup, or addon logic.

**Architecture:** UI-only pass, same pattern as Users / Newsletter / Contact. Shared chrome lives in `assets/design-system/gp-admin-settings.css` scoped under `.gp-ds .gp-settings-page`. Leftover Hyper markup is restructured; PHP queries, form `action` / `name` / `id`, and JS hooks stay. Do not remove features, actions, fields, buttons, dialogs, tabs, filters, or flows — restyle them in place.

**Tech stack:** CodeIgniter 3 views, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge` / `gp_ds_alert` / `gp_ds_table`, `--gp-*` tokens, leftover Hyper + Select2 + tagsinput + Summernote + DataTables + `#basicwizard` (hooks preserved).

**Source of truth:** `geeseprojdesignsystem.html` (cards §06, forms §07, tables §14, tabs, badges §12, alerts, icon-btn). Reuse: `gp-nav-tabs.css`, `gp-pagination.css` §15, form tokens already on `.gp-ds`.

**Recommended layout:** one shared Settings CSS + `.gp-settings-page` wrapper; simple forms stay a two-column card + help column; tabbed settings stay one card with restyled leftover pills; lists stay one card + table.

---

## 1. Audit — page inventory

Audited from `application/views/backend/admin/navigation.php` (Settings menu, `has_permission('settings')`), live `page_name` values, and the views those routes load.

Settings is a **dropdown**, not a three-level menu. Themes is a **sibling** top-level item (already redesigned). Manage Profile is a sibling (already redesigned). Academy Cloud is **commented out** in the nav.

### 1.1 Live sidebar pages (in scope)

| # | Sidebar label | URL | `page_name` | View(s) | Current UI |
|---|---------------|-----|-------------|---------|------------|
| 1 | System settings | `/admin/system_settings` | `system_settings` | `system_settings.php` | Title already `gp_ds_page_title`. Two leftover cards (settings + update product). Leftover save / update. tagsinput `#website_keywords`. Leftover `#a7a4a4` API-key links. Select2 + radios. |
| 2 | Website settings | `/admin/frontend_settings` | `frontend_settings` | `frontend_settings.php` | Title already DS. Leftover card + leftover `#basicwizard` scrollable pills (8 tabs). Many leftover `btn-primary` / `btn-success` / `btn-danger`. Review tab: leftover table + circular dropright. `#F5F5F5` watermark preview. |
| 3 | Drip content | `/admin/drip_content_settings` | `drip_content_settings` | `drip_content_settings.php` | Leftover card + leftover save. Leftover `alert-info`. Radios toggle `.toggleMinimumWatchField`. `#minimum_duration` `data-toggle="timepicker"`. |
| 4 | Gamification badges | `/admin/badges` | `badges` | `badges.php`, `badges_add.php`, `badges_edit.php` | Leftover `#basicwizard` / `#badgeTabs` pills. Leftover Add Badges + circular dropright. `showAjaxModal` add/edit. `confirm_modal` delete. Optional Certificate tab if addon on. |
| 5 | SEO | `/admin/seo_settings` | `seo_settings` | `seo_settings.php` | Leftover card + leftover Update. tagsinput `#meta_keywords`. |
| 6 | Sitemap | `/admin/sitemap_settings` | `sitemap_settings` | `sitemap_settings.php` | Title leftover `btn-outline-primary btn-rounded`. Two leftover cards (static / dynamic route lists). |
| 7 | Certificate | `/addons/certificate/settings` | `certificate_settings` | `certificate_settings.php` | **Addon-gated.** Leftover save buttons. Leftover `#F5F5F5` preview `.js--image-preview`. Position link leftover `btn-primary`. |
| 8 | S3 | `/addons/amazons3/settings` | `s3_settings` | addon view (not in this workspace) | **Addon-gated.** View folder not present. Restyle only if the addon is installed. |
| 9 | Wasabi | `/admin/wasabi_settings` | `wasabi_settings` | `wasabi_settings.php` | Leftover card + leftover save. |
| 10 | Open AI | `/admin/open_ai_settings` | `open_ai_settings` | `open_ai_settings.php` | **Addon-gated.** Already `gp_ds_page_title` + `gp_ds_card` stub (addon present vs `addon_not_found`). Light wrap only. |
| 11 | Zoom live class | `/addons/liveclass/settings` | `zoom_live_class_settings` | addon view (not in this workspace) | **Addon-gated.** Same as S3. |
| 12 | Jitsi live class | `/addons/jitsi_liveclass/settings` | `jitsi_live_class_settings` | addon view (not in this workspace) | **Addon-gated.** Same as S3. |
| 13 | BBB live class | `/admin/bbb_live_class_settings` | `bbb_live_class_settings` | `bbb_live_class_settings.php` | Leftover card + leftover `btn-success` Save. |
| 14 | Payment settings | `/admin/payment_settings` | `payment_settings` | `payment_settings.php` | Title already DS. Leftover currency card + one leftover card per gateway. Leftover `btn-block btn-primary`. Leftover `alert-info`. Select2. Gateway `keys` JSON fields include `type="color"` for `theme_color`. |
| 15 | Language | `/admin/manage_language` | `manage_language` | `manage_language.php` | Leftover `nav-tabs nav-bordered`. Leftover `btn-info` / `btn-success` / `btn-danger`. Phrase save `updatePhrase` + `btn-{slug}`. Import leftover. |
| 16 | Notification | `/admin/notification_settings` | `notification_settings` | `notification_settings.php`, `edit_email_template.php` | Leftover pills (`#smtpSettings` / `#emailTemplate` / `#notification`). Leftover save. Leftover rounded pencil → `showRightModal`. |
| 17 | Social login | `/admin/social_login_settings` | `social_login` | `social_login.php` | Leftover `alert-danger` HTTPS warning. Leftover save + `checkRequiredFields`. Radios. |
| 18 | Custom page builder | `/admin/custom_page` | `custom_page` | `custom_page.php`, `add_custom_page.php`, `edit_custom_page.php` | Title leftover add button. Leftover `#basic-datatable` + circular dropright. Add/edit leftover `btn-success`. `#summernote-basic`. |
| 19 | Home page builder | `/admin/home_page_builder` | `home_page_builder` | `home_page_builder.php`, `home_page_add.php`, `home_page_edit.php` | Leftover pills. Leftover `#1b84ff` dashed add tile. Leftover Hyper badges + outline info/danger. `showAjaxModal` add/edit. `confirm_modal` delete. Pre-built tab leftover plus/minus. |
| 20 | Data center | `/admin/data_center` | `data_center` | `data_center.php` | Leftover import / backup buttons. Leftover alerts. Leftover `custom-file`. `#data-import-alert-modal` in `modal.php`. Download / delete URLs. |
| 21 | About | `/admin/about` | `about` | `about.php` | Leftover hex `#343a40`. Leftover `btn-primary` / `btn-success` / `btn-warning`. Leftover Hyper badges. `showAjaxModal` purchase code. |

### 1.2 Reached while Settings stays active (in scope)

| # | Surface | URL / trigger | View | Why |
|---|---------|---------------|------|-----|
| 22 | Review add modal | `showAjaxModal('admin/review_add')` | `review_add.php` | Website settings Review tab. |
| 23 | Review edit modal | `showAjaxModal('admin/review_edit/{id}')` | `review_edit.php` | Same tab. Keep `confirm_modal` delete. |
| 24 | Badge add modal | `showAjaxModal('admin/badges_add?type=...')` | `badges_add.php` | Keep `type` query. |
| 25 | Badge edit modal | `showAjaxModal('admin/badges_edit/{id}')` | `badges_edit.php` | Keep update / delete. |
| 26 | Email template drawer | `showRightModal('admin/edit_email_template/{id}')` | `edit_email_template.php` | Keep `subject[{type}]` / `template[{type}]` and `initSummerNote(['textarea'])`. |
| 27 | Home page add modal | `showAjaxModal('modal/popup/home_page_add')` | `home_page_add.php` | Keep `#summernote-basic` init. |
| 28 | Home page edit modal | `showAjaxModal('modal/popup/home_page_edit/{id}')` | `home_page_edit.php` | Same. |
| 29 | Certificate text position | `/addons/certificate/position` | `certificate_text_position.php` | Standalone page (own HTML). Drag-drop + AJAX `addons/certificate/position/save`. Restyle chrome only; do not rewrite the drag script. |

### 1.3 Out of this plan unless requested

| Surface | Why excluded |
|---------|----------------|
| Academy Cloud (`academy_cloud`) | Commented out of the Settings nav. |
| Themes | Sibling top-level item. Already redesigned. |
| Manage Profile | Sibling item. Already redesigned. |
| Offline payment settings | Different sidebar group (`addons/offline_payment/settings`). |
| Instructor settings | Users menu. Already in Users plan. |
| Home page **canvas** (`home_page_builder/index.php`) | Standalone builder shell (`css.php` / `js.php`, `save_layout()`, offcanvas). Highest JS risk. Restyle the **list** page in Phase 10; do not restyle the canvas unless asked after that visual check. |
| `application/views/backend/user/**` | Standing scope rule. |
| S3 / Zoom / Jitsi views | Addon packages are not in this workspace. If they appear later, treat as Phase 9 extras. Do not invent views. |
| Nav item **order** | Do not reorder Settings. Parent `active` list is incomplete (see §2.4) — CSS/class fix only, not a reorder. |

### 1.4 Whitelist notes

`design_system_pages.php` already lists most Settings `page_name`s. Shell-level `.gp-ds` is on unless excluded. Missing inventory rows (safe to add when restyling): `s3_settings`, `zoom_live_class_settings`, `jitsi_live_class_settings`. Not required for activation.

---

## 2. Constraints (every phase)

### 2.1 First constraint — design system over leftover / foreign UI

If a control is leftover Hyper, Bootstrap-default, or any other foreign look, use the Geese Project design system equivalent. Do not keep the old skin. Do not invent a third style.

Helpers only: `gp_ds_button` (`primary` / `secondary` / `outline` / `quiet`), `gp_ds_badge`, `gp_ds_alert`, `gp_ds_card`, `gp_ds_table`, `gp_ds_page_title`.

`gp_ds_button` **html_escapes the label** — no raw `<i>` icons inside the label. Pass JS via `attrs`. Compact admin chrome (8px 16px / 38px), not marketing §05 size.

### 2.2 UI only — restyle, do not remove

Never modify:

- Controllers (`Admin.php` settings methods, `updater/update`, `data_center/*`, addon controllers)
- Models, queries, schema, payment gateway JSON `keys`, language phrase files
- Routes, URLs, form `action` / `name` / `id`
- Auth / `check_permission` / `has_permission` / `addon_status`
- Payment SDK markup / gateway identifier loop / `type="color"` for `theme_color`
- DataTables JS in `common_scripts.php`
- Home builder `save_layout()`, `show_offcanvas()`, sortable blocks
- Certificate drag-drop position script

If a visual change appears to need a logic change or a removal: **stop** and report it.

### 2.3 Hooks that must stay

**System settings**

- Form `admin/system_settings/system_update`, class `required-form`
- `#website_keywords` `data-role="tagsinput"`
- Field ids: `system_name`, `system_title`, `website_description`, `author`, `slogan`, `system_email`, `address`, `youtube_api_key`, `vimeo_api_key`, language / timezone / public_signup Select2, `account_disable` radios
- Save `type="button"` `onclick="checkRequiredFields()"`
- Update product form `updater/update`, `#file_name` `onchange="changeTitleOfImageUploader(this)"`

**Website settings**

- `#basicwizard` + leftover scroll left/right buttons + tab hrefs: `#frontendsettings` `#websitefaqs` `#contact_information` `#recaptcha` `#logo_and_images` `#custom_codes` `#water_mark` `#review`
- FAQ `appendFaq()` / `removeFaq(this)`
- Review `showAjaxModal` add/edit + `confirm_modal` delete
- `.js--image-preview` / watermark file inputs
- All existing form actions under `admin/frontend_settings/...`

**Drip**

- `admin/drip_content_settings/update`
- Radios `name="lesson_completion_role"` + `$('.toggleMinimumWatchField').toggleClass('d-hidden')`
- `#minimum_duration` `data-toggle="timepicker"` `data-show-meridian="false"`
- `#minimum_percentage`, `#locked_lesson_message`

**Badges**

- `#basicwizard` / `#badgeTabs` + tab hrefs `#courseCount` `#coursesRating` `#courseSale` `#articles` `#courseCompleted` `#certificate`
- `showAjaxModal('admin/badges_add?type=...')` types: `course_count`, `courses_rating`, `courses_sale`, `articles`, plus completed / certificate types already in the view
- `showAjaxModal('admin/badges_edit/{id}')`
- `confirm_modal('admin/badges/delete/{id}')`

**SEO / Sitemap / Wasabi / BBB**

- Existing form actions and field names
- Sitemap title link `base_url('sitemap.xml')` `target="_blank"`
- BBB `name="endpoint"` `name="secret"` `admin/bbb_live_class_settings/update`

**Certificate**

- `#certificate_template` / `.js--image-preview`
- Position URL `addons/certificate/position`
- Position page AJAX `addons/certificate/position/save` + `.certificate-text-position`

**Payment**

- Currency form `admin/payment_settings/system_currency`
- `#system_currency` `#currency_position` Select2
- Per-gateway form `admin/payment_settings`, hidden `name="identifier"`, `status`, `enabled_test_mode`, `currency`, and every JSON key input (including `theme_color` color input)
- Skip logic `is_addon` / `offline_payment` stays

**Language**

- Tabs `#edit` `#list` `#add_lang` `#import_language`
- `updatePhrase('{slug}', '{key}')` and button `id="btn-{slugify($key)}"`
- Edit `admin/manage_language/edit_phrase/{language}`
- Export `admin/export_language/{language}`
- Delete `confirm_modal('admin/manage_language/delete_language/{language}')`

**Notification + social**

- Tabs `#smtpSettings` `#emailTemplate` `#notification` and `$tab` active classes
- SMTP field ids unchanged; save `checkRequiredFields()`
- Pencil `showRightModal('admin/edit_email_template/{id}', ...)`
- Social form `admin/social_login_settings/update`, `fb_social_login` radios, `#fb_app_id` `#fb_app_secret`, `checkRequiredFields()`

**Custom pages**

- `#basic-datatable`, `tr.gradeU`
- Dropright edit `admin/edit_custom_page/{id}`, delete `confirm_modal('admin/custom_page/delete/{id}')`
- Add/edit `#summernote-basic`, `page_title`, `button_title`, `button_position`, `page_url`

**Home page builder (list only)**

- Tabs `#home-page-builder` `#pre-built-home-settings`
- Add tile `showAjaxModal('modal/popup/home_page_add')`
- Status `admin/home_page_builder/status/{id}`
- Open Builder `admin/home_page/builder/{id}`
- Edit `showAjaxModal('modal/popup/home_page_edit/{id}')`
- Delete `confirm_modal('admin/home_page_builder/delete/{id}')`
- Pre-built `appendMotivational_speech()` / `removeMotivational_speech(this)` / `removeFaq(this)`

**Data center**

- `#import_backup_data_form` `data_center/demo_importer`
- `#data_file` `onchange="changeTitleOfImageUploader(this)"`
- Import opens `#data-import-alert-modal` (defined in `modal.php` — restyle via existing DS modal tokens, do not change the id)
- Backup `data_center/create_backup_file`
- Download `data_center/download_zip_file/{dir}`
- Delete `confirm_modal('data_center/delete_dir/{dir}')`

**About**

- `showAjaxModal('admin/save_valid_purchase_code')`
- External support / renew / services hrefs stay

**Global**

- Confirm dialogs: keep `confirm_modal()`, `#alert-modal`, `#update_link`
- Compose mashed `get_phrase()` labels with spaces, or use an existing complete key. Do not invent new phrase keys.
- CSS only under `.gp-ds`
- Do not edit `application/views/backend/user/**`
- Do not commit unless the user asks

### 2.4 Sidebar parent active (CSS/class only)

Parent Settings `<li>` active list is incomplete. It includes `themes` (wrong — Themes is a sibling) and misses: `drip_content_settings`, `badges`, `certificate_settings`, `s3_settings`, `wasabi_settings`, `open_ai_settings`, `zoom_live_class_settings`, `bbb_live_class_settings`, `social_login`, `home_page_builder`.

**Phase 0 or 1:** add the missing `page_name`s to the parent `active` condition. Remove `themes` from that list. Do **not** change link order or labels. Put `active` on `<li class="side-nav-item active">`, never concatenate onto `side-nav-link`.

### 2.5 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-admin-settings.css` (new, shared)
- `application/views/backend/includes_top.php` — one `<link>` for that CSS
- `application/views/backend/admin/navigation.php` — parent `active` list only
- Token / hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Admin.php`, `common_scripts.php`, models, `hyper-admin-theme.css` repo-wide edits, payment controllers, builder JS, inventing addon views.

---

## 3. What to replace (component map)

| Leftover Hyper | Replace with | Notes |
|----------------|--------------|--------|
| Title `btn btn-outline-primary btn-rounded` | `gp_ds_button` `outline` | Compact. Keep href / target. |
| Leftover `.card` / `.card-body` / `h4.header-title` | `gp_ds_card` | Keep inner section titles as card `title` or body heading. |
| Leftover `btn-primary` / `btn-success` / `btn-info` / `btn-danger` / `btn-warning` / `btn-block` | `gp_ds_button` primary / outline / quiet | No leftover green/cyan/pink. Danger actions stay `confirm_modal` + outline/quiet, not a new red helper. |
| Leftover `nav-pills bg-nav-pills` / `nav-tabs nav-bordered` | Same markup + `gp-nav-tabs.css` / scoped tokens | Keep `href` + `data-toggle="tab"`. `#basicwizard` stays. |
| Leftover `alert-info` / `alert-danger` / `alert-success` / `alert-light` | `gp_ds_alert` | Keep the same copy. |
| Leftover `badge-*` / `badge-*-lighten` | `gp_ds_badge` | Status chips we own. |
| Leftover circular dropright | Scoped `.btn-icon` → DS 30×30 / 8px radius | Do not remove the dropdown. |
| Leftover `#basic-datatable` | Keep id; wrap with `gp_ds_table` **or** leftover table + token CSS. Map pager in `gp-pagination.css` | Do not edit DataTables JS. |
| Leftover Select2 / tagsinput / timepicker / custom-file | Token restyle under `.gp-settings-page` | Keep `data-role="tagsinput"`, `data-toggle="select2"`, `data-toggle="timepicker"`. |
| Leftover hex `#a7a4a4` `#F5F5F5` `#343a40` `#1b84ff` | `--gp-*` | Help links use `--gp-text-muted` / `--gp-link`. |
| Home builder dashed `#1b84ff` tile | DS dashed empty/add tile using `--gp-border` + `--gp-accent` | Keep `showAjaxModal` onclick. |
| Confirm / import / right / ajax modals | Existing DS modal tokens | Keep `confirm_modal`, `showAjaxModal`, `showRightModal`, `#data-import-alert-modal`. |

Do not invent a new helper. Button variants only: `primary`, `secondary`, `outline`, `quiet`.

---

## 4. Layout (per page type)

**Simple form + help column (system, drip, payment, social)**  
Page title → keep the existing two-column grid (form card wider, help / updater / alert narrower). Do not stack on desktop.

**Single form card (SEO, Wasabi, BBB, Open AI, add/edit custom page)**  
Page title (+ back outline on add/edit) → one medium card.

**Tabbed settings (website, badges, notification, language, home list)**  
Page title → one full-width card → restyled leftover tabs → tab panes. Do not flatten tabs into one scrolling form.

**List + DataTable (custom pages)**  
Page title + add outline → one card → keep `#basic-datatable`.

**Two equal cards (sitemap, data center)**  
Page title → existing `col-xl-6` + `col-xl-6`.

**About**  
Page title → one definition-style card. Keep every row and external link.

**Modals / right drawer**  
Keep the form fields. Restyle buttons / inputs only.

---

## 5. Shared visual language

- Wrapper: `.gp-settings-page` on every in-scope admin-shell view
- Page title: `gp_ds_page_title`
- Cards: `gp_ds_card` with `extra_class` `gp-dash-panel` when the page already uses that pattern
- Buttons: `gp_ds_button`; compact
- Badges / alerts: `gp_ds_badge` / `gp_ds_alert`
- Tables: leftover DataTables ids stay; static tables may use `gp_ds_table` when there is no DataTables id
- Help / API links: `color: var(--gp-fg-muted)` and `color: var(--gp-primary)`. Do **not** use `--gp-text-muted` or `--gp-link` — those tokens do not exist.

New CSS file: `assets/design-system/gp-admin-settings.css`  
Cache query: bump `?v=settings-N` in `includes_top.php` each phase that changes it.

### 5.1 Light / Dark (design-system HTML)

Source: `geeseprojdesignsystem.html` `:root` (light) and `:root[data-theme="dark"]` / `prefers-color-scheme`. LMS copies those hex values onto `--gp-*` in `gp-tokens.css`. Admin shell toggle is `data-theme="light|dark|system"` on `.gp-ds`. Leftover widgets (Select2, file inputs, `#basicwizard` scroll buttons) already flip in `gp-dark-surfaces.css`. Do not invent a second Settings dark theme.

**Write Settings CSS as `var(--gp-*)` only.** No hardcoded `#111015`, `#FBFAF7`, `#fff`, `#1b84ff`, or leftover Hyper hex. Brand `--gp-primary` / `--gp-secondary` / `--gp-accent` stay the same in both modes. Surfaces, text, borders, shadows, and semantic success / warning / danger / info change.

| Role | Use this token | Light | Dark |
|------|----------------|-------|------|
| Page | `--gp-bg` | `#FBFAF7` | `#111015` |
| Card | `--gp-surface` | `#ffffff` | `#17161c` |
| Preview / sunk | `--gp-surface-sunk` | `#F3F1EB` | `#0c0c10` |
| Text | `--gp-fg` | `#171613` | `#EDEBE6` |
| Help / muted | `--gp-fg-muted` | `#6B6B65` | `#A7A4B0` |
| Faint | `--gp-fg-faint` | `#9C988D` | `#726f7c` |
| Border | `--gp-border` | `#E4E1D8` | `#2b2a32` |
| Strong border | `--gp-border-strong` | `#CFCBBE` | `#3c3a45` |

Leftover hex map on Settings pages:

| Leftover | Token |
|----------|--------|
| `#a7a4a4` / `#343a40` help links | `--gp-fg-muted` (hover `--gp-fg`) |
| `#F5F5F5` watermark / certificate preview | `--gp-surface-sunk` |
| `#1b84ff` / `#1b84ff29` home-builder tile | `--gp-primary` + `--gp-border` |
| Leftover `alert-*` / `badge-*-lighten` | `gp_ds_alert` / `gp_ds_badge` (they already use `--gp-*-soft`) |

**Visual check** means toggle Light and Dark on the live page, not only the PHP. A leftover hex that looks fine in Light is a Phase fail.

If custom pages (or any Settings table) uses leftover DataTables pager, add `.gp-settings-page` to the existing `gp-pagination.css` §15 selector list (same as Contact / Blog). Do not reintroduce Hyper circular pager.

---

## 6. Phases

Stop after each phase for a visual check (Light + Dark). Do not start the next phase until the user confirms.

### Phase 0 — Lock CSS + parent active

**Files**

- Create: `assets/design-system/gp-admin-settings.css`
- Modify: `application/views/backend/includes_top.php` (link after `gp-admin-profile.css`)
- Modify: `application/views/backend/admin/navigation.php` (parent `active` list only)

**Do**

- File header listing in-scope `page_name` values and forbidden hooks
- Empty scoped section `.gp-ds .gp-settings-page { }` plus compact-button, form, tabs, dropright-as-icon-btn, tagsinput, alert, and DataTables token rules ready for later phases
- Fix Settings parent `active` (add missing page names; drop `themes`)
- Prove the CSS 404s not (view-source `/admin/system_settings` contains `gp-admin-settings.css`)

**Do not** change any Settings view yet (except the nav `active` list).

### Phase 1 — System + Website settings

**Files:** `system_settings.php`, `frontend_settings.php`, `review_add.php`, `review_edit.php`, `gp-admin-settings.css`

**Do**

- Wrap in `.gp-settings-page`
- System: two `gp_ds_card`s; keep tagsinput, Select2, radios, `checkRequiredFields`, updater `#file_name`
- Website: keep `#basicwizard` and all 8 tab hrefs + scroll buttons; replace leftover buttons / FAQ plus-minus / review dropright
- Review modals: leftover submit → `gp_ds_button`; keep Select2 ids

**Test:** Save system settings; upload updater file picker still labels; every Website tab still switches; FAQ add/remove; logo uploads; review add/edit/delete; Light + Dark

### Phase 2 — Drip + SEO + Sitemap + Wasabi

**Files:** `drip_content_settings.php`, `seo_settings.php`, `sitemap_settings.php`, `wasabi_settings.php`

**Do**

- Form cards + `gp_ds_alert` for drip help
- Keep timepicker / percentage toggle
- Sitemap title action = outline `gp_ds_button` to `sitemap.xml`
- Wasabi leftover save → primary

**Test:** Drip radio still shows the matching field; SEO tagsinput still chips; sitemap links open; Wasabi save still posts

### Phase 3 — Badges

**Files:** `badges.php`, `badges_add.php`, `badges_edit.php`

**Do**

- Keep `#badgeTabs` / tab hrefs / Certificate tab `addon_status`
- Add Badges = outline `gp_ds_button` with the existing `showAjaxModal` href
- Circular dropright → DS icon-btn; keep edit / delete hooks
- Modal create / update → `gp_ds_button`

**Test:** Each tab; add/edit modal submits; delete confirm; Certificate tab only when addon on

### Phase 4 — Payment settings

**Files:** `payment_settings.php`

**Do**

- Keep the two-column layout (forms left, heads-up alert right)
- One `gp_ds_card` per existing card (currency + each visible gateway)
- Keep the gateway foreach skip logic, hidden `identifier`, Select2, color input
- Leftover `alert-info` → `gp_ds_alert`

**Test:** Currency save; at least one gateway save; test-mode / status selects; color input still submits

### Phase 5 — Language settings

**Files:** `manage_language.php`

**Do**

- Keep leftover tabs and `#edit` pane when `$edit_profile` is set
- Phrase row save keeps `id="btn-{slug}"` `onclick="updatePhrase(...)"`
- List row leftover info/success/danger → outline / primary / quiet + `confirm_modal`
- Import leftover → primary

**Test:** Phrase tick still updates; add language; import; export download; delete confirm

### Phase 6 — Notification + Social login

**Files:** `notification_settings.php`, `edit_email_template.php`, `social_login.php`

**Do**

- Keep notification tab hrefs and `$tab` active classes
- Pencil stays `showRightModal`; restyle as DS icon-btn
- Email template leftover save → primary; keep `initSummerNote(['textarea'])`
- Social leftover danger → `gp_ds_alert`; keep radios + `checkRequiredFields`

**Test:** SMTP save; open/save email template drawer; notification tab; Facebook save; HTTPS alert still shows on non-https

### Phase 7 — Custom pages

**Files:** `custom_page.php`, `add_custom_page.php`, `edit_custom_page.php`

**Do**

- Title add = outline `gp_ds_button` to `admin/add_custom_page`
- Keep `#basic-datatable` + dropright edit/delete
- Add/edit: `gp_ds_card`; leftover success → primary; keep `#summernote-basic` and URL input-group prefix
- Map leftover pager in `gp-pagination.css` if DataTables chrome shows

**Test:** DataTables search/sort/page; add page; edit Summernote; delete confirm

### Phase 8 — Data center + About

**Files:** `data_center.php`, `about.php`

**Do**

- Data center: two cards; leftover import / backup → `gp_ds_button` (no raw icon in the helper label)
- Keep `#data-import-alert-modal` show call and backup download/delete URLs
- Leftover alerts → `gp_ds_alert`
- About: leftover badges → `gp_ds_badge`; leftover hex links → tokens; leftover buttons → `gp_ds_button`; keep `showAjaxModal` purchase code

**Test:** Import modal still opens; backup create/download/delete; About purchase-code modal; external links

### Phase 9 — Addon-gated + BBB + Open AI

**Files:** `certificate_settings.php`, `certificate_text_position.php` (chrome only), `open_ai_settings.php`, `bbb_live_class_settings.php`  
**If installed:** S3 / Zoom / Jitsi addon settings views (do not invent)

**Do**

- Certificate leftover save / preview hex / position link → DS
- Position page: token the standalone chrome; do not rewrite drag-drop JS
- Open AI: wrap stub in `.gp-settings-page` only
- BBB leftover success → primary

**Test:** Certificate save + preview still shows template; position page still drags/saves; BBB save; Open AI still shows addon / not-found copy

### Phase 10 — Home page builder list (last)

**Files:** `home_page_builder.php`, `home_page_add.php`, `home_page_edit.php`

**Do**

- Keep leftover tabs and every status / builder / edit / delete URL
- Replace `#1b84ff` dashed tile with DS tokens; keep `showAjaxModal`
- Leftover badges / outline-info / outline-danger → `gp_ds_badge` / `gp_ds_button`
- Pre-built plus/minus keep `appendMotivational_speech` / `removeMotivational_speech` / `removeFaq`
- Modals: leftover success → primary; keep `#summernote-basic` init

**Do not** restyle `home_page_builder/index.php` (canvas) in this phase.

**Test:** Add modal; Open Builder still loads the canvas; status toggle; edit; delete confirm; pre-built save

---

## 7. Done when

- Every live Settings sidebar page (except missing addon packages) uses `.gp-settings-page` + DS helpers / token restyles
- No leftover Hyper cyan/pink/green buttons, circular dropright, leftover hex, or leftover `alert-*` / `badge-*-lighten` on those pages
- All hooks in §2.3 still work
- Settings parent nav highlights on every in-scope `page_name`
- Light + Dark checked per phase
- Home canvas and Academy Cloud untouched unless the user asks
