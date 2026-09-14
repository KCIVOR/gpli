# Phase 5 Completion Report — Broken Routes & Extended Surfaces

**Date:** Saturday, September 12, 2026  
**Status:** Partial complete — determined work implemented; six routes and the installer need your decision  
**Constraints honored:** UI-only. No payment/enrollment/auth logic changes. Phase 4 Bootstrap 5 admin work left intact. `gp-theme-toggle.js` default remains `light`.

---

## 5a — Broken routes (10)

Inspected each controller method. Added a **minimal** view only when `$page_data` / existing view patterns already defined the content. Did not invent forms, queries, or actions.

| Route | Controller signal | Decision | Status |
|---|---|---|---|
| `cookie_policy` (Home.php:1108) | `page_name` / `page_title` only; `get_frontend_settings('cookie_policy')` already used by `frontend_settings` and matches `privacy_policy` / `refund_policy` | New view mirrors those policy pages | **Done + whitelisted** |
| `update_user_photo` (Home.php:445) | `$user_details` from `get_user()`; `update_profile/update_photo` already posts `user_image` | Photo-only page using that existing form action/field | **Done + whitelisted** |
| `lessons` (Admin.php:1308) | `$lessons` query + `$course_id` + title | Minimal table of title / lesson_type / duration | **Done + whitelisted** |
| `lessons` (User.php:460) | Same as admin | Same minimal table | **Done + whitelisted** |
| `my_notifications` (Home.php:390) | Title only. Notifications are loaded by `get_my_notification()` into the header dropdown (`notifications.php`), not this page | **cannot be determined — needs user decision** | Skipped |
| `instructor_dashboard` (Home.php:1116) | `$type` (`active` or URL param) + `$user_id`. No course query. Live instructor dashboard is backend `User.php` | **cannot be determined — needs user decision** | Skipped |
| `create_course` (Home.php:1134) | Title only. POST handler is `course_action`; live create UI is backend `course_add` | **cannot be determined — needs user decision** | Skipped |
| `manage_course_details` (Home.php:1145) | `$course_id` + `$type` only. No course row loaded. Live editor is backend `course_edit` | **cannot be determined — needs user decision** | Skipped |
| `lesson_edit` (Home.php:1233) | `$lesson_id` + `$course_id` + `$type`. No lesson row. Live editor is backend modal `lesson_edit` | **cannot be determined — needs user decision** | Skipped |
| `open_ai_settings` (Admin.php:2365) | Title only. Update calls missing addon `addons/ai_model` (not in this repo) | **cannot be determined — needs user decision** | Skipped |

### Files added (5a)

- `application/views/frontend/default-new/cookie_policy.php`
- `application/views/frontend/default-new/update_user_photo.php`
- `application/views/backend/admin/lessons.php`
- `application/views/backend/user/lessons.php`

### Verification (5a)

- `http://localhost/academy/home/cookie_policy` → **200**, `.gp-ds` present, policy body rendered.
- Homepage and cookie page load `gp-homepage-builder.css` / `gp-carousel.css` via shared `includes_top` (expected).
- Admin/user `lessons` and `update_user_photo` require login; not browser-verified here.

---

## 5b — `payment-global/` (20 files)

**Visual wrapper only.** No gateway SDK form fields, names, actions, or required markup were changed.

| File group | Action |
|---|---|
| `index.php` | Added `class="gp-ds" data-theme="light"` on `<body>` |
| `includes_top.php` | Loaded tokens/base/core + `gp-payment.css` (Stripe script left in place) |
| `payment_gateway.php` | Chrome styled via CSS only (header, close button, totals, gateway cards, pay button). JS hooks `.payment-gateway`, `.gateway`, `.tick-icon` unchanged |
| 15 `*/payment_form.php` files | **Untouched** |
| `includes_bottom.php`, `go_back_to_mobile_app.php` | Untouched |

**Gateway conflict:** none found. Stop condition in §11 (third-party payment SDK markup) was respected by leaving every `payment_form.php` alone.

### Files added/changed (5b)

- Added `assets/design-system/gp-payment.css`
- Modified `application/views/payment-global/index.php`
- Modified `application/views/payment-global/includes_top.php`

Checkout itself was not exercised (needs a cart + login + payment session).

---

## 5c — `email/` (2 files)

Cannot use linked `.gp-ds` CSS. Both templates were hand-translated to **inlined, table-based** colors/type from the hard-rule file.

| Token | Value used |
|---|---|
| `--bg` | `#FBFAF7` |
| `--surface` | `#ffffff` |
| `--border` | `#E4E1D8` |
| `--fg` | `#171613` |
| `--fg-muted` | `#6B6B65` |
| `--fg-faint` | `#9C988D` |
| `--font-head` | Manrope, Arial, sans-serif |
| `--font-body` | Inter, Arial, sans-serif |

PHP variables, replace loop, logo path, and hidden `system_notification_start` / `system_notification_end` trackers are unchanged.

### Files changed (5c)

- `application/views/email/common_template.php`
- `application/views/email/static_common_template.php`

**Stop condition / leftover:** plan §8 Phase 5c asks for a send-test in at least one real email client. That was **not** run (no mailer send from this session). Browser/HTML preview only.

---

## 5d — `components/main/` (105 homepage-builder templates)

Styled as shared partials with **CSS-only** `.gp-ds` overrides. Builder PHP, `builder-identity` attributes, and JS hook classes (`.lms2-reviewSlider`, `.lms3-reviewSlider-*`, `.checkPropagation`, `.owl-carousel`) were not rewritten.

Carousel **is** used here, but it is **Owl Carousel** (`top_instructors_3.php`) and **Slick** (`reviews_section_language.php`), not Bootstrap `.carousel`. `gp-carousel.css` was created from hard-rule §24 (navy gradient + 7px dots) and loaded the same way as other `gp-*.css` files in both `includes_top.php` files. Dots/nav chrome only; slider JS untouched.

Homepage `page_name`s (`home_builder` and permanent `home_*` variants) were whitelisted so `.gp-ds` applies on the live home.

### Files added/changed (5d)

- Added `assets/design-system/gp-homepage-builder.css`
- Added `assets/design-system/gp-carousel.css`
- Modified `application/views/frontend/default-new/includes_top.php`
- Modified `application/views/backend/includes_top.php` (carousel CSS only, same load pattern)
- Modified `application/config/design_system_pages.php` (home + 5a entries)

### Verification (5d)

- `http://localhost/academy/` → **200**, `.gp-ds` present, `gp-homepage-builder.css` and `gp-carousel.css` linked.

---

## 5e — `install/` (11 files)

**Skipped — too risky for a visual-only pass.**

The installer writes `application/config/database.php` and `routes.php`, loads the old Hyper/`app.min.js` + Bootstrap 4 DataTables stack, and uses a hardcoded setup header. Adding `.gp-ds` plus current design-system CSS would restyle setup forms and could hide permission/diagnosis states. Per your instruction: if risky, document and skip.

No install files were changed.

---

## Stop conditions hit

| §11 condition | Where |
|---|---|
| Broken route content cannot be determined from the code | 5a: `my_notifications`, `instructor_dashboard`, `create_course`, `manage_course_details`, `lesson_edit`, `open_ai_settings` |
| Correct behavior UNKNOWN — do not guess | Same six routes; OpenAI addon model missing |
| Third-party plugin required markup | 5b: all 15 gateway `payment_form.php` files left untouched |
| Installer / setup risk (lowest priority) | 5e skipped |
| Email client send-test not possible here | 5c leftover |

No backend/auth/payment logic was changed. No Bootstrap JS was removed. `gp-theme-toggle.js` was not edited.

---

## User decisions needed

1. **`my_notifications`** — Build a full-page list by copying the header dropdown query in `notifications.php`, or leave notifications header-only?
2. **`instructor_dashboard` / `create_course` / `manage_course_details` / `lesson_edit`** — These look like leftovers from an old frontend instructor portal. Redirect each to the live backend `User.php` equivalents (`dashboard`, `course_add`, `course_edit`, curriculum modal), or keep them 404 until you specify the UI?
3. **`open_ai_settings`** — The `addons/ai_model` addon is not in this repo. Provide the addon (or the intended fields) before a settings form can be built.
4. **Email send-test** — Confirm `common_template.php` / `static_common_template.php` in Gmail and Outlook (or your actual transactional mailer).
5. **`install/`** — Approve a scoped visual pass on the installer, or leave it on the legacy setup theme permanently?

---

## Files changed (summary)

**Added**

- `application/views/frontend/default-new/cookie_policy.php`
- `application/views/frontend/default-new/update_user_photo.php`
- `application/views/backend/admin/lessons.php`
- `application/views/backend/user/lessons.php`
- `assets/design-system/gp-payment.css`
- `assets/design-system/gp-homepage-builder.css`
- `assets/design-system/gp-carousel.css`
- `PHASE_5_COMPLETION_REPORT.md`

**Modified**

- `application/config/design_system_pages.php`
- `application/views/frontend/default-new/includes_top.php`
- `application/views/backend/includes_top.php`
- `application/views/payment-global/index.php`
- `application/views/payment-global/includes_top.php`
- `application/views/email/common_template.php`
- `application/views/email/static_common_template.php`

**Explicitly not changed**

- All 15 `application/views/payment-global/*/payment_form.php`
- `application/views/payment-global/payment_gateway.php` (chrome via CSS only)
- `assets/design-system/gp-theme-toggle.js`
- Phase 4 admin Bootstrap 5 bridge/theme files
- All 105 `application/views/components/main/*.php` builder templates
- All 11 `application/views/install/**` files
