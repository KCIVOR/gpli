# Admin Report Redesign — Implementation Plan

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. Implement one phase at a time with spec + quality review. Do not skip the constraints in §2.

**Goal:** Restyle every live admin page under the Report sidebar using Geese Project tokens and existing `gp_ds_*` helpers, without changing revenue, payout, purchase, or DataTables logic.

**Architecture:** UI-only pass, same pattern as admin Courses. Shared chrome lives in `assets/design-system/gp-admin-report.css` scoped under `.gp-ds`. Leftover Hyper markup is restructured; PHP queries, form `action`/`name`/`id`, and JS hooks stay. Do not remove features, actions, fields, buttons, dialogs, filters, or flows — restyle them in place.

**Tech stack:** CodeIgniter 3 views, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge`, `--gp-*` tokens, leftover Hyper + DataTables + daterangepicker (hooks preserved).

**Source of truth:** `geeseprojdesignsystem.html` (cards §06, forms §07, tables §14, badges §12). Courses reference: `application/views/backend/admin/coupons.php` + `assets/design-system/gp-admin-courses.css`.

---

## 1. Audit — page inventory

Audited from `application/views/backend/admin/navigation.php` (Report menu, `has_permission('revenue')`), `Admin.php` `page_name` assignments, and the views those routes load.

### 1.1 Live sidebar pages (in scope)

| # | Nav label | URL | View | Current UI |
|---|-----------|-----|------|------------|
| 1 | Admin revenue | `/admin/admin_revenue` | `application/views/backend/admin/admin_revenue.php` | `gp_ds_page_title` + leftover Hyper card, `#reportrange` GET filter, leftover `btn-info` `#submit-button`, `#basic-datatable` |
| 2 | Instructor revenue | `/admin/instructor_revenue` | `application/views/backend/admin/instructor_revenue.php` | Same leftover card + `#basic-datatable`. Hidden when `allow_instructor != 1` |
| 3 | Purchase history | `/admin/purchase_history` | `application/views/backend/admin/purchase_history.php` | `gp_ds_page_title` + leftover card + `#basic-datatable` |

### 1.2 Reached while Report stays active (in scope)

| # | Surface | URL | View | Why |
|---|---------|-----|------|-----|
| 4 | Invoice | `/admin/invoice/{payout_id}` | `application/views/backend/admin/invoice.php` | Report nav marks `invoice` active. Printable payout invoice (logo, status badge, print button). Linked from Users → instructor payout, not from the three Report lists. |

### 1.3 Out of this plan unless requested

| View | Why excluded |
|------|----------------|
| `instructor_payout.php` | Lives under Users, not Report |
| `application/views/backend/user/payout_report.php`, `sales_report.php`, `invoice.php` | Instructor copies |
| Ebook / bootcamp / bundle / team-training addon report pages | Other sidebar menus |
| `enrol_history.php` | Enrolment menu, not Report |

---

## 2. Constraints (every phase)

### 2.1 UI only — restyle, do not remove

Never modify:

- Controllers (`Admin.php` methods: `admin_revenue`, `instructor_revenue`, `purchase_history`, `invoice`)
- Models, queries, schema, `get_revenue_by_user_type`, `purchase_history()`, `get_payouts`
- Routes, URLs, GET `date_range` format (`d F, Y - d F, Y`)
- Auth / `check_permission('revenue')` / `has_permission('revenue')`
- Payment / payout / currency math
- DataTables JS in `common_scripts.php`

Do not remove the date filter, Filter button, table columns, coupon badges, course/user links, print button, invoice fields, or instructor-revenue `$payment_keys` / `$paypal_keys` / `$stripe_keys` / `$razorpay_keys` assignments (keep even if unused in markup).

If a visual change appears to need a logic change or a removal: **stop** and report it.

### 2.2 Hooks that must stay

**Admin revenue**

- Form `action="<?php echo site_url('admin/admin_revenue/filter_by_date_range') ?>"` `method="get"`
- `#reportrange` with `data-toggle="date-picker-range"` `data-target-display="#selectedValue"` `data-cancel-class="btn-light"`
- `#selectedValue` span (daterangepicker writes the label here)
- `#date_range` `name="date_range"` hidden input
- `#submit-button` + `onclick="update_date_range();"`
- `function update_date_range()` (copies `#selectedValue` into `#date_range`)
- `#basic-datatable`, `tr.gradeU`
- Course edit links `admin/course_form/course_edit/{id}`

**Instructor revenue**

- `#basic-datatable`, `tr.gradeU`
- Public course links `home/course/{slug}/{id}`
- Enrolment-date line and coupon badge block

**Purchase history**

- `#basic-datatable`, `tr.gradeU`
- Public course links `home/course/{slug}/{id}`
- User name + email badge, paid amount (`amount+tax`), payment type, purchased date

**Invoice**

- `$payout_id` usage unchanged
- Status badges for paid / unpaid
- Print control: `javascript:window.print()` and `.d-print-none`
- All existing fields: requested date, withdrawal request id, instructor/admin details, type, amounts, subtotal

**Global**

- `gp_ds_*` for new title/card/button/badge markup
- CSS only under `.gp-ds`
- Compose mashed labels with `' ' . get_phrase('word')` or an existing complete key. Do not invent new phrase keys.
- Do not edit `application/views/backend/user/**`
- Do not commit unless the user asks

### 2.3 Allowed file types

- Views listed in the phase
- `assets/design-system/gp-admin-report.css` (new, shared)
- `application/views/backend/includes_top.php` — one `<link>` for that CSS
- Optional: `gp-admin-shell.css` word-spacing on `.side-nav-second-level a` so Report submenu labels do not mash (no nav markup change)
- Token/hex values only from `gp-tokens.css` / `geeseprojdesignsystem.html`

Forbidden: `Admin.php`, `common_scripts.php`, models, `hyper-admin-theme.css` repo-wide edits.

---

## 3. Shared visual language

- Page title: `gp_ds_page_title`
- Cards: `gp_ds_card` with `gp-dash-panel`
- Filter: compact toolbar card; leftover daterangepicker kept, restyled
- Buttons: `gp_ds_button` variants only; compact 8px 14px / 38px min-height
- Badges: `gp_ds_badge` (`success` / `danger` / `neutral`) where a leftover Hyper badge is a status chip. Keep coupon tag icon if already present.
- Tables: leftover `#basic-datatable` markup; do **not** wrap in `gp_ds_table` (DataTables owns that id)
- Invoice: surface card, token borders, compact print button

New CSS file: `assets/design-system/gp-admin-report.css`  
Cache query: bump `?v=report-N` in `includes_top.php` each phase that changes it.

---

## 4. Phases

### Phase 0 — Lock CSS + constraints

**Files**

- Create: `assets/design-system/gp-admin-report.css`
- Modify: `application/views/backend/includes_top.php` (link after `gp-admin-courses.css`)
- Modify: `assets/design-system/gp-admin-shell.css` — `word-spacing: 0.2em` on `.side-nav-second-level a` / `.side-nav-third-level a`; bump `?v=admin-shell-8` → `admin-shell-9`

**Do**

- File header listing in-scope `page_name` values and forbidden hooks
- Empty scoped section `.gp-ds .gp-report-page { }` plus compact-button, toolbar, date-range, table, invoice, word-spacing rules ready for later phases
- Prove the CSS 404s not (view-source `/admin/admin_revenue` contains `gp-admin-report.css`)

**Do not** change any report view yet.

### Phase 1 — Admin revenue

**Files:** `admin_revenue.php`, `gp-admin-report.css` (tweak only if needed)

**Do**

- Wrap content in `.gp-report-page`
- Keep page title. Card via `gp_ds_card` with existing `admin_revenue` title (do not drop the inner heading)
- Filter toolbar: leftover `#reportrange` + hidden `#date_range` + `update_date_range`. Filter control becomes `gp_ds_button` (`type=submit`, `id=submit-button`, `onclick=update_date_range()`)
- Table stays `#basic-datatable`. Coupon leftover badge → `gp_ds_badge` tone `success` (keep tag icon)

**Test:** date picker still fills `#selectedValue`; Filter still GETs `date_range`; DataTables search/sort/page; course edit links; Light + Dark

### Phase 2 — Instructor revenue

**Files:** `instructor_revenue.php`

**Do**

- Same card + `#basic-datatable` wrap as Phase 1
- Keep `$payment_keys` / gateway key assignments
- Keep public course links, enrolment date, coupon badge

**Test:** table still initializes; course links open public course; Light + Dark

### Phase 3 — Purchase history

**Files:** `purchase_history.php`

**Do**

- Same card + `#basic-datatable` wrap
- Keep user/email, course link, `amount+tax`, payment type, date
- Email stays leftover `badge badge-light` (DS badges are uppercase and would mangle an address). Restyle via `.gp-report-page .badge-light` tokens only.

**Test:** DataTables still works; course links; Light + Dark

### Phase 4 — Invoice

**Files:** `invoice.php`, `gp-admin-report.css`

**Do**

- Wrap in `.gp-report-page.gp-report-invoice`
- Keep logo, all detail fields, amounts table, subtotal
- Paid/unpaid → `gp_ds_badge` (`success` / `danger`)
- Print stays `javascript:window.print()` inside `.d-print-none` (may use `gp_ds_button` with that href; keep printer icon)

**Test:** open from `/admin/invoice/{existing_payout_id}` or payouts print icon; Print still opens the browser dialog; no fields missing; Light + Dark

---

## 5. Close-out

- Hard-refresh all four URLs
- Confirm leftover Hyper cyan Filter / pink-cyan confirm is gone on these pages
- Confirm Report submenu still lists the same three items
- Do not commit unless asked
