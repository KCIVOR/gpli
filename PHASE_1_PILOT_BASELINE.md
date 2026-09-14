# Phase 1-Pilot — Baseline Documentation

**Date:** Saturday, September 12, 2026  
**Status:** BASELINE CAPTURED — Ready for Migration  

---

## Selected Pages for Pilot

### 1. Frontend: `courses_page`
**File:** `application/views/frontend/default-new/courses_page.php`  
**Route:** `home/courses` (via Home.php controller)  
**Controller Method:** Home.php → `courses()` (assumed)

#### Components Present (Before Migration):
- ✓ Breadcrumb navigation
- ✓ Sidebar filters (category, price, level, language, rating)
- ✓ Course cards (grid/list layout toggle)
- ✓ Badges (course level, rating, H5P/SCORM indicators)
- ✓ "Not Found" empty state with SVG
- ✓ Form elements (filter inputs)
- ✓ Dropdown selects (sorting)

#### Interactive Elements:
- `$('#course_filter_form').submit()` - Form submission
- `$('#sorting_select_input').val()` - Sorting dropdown
- Layout toggle (grid vs list) - via included layout file
- Sidebar collapse/expand (Show More/Less buttons)

#### Page Structure:
```
<section class="grid-view courses-list-view">
  <div class="container">
    <div class="row">
      <div class="col-lg-3"> <!-- Sidebar -->
      <div class="col-lg-9"> <!-- Main content -->
```

---

### 2. Admin: `categories`
**File:** `application/views/backend/admin/categories.php`  
**Route:** `admin/categories` (via Admin.php controller)  
**Controller Method:** Admin.php → `categories()` (assumed)

#### Components Present (Before Migration):
- ✓ Page header card with title
- ✓ Action button "Add new category" (btn-outline-primary)
- ✓ Category cards with thumbnail images
- ✓ List groups (sub-categories)
- ✓ Hover-action buttons (Edit/Delete)
- ✓ Icons (FontAwesome classes)
- ✓ Badge-like counters ("X sub_categories")

#### Interactive Elements:
- `.on-hover-action` - jQuery mouseenter/mouseleave
- `$('#category-delete-btn-' + id).show()` - Show/hide delete button
- `$('#category-edit-btn-' + id).show()` - Show/hide edit button
- `confirm_modal()` - Delete confirmation (global JS function)

#### Page Structure:
```
<div class="row">
  <div class="col-xl-12">
    <div class="card"> <!-- Header card -->
  
<div class="row">
  <?php foreach ($categories): ?>
    <div class="col-md-6 col-lg-6 col-xl-4">
      <div class="card d-block">
        <img class="card-img-top">
        <div class="card-body">
        <ul class="list-group">
```

#### Known JS Hook Classes:
- `.on-hover-action` - DO NOT REMOVE (used by jQuery)

---

### 3. User/Instructor: `dashboard`
**File:** `application/views/backend/user/dashboard.php`  
**Route:** `user/dashboard` (via User.php controller)  
**Controller Method:** User.php → `dashboard()` (assumed)

#### Components Present (Before Migration):
- ✓ Page header card with title
- ✓ Revenue chart card (canvas element)
- ✓ Widget-inline card (4-column stat grid)
- ✓ Stat cards with icons and numbers
- ✓ Links on stat cards
- ✓ Border-left dividers between stat cards

#### Interactive Elements:
- `<canvas id="task-area-chart">` - Chart.js revenue graph
- Stat card links (`href="<?php echo site_url('user/courses'); ?>"`)

#### Page Structure:
```
<div class="row">
  <div class="card"> <!-- Header -->

<div class="row">
  <div class="card"> <!-- Revenue chart -->
    <canvas id="task-area-chart">

<div class="row">
  <div class="card widget-inline">
    <div class="card-body p-0">
      <div class="row no-gutters">
        <div class="col-sm-6 col-xl-3">
          <div class="card shadow-none m-0">
            <div class="card-body text-center">
              <i class="dripicons-archive">
              <h3><span>X</span></h3>
              <p>number_of_courses</p>
```

---

## Baseline Visual Characteristics (Current State)

### Frontend (courses_page)
- Bootstrap 5.3.1 styles (from frontend template)
- Default card shadows and borders
- Standard button styles (Bootstrap variants)
- Default form input styles (boxed inputs)
- Standard badge pill style
- Blue/gray color scheme (default Bootstrap)

### Admin (categories)
- Bootstrap 4.3.1 + 5.3.1 hybrid (dual-version conflict)
- Backend template custom styles (`app.min.css`)
- Card thumbnails with border radius
- List group items with hover effects
- Action icons (mdi icons)
- Btn-outline-primary/info/danger variants

### User Dashboard
- Same backend template as Admin
- Stat cards with centered content
- Dripicons font icons
- Border-left dividers between cards
- Chart.js canvas element
- Shadow-none m-0 utility classes

---

## Risk Assessment (Pre-Migration)

### Low Risk
- ✅ All 3 pages can be isolated via whitelist
- ✅ No shared components between pages initially
- ✅ Clear page_name identifiers

### Medium Risk
- ⚠️ `.on-hover-action` class is a JS hook (must preserve)
- ⚠️ Chart.js canvas might have styling dependencies
- ⚠️ Form filter submission behavior must remain unchanged

### Known Constraints
- ❌ Cannot change PHP variables or loops
- ❌ Cannot alter form action/method attributes
- ❌ Cannot modify jQuery event handlers
- ❌ Cannot change canvas element IDs
- ❌ Cannot remove JS hook classes

---

## Testing Plan (Per Page)

### For Each Page:
1. **Visual Regression:**
   - Compare current appearance with baseline description
   - Verify no unexpected layout shifts
   - Check all colors/spacing match design system

2. **Functional Testing:**
   - Test every button click
   - Test every form submission
   - Test every hover action
   - Test every link navigation
   - Test every dropdown/select
   - Verify Chart.js still renders (dashboard)

3. **Theme Testing:**
   - Test Light mode
   - Test System mode
   - Test Dark mode
   - Verify theme toggle appears in header
   - Verify theme persists across reload

4. **Responsive Testing:**
   - Desktop (1920px, 1440px, 1366px)
   - Tablet (768px)
   - Mobile (480px, 375px)

---

## Whitelist Addition Plan

### Frontend Whitelist
```php
$config['gp_ds_frontend_pages'] = [
    'courses_page'  // Initial pilot page
];
```

### Admin Whitelist
```php
$config['gp_ds_admin_pages'] = [
    'categories'  // Initial pilot page
];
```

### User/Instructor Whitelist
```php
$config['gp_ds_user_pages'] = [
    'dashboard'  // Initial pilot page
];
```

---

## Expected Changes After Migration

### All 3 Pages Will Have:
1. `.gp-ds` class on `<body>` tag
2. Theme toggle buttons in header
3. New button styles (Manrope 800, uppercase)
4. New card styles (14px radius, soft shadow)
5. New badge styles (pill shape, semantic colors)
6. New form input styles (underline-only)
7. Typography in Manrope (headings) + Inter (body)
8. Dark mode support

### What Will NOT Change:
- Page layouts (grid/flex structure)
- JavaScript behavior
- Form submissions
- Link destinations
- PHP logic
- Canvas element rendering
- Image sources
- Icon font rendering
- jQuery event handlers

---

## Rollback Plan (Per Page)

### Single Page Rollback:
1. Open `application/config/design_system_pages.php`
2. Remove the page_name from the appropriate array
3. Save file
4. Reload page — `.gp-ds` class will not apply
5. Page returns to baseline state

### Full Rollback (All 3 Pages):
```php
$config['gp_ds_frontend_pages'] = [];  // Empty
$config['gp_ds_admin_pages'] = [];     // Empty
$config['gp_ds_user_pages'] = [];      // Empty
```

**Rollback Time:** < 30 seconds per page  
**Files Modified:** 1 file only (design_system_pages.php)  
**Risk:** ZERO (whitelist-based, no CSS changes needed)

---

## Next Actions

1. ✅ Baseline documented
2. ⏭️ Add pages to whitelist
3. ⏭️ Test each page with `.gp-ds` class applied
4. ⏭️ Document any component gaps found
5. ⏭️ Extend `gp-components-core.css` if needed
6. ⏭️ Test all 3 pages in Light/System/Dark modes
7. ⏭️ Test responsive breakpoints
8. ⏭️ Create final Phase 1-Pilot completion report

---

**Baseline captured. Ready to proceed with whitelist addition.**
