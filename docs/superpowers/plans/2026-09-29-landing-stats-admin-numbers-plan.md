# Landing Page Stats Follow the Admin's Numbers — Implementation Plan

**Goal:** The four stat numbers in the landing page's hero and "Why GPLI" sections show the figures the admin sets in Home Page Builder (e.g. "100+", "8", "2hrs"), matching GPLI's real catalogue, instead of numbers that contradict their own labels.
**Root cause:** `home_gpli.php` ignores the admin's saved "Number" for stats 1-3 and prints live counts instead (`home_gpli.php:97,102,107,321,325,329`, by design per the comment at `:88-92`). The labels stay admin-edited, so "Avg. Course Length" sits over the student count (19), and "Business Functions" over every category row (6).
**Approach:** Show the admin's saved number for each stat; only when the admin leaves a number blank, fall back to the live count. Labels, categories, courses and everything else stay as they are.
**Tech stack:** PHP 8.3, CodeIgniter 3.1.9, MySQL; no automated test suite in the repo.
**Source:** Boss review of gpli.tech (2026-09-29): "doesn't align on the requirements and the data is not consistent". User confirmed the sample page `gpli-lms-landing-package/index.html` holds the **real** figures from GPLI's old LMS (100+ courses, 8 business functions, 2 hrs average); only 18 of those courses have been migrated so far.

## Open questions (resolve before implementing)

| # | Question | Why it matters | Recommended answer |
| --- | --- | --- | --- |
| 1 | When the admin leaves a stat's Number blank, show the live count or nothing? | Gives a way back to automatic counts once migration is complete. | Live count (courses / main categories / learners), as planned below. |
| 2 | Should "Business Functions" live fallback count only main categories? | Today it counts sub-categories too (6 instead of 3) (`home_gpli.php:12`). | Yes, main categories only (`parent = 0`). |
| 3 | Clean-up of sample data (15 fake testimonials + their accounts, test instructor names) — do now or separately? | They show on the public page as if real. Data deletion is irreversible. | Separate item, after a phpMyAdmin backup; not part of this code change. |

---

## Live database/system validation: 2026-09-29

Read-only, via SSH + `mysql` as the site DB user; no data changed.

- Courses: 18, all `status = private`, `is_free_course = 1`, `is_top_course = 1`, `course_type = scorm`, all `creator = 1`.
- Categories: 6 rows = 3 main (`parent = 0`: Leadership Accelerator Course, Leadership Challenge, Shared) + 3 sub-categories, 6 courses each.
- Users with `is_instructor = 0`: 19, of which 15 (ids 11-25) are the seeded testimonial authors; `enrol` has 0 rows.
- Site testimonials (`rating` with `ratable_type/ratable_id` NULL): 15 rows all created 2026-09-15 21:00:56 — the dummy data from `GPLI_DUMMY_DATA_SEED_PLAN.md` §8 (line 182).
- Instructors: 5 test accounts (gpli instructor, Demo Instructor, GPLI Instructor 1-3).
- Lessons: 18 SCORM lessons, all with empty/zero duration → "0 Hours" on cards.
- `frontend_settings.banner_sub_title` = "GPLI provides unlimited access to 100+ self-paced courses…" (admin text).
- UNVERIFIED: the saved `frontend_settings.landing_page_extras` JSON (the admin's current stat numbers/labels). Verify by opening Admin → Home Page Builder and reading the hero/why "Stats" fields, or `SELECT value FROM frontend_settings WHERE \`key\`='landing_page_extras'`. The live page shows label "Avg. Course Length" for stat 3, so at least the labels were saved.

## Audit findings

1. **Admin already has the fields.** Home Page Builder renders Number/Label/Sub inputs for all 4 hero stats (`application/views/backend/admin/home_page_builder.php:408-410`) and Number/Label for all 4 why stats (`:497-498`). Defaults are the real GPLI figures: `100+ / 8 / 2hrs / SME` (`application/helpers/landing_helper.php:20-23`, `:59-62`).
2. **The page discards them.** Stats 1-3 print `$gpli_total_courses`, `$gpli_total_categories`, `$gpli_total_students` (`home_gpli.php:97,102,107` and `:321,325,329`); only stat 4 prints the saved `num` (`:112`, `:333`). Result on live: "18+", "6", "19+".
3. **Prior decision found.** `home_gpli.php:88-92` says numbers 1-3 intentionally use live counts "instead of needing a manual update"; the file header (`:3-8`) says the page must "never" use "the sample file's own placeholder figures". Both assumed the sample figures were fake. The user has now confirmed they are real, so this decision is superseded — the plan replaces that comment.
4. **Other readers of the same stats.** `components/main/hero_section_1.php:24` and `components/main/why_section.php:25` already print the saved `num`; they belong to other page templates and are unaffected.
5. **Live-count definitions** (`home_gpli.php:11-13`): courses = active+private; categories = every row (bug: includes sub-categories); students = `is_instructor = 0` (includes the 15 seeded accounts).
6. **Consistent text elsewhere.** Hero paragraph "100+ self-paced courses" (admin setting, finding in validation) and the Join box "unlimited access to 100+ SME-focused courses" (`home_gpli.php:370`) already match the real catalogue — no change needed once stats agree.
7. **Category sections are real data** (`get_top_categories`, `home_gpli.php:146`). They'll show the 8 business functions once those categories exist and courses are assigned; hardcoding per-function counts would link visitors to empty categories, so they stay live.

---

## Scope and constraints

### In scope
- Hero stats 1-3 and Why stats 1-3 show the admin's saved number; blank → live count.
- Live "Business Functions" fallback counts main categories only.
- Replace the outdated comment (`home_gpli.php:88-92`) and header note (`:3-8`).
- A one-line hint under the Stats fields in Home Page Builder: "Leave a number blank to show the live count."

### Out of scope: do not change
- Category sections, Top Courses, facilitators, testimonials queries.
- Database content (sample reviews, test instructors, lesson durations, contact settings) — separate data tasks (Open question 3).
- `landing_helper.php` defaults, other page templates, `hero_section_1.php`, `why_section.php`.

### Non-negotiable safety constraints
- Keep `htmlspecialchars()` on every admin value printed.
- No database or schema change.

### Contract

| Case | Actor | Input | Required outcome |
| --- | --- | --- | --- |
| 1 | Visitor | Admin numbers saved as 100+ / 8 / 2hrs / SME | Hero and Why show exactly 100+, 8, 2hrs, SME with their labels |
| 2 | Admin | Clears stat 1 Number and saves | Stat 1 shows live course count (18) |
| 3 | Admin | Clears stat 2 Number | Shows main-category count (3), not 6 |
| 4 | Admin | Clears stat 3 Number | Shows learner count (19) |
| 5 | Admin | Enters `<script>` in a Number | Rendered as text, not executed |
| 6 | Fresh install, nothing saved | — | Defaults from `landing_helper.php` (100+ / 8 / 2hrs / SME) |

## Files

| File | Change | Responsibility |
| --- | --- | --- |
| `application/views/frontend/default-new/home_gpli.php` | Modify | Stats use admin number with live fallback; main-category count; updated comments |
| `application/views/backend/admin/home_page_builder.php` | Modify | Hint text under hero and why Stats fields |

## Phase 0: Failing tests first

No automated test runner in this project; checks are manual on `http://localhost/academy/`.

### Task 0.1: Capture baseline
- [ ] In local Admin → Home Page Builder, set hero stat numbers to `100+`, `8`, `2hrs`, `SME` and save.
- [ ] Open `http://localhost/academy/` → Expected now (FAIL): stats show the local live counts, not 100+ / 8 / 2hrs.

## Phase 1: Use the admin's numbers

**Files:** `application/views/frontend/default-new/home_gpli.php`

### Task 1.1: Fallback helper and correct category count
- [ ] Line 12: `$gpli_total_categories = $this->db->where('parent', 0)->count_all_results('category');`
- [ ] After `$extras = gp_landing_extras();` (line ~17) add:

```php
// Admin's saved number wins; a blank number falls back to the live count.
function gpli_stat_num($stats, $index, $live)
{
    $num = isset($stats[$index]['num']) ? trim((string) $stats[$index]['num']) : '';
    return htmlspecialchars($num !== '' ? $num : (string) $live);
}
```
- [ ] Replace the comment at lines 88-92 with: `// Numbers come from Home Page Builder; blank numbers show live counts.`
- [ ] Replace the header lines 3-8 note "never the sample file's own placeholder figures" with: `Stat numbers are admin-set (Home Page Builder) because GPLI's catalogue is larger than what is migrated so far; category, course and facilitator sections show live data.`

### Task 1.2: Hero stats
- [ ] `:97` → `<div class="num"><?php echo gpli_stat_num($gpli_hero_stats, 0, $gpli_total_courses); ?></div>`
- [ ] `:102` → `gpli_stat_num($gpli_hero_stats, 1, $gpli_total_categories)`
- [ ] `:107` → `gpli_stat_num($gpli_hero_stats, 2, $gpli_total_students)`
- [ ] `:112` → `gpli_stat_num($gpli_hero_stats, 3, 'SME')`

### Task 1.3: Why stats
- [ ] `:321`, `:325`, `:329`, `:333` → same pattern with `$gpli_why_stats`, indexes 0-3.
- [ ] Run: `C:\xampp\php\php.exe -l application/views/frontend/default-new/home_gpli.php` → no syntax errors.

**Phase constraints:** labels and sub-text lines unchanged; no other section touched.

## Phase 2: Admin hint

**Files:** `application/views/backend/admin/home_page_builder.php`

### Task 2.1
- [ ] Below the hero stats inputs loop (after line ~410's block) and the why stats loop (after ~498's block), add: `<small class="text-muted d-block"><?php echo get_phrase('Leave a number blank to show the live count.'); ?></small>` — once per section, outside the per-stat loop.
- [ ] Run: `C:\xampp\php\php.exe -l application/views/backend/admin/home_page_builder.php`

## Phase last: Regression verification and rollout

| Role | Action | Expected |
| --- | --- | --- |
| Admin | Save 100+ / 8 / 2hrs / SME | Landing hero + why show them |
| Admin | Clear stat 2 | Shows 3 locally-counted main categories |
| Admin | Enter `<b>x</b>` as a number | Shows literally `<b>x</b>` |
| Visitor | Landing page | Labels and numbers agree; rest of page unchanged |

- After deploy: in live Admin → Home Page Builder, confirm the four hero and four why numbers read 100+ / 8 / 2hrs / SME (re-enter and save if not), then check https://gpli.tech.

## Rollback

1. `git revert <commit>` and push to `main`; the deploy workflow restores the previous page. No data was changed, so nothing else to undo.

## Commit

```bash
git add application/views/frontend/default-new/home_gpli.php application/views/backend/admin/home_page_builder.php docs/superpowers/plans/2026-09-29-landing-stats-admin-numbers-plan.md
git commit -m "fix: landing page stats show the admin's numbers, live counts as fallback"
```

Stage only these files (never `git add .`; `tmp/` must not ship).

## Self-review

1. **Contradictions:** "use admin numbers" vs old comment "use live counts" — resolved by replacing the comment (Task 1.1), recorded as superseded decision (finding 3).
2. **Goal reachability:** Existing site: numbers appear as soon as the admin's saved values are right (UNVERIFIED what is saved — rollout step checks it). Future: when migration completes, admin can clear numbers to switch to live counts.
3. **Bypass:** Display-only change; no write path or permission involved.
4. **Existence:** Verified: `gp_landing_extras` (`landing_helper.php:4`), stats inputs (`home_page_builder.php:408,497`), stat lines in `home_gpli.php` 97-112 and 321-333, `category.parent` column (live query). `gpli_stat_num` is new; name checked for no clash (only `gpli_bg_photo_attrs` and `gpli_two_tone_heading` exist in the file).
5. **Consistency:** Files table = Phase 1-2 files = commit list (plus this plan doc).
6. **Duplication:** Uses the existing saved `num` fields instead of adding new settings.
7. **Placeholders:** None.

Not applicable: authorization/RLS (display-only), migrations (none), variants beyond hero/why stats (other templates already use `num`).
