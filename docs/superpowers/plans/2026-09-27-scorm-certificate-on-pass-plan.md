# SCORM Certificate on Pass Implementation Plan

**Goal:** When a student passes a SCORM course's final test (80% or more), the course progress bar shows 100% and the certificate is created automatically, the same way it works on standard LMSs.
**Root cause:** The SCORM player posts lesson ID `0` because SCORM courses are opened without a lesson ID (`application/views/lessons/scorm_course_content_body.php:79`, `application/controllers/Home.php:874-916`). On top of that, the first time any student finishes, the certificate check is skipped (`application/models/Crud_model.php:3881-3892`). So a passing student gets 0% and no certificate.
**Approach:** Work out the SCORM lesson on the server instead of trusting the browser, make sure every SCORM course has exactly one SCORM lesson, run the certificate check in the "first progress record" path too, and make the SCORM certificate require a reported score of 80 or more. The SCORM runtime and resume support stay as they are.
**Tech stack:** PHP 8.3.29 (XAMPP), CodeIgniter 3, MariaDB/MySQL (`academy_lms`), jQuery. There is no automated test suite in the repo.
**Source:** User request in chat on 2026-09-27: "i need the system to generate certificate once they hit 80% of their learning". Asked what 80% means, the user replied: "how does the standard scorm courses behaves". Standard behaviour is that the package decides "passed" and the LMS issues the certificate.

## Open questions (resolve before implementing)

All four questions were answered by the user on 2026-09-27.

| # | Question | Answer |
| --- | --- | --- |
| 1 | Is "80%" the **Post Test score** or **80% of the content viewed**? | **Post Test score of 80% or more** (user: "yes"). |
| 2 | Course #77 "Practical Leadership: Leading Teams & Driving Results" contains the "Improving Self-Awareness" package. Is that right? | Audited all packages (see "Client package audit" below). "Practical Leadership" **is not in the client's course list** and has no package of its own. Course #77 is a test/placeholder course. This is not a code issue; the admin should rename it or replace it with the real course. |
| 3 | Show "In progress" instead of "0%"? | **Later.** Out of scope. |
| 4 | Packages with no score? | "There is always a quiz at the end." The audit confirms that all 139 packages have a scored Post Test. So **tighten the gate**: a SCORM certificate requires a reported score of 80 or more, and a missing score blocks it (Phase 2, Task 2.2). |

## Client package audit: 2026-09-27

Read-only scan of every package inside the 7 bundles in `C:\Users\Rovick\Downloads\courses\Copy of *.zip`. Each inner zip's `imsmanifest.xml` and Rise course data were read. For 2 newer-format exports, the data was read from `scormcontent/locales/und.js`.

- **139 packages**, all SCORM 1.2.
- **All 139** have the same finish settings: finish when the quiz is passed (`completeWith: quiz`), report `passed-incomplete`, the tracked quiz is the "Post Test"/"Post-Test", **pass mark 80**, **20 questions**, and unlimited retries (`retryCount -1`).
- In 137 packages the Post Test is the last item. In 2 (Practical Bookkeeping, Budgets and Financial Reports), a "Course Summary" page follows it. That doesn't matter, because completion fires on passing the test.
- The client's list (`Courses, Description, & Images.xlsx`) has 139 courses, matching the 139 packages one-to-one. 5 differ only in wording: Basic/Practical Bookkeeping, Learning/mLearning Essentials, Project Management (7th Edition), Diversity Equity and Inclusion / Diversity and Inclusion in the Workplace, and Trust Building and Resilience (Development). One file name has a typo ("Sensivity_Training") but its title inside is correct.
- There is **no** "Practical Leadership" package.
- `uploads/scorm/courses/e951935d8b53e453adec7a89355be49c` (Trust Building and Resilience Development) is not linked to any course in `scorm_curriculum`. It is a leftover from an earlier upload; cleanup is out of scope.
- **Conclusion:** the one code fix in this plan works for every client course. No package needs re-exporting.

---

## Live database/system validation: 2026-09-27

Read-only; no data was changed.

- **V1. SCORM courses:** `SELECT … FROM course WHERE course_type='scorm'` returns 1 row: course #77, with **1** `lesson` row (id 890, `lesson_type='scorm'`, section 313).
- **V2. All lessons:** `SELECT lesson_type, COUNT(*) FROM lesson GROUP BY lesson_type` returns only `scorm: 1`.
- **V3. Tracking:** `scorm_tracking` has 2 rows (course 77, students 3 and 4). For both, `lesson_status` and `score_raw` are NULL, and `suspend_data` holds resume data. There is **no** `watch_histories` row for either student, and there are **0** `certificates` rows for course 77.
- **V4. Add-ons:** `addons` shows `certificate=1` and `scorm_course=1`.
- **V5. Package settings** (`uploads/scorm/courses/bdffd8ee…/scormcontent/index.html`, `courseData.exportSettings`):
  - `target: scorm12`
  - `completeWith: "quiz"`
  - `quizId` = the **Post Test** lesson (last of 74 items)
  - `reporting: "passed-incomplete"`
  - `passingScore: 80`
  - Package title: "Improving Self Awareness"
- **V6. Table definition:** `watch_histories.quiz_result` is `longtext NOT NULL` with no default. The insert path doesn't set it. It works locally because the global `sql_mode` has no `STRICT_*` and `database.php:93` has `stricton => false`. Production `sql_mode` is **UNVERIFIED**. The plan removes the risk anyway: Task 2.1 sets `quiz_result` explicitly on insert, so it works in strict mode too.
- **V7. Enrolment:** `enrol` has 2 rows for course 77.
- **V8. Student decode:** decoding Rise `suspend_data` shows student 3 has completed several sections and student 4 is partway through a section. Neither has passed the Post Test.

## Audit findings

1. **The lesson ID is lost for SCORM courses.** Every "Start/Continue" link uses `home/lesson/<slug>/<course_id>` with no lesson ID (`application/views/frontend/default-new/my_courses.php:106`, `course_page.php:199,346`). For `course_type=='scorm'`, `Home::lesson()` never sets `$lesson_id` (`application/controllers/Home.php:913-916`). So `$lesson_details` is empty and the player sends `gpScormLessonId = 0` (`scorm_course_content_body.php:79`).
2. **The controller trusts the posted lesson ID.** `Home::save_scorm_progress()` reads `lesson_id` from POST and marks it complete (`application/controllers/Home.php:1635-1647`). With 0, it records the non-existent lesson 0.
3. **The progress helper removes lesson 0 again.** `course_progress()` intersects completed IDs with real lesson IDs and rewrites `watch_histories` (`application/helpers/common_helper.php:590-620`). So lesson 0 is dropped and the bar returns to 0%.
4. **No certificate check on the first finish.** In `Crud_model::update_watch_history_manually()`, the branch for an existing row calls `check_certificate_eligibility` at 100% (`Crud_model.php:3876-3880`). The branch for a new row inserts and returns without calling it (`Crud_model.php:3881-3892`). This affects **general courses too**, for example a student who finishes a 1-lesson course with one tick.
5. **Division by zero.** The same function computes `100 / $total_lesson` (`Crud_model.php:3847,3863,3883`). A SCORM course with no `lesson` row would throw `DivisionByZeroError` on PHP 8.
6. **Nothing creates or deletes the SCORM lesson row.** Deleting a SCORM course removes only `scorm_curriculum` and its files, not its lesson/section (`Crud_model.php:1125-1135`). No code writes `lesson_type='scorm'`: a grep for `lesson_type.*scorm` finds only readers in `views/lessons/sidebar.php`. `Scorm_model::add_curriculum()` (`application/models/addons/Scorm_model.php:31-81`) only writes `scorm_curriculum`. Lesson 890 was added by hand, so any **new** SCORM course would have 0 lessons (see finding 5).
7. **No enrolment check.** `save_scorm_progress` only checks `user_login` (`Home.php:1624-1626`). Any logged-in user can post a course ID and create tracking or completion. `enroll_status()` already exists (`application/helpers/user_helper.php:63-83`).
8. **The certificate score gate is already in place.** `Certificate_model::check_certificate_eligibility()` blocks when `score_raw < 80` (`application/models/addons/Certificate_model.php:21-26`). The score is saved before completion is triggered (`Home.php:1628` then `:1633`), so the gate sees the fresh score.
9. **Readers of the result.** These read `watch_histories` or `course_progress()` and need no change once the real lesson is recorded:
   - learner bar: `views/lessons/index.php:97`, `views/lessons/certificate_progress.php:4-28`
   - My Courses: `views/frontend/default-new/my_courses.php`
   - admin/instructor progress: `Admin::student_academic_progress` (`Admin.php:2806`), `User.php:1014`
   - CSV export: `Admin::export_student_progress_csv` (`Admin.php:3444`)
10. **Prior decision.** Commit `e21a27b` (2026-09-26) set the requirement: "pass 80% on the final Knowledge Test". The sidebar comment at `views/lessons/sidebar.php:122` says SCORM completion is reported by the package, not self-ticked. Both are honoured here.

**Variants**

| Variant | Supported today? | Change needed |
| --- | --- | --- |
| SCORM course with a lesson row (#77) | No, lesson 0 is posted | Work out the lesson on the server |
| SCORM course without a lesson row (future uploads) | No, divide by zero | Create the lesson on upload, plus a divide-by-zero guard |
| General course, first completion reaching 100% | No certificate check | Add the check to the insert branch |
| General course, later completions | Yes | None |

---

## Dependency re-audit: 2026-09-27 (second pass)

These are every other place that marks a lesson complete, reads the progress, or issues a certificate. They were checked because the first pass only followed the main path.

**Other ways a SCORM lesson can be marked "done" without passing the test**

| # | Path | What happens today | Risk |
| --- | --- | --- | --- |
| D1 | Web `home/update_watch_history_manually` (`Home.php:1614`, the checkbox endpoint) | The sidebar hides the checkbox for SCORM (`sidebar.php:121-124`), but the URL still accepts any `lesson_id`, with no lesson-type or enrolment check | A student can post lesson 890 → 100% bar without passing |
| D2 | Web `home/update_watch_history_with_duration` → `Crud_model.php:4332-4428` | For a drip-enabled course, a SCORM lesson has no `duration`, so `$lesson_total_seconds` = 0 and the lesson completes right away. It also calls `explode()` on NULL | Same as D1. Only affects SCORM courses with drip content on |
| D3 | Mobile API `save_course_progress_get` (`Api.php:382`, `Api_model.php:875-881`) | Marks any `lesson_id` complete for the token's user | Same as D1, from the app |
| D4 | Mobile API `update_watch_history_post` (`Api.php:804`, `Api_model.php:1350+`) | Same duration logic as D2 | Same as D2 |

**Certificate paths that ignore or mis-handle the 80% gate**

| # | Path | What happens today | Risk |
| --- | --- | --- | --- |
| D5 | Mobile API `certificate_addon_get` (`Api_model.php:975-1000`) | If `course_progress == 100`, it **inserts the certificate directly** and never calls `Certificate_model` | **A certificate without passing**, combined with D3. This is the most serious gap. |
| D6 | `Certificate::check_certificate_eligibility` AJAX (`controllers/addons/Certificate.php:51-62`) | Echoes `1` when progress ≥ 100 even if the gate blocked the certificate | The UI says the certificate is ready when it isn't |
| D7 | Admin/instructor "student certificate" (`Admin.php:2836-2846`, `User.php:1040-1048`) | Redirects to `certificate/<shareable_url>` even when no certificate row was created | Broken page instead of a clear message |

**Readers that behave fine and need no change:** `course_progress()` callers (`my_courses.php:34`, `certificate_progress.php`, `Home::check_course_progress`, `Api_model.php:605,890,1163`), admin/instructor progress views, and the CSV export. They all count real lessons and will show 100% once lesson 890 is recorded. Lesson-count displays (course cards, admin lists, `Api_model.php:606,803,888`) already show "1 lesson" for course #77, because lesson 890 already exists. New uploads will look the same.

**Cosmetic, out of scope:** the certificate template's `{total_duration}` (`views/certificate/index.php:53,90`) sums `lesson.duration`. SCORM lessons have none, so it shows "0 hours". Flagged for the admin to avoid that placeholder, or for a later change.

## Plan validation: 2026-09-27 (third pass)

Every step was checked against the current code:

| Check | Result |
| --- | --- |
| `enroll_status()` available in `Home` | Yes, the `user` helper is autoloaded (`config/autoload.php:92`) |
| Test students enrolled in #77 | Yes, users 3 and 4, with no expiry (`enrol` table) |
| CSRF would block the player's `sendBeacon` post | No, `csrf_protection = FALSE` (`config/config.php:465`) |
| `scorm_model` loaded in `save_scorm_progress` | Yes, `Home.php:1627` |
| The learner's certificate tab already handles "100% but score too low" | Yes, `views/lessons/certificate_progress.php:18-23`. No change needed |
| Score scale | Rise sends the score through `SetScore(score, max, min)` (`scormdriver.js`). **UNVERIFIED** that it's 0–100: confirm in the smoke test that `scorm_tracking.score_raw` matches the % shown in the player |

**Corrections made in this pass:**
1. **Pass and score arrive in separate calls.** Added a certificate re-check when the lesson is already complete (Task 1.2).
2. **The mobile certificate uses a different link format** (`.jpg` image). The plan now keeps the mobile flow and only adds the shared score rule (`passes_scorm_gate`, Tasks 2.2 and 2.5), instead of replacing it.
3. **Existing bug:** a new `watch_histories` row stored progress in `date_added`. Fixed in Task 2.1.
4. **Missing code:** the `course.section` update was described but not shown. Added to the Task 1.1 code. Tasks were also reordered to 2.1–2.5.

## Scope and constraints

### In scope
- The server works out the SCORM lesson ID, and the posted `lesson_id` is ignored.
- Every SCORM course has exactly one `lesson_type='scorm'` lesson; it is created on upload if missing.
- Certificate check on the first-completion (insert) path.
- A guard against `$total_lesson == 0`.
- An enrolment check in `save_scorm_progress`.
- The SCORM certificate gate requires a score (a missing score blocks it; answer 4).
- Only the SCORM package report can complete a SCORM lesson: D1–D4 refuse `lesson_type='scorm'`.
- Every certificate path goes through `Certificate_model` and reports honestly when it's blocked (D5–D7).

### Out of scope: do not change
- SCORM runtime API, resume data, and the chunked upload.
- Showing "In progress" on the bar (open question 3).
- Reading Articulate `suspend_data` for a percent value (open question 1).
- Replacing course #77's package (open question 2).
- Client-side spoofing of "passed" plus a score. This is a limitation of SCORM 1.2 itself: the package runs in the browser.

### Non-negotiable safety constraints
- Never trust `lesson_id` from the browser for completion.
- Never toggle a completed lesson back to incomplete from a package report (keep the existing guard at `Home.php:1643-1647`).
- Don't touch existing `scorm_tracking` rows.

### Contract

`POST home/save_scorm_progress` accepts `course_id`, `lesson_status`, `score_raw`, `lesson_location`, `suspend_data`. The `lesson_id` field is accepted but ignored. The response body is empty (same as now).

| Case | Actor | Input | Required outcome |
| --- | --- | --- | --- |
| Pass | Enrolled student, no `watch_histories` row | status `passed`, score 85 | Lesson 890 is recorded, progress 100, 1 certificate row |
| Pass, row exists | Enrolled student with a row | status `passed`, score 90 | Same as above; no duplicate certificate |
| Fail | Enrolled student | status `incomplete`, score 60 | Score is saved; no completion; no certificate |
| Pass with a low score | Enrolled student | status `passed`, score 70 | Completion is recorded (100%), but the certificate is blocked by the gate |
| Pass with no score | Enrolled student | status `passed`, no score | Completion is recorded, no certificate |
| Repeat report | Student already complete | status `passed` again | Stays complete; not toggled |
| Resume only | Enrolled student | only `suspend_data` | Tracking is updated; no completion |
| Not enrolled | Logged-in user not enrolled | any | Nothing is written |
| Not logged in | Anonymous | any | Nothing is written |
| Forged lesson | Enrolled student | `lesson_id=999` | Ignored; the server uses the course's SCORM lesson |
| New SCORM upload | Admin/instructor | upload zip for a course without a lesson | 1 section + 1 SCORM lesson created; a re-upload doesn't duplicate them |
| General course, 1st tick finishes it | Student | checkbox | Certificate check runs |
| Forge a completion | Student | POST `home/update_watch_history_manually` with lesson 890 | Nothing changes |
| Forge from the app | Student | API `save_course_progress` with lesson 890, then `certificate_addon` | No completion, no certificate |
| Admin opens a certificate for a student who hasn't passed | Admin | student_certificate | Clear message, no broken page |
| Delete SCORM course | Admin | delete course | Its `scorm_curriculum`, `lesson` and `section` rows are all removed |

## Files

| File | Change | Responsibility |
| --- | --- | --- |
| `application/models/addons/Scorm_model.php` | Add `get_scorm_lesson_id($course_id)` and `ensure_scorm_lesson($course_id)`; call `ensure_scorm_lesson` at the end of successful `add_curriculum` | Guarantee and find the single SCORM lesson |
| `application/controllers/Home.php` | In `save_scorm_progress`: enrolment check, lesson ID from `get_scorm_lesson_id` instead of POST, and pass `true` as the new 4th argument to `update_watch_history_manually` (Task 2.4) | Trustworthy completion reporting |
| `application/models/Crud_model.php` | In `update_watch_history_manually`: return early when `$total_lesson == 0`; call the certificate check in the insert branch when progress ≥ 100. In `delete_course`'s SCORM branch: also delete the course's `lesson` and `section` rows | First-finish certificate, no crash, no orphan rows |
| `application/models/addons/Certificate_model.php` | Move the SCORM rule into `passes_scorm_gate()`; block when the score is missing or below 80 | Certificate needs a real passing score |
| `application/models/Api_model.php` | `save_course_progress_get` and `update_watch_history_with_duration_post`: ignore SCORM lessons. `certificate_addon_get`: also require `Certificate_model::passes_scorm_gate()` before issuing (keep its own `.jpg` flow) | Close the mobile bypass (D3–D5) |
| `application/controllers/addons/Certificate.php` | `check_certificate_eligibility`: echo `1` only if a `certificates` row exists after the check | Honest "ready" status (D6) |
| `application/controllers/Admin.php` | `student_certificate`: if no certificate row after the check, show "Certificate requires passing the final test (80%)" instead of redirecting | Clear message (D7) |
| `application/controllers/User.php` | Same as Admin, for the instructor panel | Clear message (D7) |
| `application/views/lessons/scorm_course_content_body.php` | Stop posting `lesson_id` (remove `gpScormLessonId` and its two uses) | Remove the misleading field |

## Phase 0: Failing checks first

There is no PHPUnit or other test runner in the repo (no `tests/`, `phpunit.xml` or `composer` test script). Use manual, repeatable checks against the local DB.

### Task 0.1: Reproduce the bug
- [ ] Log in locally as enrolled student 3 or 4 (use a local test account; don't put credentials in this doc) and open course 77.
- [ ] In the browser console, simulate a pass:
  ```js
  jQuery.post('/academy/home/save_scorm_progress', {course_id: 77, lesson_status: 'passed', score_raw: 85, lesson_id: 0});
  ```
- [ ] Run:
  ```bash
  /c/xampp/mysql/bin/mysql.exe -uroot academy_lms -e "SELECT completed_lesson,course_progress FROM watch_histories WHERE course_id=77; SELECT COUNT(*) FROM certificates WHERE course_id=77;"
  ```
- [ ] Expected (FAIL): `completed_lesson=[0]` and **0** certificates. After reloading the lesson page, the bar shows 0%.
- [ ] Clean up this local test row afterwards (local only; never on production).

## Phase 1: SCORM lesson exists and is found on the server

### Task 1.1: `Scorm_model` helpers
**Files:** `application/models/addons/Scorm_model.php`
- [ ] Add:
  ```php
  public function get_scorm_lesson_id($course_id) {
      return (int) $this->db->select('id')->where(['course_id' => $course_id, 'lesson_type' => 'scorm'])
          ->order_by('id', 'asc')->limit(1)->get('lesson')->row('id');
  }

  // A SCORM course is tracked as one lesson so the normal progress/certificate code works.
  public function ensure_scorm_lesson($course_id) {
      if ($this->get_scorm_lesson_id($course_id) > 0) return;
      $section_id = (int) $this->db->select('id')->where('course_id', $course_id)->order_by('order', 'asc')->limit(1)->get('section')->row('id');
      if ($section_id <= 0) {
          $this->db->insert('section', ['course_id' => $course_id, 'title' => 'Course Content', 'order' => 1]);
          $section_id = $this->db->insert_id();
          $sections = json_decode($this->db->get_where('course', ['id' => $course_id])->row('section'), true);
          $sections = is_array($sections) ? $sections : [];
          $sections[] = $section_id;
          $this->db->where('id', $course_id)->update('course', ['section' => json_encode($sections)]);
      }
      $title = $this->db->get_where('course', ['id' => $course_id])->row('title');
      $this->db->insert('lesson', ['course_id' => $course_id, 'section_id' => $section_id, 'title' => $title,
          'lesson_type' => 'scorm', 'order' => 1, 'date_added' => time()]);
  }
  ```
- [ ] Columns were verified 2026-09-27 via `information_schema.COLUMNS`: `section` and `lesson` have **no** NOT NULL column without a default (other than the auto-increment ID). `lesson.order` is `int NOT NULL DEFAULT 0`, `lesson.date_added` is `int NULL`, and `section` has `title`, `course_id`, `order`, `start_date`, `end_date`, `restricted_by`.
- [ ] The code above also adds a new section's ID to the `course.section` JSON list, the way `Crud_model::add_section` does (`Crud_model.php:1373-1386`). Course #77 currently has `section = []` even though section 313 exists (V1). SCORM course pages don't read that list, but keep it consistent.
- [ ] In `add_curriculum`, call `$this->ensure_scorm_lesson($course_id);` just before **both** `return 'success';` lines (67-69 and 71-73).
- [ ] Run `/c/xampp/php/php.exe -l application/models/addons/Scorm_model.php` → expect "No syntax errors".

### Task 1.2: The controller uses the server-side lesson and checks enrolment
**Files:** `application/controllers/Home.php`
- [ ] In `save_scorm_progress()`, after the login check:
  ```php
  $course_id = (int) $this->input->post('course_id');
  if (enroll_status($course_id) !== 'valid') { return; }
  ```
  Admins and instructors previewing aren't enrolled, so their preview won't record progress. That is intended.
- [ ] Replace `$lesson_id = (int) $this->input->post('lesson_id');` with:
  ```php
  $lesson_id = $this->scorm_model->get_scorm_lesson_id($course_id);
  if ($lesson_id <= 0) { return; }
  ```
- [ ] Keep the "only toggle if not already complete" guard, but add an `else` branch: if the lesson is **already** complete, call `Certificate_model::check_certificate_eligibility($course_id, $user_id)` directly (when `addon_status('certificate')`). This is needed because Rise reports the pass and the score as separate calls (`SetPassed`, `SetScore`; hook list in the package's `scormcontent/index.html`), and our player batches commits with a 1.5-second debounce (`scorm_course_content_body.php:122-136`). If the "passed" commit arrives before the score, the tightened gate (Task 2.2) blocks the certificate, and without this branch the next commit (which carries the score) would never re-check it. Every commit resends the stored status, so the retry happens on the next commit or the next visit. `check_certificate_eligibility` never creates duplicates (`Certificate_model.php:32-33`).
- [ ] Pass `true` as the 4th argument in the existing `update_watch_history_manually($lesson_id, $course_id, $user_id)` call (see Task 2.4).
- [ ] Run `php -l` on the file → expect no errors.

### Task 1.3: Stop posting `lesson_id`
**Files:** `application/views/lessons/scorm_course_content_body.php`
- [ ] Remove `var gpScormLessonId` (line 79) and both `lesson_id: gpScormLessonId,` entries (around lines 93 and 109).
- [ ] Run `php -l` on the file → expect no errors.

**Phase constraints:** don't change the runtime API keys, commit debounce or resume data.

## Phase 2: Certificate on first finish and divide-by-zero guard

### Task 2.1: First-finish certificate check and no-lesson guard
**Files:** `application/models/Crud_model.php`
- [ ] Right after the `$user_id` defaulting (line ~3837), add:
  ```php
  $total_lesson = $this->db->get_where('lesson', ['course_id' => $course_id])->num_rows();
  if ($total_lesson == 0) {
      return json_encode(['lesson_id' => $lesson_id, 'course_progress' => 0, 'is_completed' => 0]);
  }
  ```
  Then remove the three repeated `$total_lesson = …` lines (3847, 3863, 3883).
- [ ] In the `else` (insert) branch, after `$this->db->insert('watch_histories', $insert_data);`, add:
  ```php
  $is_completed = 1;
  if (addon_status('certificate') && $course_progress >= 100) {
      $this->load->model('addons/Certificate_model', 'certificate_model');
      $this->certificate_model->check_certificate_eligibility($course_id, $user_id);
  }
  ```
- [ ] Also set `$insert_data['completed_date'] = $course_progress >= 100 ? time() : null;` to match the update branch, and `$insert_data['quiz_result'] = '';` so the insert doesn't fail on a strict-mode server (V6).
- [ ] Fix the existing bug `$insert_data['date_added'] = $course_progress;` (`Crud_model.php:3890`) to `time()`. Right now it stores the progress number as the date.
- [ ] Run `php -l` → expect no errors.

### Task 2.2: A SCORM certificate needs a score
**Files:** `application/models/addons/Certificate_model.php`
- [ ] At line 23, change `if ($score_raw !== null && $score_raw < 80)` to `if ($score_raw === null || (int) $score_raw < 80)`, and update the comment above it: all client packages end in a scored Post Test (see Client package audit).
- [ ] Run `php -l` → expect no errors.
- [ ] Put this rule inside the new `passes_scorm_gate()` (Task 2.5) so web and mobile share one rule.

### Task 2.3: Deleting a SCORM course also removes its lesson and section
**Files:** `application/models/Crud_model.php`
- [ ] In the `elseif ($course_type == 'scorm')` branch (`Crud_model.php:1125-1135`), add the same two deletes the `general` branch uses (lines 1118-1124): `lesson` by `course_id` and `section` by `course_id`. Today they are left behind, because only `scorm_curriculum` and the files are removed.
- [ ] Run `php -l` → expect no errors.

### Task 2.4: Only the package can complete a SCORM lesson (D1–D4)
**Files:** `application/models/Crud_model.php`, `application/models/Api_model.php`
- [ ] In `Crud_model::update_watch_history_manually`, add an optional 4th parameter `$from_scorm_package = false`. If the lesson's `lesson_type` is `scorm` and it's `false`, return without changes. `Home::save_scorm_progress` passes `true`. This one guard covers D1 and D3, since both call this function.
- [ ] In `Crud_model::update_watch_history_with_duration` (D2) and `Api_model::update_watch_history_with_duration_post` (D4), return early when the lesson's `lesson_type` is `scorm`.
- [ ] Run `php -l` on both files → expect no errors.

### Task 2.5: All certificate paths use the gate (D5–D7)
**Files:** `application/models/Api_model.php`, `application/controllers/addons/Certificate.php`, `application/controllers/Admin.php`, `application/controllers/User.php`
- [ ] D5: **don't** swap the mobile flow for the web one. The mobile path stores `shareable_url` with a `.jpg` suffix and generates an image with `create_certificate()` (`Api_model.php:991-1000`); the web path doesn't. Swapping them would break the link the app shows. Instead:
  - in `Certificate_model`, move the SCORM score rule into `public function passes_scorm_gate($course_id, $user_id)` (returns `true` for non-SCORM courses) and use it at the top of `check_certificate_eligibility`;
  - in `Api_model::certificate_addon_get`, change `if ($course_progress == 100)` to `if ($course_progress == 100 && $this->certificate_model->passes_scorm_gate($course_id, $user_id))`. A student at 100% who hasn't passed the gate gets `is_completed = 0` and an empty URL, the existing "not ready" response.
- [ ] D6: in `Certificate::check_certificate_eligibility`, after calling the model, `echo certificate_eligibility($course_id) ? 1 : 0;`.
- [ ] D7: in `Admin::student_certificate` and `User::student_certificate`, if `$certificate->num_rows() == 0` after the check, set the flash error "This student has not passed the final test (80%) yet" and redirect back, instead of redirecting to an empty certificate URL.
- [ ] Run `php -l` on all four files → expect no errors.

**Phase constraints:** the toggle behaviour for existing rows stays the same (the checkbox still un-ticks). Non-SCORM courses aren't affected by Task 2.2, because the check sits inside the `scorm_curriculum` branch.

## Phase last: Regression verification and rollout

- Lint: run `php -l` on all 9 files.
- Re-run Task 0.1 → expected: `completed_lesson=["890"]` (or `[890]`), `course_progress=100`, 1 certificate. The bar shows 100% and the certificate page opens.

**Smoke tests**

| Actor | Course | Action | Expected |
| --- | --- | --- | --- |
| Enrolled student | #77 | Actually pass the Post Test at 80% or more in the player | Bar 100%, certificate issued, certificate email sent |
| Enrolled student | #77 | Fail the Post Test | Bar 0%, no certificate |
| Enrolled student | #77 | Leave halfway, return | Resumes where they left off (no regression) |
| Not-enrolled user | #77 | Post a pass | Nothing written |
| Admin | New course | Upload a SCORM zip | 1 section + 1 SCORM lesson; re-upload keeps it at 1 |
| Student | General multi-lesson course | Tick all lessons | 100% and certificate (unchanged) |
| Student | #77 | POST `home/update_watch_history_manually` with lesson 890 (browser console) | Bar stays 0% |
| Student (mobile app / API) | #77 | `save_course_progress` with lesson 890, then `certificate_addon` | No completion, no certificate |
| Student | #77 after passing | Certificate "ready" check | Shows ready only when a certificate row exists |
| Admin | #77, student not passed | Open the student's certificate | Message "has not passed the final test (80%) yet", no broken page |
| Student | General course with drip content on | Watch a video to the end | Still completes (unchanged) |

**Data checks after deploy (read-only)**
```sql
SELECT c.id, (SELECT COUNT(*) FROM lesson l WHERE l.course_id=c.id AND l.lesson_type='scorm') AS n
FROM course c WHERE c.course_type='scorm';
```
Expected: `n = 1` for every SCORM course. Courses uploaded before this change with `n = 0` will get their lesson the next time the admin uploads their package. Alternatively, run a one-off script that calls `ensure_scorm_lesson` for them; currently no such course exists (V1).

Production `sql_mode` (V6) no longer blocks the deploy, because Task 2.1 sets `quiz_result`.

## Rollback

1. Revert the commit. The code goes back to its previous behaviour.
2. Section/lesson rows created by `ensure_scorm_lesson` and certificates issued stay. They are valid data, and the old code tolerates them: the old code would still count the lesson but never complete it.
3. There is no migration, so there is nothing else to undo.

## Commit

```bash
git add application/models/addons/Scorm_model.php application/controllers/Home.php application/models/Crud_model.php application/models/addons/Certificate_model.php application/models/Api_model.php application/controllers/addons/Certificate.php application/controllers/Admin.php application/controllers/User.php application/views/lessons/scorm_course_content_body.php
```

Message: `fix: issue SCORM certificates when the package reports passed` (on `main`, following the repo's recent commit style), ending with the attribution line.

## Self-review

1. **Contradictions:** none. The gate is tightened (Task 2.2) to match answer 4, and the audit backs it: all 139 packages report a score.
2. **Goal reachability:**
   - Existing course #77 has lesson 890, so the server finds it: yes.
   - Future uploads get a lesson from `ensure_scorm_lesson`: yes.
   - Students 3 and 4 haven't passed yet, so nothing needs backfilling (V3).
3. **Bypass:** second pass found D1–D7, closed by Tasks 2.4 and 2.5. The only remaining gap is client-side forgery of "passed" plus a score, which is inherent to SCORM 1.2 (the package runs in the browser) and out of scope.
4. **Existence:** these were confirmed by reading the files: `enroll_status`, `addon_status`, `check_certificate_eligibility`, `get_watch_histories`, `update_watch_history_manually`, `add_curriculum`, and the tables `lesson`, `section`, `watch_histories`, `scorm_tracking`, `certificates`, `enrol`. The section/lesson columns were checked in `information_schema` (Task 1.1).
5. **Consistency:** the Files table, the phases and `git add` all list the same 9 files. There is no test runner, so manual checks are used instead.
6. **Duplication:** this reuses the existing `lesson` / `watch_histories` mechanism. There is no new progress store.
7. **Placeholders:** none. The course path `/academy/` in the Task 0.1 JS assumes the local XAMPP base URL; adjust it if `base_url` differs.

**Checklist sections not applicable:**
- D (Postgres RLS): this is MySQL; authorization is app-level and covered in finding 7.
- G migrations: none needed.
