# Private Courses on Public Listing Pages — Implementation Plan

**Goal:** Visitors can find private courses on every public page that lists courses, but can never enroll or buy one themselves. Only an instructor or admin can enroll a student.
**Root cause:** Every public listing query filters `status = 'active'`, so private courses are invisible outside the landing page (e.g. `application/controllers/Home.php:154`, `application/models/Crud_model.php:3424`). Separately, the add-to-cart / buy-now routes never check status (`application/controllers/Home.php:566`, `:607`), so a paid private course can be bought by URL.
**Approach:** Widen the public listing queries from `active` to `active` + `private`, relabel the card button to "View Course" for private courses, and block private courses at the add-to-cart / buy-now routes. Admin/instructor dashboards, the mobile API and the compare page stay untouched.
**Tech stack:** PHP 8.3, CodeIgniter 3.1.9 (`system/core/CodeIgniter.php` `CI_VERSION = '3.1.9'`), MySQL, jQuery front end. No automated test suite exists (no `tests/` or `application/tests/` directory).
**Source:** Client request in chat, 2026-09-29: show private courses on the public pages "just like the landing page", but students "must not be allowed to enroll… instructor will be the one who will enrol".

## Open questions (resolve before implementing)

| # | Question | Why it matters | Recommended answer |
| --- | --- | --- | --- |
| 1 | Can a private course have a price, or are private courses always free? | Status and price are set independently (`Crud_model.php:902-905`, `:980-981`), so a paid private course is possible. If paid ones exist, the cart / buy-now routes must refuse them or a student can pay and self-enroll. | Add the server guard (Phase 3) regardless: it costs little and closes the hole even if private courses are "always free" by convention. |
| 2 | Include the Compare page (`/home/compare`) and the mobile app API? | Both filter `active` only (`Home.php:1437`, `:1856`; `Api_model.php:23,73,93,143,177,1121`). | No, leave them out. The compare page isn't linked from the GPLI theme's main flow, and the mobile app is out of scope. |
| 3 | Should private courses count toward instructor badges ("Course Earned")? | Badges count `active` courses only (`Home.php:262`, `:2171`). | No change: badges are a reward for public catalogue courses. |

---

## Live database/system validation: 2026-09-29

Read-only; no data changed.

- **Local DB (`academy_lms`)**: 1 course, `status = active`, `is_free_course = 1` (query: `SELECT status, is_free_course, COUNT(*) FROM course GROUP BY 1,2`). No private course exists locally, so local testing needs a temporary status flip (see Phase last).
- `course.status` is `varchar(255) NULL`, no CHECK constraint; `course.is_free_course` is `int(11) NULL` (`SHOW COLUMNS FROM course`). Status values written by the app: `active`, `private`, `upcoming`, `draft`, `pending` (`Crud_model.php:902-908`, `:980-991`, `:1087-1093`).
- **Live DB (`gpli_lms` on gpli.tech)**: UNVERIFIED — number of private courses and how many are paid. Verify with phpMyAdmin (read-only): `SELECT status, is_free_course, COUNT(*) FROM course GROUP BY status, is_free_course;`. This decides how urgent Open question 1 is.
- Deployed code state: `main` is in sync with `origin/main`; latest commits are `1ab229a` (block self-enrollment in private courses) and `4eb3c39` (private courses on the landing page) (`git log`, `git status -sb`).

## Audit findings

1. **Concept representation.** "Private" exists only as `course.status = 'private'`. Writers: admin course add (`Crud_model.php:902`), course add from the frontend form via `is_private` checkbox (`Crud_model.php:980-981`), admin course edit (`Crud_model.php:1087`), status switch (`Crud_model.php:1160-1170`). The admin edit form offers it as a radio (`application/views/backend/admin/course_edit.php:378`). There is no separate "hidden"/"invite-only" flag, so no second source of truth.
2. **Already done and live.**
   - Landing page shows private courses in Top Courses, category counts and total (`home_gpli.php:10`, `Crud_model.php:1314-1343`, commit `4eb3c39`).
   - Course page disables Enroll for private courses (`course_page.php:211-221`) and the free-enroll routes refuse them (`Home.php:1272-1275`, mobile route `Home.php` `get_enrolled_to_free_course_mobile`), commit `1ab229a`.
   - Course detail page is viewable for private courses (`Home.php` `access_denied_courses` blocks only `draft`/`pending`, lines ~1400-1410).
3. **Public listing readers that hide private courses (GPLI theme `default-new`):**

   | Page | Query | Shared with non-public callers? | Change |
   | --- | --- | --- | --- |
   | Courses page, no filters | `Home.php:154` (count) and `:172` (rows) | No | Include private |
   | Courses page, filters/sort | `Crud_model::filter_course` `:3424`, `:3511` | No (API uses its own `Api_model::filter_course`, `Api.php:140`) | Include private |
   | Search results | `Crud_model::get_courses_by_search_string` `:1248`, used only at `Home.php:990,998` | No | Include private |
   | Courses sidebar "All" count | `Crud_model::get_active_course` `:4648`, used only at `courses_page_sidebar.php:42` | No | Include private |
   | Courses sidebar category counts | `Crud_model::get_active_course_by_category_id` `:4638`, used only at `courses_page_sidebar.php:49,61` | No | Include private |
   | Related courses on course page | `Crud_model::get_related_courses` `:5274`, used only at `course_page.php:308` | No | Include private |
   | Login/sign-up side panel count | `gp_auth_visual.php:5` | No | Include private |
   | Instructor profile course list | `instructor_page.php:4` via `get_instructor_wise_courses` → `multi_instructor_course_ids_for_an_instructor` (`Crud_model.php:1510-1517`) — **no status filter at all**, so drafts and pending courses show today | **Yes**: same function feeds instructor dashboards (`backend/user/dashboard.php:3`, `instructor_dashboard.php:7`, `Crud_model.php:1521,3165,4269`) | Filter in the view only, to `active` + `private` |

4. **Enroll paths for a private course (writers of `enrol`).**
   - Free self-enroll: blocked (finding 2).
   - Cart / Buy Now: `handle_cart_items` (`Home.php:566`), `handle_buy_now` (`Home.php:607`), `handleCartItemForBuyNowButton` (`Home.php` right after `:639`) add any course id to the session cart with no status check. Payment and 100%-coupon flows then call `enrol_student` (`Home.php:738,776,841,1953`; `Payment.php:61,65`) → **not blocked**.
   - Admin/instructor manual enrol: `Admin::enrol_student` (`Admin.php:547`) → `Crud_model::enrol_a_student_manually` (`:2870`). Must keep working.
   - Guarding inside `Crud_model::enrol_student` is rejected: it runs after payment, so a student would be charged without being enrolled. The guard belongs at add-to-cart.
5. **Card button labels.** "Enroll Now" on cards is only a label; the whole card links to the course page: `courses_page_grid_layout.php:71`, `courses_page_list_layout.php:77`, `instructor_page.php:191`, `home_gpli.php:267` (a real `<a>` to the course page). For private courses it should read "View Course".
6. **Prior decisions.** None found about private courses in `docs/`, root `*.md`, or project memory (grep "private course" / "status.*private"). Project memory requires plain-language, non-technical explanations to the user.
7. **Other themes** (`home_1…7`, fitness, kindergarten, etc.) and `components/main/function_grid.php` are not used by the active GPLI homepage and stay out of scope.

---

## Scope and constraints

### In scope
- Private courses listed on: courses page (unfiltered and filtered), search results, courses sidebar counts, related courses, login/sign-up course count, instructor profile.
- "View Course" label instead of "Enroll Now" on private course cards (grid, list, instructor profile, landing page).
- Server-side refusal to add a private course to the cart or Buy Now.
- Instructor profile stops showing draft/pending courses.

### Out of scope: do not change
- Admin and instructor dashboards, course management, `get_instructor_wise_courses` / `multi_instructor_course_ids_for_an_instructor`.
- Admin/instructor manual enrollment (`Admin::enrol_student`, `Crud_model::enrol_a_student_manually`).
- Mobile API (`Api_model.php`), Compare page (`Home.php:1437`, `:1856`), instructor badges (`Home.php:262`, `:2171`), non-GPLI themes.
- `Crud_model::enrol_student` and the payment gateways.

### Non-negotiable safety constraints
- Draft and pending courses must never appear on any public page.
- Hiding/relabelling a button is not a security boundary: every self-enroll route must refuse private courses on the server.
- No database migration; no data changes.

### Contract

| Case | Actor | Input | Required outcome |
| --- | --- | --- | --- |
| 1 | Visitor | Open `/home/courses` | Active and private courses listed; draft/pending/upcoming not listed; count matches rows |
| 2 | Visitor | Filter by category / price / level / sort | Private courses matching the filter appear |
| 3 | Visitor | Search a private course's title | It appears in results |
| 4 | Visitor | Courses sidebar | "All" and category counts include private courses |
| 5 | Visitor | Open an active course in the same category as a private one | Private course can appear under Related courses |
| 6 | Visitor | Login page side panel | Course count = active + private |
| 7 | Visitor | Instructor profile | Lists that instructor's active + private courses only; no drafts/pending; heading count matches |
| 8 | Student (logged in, not enrolled) | Private course card anywhere | Label reads "View Course" |
| 9 | Student | Course page of a private course | Enroll disabled with message (already live) |
| 10 | Student | Direct URL `home/handle_cart_items/<private id>` or `home/handle_buy_now/<private id>` | Refused with error message; cart unchanged |
| 11 | Student | Direct URL `home/get_enrolled_to_free_course/<private id>` | Refused (already live) |
| 12 | Admin / instructor | Enroll a student into a private course from admin | Still works |
| 13 | Student already enrolled in a private course | Any card | Still shows "Start Now" |
| 14 | Visitor | Active course card | Unchanged ("Enroll Now", cart buttons work) |

## Files

| File | Change | Responsibility |
| --- | --- | --- |
| `application/controllers/Home.php` | Modify | Unfiltered courses list includes private; cart/buy-now routes refuse private |
| `application/models/Crud_model.php` | Modify | `filter_course`, `get_courses_by_search_string`, `get_active_course`, `get_active_course_by_category_id`, `get_related_courses` include private |
| `application/views/frontend/default-new/gp_auth_visual.php` | Modify | Login/sign-up count includes private |
| `application/views/frontend/default-new/instructor_page.php` | Modify | List only active + private; "View Course" label |
| `application/views/frontend/default-new/courses_page_grid_layout.php` | Modify | "View Course" label for private |
| `application/views/frontend/default-new/courses_page_list_layout.php` | Modify | "View Course" label for private |
| `application/views/frontend/default-new/home_gpli.php` | Modify | "View Course" label for private top courses |

## Phase 0: Failing tests first

No automated test runner exists in this project (no `tests/` or `application/tests/`; `composer.json` lists PHPUnit only as the framework's own dev dependency). Tests are manual, run on the local XAMPP site (`http://localhost/academy/`) against a temporary private course. Record the "before" state:

### Task 0.1: Capture the failing baseline
- [ ] Make the local course private: `C:\xampp\mysql\bin\mysql.exe -u root academy_lms -e "UPDATE course SET status='private' WHERE id=77"` (local dev data only; reverted in Phase last).
- [ ] Open `http://localhost/academy/home/courses` → Expected now: course **missing** (FAIL for case 1).
- [ ] Open `http://localhost/academy/home/search?query=Practical` → Expected now: no result (FAIL for case 3).
- [ ] Run `curl -s "http://localhost/academy/home/handle_cart_items/77"` → Expected now: `"Item successfully added to cart"` (FAIL for case 10).

## Phase 1: Include private courses in public listing queries

Use one shared list so the rule lives in one place. In `Crud_model.php`, next to `get_top_courses` (line ~1327), add:

```php
    // Statuses a visitor may see in public course listings. Private courses are
    // listed but not self-enrollable (see Home::handle_cart_items / handle_buy_now).
    public function public_listing_statuses()
    {
        return ['active', 'private'];
    }
```

### Task 1.1: Courses page, unfiltered
**Files:** `application/controllers/Home.php`
- [ ] Line 154: `$this->db->where('status', 'active');` → `$this->db->where_in('status', $this->crud_model->public_listing_statuses());`
- [ ] Line 172: same replacement inside the existing `group_start()/group_end()`.

### Task 1.2: Filters, search, sidebar, related
**Files:** `application/models/Crud_model.php`
- [ ] `get_courses_by_search_string` line 1248 → `$this->db->where_in('status', $this->public_listing_statuses());`
- [ ] `filter_course` lines 3424 and 3511 → `$this->db->where_in('c.status', $this->public_listing_statuses());`
- [ ] `get_active_course_by_category_id` line 4638 and `get_active_course` line 4648 → `where_in('status', $this->public_listing_statuses())`
- [ ] `get_related_courses` line 5274 → `where_in('status', $this->public_listing_statuses())`
- [ ] Do **not** touch `get_category_wise_courses` (`:3986`, feeds the mobile API), `get_latest_10_course` (`:2835`), or `get_status_wise_courses*`.
- [ ] Run: `C:\xampp\php\php.exe -l application/models/Crud_model.php` → `No syntax errors detected`

### Task 1.3: Login/sign-up count
**Files:** `application/views/frontend/default-new/gp_auth_visual.php`
- [ ] Line 5 → `$gp_auth_course_count = (int) $this->db->where_in('status', $this->crud_model->public_listing_statuses())->count_all_results('course');`

### Task 1.4: Instructor profile shows only public courses
**Files:** `application/views/frontend/default-new/instructor_page.php`
- [ ] After line 4, filter the ids in the view (the shared function must keep returning all statuses for dashboards):

```php
if (! empty($course_ids)) {
    $course_ids = array_column(
        $this->db->select('id')
            ->where_in('id', $course_ids)
            ->where_in('status', $this->crud_model->public_listing_statuses())
            ->get('course')->result_array(),
        'id'
    );
}
```
- [ ] Line 8 (`where_in('course_id', $course_ids)`) must not run with an empty array: wrap lines 6-9 so `$total_students = 0` when `$course_ids` is empty. (CodeIgniter builds invalid SQL for `where_in` with an empty array.)
- [ ] Run: `C:\xampp\php\php.exe -l application/views/frontend/default-new/instructor_page.php`

**Phase constraints:** no change to any admin/instructor dashboard query; draft/pending/upcoming stay hidden.

## Phase 2: "View Course" label on private course cards

Replace each `Enroll Now` label shown to non-enrolled users with:

```php
<?php echo $course['status'] == 'private' ? site_phrase('View Course') : site_phrase('Enroll Now'); ?>
```

### Task 2.1: Card labels
- [ ] `courses_page_grid_layout.php:71`
- [ ] `courses_page_list_layout.php:77`
- [ ] `instructor_page.php:191`
- [ ] `home_gpli.php:267` (variable is `$top_course`, and it uses `get_phrase`: `<?php echo get_phrase($top_course['status'] == 'private' ? 'View Course' : 'Enroll Now'); ?>`)
- [ ] Manual check: private card shows "View Course"; active card still "Enroll Now"; enrolled student still sees "Start Now".

## Phase 3: Refuse private courses at add-to-cart and Buy Now

**Files:** `application/controllers/Home.php`

### Task 3.1: Guard the three cart entry points
- [ ] Add a private helper near `access_denied_courses` (~line 1397):

```php
    private function is_private_course($course_id)
    {
        return $this->crud_model->get_course_by_id($course_id)->row('status') == 'private';
    }
```
- [ ] At the top of `handle_cart_items` (line 566) and `handle_buy_now` (line 607), before touching the session cart (both return JSON and take `$course_id` from the URL):

```php
        if ($this->is_private_course($course_id)) {
            echo json_encode(['error' => get_phrase('Your instructor will enroll you in this course')]);
            return;
        }
```
- [ ] `handleCartItemForBuyNowButton` (line 637) is different: it reads `$course_id = $this->input->post('course_id')` (line 643) and returns the `cart_items` HTML view, not JSON. Right after line 643, skip adding a private course but still render the view, so the header cart stays correct:

```php
        if ($this->is_private_course($course_id)) {
            $this->load->view('frontend/' . get_frontend_settings('theme') . '/cart_items');
            return;
        }
```
- [ ] Confirm the front end shows `error` keys from these JSON responses (inspect the `actionTo()` handler in `assets/` for how it treats `response.error`); if it ignores `error`, the refusal still holds server-side and the cart is unchanged — acceptable.
- [ ] Run: `C:\xampp\php\php.exe -l application/controllers/Home.php`
- [ ] Run: `curl -s "http://localhost/academy/home/handle_cart_items/77"` → Expected: JSON with `error`, not "added to cart".

**Phase constraints:** do not change `enrol_student`, payment controllers, or admin enrollment.

## Phase last: Regression verification and rollout

- Lint: `C:\xampp\php\php.exe -l` on every file in the Files table.
- Smoke tests on `http://localhost/academy/` with course 77 temporarily private:

| Role | Page / action | Expected |
| --- | --- | --- |
| Visitor | `/home/courses` | Course listed, label "View Course", count includes it |
| Visitor | Filter by its category | Listed |
| Visitor | Search its title | Listed |
| Visitor | Sidebar counts | Include it |
| Visitor | `/login` side panel | Count includes it |
| Visitor | Instructor profile of its creator | Listed; no draft/pending courses |
| Student | Course page | Enroll disabled + message |
| Student | `handle_cart_items/77`, `handle_buy_now/77` | Refused |
| Admin | Enrol a student to course 77 from admin | Works |

- Repeat with course 77 set to `draft`: it must disappear from every page above. Then restore: `UPDATE course SET status='active' WHERE id=77` and confirm with `SELECT id, status FROM course`.
- After deploy (push to `main` → GitHub Actions → gpli.tech), repeat the visitor rows on `https://gpli.tech` with a real private course, and check the Actions run is green at `https://github.com/KCIVOR/gpli/actions`.

## Rollback

1. `git revert <commit>` on `main` and push; the deploy workflow redeploys the previous code automatically.
2. No data or schema changes are made, so nothing else needs undoing. Sessions whose cart already contained a private course before deploy keep it until checkout (edge case, see Self-review).

## Commit

```bash
git add application/controllers/Home.php application/models/Crud_model.php application/views/frontend/default-new/gp_auth_visual.php application/views/frontend/default-new/instructor_page.php application/views/frontend/default-new/courses_page_grid_layout.php application/views/frontend/default-new/courses_page_list_layout.php application/views/frontend/default-new/home_gpli.php
git commit -m "feat: list private courses on public pages without self-enrollment"
```

Stage only these files (never `git add .`: the working tree has untracked `tmp/` folders that must not be committed or deployed). Commit directly on `main`, as this project does.

## Self-review

1. **Contradictions:** "Instructor profile shows private" vs "don't change `get_instructor_wise_courses`" resolved by filtering in the view (Task 1.4). None left.
2. **Goal reachability:** Existing private courses appear as soon as code deploys (no data change). Courses made private later appear too, since every listing reads status live. All four `status = 'private'` writers (finding 1) feed the same column.
3. **Bypass:** Self-enroll routes: free (blocked), mobile free (blocked), cart/buy-now/buy-now-button (Phase 3). Residual: a cart filled with a private course **before** deploy could still check out; also course bundles (`addons/course_bundles`, `application/config/routes.php`) could contain a private course — UNVERIFIED, check whether bundles are used. Mobile API paid purchase is out of scope (Open question 2).
4. **Existence:** Verified by grep/read: every file and line cited; functions `filter_course`, `get_courses_by_search_string`, `get_active_course`, `get_active_course_by_category_id`, `get_related_courses`, `get_instructor_wise_courses`, `handle_cart_items`, `handle_buy_now`, `handleCartItemForBuyNowButton`, `access_denied_courses`. `public_listing_statuses` and `is_private_course` are new. `get_active_course` has a pre-existing bug (`where('id', $course_id = "")`) that is harmless for its only caller (no argument); left as is.
5. **Consistency:** Files table = files in Phases 1-3 = commit list (7 files).
6. **Duplication:** One status list (`public_listing_statuses`) instead of repeating `['active','private']`; the landing page's local `$gpli_listed_statuses` (`home_gpli.php:10`) could switch to it later but works as is.
7. **Placeholders:** None.

Checklist sections not applicable: C (RLS) — MySQL app with no row-level security; D DB-layer policies — authorization is only in PHP controllers; G migrations — none needed.
