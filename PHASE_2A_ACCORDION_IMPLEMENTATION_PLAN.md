# Phase 2a-1: Accordion Component Migration — Implementation Plan

**Date:** Saturday, September 12, 2026  
**Component:** Accordions (Bootstrap 5 `.accordion`, `.accordion-item`, `.accordion-collapse`)  
**Status:** 📋 **AWAITING APPROVAL** — Do not proceed until approved  
**Risk Level:** LOW-MEDIUM (29 files, no markup changes, CSS-only)

---

## Objective

Apply design system styling to all Bootstrap 5 accordion instances across the LMS, matching the hard-rule file (§16 Tabs & Accordion).

**Key Constraint:** NO markup changes required. All accordions already use Bootstrap 5's proper structure with `data-bs-toggle="collapse"` JS hooks. This is a **CSS-only migration**.

---

## Component Footprint (Re-Verified)

**Total Files:** 29 (confirmed via Grep)

### Breakdown by Area:

#### Frontend Pages (13 files):
1. `frontend/default-new/course_page_custom_field_info.php`
2. `frontend/default-new/course_page_curriculum.php`
3. `frontend/default-new/course_page_info_description.php`
4. `frontend/default-new/website_faq.php`
5. `frontend/default-new/courses_page_sidebar.php`
6. `frontend/default-new/home_1.php`
7. `frontend/default-new/home_2.php`
8. `frontend/default-new/home_3.php`
9. `frontend/default-new/home_4.php`
10. `frontend/default-new/home_5.php`
11. `frontend/default-new/home_6.php`
12. `frontend/default-new/home_7.php`
13. `frontend/default-new/home_cooking2.php`
14. `frontend/default-new/home_development.php`
15. `frontend/default-new/home_elegant.php`
16. `frontend/default-new/home_kindergarten.php`
17. `frontend/default-new/home_marketplace.php`

#### Homepage Builder Components (7 files):
1. `components/main/faq_section_1.php`
2. `components/main/faq_section_2.php`
3. `components/main/faq_section_6.php`
4. `components/main/faq_section_development.php`
5. `components/main/faq_section_kindergarten.php`
6. `components/main/faq_section_marketplace.php`
7. `components/main/tuition_section_university2.php`

#### Backend Admin (2 files):
1. `backend/admin/custom_field.php`
2. `backend/admin/seo_settings.php`
3. `backend/admin/newsletters.php`

#### Backend User (1 file):
1. `backend/user/custom_field.php`

#### Lessons (1 file):
1. `lessons/sidebar.php`

---

## Existing Markup Pattern (Verified)

All 29 files use Bootstrap 5's standard accordion structure:

```html
<div class="accordion" id="accordionExample">
    <div class="accordion-item">
        <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button" type="button" 
                    data-bs-toggle="collapse" 
                    data-bs-target="#collapseOne" 
                    aria-expanded="true">
                Question or Section Title
            </button>
        </h2>
        <div id="collapseOne" class="accordion-collapse collapse show" 
             data-bs-parent="#accordionExample">
            <div class="accordion-body">
                Content goes here
            </div>
        </div>
    </div>
</div>
```

**JS Dependencies (MUST NOT CHANGE):**
- `data-bs-toggle="collapse"` — Bootstrap 5 collapse plugin trigger
- `data-bs-target="#id"` — Target element selector
- `data-bs-parent="#id"` — Parent accordion (enables auto-close behavior)
- `.collapse` class — Required for Bootstrap JS
- `.show` class — Initial open state

**These attributes and classes are behavior hooks. They will NOT be modified.**

---

## Hard-Rule Design System Pattern (§16)

From `geeseprojdesignsystem (1).html` lines 311-317:

```css
.accordion-item {
    border: 1px solid var(--border);
    border-radius: 12px;
    margin-bottom: 10px;
    overflow: hidden;
    background: var(--surface);
}
.accordion-item:last-child {
    margin-bottom: 0;
}
.accordion-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16px 18px;
    cursor: pointer;
    font-family: var(--font-head);
    font-weight: 700;
    font-size: 14px;
}
.accordion-head .chev {
    transition: transform var(--dur-base) var(--ease-out);
    color: var(--fg-faint);
}
.accordion-item.open .chev {
    transform: rotate(180deg);
}
.accordion-body {
    padding: 0 18px 18px;
    color: var(--fg-muted);
    font-size: 13.5px;
    line-height: 1.7;
    display: none;
}
.accordion-item.open .accordion-body {
    display: block;
}
```

**Adaptation Required:**
- Hard-rule uses `.accordion-head` → LMS uses `.accordion-header` + `.accordion-button`
- Hard-rule uses `.chev` span → LMS button has no chevron element (Bootstrap adds `::after` pseudo)
- Hard-rule uses `.open` class → Bootstrap uses `.collapsed` (inverse)
- Hard-rule manually controls display → Bootstrap uses `.collapse` + `.show`

---

## CSS Strategy

Create `.gp-ds` scoped overrides in a new file: `assets/design-system/gp-accordion.css`

```css
/* ---------- Accordion (Bootstrap 5 Adaptation) ---------- */
.gp-ds .accordion-item {
    border: 1px solid var(--gp-border);
    border-radius: 12px;
    margin-bottom: 10px;
    overflow: hidden;
    background: var(--gp-surface);
}

.gp-ds .accordion-item:last-child {
    margin-bottom: 0;
}

.gp-ds .accordion-header {
    margin-bottom: 0; /* Reset Bootstrap default */
}

.gp-ds .accordion-button {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16px 18px;
    cursor: pointer;
    font-family: var(--gp-font-head);
    font-weight: 700;
    font-size: 14px;
    background-color: transparent; /* Override Bootstrap */
    color: var(--gp-fg);
    border: none;
    width: 100%;
    text-align: left;
    box-shadow: none; /* Remove Bootstrap focus shadow */
}

.gp-ds .accordion-button:not(.collapsed) {
    background-color: transparent;
    color: var(--gp-fg);
    box-shadow: none;
}

.gp-ds .accordion-button:focus {
    outline: 2px solid var(--gp-gold-deep);
    outline-offset: -2px;
    box-shadow: none;
}

.gp-ds .accordion-button::after {
    /* Bootstrap adds chevron via ::after */
    transition: transform var(--gp-dur-base) var(--gp-ease-out);
    color: var(--gp-fg-faint);
    flex-shrink: 0;
}

.gp-ds .accordion-button:not(.collapsed)::after {
    transform: rotate(180deg);
}

.gp-ds .accordion-collapse {
    border: none; /* Remove Bootstrap border */
}

.gp-ds .accordion-body {
    padding: 0 18px 18px;
    color: var(--gp-fg-muted);
    font-size: 13.5px;
    line-height: 1.7;
}

/* Dark mode support already handled via tokens */
```

**Why a Separate File:**
- Accordions are complex (20+ lines of CSS)
- Keeps `gp-components-core.css` focused on primitives (buttons, cards, badges, forms)
- Easier to maintain/extend
- Clear separation for Phase 2a component additions

---

## Implementation Steps

### 1. Create CSS File ✅
**File:** `assets/design-system/gp-accordion.css`
- Copy CSS above
- Verify all tokens reference `--gp-*` (not `--primary`, etc.)
- Test in scratch page first (optional)

### 2. Load CSS Globally ✅
**Modify:** `application/views/frontend/default-new/includes_top.php`
**Modify:** `application/views/backend/includes_top.php`

Add after existing design system CSS:
```php
<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-accordion.css'); ?>">
```

### 3. Whitelist Pages Progressively ✅

**DO NOT whitelist all 29 pages at once.** Follow this batched rollout:

#### Batch 1: Pilot Extension (3 pages) — Test accordion on already-migrated pages
- `course_page` (if it has accordion - verify first)
- OR pick 1-2 FAQ pages

**Wait for validation before Batch 2**

#### Batch 2: FAQ Pages (7 homepage component files)
- `components/main/faq_section_1.php`
- `components/main/faq_section_2.php`
- `components/main/faq_section_6.php`
- `components/main/faq_section_development.php`
- `components/main/faq_section_kindergarten.php`
- `components/main/faq_section_marketplace.php`
- `components/main/tuition_section_university2.php`

**Wait for validation before Batch 3**

#### Batch 3: Homepage Templates (9 files)
- All `home_*.php` files

**Wait for validation before Batch 4**

#### Batch 4: Remaining Pages (10 files)
- Backend admin/user pages
- Lessons sidebar
- Course page variants

### 4. Test Each Batch ✅

**Per-page testing checklist:**
- [ ] Page loads without errors
- [ ] Accordion items render with 12px radius, 10px margin
- [ ] Accordion button has correct typography (Manrope 700, 14px)
- [ ] Click to expand — Bootstrap JS still works
- [ ] Click to collapse — Bootstrap JS still works
- [ ] Multiple items can be open (if no `data-bs-parent`)
- [ ] Auto-close works (if `data-bs-parent` is set)
- [ ] Chevron rotates 180deg on expand
- [ ] Focus state shows gold outline
- [ ] Light/Dark/System themes all work
- [ ] Responsive at 768px and 480px

**Cross-page testing:**
- [ ] Navigate between whitelisted pages — no layout shift
- [ ] Check 2-3 non-whitelisted pages — no visual regression

---

## Files Expected to Change

### New Files (1):
```
assets/design-system/gp-accordion.css
```

### Modified Files (3):
```
application/views/frontend/default-new/includes_top.php (1 line added)
application/views/backend/includes_top.php (1 line added)
application/config/design_system_pages.php (add page names per batch)
```

### Files Explicitly Protected (NO CHANGES):
- All 29 accordion view files (markup untouched)
- All controllers (logic unchanged)
- All JavaScript files (behavior unchanged)
- Bootstrap 5 CSS/JS (vendor files untouched)

---

## Stop Conditions

**STOP immediately if:**
- ❌ Accordion collapse/expand stops working (Bootstrap JS broken)
- ❌ Auto-close behavior breaks on FAQs
- ❌ Chevron doesn't rotate or is missing
- ❌ Page layout completely breaks
- ❌ More than 10% of accordion instances don't fit this pattern

**If stopped:**
1. Rollback affected pages from whitelist
2. Document specific issue (page, browser, behavior)
3. Fix CSS in isolation
4. Re-test before resuming rollout

---

## Rollback Plan

### Single Page Rollback:
1. Open `application/config/design_system_pages.php`
2. Remove specific `page_name` from array
3. Save — page returns to baseline immediately

### Batch Rollback:
Remove all pages from the current batch from whitelist.

### Full Rollback:
1. Remove `gp-accordion.css` link from both `includes_top.php` files
2. Empty all whitelist arrays
3. Delete `assets/design-system/gp-accordion.css` (optional)

**Time:** < 2 minutes  
**Risk:** ZERO (CSS-only, no markup/JS touched)

---

## Risk Assessment

### Actual Risk: LOW ✅

**Why low risk:**
- CSS-only migration (no markup changes)
- No JS behavior changes (Bootstrap hooks preserved)
- Batched rollout (3-7 pages at a time, validated before next)
- Instant rollback (whitelist-based)
- Already tested mechanism in Phase 1-Pilot

**Why medium (not zero):**
- 29 files is non-trivial footprint
- Accordion JS is complex (collapse, auto-close, ARIA)
- Multiple accordion patterns (FAQ, curriculum, filters)
- Must test BOTH expand and collapse on every page

**Mitigations:**
- Start with small batch (3 pages)
- Validate Bootstrap JS still works before scaling
- Test auto-close behavior explicitly
- Check ARIA attributes not broken

---

## Validation Checklist

### CSS File Created:
- [ ] `gp-accordion.css` created
- [ ] All tokens use `--gp-*` prefix
- [ ] Dark mode handled via tokens (no hardcoded `@media`)
- [ ] Bootstrap overrides are scoped under `.gp-ds`
- [ ] File size reasonable (< 2 KB)

### CSS Loaded Globally:
- [ ] Link added to `frontend/includes_top.php`
- [ ] Link added to `backend/includes_top.php`
- [ ] File loads successfully (200 status in Network tab)
- [ ] No JavaScript console errors

### Batch 1 Testing:
- [ ] 3 pages whitelisted
- [ ] All accordions expand/collapse correctly
- [ ] Styling matches hard-rule file
- [ ] Light/Dark themes work
- [ ] No regressions on non-whitelisted pages

### Repeat for Each Batch:
- [ ] Batch 2 (FAQ components) validated
- [ ] Batch 3 (homepage templates) validated
- [ ] Batch 4 (remaining pages) validated

### Final Validation:
- [ ] All 29 pages tested
- [ ] Component Registry updated (§12)
- [ ] `PHASE_2A_ACCORDION_COMPLETION_REPORT.md` created

---

## Success Criteria

✅ All 29 accordion instances styled consistently  
✅ Bootstrap 5 collapse JS behavior preserved  
✅ Auto-close functionality works on FAQ pages  
✅ Chevron rotation animation smooth (260ms ease-out)  
✅ Light/Dark themes both work  
✅ Responsive at all breakpoints  
✅ Zero JavaScript errors  
✅ Zero PHP errors  
✅ Instant rollback confirmed working  

---

## Next Component After Accordion

**Dropdowns** (34 files) — Second smallest, test JS dropdown plugin behavior

---

## Approval Required

**Before proceeding, confirm:**
1. This plan follows §6 (Component Extension Rule) correctly
2. Batched rollout strategy is acceptable
3. CSS-only approach (no markup changes) is correct
4. Risk level LOW is acceptable
5. Timeline (4 batches × testing) is acceptable

**Please approve or request changes before implementation begins.**

---

**Status:** 📋 Awaiting approval to create `gp-accordion.css` and begin Batch 1 rollout.
