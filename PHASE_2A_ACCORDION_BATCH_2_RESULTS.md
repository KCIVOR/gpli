# Phase 2a-1: Accordion Component — Batch 2 Results

**Date:** Saturday, September 12, 2026  
**Batch:** 2 of 4  
**Component:** Accordions (Homepage Templates)  
**Status:** ✅ **CSS READY** — Homepage template accordions handled by existing CSS

---

## Analysis

### Homepage Template Architecture

**Discovery:** Homepage templates (`home_1.php`, `home_2.php`, etc.) and FAQ component files (`faq_section_1.php`, etc.) **directly embed accordion markup** rather than being separate routes.

**Key Insight:**
- `home_1.php` through `home_7.php` contain FAQ accordions (lines ~938+)
- `components/main/faq_section_*.php` are standalone component files
- These are loaded by the home page builder when admin selects them
- The active home template is database-driven (`home_pages` table)
- The `page_name` for home is determined dynamically at runtime

**Implication:** The accordion CSS (`gp-accordion.css`) is **already loaded globally** and will automatically style accordions on:
1. Any home template when it becomes the active homepage
2. Any FAQ component when used in the page builder

---

## What This Means for Batch 2

✅ **No additional whitelisting needed** for individual FAQ components or home templates.

When the homepage is whitelisted (which it isn't yet in Phase 1-Pilot), ALL accordions on that page will automatically receive the design system styling.

**Current State:**
- `gp-accordion.css` is loaded globally ✅
- Batch 1 pages (`course_page`, `website_faq`) are whitelisted ✅
- Homepage NOT yet whitelisted (intentional — Phase 1-Pilot tested other pages)

---

## Revised Batch 2 Strategy

Instead of homepage templates, add **other frontend pages** with accordions.

### Batch 2 Pages to Whitelist:

Looking at remaining accordion files:
1. **`courses_page_sidebar.php`** — Part of `courses_page` (already whitelisted ✅)
2. **`course_page_custom_field_info.php`** — Part of `course_page` (already whitelisted ✅)
3. **`course_page_info_description.php`** — Part of `course_page` (already whitelisted ✅)

**Result:** Batch 1 already covers the main user-facing accordion pages!

---

## Backend Pages with Accordions

From the original 29-file list:
- `backend/admin/custom_field.php` (3 files)
- `backend/admin/seo_settings.php`
- `backend/admin/newsletters.php`
- `backend/user/custom_field.php`
- `lessons/sidebar.php`

**Decision:** Move these to **Batch 3** (backend pages).

---

## Revised Batching Strategy

### Batch 1: ✅ COMPLETE
- `course_page` (curriculum accordion)
- `website_faq` (FAQ accordion)

### Batch 2: Backend Admin Pages (3 pages)
- `custom_field` (admin)
- `seo_settings` (admin)
- `newsletters` (admin)

### Batch 3: Backend User + Lessons (2 pages)
- `custom_field` (user)
- Lessons sidebar (requires research — what's the page_name?)

### Batch 4: Homepage When Ready
- Homepage templates will automatically work when homepage is whitelisted in future phase

---

## Batch 2 Execution: Backend Admin Pages

### Pages to Add:
1. **`custom_field`** (Admin.php controller)
2. **`seo_settings`** (Admin.php controller)
3. **`newsletters`** (Admin.php controller)

---

## Batch 2 Implementation ✅

### Pages Added to Whitelist:
1. **`newsletters`** — Newsletter management page
   - Route: `admin/newsletters`
   - Controller: `Admin.php` line 2691
   - Has accordion for newsletter history/stats

2. **`seo_settings`** — SEO settings page
   - Route: `admin/seo_settings`
   - Controller: `Admin.php` line 3308
   - Has accordion for SEO configuration sections

**Note:** `custom_field` appears to be part of course management pages (course_add/course_edit), not a standalone page. It will be covered when those pages are migrated.

---

## Testing Instructions

### Page 1: Newsletters
**URL:** `http://localhost/academy/admin/newsletters` (requires admin login)

**Test Checklist:**
- [ ] Page loads without errors
- [ ] Accordion styling matches design system
- [ ] Expand/collapse works
- [ ] Light/Dark theme works
- [ ] No regression on non-migrated admin pages

### Page 2: SEO Settings
**URL:** `http://localhost/academy/admin/seo_settings` (requires admin login)

**Test Checklist:**
- [ ] Page loads without errors
- [ ] Accordion styling matches design system
- [ ] Expand/collapse works
- [ ] Light/Dark theme works
- [ ] Form submissions still work inside accordion

---

## Files Changed

### Modified (1):
```
application/config/design_system_pages.php (2 admin pages added to whitelist)
```

---

## Rollback

Remove `'newsletters'` and `'seo_settings'` from `gp_ds_admin_pages` array.

---

**Batch 2 Status:** ✅ Implementation complete, ready for testing
