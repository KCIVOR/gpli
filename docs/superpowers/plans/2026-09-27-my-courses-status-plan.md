# My Courses Status Implementation Plan

**Goal:** On My Courses, every course clearly shows **Not started**, **In progress**, **Completed** or **Expired**, and the student can filter by status. SCORM courses show the course player's real % as their progress, both on My Courses and at the top of the course page, instead of the website's 0%/100%.
**Root cause:** My Courses shows only the website's progress % (`my_courses.php:34,59-64`), which reads `watch_histories` alone. SCORM courses record "started" only in `scorm_tracking` (`Scorm_model::save_scorm_progress`), so a SCORM student who is halfway through shows 0%. The page has no status label or filter.
**Approach:** Add one read-only helper, `course_status()`, that combines the existing sources into a status, then use it on My Courses for a status badge, a SCORM %, a completion line and client-side filter tabs. Progress, certificate and SCORM tracking logic stay unchanged.
**Tech stack:** PHP 8.3.29, CodeIgniter 3, MariaDB (`academy_lms`), jQuery, project design system (`gp_ds_*` helpers, `assets/design-system/*.css`). No automated test runner.
**Source:** Client question 3 (WhatsApp, 2026-09-27): "Does completed course get registered on the user profile as completed?" User decisions on 2026-09-27: option 2 + filter tabs; Expired is a separate status; for normal courses, "In progress" requires at least one completed lesson.

## Open questions (resolve before implementing)

None. All decisions were made by the user on 2026-09-27:

| # | Decision | Answer |
| --- | --- | --- |
| 1 | Expired enrolments | A separate **Expired** status |
| 2 | Normal course "In progress" | Only when **at least one lesson is done**; opening alone doesn't count |
| 3 | Scope | Status labels + real SCORM % (Articulate) + filter tabs |
| 4 | SCORM progress number | Show the player's % instead of 0/100. Passed = always 100%. Not passed = capped at **99%**. It's for display only: completion, certificates and badges still need a Post Test pass (user, 2026-09-27) |
| 5 | Where the % shows | My Courses **and** the "…% Completed" label at the top of the course page |

---

## Live database/system validation: 2026-09-27

Read-only.

- **V1. Courses:** 1 course (id 77, `course_type='scorm'`, 1 lesson, 2 enrolments). **There are no normal courses in the local DB**, so testing them needs a test course (Phase last).
- **V2. Enrolments** (`enrol`, read by `User_model::my_courses`, `User_model.php:250-256`):
  - student 3: `watch_histories` none; `scorm_tracking` has a bookmark and suspend_data (1357 bytes), status NULL.
  - student 4: `watch_histories` progress 100, `completed_date` set; `scorm_tracking` status `passed`, score 90; certificate 1.
- **V3. Decoded Rise suspend_data:**
  - student 3: `progress.p = 10`, Post Test not taken.
  - student 4: `progress.p = 13`, Post Test score 90.
  - `progress.p` matches the player's "13% COMPLETE" label (screenshot 2026-09-27). So `p` is the player's own overall %, not the website's.
- **V4. Table definitions:** `watch_histories.course_progress int NOT NULL`, and `completed_lesson` / `quiz_result` are `longtext NOT NULL` with no default (`SHOW COLUMNS`). `scorm_tracking.date_updated` is stored as `strtotime(date('d M Y'))`, i.e. day only (`Scorm_model.php:99`).
- **V5. Expiry:** `enrol.expiry_date` is NULL or 0 for lifetime access, otherwise a unix time. The page already uses `expiry_date > 0 && expiry_date < time()` for expired (`my_courses.php:83,94`).

## Audit findings

1. **Normal courses get a `watch_histories` row when first opened** (`Crud_model::update_last_played_lesson`, `Crud_model.php:4320-4349`). It has 0 progress and an empty `completed_lesson`. Per decision 2, that row alone is **not** "In progress"; at least one valid completed lesson is required.
2. **SCORM courses skip `update_last_played_lesson`** (`Home.php:888-916`: only `general` calls it). Their "started" signal is a `scorm_tracking` row, created on the player's first save (`Scorm_model.php:115-125`).
3. **`course_progress()` rewrites `watch_histories` when it reads it** (`common_helper.php:612-620`), and returns the valid completed lesson IDs when `$return_type == 'completed_lesson_ids'` (`common_helper.php:602-604`). `course_status()` must reuse it rather than re-query, so there's one source of truth.
4. **Completed signals:** `course_progress >= 100`; `watch_histories.completed_date` (set by `update_watch_history_manually` and the duration path); the certificate URL from `Certificate_model::get_certificate_url` (`Certificate_model.php:100-112`).
5. **The Rise LZW format** is `{"v":2,"d":[codes],"cpv":…}`. It decodes with the standard LZW scheme (codes ≥ 256 are dictionary entries). This was verified in this session: re-encoding reproduced the stored data byte-for-byte. Non-Rise packages or unexpected data must fall back to "In progress" without a %.
6. **The page already handles expiry for the button and date** (`my_courses.php:83-110`: "Join again" when expired). The Expired status must match that exact test.
7. **Design system:**
   - `gp_ds_badge($label, $tone)` with tones `primary|secondary|success|warning|danger|neutral` (`design_system_helper.php:133-145`);
   - `gp_ds_button` is already used on the page;
   - the student page styles are in `assets/design-system/gp-student.css` (`.gp-student-course-progress` at line 365);
   - tabs are styled in `assets/design-system/gp-nav-tabs.css`.
8. **There's no other consumer of the My Courses markup.** `Home::my_courses_by_category` loads `reload_my_courses`, which doesn't exist in `default-new` (`ls views/frontend/default-new`), so it's dead code and out of scope.
9. **Prior decision:** keep plain-language UI labels (memory: non-technical explanations). The client gaps are recorded in memory `project-client-requirements-gaps`.

**Status rule**

Rules are checked in order; the first match wins.

| Order | Status | Rule |
| --- | --- | --- |
| 1 | **Expired** | `enrol.expiry_date > 0 && expiry_date < time()` |
| 2 | **Completed** | `course_progress() >= 100` |
| 3 | **In progress** | Normal course: ≥ 1 valid completed lesson (`course_progress(…, 'completed_lesson_ids')` not empty). SCORM course: a `scorm_tracking` row exists with a non-empty `suspend_data` or `lesson_location` |
| 4 | **Not started** | Otherwise |

**% shown**
- Normal courses: `course_progress()` (unchanged).
- SCORM courses:
  - Completed → 100.
  - In progress → Rise `progress.p`, **capped at 99** (a student can view every page without passing). If it doesn't decode, show no %, just "In progress".
  - Not started → 0.

---

## Plan validation and dependency audit: 2026-09-27

Every student-facing place that shows course progress was listed with `grep course_progress|check_course_progress` over `application/views` and `application/controllers`, excluding the admin/instructor backends, mobile views and the `update_7.2` copy.

| # | Place | Shows | Covered by plan? |
| --- | --- | --- | --- |
| P1 | My Courses card (`my_courses.php:34,64,66`) | `course_progress()` | ✅ Task 2.1 |
| P2 | Course page top label (`lessons/index.php:96-98`) | `watch_histories.course_progress`, only when a lesson is done | ✅ Task 2.3 |
| P3 | **Certificate tab** (`lessons/certificate_progress.php:4,28`): circle and "You have completed N% of the course" | `course_progress()`, so a SCORM student partway shows **0%** | ❌ **Missing. Added as Task 2.4** |
| P4 | Live update after passing (`scorm_course_content_body.php:112-118`) | Server reply `course_progress` (0/100) | ✅ Task 2.3 (text only). Fires only on a pass, which is correct, because passed = 100% |
| P5 | `Home::check_course_progress` (`Home.php:1449-1452`) | Echoes `course_progress()` | Not student-visible: no caller in `views/` or `assets/` (grep). No change |
| P6 | Mobile API (`Api_model.php:605,890,1163`) | `course_progress()` 0/100 | ❌ Out of scope. **The app will still show 0%/100% for SCORM**; follow-up |
| P7 | Admin/instructor progress and CSV (`Admin.php:3470`, backend views) | `watch_histories` | Out of scope (client question 4 plan). Should reuse `course_status()` |
| P8 | Certificate / badge / completion rules (`Certificate.php:56,138`, `Admin.php:2840`, `User.php:1044`, `Home.php:2247`) | `course_progress >= 100` | ✅ Must **not** change: the player's % is display-only |

**Other checks**

| Check | Result |
| --- | --- |
| `gp_ds_badge` escapes the label | Yes, `html_escape` in `views/components/design-system/badge.php` |
| Tab styles available on My Courses | Yes, `gp-nav-tabs.css` is loaded (`frontend/default-new/includes_top.php:51`). Use `.nav-tabs .nav-item .nav-link` with `.active` |
| CSS cache-busting | `gp-student.css` is loaded as `?v=student-18` (`includes_top.php:73`). **Must bump it to `student-19`**, or browsers keep the old styles. Added to Files |
| `$watch_history` in `my_courses.php:33` | Only assigned, never read (grep). Safe to remove with `$course_progress` |
| Expired students on the course page | `Home::lesson` redirects expired students away (`Home.php:921-923`), so P2 and P3 never need an "Expired" label |
| `min(99, null)` in PHP 8 | Returns `null` only because `null` sorts below 99, which is fragile. **Use an explicit check** (`$p === null ? null : min(99, $p)`). Fixed in Task 1.2 |
| Admin/instructor previewing a SCORM course (not enrolled) | No `scorm_tracking` row, so the status is `not_started` and no label shows. That's acceptable |

## Scope and constraints

### In scope
- New helper `course_status($course_id, $user_id, $expiry_date)` and a Rise decoder `scorm_rise_progress_percent($suspend_data)` in `common_helper.php`.
- My Courses:
  - a status badge per course;
  - SCORM % from the player;
  - "Completed on …" plus a **Get certificate** button when there is one;
  - a "Continue" / "Start" label on the main button;
  - filter tabs (All / In progress / Completed / Not started / Expired) with counts;
  - sorting in the order In progress → Not started → Completed → Expired.

### Out of scope: do not change
- The mobile app's progress (P6) will still show 0%/100% for SCORM. Follow-up.
- How progress is calculated (`course_progress`), certificates, SCORM saving, and the course player.
- The admin report (client question 4; a separate plan).
- The mobile app API.
- The strict-mode insert risk in `update_last_played_lesson` (audit note 4). Flagged as a follow-up, not changed here.

### Non-negotiable safety constraints
- `course_status()` is **read-only apart from what `course_progress()` already does**. No new writes.
- Invalid or huge `suspend_data` must never break the page: cap the decode at 1 MB, catch every error, and fall back.
- Output-escape all labels. Titles are already rendered as they are today; don't change that.

### Contract

`course_status()` returns `['status' => 'not_started'|'in_progress'|'completed'|'expired', 'percent' => int|null, 'completed_date' => int|null, 'certificate_url' => string|null]`.

| Case | Actor | Data | Required outcome |
| --- | --- | --- | --- |
| SCORM halfway | Student 3 | tracking row, `p=10`, not passed | **In progress · 10%** |
| SCORM passed | Student 4 | progress 100, certificate | **Completed**, "Completed on 27 Sep 2026", Get certificate |
| SCORM enrolled, never opened | New student | no tracking row | **Not started · 0%** |
| SCORM, unreadable saved data | Student with non-Rise or corrupt `suspend_data` | tracking row | **In progress** (no %), page still renders |
| Normal course, only opened | Student | `watch_histories` row, 0 lessons done | **Not started** |
| Normal course, 1 of 4 lessons | Student | 1 valid completed lesson | **In progress · 25%** |
| Normal course, all lessons | Student | 100% | **Completed** |
| Expired enrolment | Student | `expiry_date` in the past, any progress | **Expired** (existing "Join again" button kept) |
| Filter tab | Student | click "Completed" | Only completed cards visible; counts correct; no reload |
| No enrolments | Student | none | Existing "No data found" card, no tabs |

## Files

| File | Change | Responsibility |
| --- | --- | --- |
| `application/helpers/common_helper.php` | Add `scorm_rise_progress_percent()` and `course_status()` | One status rule, shared later by the admin report |
| `application/views/frontend/default-new/my_courses.php` | Compute the status per enrolment; sort; render tabs, badges, %, completed line, certificate button, Continue/Start label | Show the status to the student |
| `application/views/lessons/scorm_course_content_body.php` | Live-update label text "100% Completed" (drop "(1/1)") | Consistent label format |
| `application/views/lessons/index.php` | For SCORM courses, show the top "…% Completed" label from `course_status()` | Same % at the top of the course page as on My Courses |
| `application/views/lessons/certificate_progress.php` | Show the `course_status()` % for the circle and the "You have completed N%" text. Keep `course_progress() == 100` for the "completed but score too low" branch | Certificate tab matches My Courses (P3) |
| `application/views/frontend/default-new/includes_top.php` | Bump `gp-student.css?v=student-18` to `student-19` | Browsers load the new styles |
| `assets/design-system/gp-student.css` | Small styles for the status row and filter tabs (reuse `gp-nav-tabs.css` classes where possible) | Look and feel |

## Phase 0: Failing checks first

No test runner exists; use manual checks.

### Task 0.1: Current behaviour
- [ ] Sign in as student 3 (enrolled in course 77, has SCORM tracking data) and open My Courses.
- [ ] Expected (FAIL): the course shows **0%**, with no status label and no filter tabs.

## Phase 1: Status helpers

### Task 1.1: Rise % decoder
**File:** `application/helpers/common_helper.php`
- [ ] Add, wrapped in `if (!function_exists(...))` like the other helpers:
  ```php
  // Articulate Rise keeps its own overall % inside suspend_data ({"v":2,"d":[LZW codes]}).
  // Returns 0-100, or null when the data isn't in that format.
  function scorm_rise_progress_percent($suspend_data)
  {
      if (!is_string($suspend_data) || $suspend_data === '' || strlen($suspend_data) > 1048576) return null;
      $wrapper = json_decode($suspend_data, true);
      if (!is_array($wrapper) || !isset($wrapper['d']) || !is_array($wrapper['d']) || count($wrapper['d']) === 0) return null;
      $codes = $wrapper['d'];
      $dict = []; $next = 256;
      $w = mb_chr((int) $codes[0], 'UTF-8'); $out = $w;
      for ($i = 1, $n = count($codes); $i < $n; $i++) {
          $k = (int) $codes[$i];
          if ($k < 256)              $entry = mb_chr($k, 'UTF-8');
          elseif (isset($dict[$k]))  $entry = $dict[$k];
          elseif ($k === $next)      $entry = $w . mb_substr($w, 0, 1, 'UTF-8');
          else return null;
          $out .= $entry;
          $dict[$next++] = $w . mb_substr($entry, 0, 1, 'UTF-8');
          $w = $entry;
      }
      $data = json_decode($out, true);
      $p = $data['progress']['p'] ?? null;
      return is_numeric($p) ? max(0, min(100, (int) $p)) : null;
  }
  ```
- [ ] Verify with a throwaway CLI script (in the scratchpad, not the repo) that student 3's stored `suspend_data` returns **10** and student 4's returns **13**.
- [ ] Run `/c/xampp/php/php.exe -l application/helpers/common_helper.php` → expect no errors.

### Task 1.2: `course_status()`
**File:** `application/helpers/common_helper.php`
- [ ] Add `course_status($course_id, $user_id = "", $expiry_date = null)`:
  1. If `$user_id` is empty, use the session user.
  2. If `$expiry_date > 0 && $expiry_date < time()` → `expired`. Still fill in `percent` from `course_progress()` so the card keeps its bar.
  3. `$progress = course_progress($course_id, $user_id)`.
  4. If `$progress >= 100` → `completed`, with `percent` 100, `completed_date` from `get_watch_histories(...)->row('completed_date')`, and `certificate_url` from `Certificate_model::get_certificate_url` when `addon_status('certificate')` (`null` if it returns `'#'`).
  5. SCORM course (`course_type == 'scorm'`): read `scorm_tracking` for (course, user). If the row has a non-empty `suspend_data` or `lesson_location` → `in_progress` with `$p = scorm_rise_progress_percent($row['suspend_data']); percent = ($p === null) ? null : min(99, $p);`, where `null` means no %. Otherwise → `not_started`, percent 0.
  6. Normal course: `count(course_progress($course_id, $user_id, 'completed_lesson_ids')) > 0` → `in_progress` with percent = round($progress); otherwise `not_started`, percent 0.
- [ ] Load the certificate model through `get_instance()` (the lesson in this session: models loaded late aren't reachable through `$this` in views).
- [ ] Run `php -l` → expect no errors.

**Phase constraints:** don't change `course_progress()` itself.

## Phase 2: My Courses page

### Task 2.1: Compute, sort and render
**File:** `application/views/frontend/default-new/my_courses.php`
- [ ] After loading `$enrolments` (line 1), build `$rows` where each item holds `enrolment`, `course_details` and `status` (from `course_status($course_id, $user_id, $enrolment['expiry_date'])`). Skip enrolments whose course no longer exists.
- [ ] Sort `$rows` in this order: in_progress, not_started, completed, expired. Keep the enrolment order within each group.
- [ ] Above the list, render the filter tabs with counts: **All (n) · In progress (n) · Completed (n) · Not started (n) · Expired (n)**. Hide a tab when its count is 0, except All. Use the `gp-nav-tabs` classes.
- [ ] Loop over `$rows` instead of `$enrolments`. Add `data-status="<status>"` on the card wrapper (`gp_ds_card` `extra_class` or an outer div).
- [ ] Replace the progress block (lines 59-64) with:
  - the status badge via `gp_ds_badge()`. Tones: in_progress = `primary`, completed = `success`, not_started = `neutral`, expired = `danger`. Labels come from `get_phrase('In progress')` and so on;
  - the bar and % when `percent !== null`;
  - when there's no %, the bar is hidden and only the badge shows.
- [ ] Completed: add a line "Completed on d M Y" when `completed_date` is set, and a **Get certificate** button (`gp_ds_button`, `variant` outline, opens in a new tab) when `certificate_url` is set.
- [ ] Main button label: "Continue" for in_progress and completed, "Start Now" for not_started. Keep "Join again" for expired, exactly as today (lines 94-102).
- [ ] Remove the now-unused `$course_progress` variable (line 34).
- [ ] Run `php -l` → expect no errors.

### Task 2.2: Filter behaviour and styles
**Files:** `my_courses.php` (inline script at the bottom, matching the page's style), `assets/design-system/gp-student.css`
- [ ] Clicking a tab toggles `.d-none` on cards whose `data-status` doesn't match, and marks the tab active. There's no reload. Remember the chosen tab in `localStorage`, wrapped in try/catch.
- [ ] Add minimal CSS for the status row (badge next to the bar) and tab spacing. Use existing design tokens (`var(--gp-*)`); no new colours.

**Phase constraints:** no change to the dropdown, rating stars, live class include or expiry text.

### Task 2.3: Top-of-course-page label for SCORM
**File:** `application/views/lessons/index.php`
- [ ] At lines 96-98, the label only renders when `$watch_history['completed_lesson']` isn't empty, and it shows `course_progress`. For `course_type == 'scorm'`, instead render `$gp_status = course_status($course_details['id'])`, with no expiry argument, because expired students are redirected before this page renders (`Home.php:921-923`):
  - `completed` → "100% Completed";
  - `in_progress` with a % → "N% Completed";
  - `in_progress` without a % → "In progress";
  - `not_started` → no label, as today.
  Normal courses keep the existing markup unchanged.
- [ ] The live update after passing (`gpScormShowResult` in `scorm_course_content_body.php`) already sets this label to "100% Completed (1/1)". Change its text to "100% Completed" so the format matches. **This is a one-line edit, so add `scorm_course_content_body.php` to the Files table.**
- [ ] Run `php -l` on both files → expect no errors.

### Task 2.4: Certificate tab shows the same %
**File:** `application/views/lessons/certificate_progress.php`
- [ ] At the top, add `$gp_status = course_status($course_id);` and `$gp_display = $gp_status['percent'] ?? 0;`.
- [ ] Use `$gp_display` for the circle (`data-percent` and label, line 4) and the "you have completed N% of the course" text (line 28).
- [ ] **Keep** `course_progress($course_id) == 100` on line 18 unchanged. That rule is about completion, not display.
- [ ] Run `php -l` → expect no errors.

### Task 2.5: Cache-bust the stylesheet
**File:** `application/views/frontend/default-new/includes_top.php`
- [ ] Line 73: `?v=student-18` → `?v=student-19`.

## Phase last: Regression verification and rollout

- Lint the 3 files (`php -l` for the 2 PHP files).
- To test normal courses, create a **local-only** test course as admin (normal type, 4 lessons), enrol the test student, and tick 1 lesson. Delete it afterwards.

**Smoke tests**

| Student | Course | Expected on My Courses |
| --- | --- | --- |
| 3 | #77 SCORM | **In progress · 10%** on My Courses, "10% Completed" at the top of the course page, and a **10%** circle and "You have completed 10%" in the Certificate tab |
| 3 | #77, player % set to 100 but not passed (scratch-tested decode only) | Shows **99%**, not 100% |
| 4 | #77 SCORM | **Completed**, completion date, Get certificate |
| 4 | Test normal course, only opened | **Not started · 0%** |
| 4 | Test normal course, 1 of 4 ticked | **In progress · 25%** |
| 4 | Test normal course, all ticked | **Completed** |
| 4 | Any course with `expiry_date` set in the past (local test edit, reverted after) | **Expired**, "Join again" |
| 4 | Click each tab | Only matching cards visible; counts match |
| 4 | Dark mode and phone width (375px) | Badges and tabs readable; no horizontal scroll |

**Data checks:** none. This change only reads data.

## Rollback

1. Revert the commit. There's no data to undo, because the feature doesn't write anything new.

## Commit

```bash
git add application/helpers/common_helper.php application/views/frontend/default-new/my_courses.php application/views/lessons/index.php application/views/lessons/scorm_course_content_body.php application/views/lessons/certificate_progress.php application/views/frontend/default-new/includes_top.php assets/design-system/gp-student.css
```

Message: `feat: show Not started / In progress / Completed / Expired status on My Courses`, ending with the attribution line.

This is a separate commit from the certificate fixes, which are still uncommitted.

## Self-review

1. **Contradictions:** none. The player's % is display-only; completion still comes from `course_progress()` = 100 (Post Test pass). "No writes" is consistent: `course_progress()`'s existing rewrite behaviour is reused, not added.
2. **Goal reachability:**
   - Existing data: students 3 and 4 get the right statuses (V2, V3).
   - Future data: new SCORM students get a tracking row on the player's first save.
   - Normal courses get completed lessons through the existing paths.
3. **Bypass:** not applicable. The feature is display-only, and each student only sees their own enrolments (`User_model::my_courses` uses the session user).
4. **Existence:** these were all read in this session:
   - helpers and models: `course_progress`, `get_watch_histories`, `get_certificate_url`, `gp_ds_badge`, `gp_ds_button`, `addon_status`;
   - tables: `scorm_tracking`, `enrol.expiry_date`;
   - files: `gp-student.css`, `gp-nav-tabs.css`.
   `mb_chr` needs the mbstring extension; it is installed (`php -m` lists `mbstring`). The decoder in Task 1.1 was run on 2026-09-27 as a scratch script (not in the repo) against the live rows: student 3 gave **10**, student 4 gave **13**, and garbage input and bad LZW codes both gave `null`.
5. **Consistency:** the Files table matches the phases and the `git add` list (7 files).
6. **Duplication:** a single status helper is added, intended to be reused by the admin report (client Q4) so the two never disagree.
7. **Placeholders:** none.

**Checklist sections not applicable:**
- D (RLS/authorization): no new write paths.
- Migrations: none.
