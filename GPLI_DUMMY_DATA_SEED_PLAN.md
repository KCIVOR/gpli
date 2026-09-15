# GPLI Dummy Data Seed — Implementation Plan

Goal: seed realistic categories, courses (with real sections/lessons/YouTube
videos), FAQs, and testimonials via `.sql` migration files you import on
cPanel (same phpMyAdmin import flow as `uploads/install.sql` and
`migrations/2026_gpli_homepage.sql`). This is the **plan only** — no SQL has
been written yet. Every field/table referenced below was verified against
the actual schema and real existing rows in `academy_lms`, not guessed.

## 0. Ground rules (why this plan looks the way it does)

- **Additive, never destructive.** Nothing here touches or deletes your
  existing 5 categories or 11 courses. New rows only.
- **Portable across environments.** Your live cPanel database has different
  auto-increment IDs than this local dev copy. Every migration below must
  link foreign keys (category → course → section → lesson) by **looking up
  IDs at insert time** — via `SELECT id FROM category WHERE slug=...`
  subqueries, or `LAST_INSERT_ID()` captured into a `SET @var` right after
  each `INSERT` — never by hardcoding a numeric ID. This is the only way the
  same file produces correct results on your dev DB and your live DB.
- **Idempotent.** Every insert is guarded (`WHERE NOT EXISTS (...)`) so
  re-running a migration by accident does not create duplicates.
- **Real conventions, not invented ones.** The formats below (JSON shapes,
  hashing, video fields) are copied from your actual existing data, not
  assumed.

## 1. Verified schema facts this plan relies on

| Table | Fact | Verified via |
|---|---|---|
| `category` | Self-referential: `parent = 0` is a top-level category, `parent = <id>` makes it a sub-category of that row. `slug` is unique-ish and used for lookups. | Live query: `id=1 Information Technology (parent=0)`, `id=2 Marketing (parent=1)` |
| `course` | `category_id` = the parent category, `sub_category_id` = the specific (sub) category shown in "Top Categories" / filtering. `outcomes` and `requirements` are **JSON arrays of strings**. `faqs` is a **JSON object** of `{"question":"answer"}` pairs (not an array — different shape from the site-wide FAQ setting below). `is_top_course` flag controls the homepage "Top Courses" section. `creator` = `users.id` of the instructor. | Live row `id=1 "Introduction to Web Development"`: `outcomes=["Build and deploy...","...]`, `faqs={"What background knowledge...":"No prior..."}` |
| `section` | One row per course section/module: `title`, `course_id`, `order`. | Live rows for course 1: 5 sections, `order` 0-based |
| `lesson` | One row per lesson: `title`, `duration` (`HH:MM:SS` string, only set on video lessons), `course_id`, `section_id`, `video_type` (`youtube` or `NULL`), `video_url` (full `https://www.youtube.com/watch?v=...` URL), `lesson_type` (`video` or `text`), `is_free`, `order`. **Real existing convention**: only the *first* lesson of course 1 has a real YouTube video; the rest are `text` lessons with no video. This plan follows that same pattern — 1 real, verified YouTube video per course, remaining lessons as text — rather than fabricating YouTube IDs that might not resolve. | Live rows for course 1, lessons 1-8 |
| `frontend_settings` (`key='website_faqs'`) | Site-wide FAQ widget: JSON **array** of `{"question":..., "answer":...}` objects. Different shape from `course.faqs`. | Live value: `[{"question":"How do I get started?","answer":"..."}]` |
| `rating` | Used for both course reviews and site-wide testimonials. Site-wide testimonial = `ratable_type = NULL` and `ratable_id = NULL` (confirmed: this is exactly what `home_gpli.php`'s "What the people Thinks About Us" section already queries). Course-specific review would set `ratable_type='course'`, `ratable_id=<course_id>`. | Live rows 1-3, `home_elegant.php:618` query |
| `users` | Password is `SHA1(plaintext)`, 40 hex chars (confirmed live: `sha1()` used in `Login.php:57,132`). `is_instructor` (0/1), `role_id` (1=Admin, 2=User — instructors are `role_id=2` with `is_instructor=1`). `image` stores just a filename; blank/`NULL` falls back to a built-in placeholder automatically (already relied on by `home_gpli.php`). | Live `role` table, `Login.php` |

## 2. Category taxonomy — 24 new categories (≥ 20 required)

Reusing the **exact 8 business functions already approved** in the GPLI
landing page ("Courses by Function" section) as the 8 parent categories,
each split into 2 real sub-categories — this keeps the new taxonomy
consistent with copy you've already signed off on, instead of inventing an
unrelated one.

| Parent (`parent=0`) | Sub-category A | Sub-category B |
|---|---|---|
| HR | Recruitment & Talent Acquisition | Diversity, Inclusion & Retention |
| Sales | Prospecting & Lead Generation | Closing & Negotiation |
| Marketing | Digital Marketing Strategy | Brand & Communications |
| Operations | Project Management | Process Improvement |
| Customer Support | Service Excellence | Communication Skills |
| Leadership | Executive Leadership | Change Management |
| Management | Time Management & Delegation | People Management |
| Professional Development | Communication & Assertiveness | Mindfulness & Wellbeing |

8 parents + 16 sub-categories = **24 categories**, all inserted with
`slug`s derived from the name and a generic `font_awesome_class` icon per
parent (no thumbnail image required — `category.thumbnail` /
`sub_category_thumbnail` are nullable and the existing "Web Development" /
"Graphic Design" rows already ship with `NULL`/placeholder values).

## 3. Instructor accounts — 8 new, one per business function

Your current 3 users (`admin`, `John Doe`, `rovick romasanta`) are all
already instructors, but there's no realistic *variety* for "Top
Facilitators" beyond 2-3 real names. Plan: add 8 new instructor accounts
(one lead facilitator per business function above), each:
- `is_instructor = 1`, `status = 1`, `role_id = 2`
- Realistic first/last name matching their function (e.g. "Priya Nathan" —
  HR, "Marcus Webb" — Sales)
- `password = SHA1('Gpli@2026')` (a placeholder credential — documented in
  the migration file's header comment so you can change it, not left
  silent)
- `image = NULL` (falls back to the built-in placeholder avatar
  automatically, same as your real accounts today)
- Short `biography` field filled in (real column, currently unused by any
  homepage view but costs nothing to populate correctly)

These become the `creator` for the new courses, so "Top Facilitators" shows
8 distinct, function-relevant people instead of the same 2-3 accounts.

## 4. Courses — 32 new (≥ 30 required), 4 per business function

2 courses per sub-category × 16 sub-categories = 32 courses. Full list:

**HR** — *Recruitment & Talent Acquisition*: "Modern Recruitment Strategies
for SMEs", "Building an Employer Brand That Attracts Talent" · *Diversity,
Inclusion & Retention*: "Diversity & Inclusion in the Workplace", "Employee
Retention Strategies That Work"

**Sales** — *Prospecting & Lead Generation*: "Prospecting Fundamentals:
Finding Your Next Customer", "Cold Outreach That Actually Converts" ·
*Closing & Negotiation*: "Negotiation Tactics for Sales Professionals",
"Closing Techniques for High-Value Deals"

**Marketing** — *Digital Marketing Strategy*: "Digital Marketing Strategy
for Small Business", "SEO Fundamentals for Growing Brands" · *Brand &
Communications*: "Building a Brand Identity from Scratch", "Content
Marketing That Drives Engagement"

**Operations** — *Project Management*: "Project Management Fundamentals",
"Agile & Scrum for Non-Software Teams" · *Process Improvement*: "Lean
Process Improvement for SMEs", "Supply Chain Basics for Operations
Managers"

**Customer Support** — *Service Excellence*: "Customer Service Excellence
Fundamentals", "Handling Difficult Customers with Confidence" ·
*Communication Skills*: "Communication Skills for Support Teams", "Writing
Effective Support Responses"

**Leadership** — *Executive Leadership*: "Executive Leadership Essentials",
"Strategic Decision-Making for Leaders" (named to avoid colliding with your
existing "Executive Leadership & Governance" course) · *Change Management*:
"Leading Organizational Change", "Building a Culture of Accountability"

**Management** — *Time Management & Delegation*: "Time Management for New
Managers", "The Art of Delegation" · *People Management*: "Managing
High-Performing Teams", "Giving Feedback That Drives Growth"

**Professional Development** — *Communication & Assertiveness*: "Assertive
Communication in the Workplace", "Public Speaking for Professionals" ·
*Mindfulness & Wellbeing*: "Mindfulness for Workplace Wellbeing", "Managing
Stress & Avoiding Burnout"

**Per-course fields (all 32):**
- `category_id` / `sub_category_id` → looked up from the taxonomy above
- `creator` → looked up to that function's instructor account
- `level` → rotated across `beginner` / `intermediate` / `advanced`
- `price` / `discount_flag` / `discounted_price` → mix of free and paid
  (roughly 1 in 6 free, matching a realistic freemium spread), prices
  $29–$149
- `status = 'active'`, `course_type = 'general'`, `language = 'English'`
- `is_top_course = 1` on ~10 of the 32 (spread across functions) so the
  homepage's "Top Courses" section — currently empty, as flagged earlier —
  actually populates
- `outcomes` → JSON array, 3-4 realistic bullet points per course
- `requirements` → JSON array, 2-3 items (mostly "no prior experience
  needed" for beginner courses, more specific for advanced ones)
- `faqs` → JSON object, 3 Q&A pairs per course (see §6)
- `thumbnail = NULL` → falls back to the theme's placeholder automatically,
  exactly like your existing course #2 and #3 already do live

## 5. Sections & lessons — real structure, one verified video per course

Per course: **4 sections**, **3 lessons per section** (12 lessons/course ×
32 courses = 384 lesson rows). Section titles are function-specific (e.g.
for "Project Management Fundamentals": *Foundations of Project Management →
Planning & Scheduling → Risk & Stakeholder Management → Closing & Lessons
Learned*).

- **Lesson 1 of every course** gets a real, verified public YouTube video
  (`video_type='youtube'`, a real `duration`) — matching the exact
  convention your existing course #1 already uses. At implementation time
  each of the 32 video URLs will be checked to actually resolve before
  being written into the migration (not generated blind) — sourced from
  well-known free public channels appropriate to business/SME training
  (e.g. Harvard Business Review, TED, freeCodeCamp-style channels,
  depending on topic).
- **All other 11 lessons per course** are `lesson_type='text'`,
  `video_type=NULL`, matching how the real course #1's lessons 2-8 already
  work — each gets a short realistic `summary` instead of a video.
- `is_free = 1` on lesson 1 of every course (a free preview lesson), `0` on
  the rest — mirrors standard LMS preview conventions and gives "Explore
  Courses" visitors something to sample before enrolling.

## 6. Course FAQs (`course.faqs`) — 3 per course, 96 total

Templated per business function (not copy-pasted identically across all 32
— each function gets its own 3-question template, e.g. Sales courses ask
about commission/quota relevance, HR courses ask about compliance
applicability), written as the JSON object shape from §1.

## 7. Site-wide FAQs (`frontend_settings.website_faqs`) — expand from 3 to 10

Your current value already has 3 general FAQs. Plan appends 7 more (GPLI/
SME-specific: subscription minimums, team seat management, certificate
validity, mobile access, etc.) as one updated JSON array — this is an
`UPDATE`, not an insert, since it's a single settings row.

## 8. Testimonials ("What the people Thinks About Us") — 15 new reviews

Your current 3 testimonial rows (`rating` table, `ratable_type/id = NULL`)
all reference existing instructor accounts, which reads oddly ("students"
who are actually instructors). Plan:
- Add **15 new non-instructor "student" user accounts** (`is_instructor=0`,
  realistic names, same `SHA1('Gpli@2026')` placeholder password,
  documented the same way as §3)
- Insert 15 new `rating` rows (`ratable_type=NULL`, `ratable_id=NULL`,
  rating 4-5 stars, realistic SME-training-flavored review text — no two
  identical) tied to those new accounts
- `home_gpli.php` already caps this section at 6 cards and gates on
  non-empty results, so no view changes are needed — more real rows just
  means better variety in what gets shown

## 9. Migration file breakdown

Following the same phP-cPanel-import pattern as `2026_gpli_homepage.sql`,
split into ordered, independently-safe files under `migrations/`:

1. `2026_gpli_data_01_categories.sql` — §2 (24 categories)
2. `2026_gpli_data_02_instructors.sql` — §3 (8 instructor accounts)
3. `2026_gpli_data_03_courses.sql` — §4 (32 courses, FK-linked via slug/name
   lookups + `LAST_INSERT_ID()`)
4. `2026_gpli_data_04_sections_lessons.sql` — §5 (128 sections, 384 lessons)
5. `2026_gpli_data_05_course_faqs.sql` — §6 (`UPDATE course SET faqs=...`
   per course, matched by title)
6. `2026_gpli_data_06_site_faqs.sql` — §7 (1 `UPDATE` on
   `frontend_settings`)
7. `2026_gpli_data_07_testimonials.sql` — §8 (15 student accounts + 15
   rating rows)

Each file must be run **in this order** (courses depend on categories/
instructors existing first; lessons depend on courses/sections). Each is
independently idempotent, so if #4 fails partway through on live, #1-#3
don't need to be re-run.

## 10. Verification checklist (after running on any environment)

- `SELECT COUNT(*) FROM category` — should be existing + 24
- `SELECT COUNT(*) FROM course WHERE status='active'` — should be existing + 32
- `SELECT COUNT(*) FROM course WHERE is_top_course=1` — ~10, confirms
  homepage "Top Courses" section now renders
- Spot-check 2-3 courses' lesson counts (`SELECT COUNT(*) FROM lesson
  WHERE course_id=X`) — should be 12 each
- Load `/academy` homepage in both light and dark mode — Top Courses,
  Categories, Top Facilitators, and testimonials sections should all now
  show real, varied content
- Confirm the 32 YouTube lesson-1 videos actually play (spot-check a
  sample, not all 32, post-import)

## 11. What this plan deliberately does NOT do

- Does not touch payment/enrollment tables — these are dummy catalog
  courses, not purchasable transactions to fake
- Does not alter the 5 existing categories or 11 existing courses in any way
- Does not fabricate YouTube video IDs speculatively — every video URL in
  the final migration will be checked to resolve before being written in,
  per §5
- Does not change any PHP/view code — `home_gpli.php` already reads all of
  this dynamically; once the data exists, it appears with no code changes
