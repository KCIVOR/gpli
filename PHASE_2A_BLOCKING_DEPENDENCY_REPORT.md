# Phase 2a — BLOCKED: Phase 1-Pilot Dependency Not Met

**Date:** Saturday, September 12, 2026  
**Status:** ⚠️ **BLOCKED** — Cannot proceed  
**Blocking Issue:** Phase 1-Pilot (prerequisite) has not been completed

---

## Critical Dependency Issue

The Design System Implementation Plan (§8) explicitly states:

> **PHASE 1-PILOT — Three Representative Pages**  
> **⚠ STOP condition: do not proceed past this phase until you've explicitly confirmed the pilot is stable.**

**Current State:**
- ✅ Phase 0 (Foundation) is complete
- ❌ Phase 1-Pilot completion report does not exist (`PHASE_1_PILOT_COMPLETION_REPORT.md` not found)
- ❌ Whitelist is empty (no pages migrated yet)
- ❌ No practical validation of the migration process on live pages

**Why This Matters:**

Phase 1-Pilot is designed to:
1. **Prove the mechanism** — Test that tokens → components → whitelist activation works on real pages
2. **Identify integration issues** — Surface JS conflicts, DataTables issues, modal/dropdown behavior problems
3. **Validate the testing checklist** — Confirm the §9 testing process catches regressions
4. **Establish baseline process** — Create a repeatable pattern before touching 184+ card files or 103+ badge files

**Attempting Phase 2a without Phase 1-Pilot would be:**
- Violating the plan's explicit stop condition
- Scaling an unproven process to hundreds of files
- High risk of discovering fundamental issues after already touching 50+ files

---

## Component Footprint Re-Verification (Completed)

As instructed, I've re-verified the component counts before starting:

| Component | Original Estimate | **ACTUAL Count** | Files | Status |
|-----------|------------------|------------------|-------|--------|
| Accordions | 29 | **29** | ✅ Verified | Smallest |
| Dropdowns | 27 | **34** | ⚠️ +26% | Second smallest |
| Alerts | 36 | **37** | ✅ ~Same | Third smallest |
| Collapse | 35 | **58** | ⚠️ +66% | Fourth |
| Badges | 94 | **103** | ⚠️ +10% | Fifth |
| Tables | 50 | **129** | 🔴 +158% | Sixth - **MAJOR DISCREPANCY** |
| Cards | 184 | **183** | ✅ ~Same | Largest |

**Key Findings:**
1. **Tables** — Estimate was 50, actual is **129 files** (+158%). This is a critical planning gap.
2. **Collapse** — Estimate was 35, actual is **58 files** (+66%).
3. **Dropdowns** — Estimate was 27, actual is **34 files** (+26%).

**Implication:** The original priority ranking may need adjustment. Tables are NOT a "50-file medium effort" — they're a high-footprint component rivaling badges (103) and approaching cards (183).

---

## Recommended Path Forward

### Option 1: Complete Phase 1-Pilot First (STRONGLY RECOMMENDED)

**Scope:** Migrate 3 representative pages as specified in the plan:

1. **Frontend page with forms + cards + badges**
   - Candidate: `courses_page` (needs verification by reading the file)
   - Components: Form controls, course cards, badge variants
   - Risk: LOW (1 page, reversible)

2. **Admin page with table + dropdown + badge**
   - Candidate: `categories` or `users` (both DataTables-backed per audit)
   - Components: DataTables, dropdown menu, status badges
   - Risk: MEDIUM (DataTables JS interaction, Bootstrap 4/5 version conflict)

3. **User/Instructor page with form + card**
   - Candidate: `user/dashboard`
   - Components: Dashboard stats cards, form elements
   - Risk: LOW (1 page, same backend shell as admin)

**Validation per page:**
- Baseline screenshot before
- Inventory interactive elements (which dropdowns/modals/DataTables exist)
- Add to whitelist
- Apply `.gp-ds` component CSS
- Retest every interaction
- Test desktop/tablet/mobile
- Test Light/Dark/System themes

**Deliverable:** `PHASE_1_PILOT_COMPLETION_REPORT.md` documenting:
- What worked
- What broke (if anything)
- JS conflicts discovered
- Bootstrap version issues encountered
- Refinements needed to the process
- Approval to proceed to Phase 2a

**Time Estimate:** 3 pages × careful validation = prudent investment before touching 500+ component instances

---

### Option 2: Proceed Directly to Phase 2a (NOT RECOMMENDED)

**If you choose to skip Phase 1-Pilot:**

You would be accepting these risks:
- Scaling an unvalidated process to 100+ files immediately
- Discovering fundamental JS/DataTables/Bootstrap issues after already migrating many pages
- No established baseline for "what success looks like" on a real page
- Potential large-scale rollback if a core assumption is wrong

**If you proceed anyway, Phase 2a would start with:**

**Component:** Accordions (29 files — smallest verified footprint)

**Process:**
1. Find all instances via Grep
2. Identify most common markup pattern
3. Create shared partial in `application/views/components/design-system/accordion.php`
4. Extract common logic
5. Convert instances to use partial (or standardized markup)
6. Apply `.gp-ds .accordion` styles
7. Test dark mode
8. Add pages to whitelist

**Required before starting:** Your explicit written approval acknowledging the Phase 1-Pilot skip.

---

## Revised Phase 2a Sub-Phase Prioritization (Based on Actual Counts)

If Phase 1-Pilot succeeds and we proceed to Phase 2a:

**2a-1: Small Components (validate extraction pattern)**
- Accordions: 29 files
- Dropdowns: 34 files
- Alerts: 37 files

**2a-2: Medium Components (scale the pattern)**
- Collapse: 58 files (not 35)
- Badges: 103 files (not 94)

**2a-3: Large Components (proven process only)**
- Tables: 129 files (not 50 — requires special attention)
- Cards: 183 files (matches estimate)

**Reason for split:** Tables being 2.5× larger than estimated means they should NOT be grouped casually with smaller components. They deserve their own sub-phase with dedicated testing, especially given DataTables JS dependencies.

---

## Stop Conditions (from §11 of the plan)

These apply even if we skip Phase 1-Pilot:

- ❌ A UI change appears to require a backend logic change → **STOP**
- ❌ A component's JS behavior would need to change → **STOP**
- ❌ Shared component can't be safely scoped under `.gp-ds` → **STOP**
- ❌ A class is both styling + JS hook and safe path isn't obvious → **STOP**
- ❌ DataTables version conflict discovered → **STOP** (this is Phase 4 territory)

---

## Decision Required

**Please choose one:**

### ✅ **Recommended: Complete Phase 1-Pilot first**
- I will migrate 3 representative pages
- Full validation per the plan
- Deliver completion report
- Then seek approval for Phase 2a

### ⚠️ **Skip Phase 1-Pilot (against plan guidance)**
- Acknowledge risks above
- Start with Accordions (29 files)
- Proceed directly to high-volume rollout

**No work will proceed until you explicitly choose one of these paths.**

---

## Files Changed in This Investigation

None. This is a planning/verification report only.

---

## Next Steps After Decision

**If proceeding with Phase 1-Pilot:**
1. Identify the 3 specific pages (read files to confirm they match criteria)
2. Take baseline screenshots
3. Create per-page migration plan
4. Execute pilot
5. Document learnings
6. Return for Phase 2a approval

**If skipping to Phase 2a:**
1. Read `C:\Users\Rovick\Downloads\geeseprojdesignsystem (1).html` for accordion patterns (§0 hard-rule file)
2. Grep all 29 accordion instances
3. Identify common markup pattern
4. Design shared partial
5. Create implementation plan for accordion rollout
6. Wait for approval
7. Execute

---

**This report is complete. Awaiting your decision.**
