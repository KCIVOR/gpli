# Learner Progress Report Implementation Plan

**Goal:** Admins and instructors can see who completed which course and which courses are in progress, in one report and in each course's Academic progress tab. The mobile app shows the same status and % as the website.
**Root cause:**
- The admin and instructor per-course tab reads only `watch_histories` (`views/backend/admin/student_academic_progress.php:20-26`), so SCORM students who have started show "Not started yet" and 0%.
- There's no report across all courses.
- The only per-course download (`Admin::export_student_progress_csv`, `Admin.php:3450-3504`) isn't linked from any page (grep of `application/` and `assets/`) and hardcodes "out of 10".
- The mobile API sends `course_progress()` (0/100 for SCORM) (`Api_model.php:605,1163`).

**Approach:** Reuse the existing `course_status()` helper (`common_helper.php`, added for My Courses) everywhere, so the student, admin, instructor and app always agree. Add one shared data function, one new report page (admin + instructor), a CSV export, and update the per-course tab and the API. Progress, certificate and completion rules stay unchanged.
**Tech stack:** PHP 8.3.29, CodeIgniter 3, MariaDB `academy_lms`, jQuery, Bootstrap, the `gp_ds_*` design system. No automated tests.
**Source:** Client question 4 (WhatsApp, 2026-09-27): "Is there admin reporting that shows who completed what course and which courses are in process?" User decisions on 2026-09-27: admins **and** instructors; fix the mobile app **now**; fewer than 2,000 enrolments expected.

## Open questions (resolve before implementing)

None. The decisions were made by the user on 2026-09-27:

| # | Decision | Answer |
| --- | --- | --- |
| 1 | Report access | Admins (all courses) + instructors (only courses they're listed on) |
| 2 | Mobile app | Update now: same status and % as the website |
| 3 | Scale | Fewer than 2,000 enrolments, so calculate on the fly with paging (50 per page) |
| 4 | Status rules | Same as My Courses: Expired / Completed / In progress / Not started; SCORM % is the player's own, capped at 99 until passed |

---

## Live database/system validation: 2026-09-27

Read-only.

- **V1.** 1 course (#77 SCORM), 2 enrolments (users 3 and 4). There are **no normal courses** locally.
- **V2. Data per enrolment:**

  | Column | Source |
  | --- | --- |
  | Enrolled date | `enrol.date_added` |
  | Expiry | `enrol.expiry_date` |
  | Progress | `watch_histories.course_progress`, `completed_date`, `date_updated` (time) |
  | SCORM tracking | `scorm_tracking.lesson_status`, `score_raw`, `date_updated` (**day only**, `Scorm_model.php:99`), `suspend_data` |
  | Certificate | `certificates` (course_id, student_id) |

- **V3. `course_status($course_id, $user_id, $expiry_date)`** takes any user ID and has no session dependency when `$user_id` is passed (`common_helper.php`, read in full). It returns `status`, `percent`, `completed_date` and `certificate_url`.
- **V4. Cost per enrolment:** about 6–9 queries (`course_progress` ×1–2, `get_course_by_id`, the tracking row, the certificate). At 2,000 enrolments, calculating everything on every page load is heavy. Paging only helps if the status filter is applied **before** paging, which requires calculating every row. See Design: statuses are calculated for the **filtered set** (by course, student and dates, done in SQL first), with a hard cap of 2,000 rows per request.

## Audit findings

1. **Per-course tab (admin)** `views/backend/admin/student_academic_progress.php`:
   - it reads `watch_histories` directly (lines 20-26);
   - it shows "last seen", "Completed on", a progress bar, "Completed lesson X out of Y" and watched duration (lines 34-55);
   - its action buttons are quiz results and certificate (62-68).
   The **instructor copy** `views/backend/user/student_academic_progress.php` is identical except for the `admin/` → `user/` URLs (diff, 2 lines). Both are loaded by `Admin::student_academic_progress` (`Admin.php:2806`) and `User::student_academic_progress` (`User.php:1014-1025`). The instructor one checks that the user is in the course's `user_id` list (`User.php:1017-1021`).
2. **The CSV export is orphaned**: there's no link to `admin/export_student_progress_csv` anywhere, and it has the "out of 10" bug (`Admin.php:3483`). It will be **replaced** by the new report's export, with a per-course button on the tab.
3. **Admin authorization:** `admin_login` session check plus `check_permission('<slug>')` (`common_helper.php:130-140`). Slugs are listed in `views/backend/admin/admin_permission.php:5`. `has_permission()` returns true when an admin has **no** permissions row (full access, `common_helper.php:115-117`). The existing **Enrollments** menu is gated by `has_permission('enrolment')` (`navigation.php:301-323`). The learner report belongs there.
4. **Instructor menu:** `views/backend/user/navigation.php` (sales report at lines 140-148). The instructor controller is `User.php`. Its course ownership rule is `in_array($user_id, explode(',', $course['user_id']))` (`User.php:1017-1018`).
5. **Mobile API:**
   - `Api_model::my_courses_get` (`Api_model.php:594-610`) and `my_bundle_course_details_get` (`1152-1168`) set `completion = round(course_progress())`;
   - `course_completion_data` (`883-892`) returns `course_progress` after a lesson toggle (normal courses only; SCORM toggles are blocked by the earlier fix).
   The app's display code isn't in this repo, so **it's UNVERIFIED how the app renders it.** The change keeps the key names and types (`completion` stays an int) and **adds** a new `status` key, which older app builds will simply ignore.
6. **Rules that must not change:** certificates, badges and completion use `course_progress >= 100` (`Certificate.php:56,138`, `Admin.php:2840`, `User.php:1044`, `Home.php:2247`, `Api_model.php:984`).
7. **Design references:** `views/backend/admin/enrol_history.php` (list page layout in the admin shell); `gp_ds_card`, `gp_ds_badge`, `gp_ds_table` (`design_system_helper.php:44,65,133`); `assets/design-system/gp-admin-report.css` (existing report styles).

**Report columns:** Student (name and email) · Course · Status · Progress % · Test score (SCORM `score_raw`, otherwise "—") · Enrolled · Last activity · Completed on · Certificate (link or "—").

"Last activity" = the latest of `watch_histories.date_updated` and `scorm_tracking.date_updated`. The SCORM value is day-precision only, so it's shown as a date.

---

## Plan validation: 2026-09-27 (second pass, against current code)

| Check | Result |
| --- | --- |
| How backend pages load | `views/backend/index.php:30,35` includes `<role>/navigation.php` and `<role>/<page_name>.php`. Students and instructors have role `user` (`get_user_role`), so `page_name = 'learner_progress'` loads `backend/admin/…` for admins and `backend/user/…` for instructors. ✅ Matches the Files table |
| Design-system registration | Every backend page gets the design system unless excluded (`design_system_helper.php:19-28`), but `config/design_system_pages.php` keeps an **inventory** in `gp_ds_admin_pages` (line 104) and `gp_ds_user_pages` (line 199). ➕ **Added to Files:** list `learner_progress` in both, for consistency |
| `gp_ds_table` / `gp_ds_page_title` signatures | `gp_ds_table(['headers','rows','body_html','empty',...])`, `gp_ds_page_title($title, $actions)` (`design_system_helper.php:65-92`). ✅ Use `body_html` for the custom rows |
| Report CSS loaded in admin | `gp-admin-report.css?v=report-3` (`views/backend/includes_top.php:54`). ➕ **If that CSS changes, bump to `report-4`** (added to Files: `views/backend/includes_top.php`) |
| Line references | `export_student_progress_csv` is now at `Admin.php:3448` (was 3450); `enrol_history` at 462. User: constructor guards at 41-65, `sales_report` at 368. ✅ Updated |
| Instructor test data | Course #77 is owned by user 1 (`course.user_id = '1'`, `creator = 1`); **no instructor owns a course locally**. ➕ The smoke test needs a local-only instructor setup (see Phase last) |
| Student search | Query Builder `like` / `or_like` must be wrapped in `group_start()` / `group_end()`, or the OR clauses escape the course/instructor scope. **This is a security issue for the instructor scope.** ➕ Added to Task 1.1 |
| Date filter "to" | `enrol.date_added` is a unix time. "Enrolled to" must include the whole day (`23:59:59`). ➕ Added |
| CSV in Excel | Add a UTF-8 BOM (`ï»¿`) so names with accents open correctly. ➕ Added to Task 1.2 |
| Speed | Up to 2,000 rows × about 8 queries each is roughly 16,000 queries in the worst case. It's fine for today's data, but **measure it**: the smoke test times a full export. If it's over 5 s, a follow-up should batch-load the data per page |

## Scope and constraints

### In scope
- `learner_progress_rows($filters, $course_ids_allowed = null)` in a model: one SQL query over `enrol` joined with `users` and `course`, applying the course/student/date filters, capped at 2,000 rows. Then `course_status()` per row, plus score, last activity and certificate. Then the status filter, the summary counts and paging (50 per page).
- **Admin page** `admin/learner_progress` (menu: Enrollments → Learner progress, permission `enrolment`):
  - filters: course, student search, status, enrolled-from and enrolled-to dates;
  - summary tiles: Enrolled / In progress / Completed / Not started / Expired / Certificates;
  - the table and paging;
  - **Export CSV** using the same filters.
- **Instructor page** `user/learner_progress` (instructor menu): the same page, restricted server-side to the instructor's courses.
- **Per-course tab (admin and instructor):** use `course_status()` for the status badge, bar and %, show the SCORM score, fix the lesson-count wording for SCORM, and add an **Export CSV** button that links to the new export filtered to that course.
- Remove the orphaned `Admin::export_student_progress_csv`, replaced by the new export.
- **Mobile API:** `completion` becomes `course_status()['percent'] ?? 0`, and a new `status` key is added, in `my_courses_get` and `my_bundle_course_details_get`.

### Out of scope: do not change
- Completion, certificate and badge rules (finding 6).
- `course_completion_data` in the API (normal-course lesson toggles only).
- Scheduled or emailed reports.
- Any new database table or column. Everything is calculated on the fly (decision 3).

### Non-negotiable safety constraints
- **Instructor scope is enforced on the server**, in `User.php`, from the session user's courses. It's never taken from the browser. A `course_id` filter outside the instructor's courses returns nothing.
- Admin pages need `admin_login` **and** `check_permission('enrolment')`.
- CSV cells are escaped: double quotes doubled, and cells starting with `= + - @` prefixed with `'`, to stop spreadsheet formula injection.
- All filter inputs are cast or validated (`(int)` IDs; `Y-m-d` dates via `DateTime::createFromFormat`; status against a whitelist).
- The report is read-only apart from `course_progress()`'s existing rewrite behaviour.

### Contract

`learner_progress_rows()` returns `['rows' => [...], 'summary' => [status => count, 'certificates' => n], 'total' => n, 'capped' => bool]`.

| Case | Actor | Input | Required outcome |
| --- | --- | --- | --- |
| All learners | Admin | no filters | Students 3 and 4 on #77 with correct statuses; the tiles add up |
| SCORM halfway | Admin | student 3 | **In progress · 10%**, score "—" |
| SCORM passed | Admin | student 4 (in the passed state) | **Completed · 100%**, score, completion date, certificate link |
| Status filter | Admin | status = completed | Only completed rows; paging works |
| Export | Admin | filters applied, then Export | CSV with the same rows and columns; formula-safe |
| Instructor scope | Instructor of #77 | no filters | Only #77 learners |
| Instructor tampering | Instructor | `course_id` of a course they don't teach | Empty result |
| No permission | Admin without `enrolment` | open the page | Redirect with "not authorized" (existing `check_permission`) |
| Per-course tab | Admin | #77 → Academic progress | Same status and % as the report and the student's My Courses |
| Over 2,000 rows | Admin | a broad filter | First 2,000 processed; notice "Too many results; narrow by course or date" |
| Mobile | Student 3 via app | my_courses | `completion: 10`, `status: "in_progress"` |

## Files

| File | Change | Responsibility |
| --- | --- | --- |
| `application/models/Crud_model.php` | Add `learner_progress_rows()` and `learner_progress_csv()`; remove nothing else | Shared data for page, export and tabs |
| `application/controllers/Admin.php` | Add `learner_progress()` (page and `?export=csv`); remove `export_student_progress_csv()` | Admin report and auth |
| `application/controllers/User.php` | Add `learner_progress()` (page and export) scoped to the instructor's courses | Instructor report and scoping |
| `application/views/backend/admin/learner_progress.php` | **New** page: filters, tiles, table, paging, export button | Admin UI |
| `application/views/backend/user/learner_progress.php` | **New**, a thin wrapper that includes the admin view with `$gp_lp_base = 'user'` | Instructor UI without duplicating markup |
| `application/views/backend/admin/student_academic_progress.php` | Use `course_status()`, show score, per-course Export button | Correct per-course tab (admin) |
| `application/views/backend/user/student_academic_progress.php` | Same as admin (keeping its `user/` URLs) | Correct per-course tab (instructor) |
| `application/views/backend/admin/navigation.php` | Enrollments → "Learner progress" item | Admin menu |
| `application/views/backend/user/navigation.php` | "Learner progress" item near the sales report | Instructor menu |
| `application/models/Api_model.php` | `my_courses_get`, `my_bundle_course_details_get`: `completion` from `course_status()`, plus a `status` key | App matches the website |
| `application/config/design_system_pages.php` | Add `learner_progress` to `gp_ds_admin_pages` and `gp_ds_user_pages` | Keep the page inventory accurate |
| `application/views/backend/includes_top.php` | Bump `gp-admin-report.css?v=report-3` → `report-4` (only if that CSS changes) | Browsers load the new styles |
| `assets/design-system/gp-admin-report.css` | Styles for the tiles, filters and status badges if not already covered | Look |

## Phase 0: Failing checks first

No test runner exists; use manual checks.

### Task 0.1
- [ ] Admin → Courses → #77 → Edit → Academic progress. Expected (FAIL): student 3 shows **0%** and "Not started yet", although My Courses shows 10% for them.
- [ ] There's no "Learner progress" menu item (FAIL).

## Phase 1: Shared data

### Task 1.1: `Crud_model::learner_progress_rows($filters, $allowed_course_ids = null)`
- [ ] SQL (Query Builder): `enrol e JOIN users u ON u.id = e.user_id JOIN course c ON c.id = e.course_id`.
  - Filters: `course_id`, `student` (LIKE on first_name, last_name or email, **inside `group_start()`/`group_end()`** so the ORs can't bypass the course scope), `enrolled_from` (00:00:00) and `enrolled_to` (**23:59:59**, inclusive) on `e.date_added`.
  - If `$allowed_course_ids !== null`, add `where_in('e.course_id', $allowed_course_ids ?: [0])`.
  - Order by `e.date_added DESC`, `limit(2001)` to detect the cap.
- [ ] For each row (up to 2,000):
  - `course_status($course_id, $user_id, $expiry_date)`;
  - `score_raw` from `scorm_tracking` (SCORM only);
  - last activity = max of the `watch_histories.date_updated` time and the `scorm_tracking.date_updated` day;
  - certificate URL from the status, or `Certificate_model::get_certificate_url` when completed.
- [ ] Apply the status filter (whitelist `not_started|in_progress|completed|expired`), build the summary over the **pre-status-filter** set, then slice the page (50 per page, `page` ≥ 1).
- [ ] Run `php -l` → no errors.

### Task 1.2: `Crud_model::learner_progress_csv($rows)`
- [ ] Header: Student, Email, Course, Status, Progress %, Test score, Enrolled, Last activity, Completed on, Certificate URL.
- [ ] Escape each cell: `"` → `""`; prefix `'` if it starts with `= + - @`. Start the file with a UTF-8 BOM. Return the string.

## Phase 2: Admin and instructor pages

### Task 2.1: `Admin::learner_progress()`
- [ ] Check `admin_login` (as `enrol_history` does, `Admin.php:464-469`) and `check_permission('enrolment')`.
- [ ] Read and validate the filters from GET. If `?export=csv`, send the CSV (`Content-Type: text/csv`, filename `learner_progress_YYYY-MM-DD.csv`) of **all** filtered rows (not only the current page), then exit.
- [ ] Otherwise set `page_name = 'learner_progress'`, `page_title`, the data and the course list (all courses) for the filter dropdown, and load `backend/index`.
- [ ] Delete `export_student_progress_csv()` (`Admin.php:3448-3504`); confirm it's unreferenced with grep first.

### Task 2.2: `User::learner_progress()`
- [ ] Access is already enforced for every `User` method by the constructor: login (`get_protected_routes`) and `is_instructor == 1` (`instructor_authorization`, `User.php:41-65`). Also add the same explicit `user_login` check `sales_report` uses (`User.php:370-372`).
- [ ] `$allowed` = IDs of courses where `FIND_IN_SET(<session user_id>, course.user_id)`. Pass it to `learner_progress_rows`. The course dropdown lists only those courses.
- [ ] Same export behaviour as the admin page.

### Task 2.3: Views
- [ ] `views/backend/admin/learner_progress.php`:
  - `gp_ds_page_title`;
  - a GET filter form (course select, student text, status select, two date inputs, Apply/Reset);
  - 6 summary tiles;
  - `gp_ds_table` with the columns above;
  - status badges (tones as on My Courses: in_progress `primary`, completed `success`, not_started `neutral`, expired `danger`);
  - `N%` or "—" when the % is unknown;
  - the paging links keep the filters;
  - "Export CSV" links to the same URL plus `export=csv`;
  - a notice when `capped`.
  Build all URLs from `$gp_lp_base` (`admin` or `user`).
- [ ] `views/backend/user/learner_progress.php`: `$gp_lp_base = 'user'; include APPPATH.'views/backend/admin/learner_progress.php';`
- [ ] Navigation:
  - admin: a new `<li>` under Enrollments, `active` when `$page_name == 'learner_progress'`; also add `learner_progress` to the parent's active check;
  - instructor: a new side-nav item next to the sales report.

### Task 2.4: Per-course Academic progress tab (both copies)
- [ ] Replace lines 20-26 and the bar (41-45) with `course_status($course_id, $enrolment['user_id'], $enrolment['expiry_date'])`:
  - the status badge;
  - the bar and % when the % isn't null, otherwise "In progress";
  - for SCORM, show "Test score: N" instead of "Completed lesson X out of Y";
  - "Completed on" from the status.
- [ ] Keep "Enrolled from", "last seen" and the watched duration, and keep the action buttons unchanged.
- [ ] Add an **Export CSV** button above the table that links to `<base>/learner_progress?course_id=<id>&export=csv`.

## Phase 3: Mobile API

### Task 3.1
**File:** `Api_model.php`
- [ ] In `my_courses_get`, pass the enrolment's `expiry_date`: keep `$my_courses_ids` and match by course ID. Then `$st = course_status($id, $user_id, $expiry)`, `completion = (int) ($st['percent'] ?? 0)`, `status = $st['status']`.
- [ ] Same in `my_bundle_course_details_get`, with no expiry (bundle validity is already checked at line 1154).
- [ ] Keep `total_number_of_lessons` and `total_number_of_completed_lessons` unchanged.

## Phase last: Regression verification and rollout

- `php -l` on all changed PHP files.
- Create a **local-only** normal test course (4 lessons), enrol the test student, and tick 1 lesson. Remove it afterwards.
- **Instructor scope test (local only):** temporarily add a test instructor account's ID to course #77's `course.user_id` (for example `'1,<id>'`), log in as that instructor, and check the report shows #77 only. Then restore `user_id = '1'`. Also confirm a course they don't teach (the test course) is hidden and can't be reached through `?course_id=`.
- Time a full CSV export (all rows) and note the seconds.

**Smoke tests**

| Actor | Where | Expected |
| --- | --- | --- |
| Admin | Enrollments → Learner progress | Students 3 and 4 with the same status and % as their My Courses; tiles correct |
| Admin | Filter status = In progress | Only in-progress rows |
| Admin | Export CSV | File rows match the screen; opens cleanly in Excel |
| Admin | #77 → Academic progress | Status, %, score and the Export button; matches the report |
| Instructor of #77 | Learner progress | Only #77 learners |
| Instructor | URL with another course's `course_id` | Empty |
| Admin without `enrolment` permission | The page URL | Redirected, not authorized |
| API | `my_courses` for student 3 (auth token from a local login) | `completion: 10`, `status: in_progress` |
| Normal test course, 1 of 4 lessons ticked | Report and tab | In progress · 25% |

## Rollback

1. Revert the commit. It's read-only, so there's no data to undo. The old orphaned CSV function comes back with the revert.

## Commit

```bash
git add application/models/Crud_model.php application/controllers/Admin.php application/controllers/User.php application/views/backend/admin/learner_progress.php application/views/backend/user/learner_progress.php application/views/backend/admin/student_academic_progress.php application/views/backend/user/student_academic_progress.php application/views/backend/admin/navigation.php application/views/backend/user/navigation.php application/models/Api_model.php application/config/design_system_pages.php application/views/backend/includes_top.php assets/design-system/gp-admin-report.css
```

Message: `feat: learner progress report for admins and instructors; per-course tab and mobile API use course_status()`, ending with the attribution line.

**Caution:** `Crud_model.php`, `Admin.php`, `User.php` and `Api_model.php` also hold the **uncommitted certificate fixes**. Commit those first, as their own commit, so this commit only contains this feature.

## Self-review

1. **Contradictions:** none. "No new columns" is consistent with the on-the-fly design and decision 3.
2. **Goal reachability:**
   - Existing data: students 3 and 4 appear correctly.
   - Future enrolments appear automatically, because the report reads `enrol` on every request.
3. **Bypass:** the instructor scope is server-side only (`User::learner_progress`). The admin permission is checked. The export uses the same scoping as the page.
4. **Existence:** these were all read in this session:
   - helpers and models: `course_status`, `check_permission`, `has_permission`, `gp_ds_*`, `get_certificate_url`, `get_course_by_id`, `get_watch_histories`;
   - tables and columns: `enrol.date_added`, `enrol.expiry_date`, `scorm_tracking.score_raw`, `scorm_tracking.date_updated`;
   - views and CSS: `navigation.php` (both), `enrol_history.php`, `gp-admin-report.css`.
   The instructor guard was verified (`User.php:41-65` constructor checks). **UNVERIFIED:** how the mobile app renders `completion` (finding 5). The change is additive and keeps types; confirm it in the app.
5. **Consistency:** the Files table matches the phases and the `git add` list (13 files).
6. **Duplication:** one status rule (`course_status`) and one data function are used by the page, export, tab and API. The orphaned old CSV function is removed.
7. **Placeholders:** none.
