# Student Account Pages — Enhancement Plan

> **For agentic workers:** REQUIRED: Use `legacy-ui-redesign.md` plus `geeseprojdesignsystem.html` before writing CSS. This file **supersedes** `STUDENT_PAGES_REDESIGN_PLAN.md`. Do not implement the old Phase 0/1 split. Implement one phase at a time. Stop after each phase for a Light + Dark visual check of the **whole viewport**, not the include you just edited.

**Goal:** Make the logged-in student area look like a Geese Project account shell — one title, slim breadcrumb, grouped sidebar, DS course/content cards — without leftover marketing hero, leftover purple/circular CTAs, or mashed labels.

**Architecture:** Same UI-only pass as Cart. Wrap **breadcrumb + sidebar + content** in one `.gp-student-page` (cart already does this as `.gp-cart-page`). Shared CSS stays `assets/design-system/gp-student.css`. Helpers: existing `gp_ds_*` only. Do not invent a third style.

**Tech stack:** CodeIgniter 3 frontend views, `--gp-*` tokens, `gp_ds_page_title` / `gp_ds_card` / `gp_ds_button` / `gp_ds_badge` / `gp_ds_alert` / `gp_ds_table`, CSS-only list-group / progress / icon-btn.

**Source of truth:** `assets/design-system/reference/geeseprojdesignsystem.html` — breadcrumb §14, cards §06, buttons §05, list-group §20, progress §19, icon-btn §14, empty states. Reuse the cart breadcrumb hide already in `gp-cart.css`.

**Why the last pass failed:** Phase 0 restyled only `profile_menus.php`. The live page is leftover marketing breadcrumb + leftover “Courses” panel + leftover course strip. The user sees the whole screen. A DS-blue pill in a leftover layout is still leftover.

---

## 1. Live-page audit (13 Sep 2026 screenshot)

Audited from `/home/my_courses` after Phase 0. Above the fold only. Footer and public header are visible but **out of student scope** except where student CSS leaked mashed type.

### 1.1 What is wrong (concrete)

| Area | Leftover / broken | Why it fails DS |
|------|-------------------|-----------------|
| **Two titles** | Leftover `.bread-crumb` H1 “My courses” (40px, `#0D0C23`, 3D book art, leftover photo bg) **and** leftover content H1 “Courses” | Hierarchy is broken. Cart already hides `.bread-crumb h1` + `.book-img`. Student pages did not. |
| **Breadcrumb trail** | Leftover padded trail “Home / My courses”, mashed to `Mycoursess` | DS breadcrumb is 13px, `--gp-fg-muted`, 8px gaps, no leftover photo band. |
| **Type smash** | `Mycoursess`, `Coursess`, `STARTNOW`, `IntroductiontoWebdevelopment`, `Lectures10`, `Purchasehistory`, `Instructorfollowings` | Missing spaces + leftover heading letter-spacing. Phase 0 then set `word-spacing: 0.16em` on **all** of `.gp-student-page`, which is the wrong fix (cart only spaces **CTAs**). |
| **Sidebar** | Short leftover-looking card, tiny identity, one long flat list, empty white under it | Skill wants grouped nav, consistent icon+label, sticky/full-height feel. Active DS blue is the only win. |
| **Main panel** | Leftover `.my-course-1-full-body` white box with leftover unboxed row | Not a DS card. Padding and divider are leftover `#6479962e`. |
| **Kebab** | Leftover `.btn-secondary.dropdown-toggle` reads as a **red circle** | DS icon-btn is 30×30 / 8px radius / `--gp-border`. Keep both dropdown hrefs. |
| **Progress** | Leftover 5px leftover bar | `gp-progress.css` 10px track / `--gp-primary` fill. |
| **Start Now** | Leftover circular `.btn-primary` mashed `STARTNOW` | `gp_ds_button` `primary` compact, `word-spacing: 0.16em` **on the button only**. |
| **Meta** | Lectures / Quizzes / Hours / expiry smashed | Compose `get_phrase('Lectures').' '.$n`. Tokens `--gp-fg-muted` / `--gp-success`. |
| **Public header** | `SearchCoursess` | **Out of this plan.** `gp-public-shell.css`. Do not expand unless asked. |
| **Footer** | Mashed column titles | Out of this plan (already DS footer; `letter-spacing: 0.16em` on `h4` is intentional uppercase tracking). |

### 1.2 What Phase 0 got right (keep)

- Leftover purple `#754FFE` active pill is gone.
- Unread count can stay `gp_ds_badge`.
- Bootcamp SVG `currentColor`.
- Every href, `page_name` active test, addon gate, unread query.
- `gp-student.css` is linked (`?v=student-1` — bump on each CSS change).

### 1.3 What Phase 0 must undo

- Remove `.gp-student-page { word-spacing: 0.16em }` from the **whole** wrapper.
- Remove the **inner** `.gp-student-page` wrapper around only the sidebar. One wrapper around breadcrumb + grid.
- Do not ship another “sidebar-only” phase.

---

## 2. Target layout (My Courses = the visual spec)

Match cart / DS, not leftover default-new marketing.

```
.gp-student-page
  leftover breadcrumb.php          ← keep include; CSS hides h1 + book art
  .gp-student-shell
    container
      gp_ds_page_title             ← one title: get_phrase('My Courses')
      row
        col-lg-3  sidebar card     ← identity + grouped nav
        col-lg-9  course cards     ← one gp_ds_card per enrolment
```

**Do not stack** sidebar above content on desktop. On `<768px`, sidebar first, then title/content.

**Do not invent** a second summary dashboard that needs new queries. Optional count on the page title actions: `count($enrolments).' '.get_phrase('Courses')` — existing key only.

### 2.1 Leftover breadcrumb → DS trail

Same recipe as `gp-cart.css`:

- `.gp-ds .gp-student-page .bread-crumb` — no leftover photo, no leftover `#0D0C23`, padding 8px 0 0, transparent
- `.bread-crumb h1` and `.book-img` — `display: none`
- Trail uses `--gp-fg-muted` / current `--gp-fg`, 13px

Keep `breadcrumb.php` and `$page_title`. Do not delete the include.

### 2.2 Sidebar

One `gp_ds_card` (`.gp-student-sidebar`). Identity: 72px avatar, name `--gp-fg`, email `--gp-fg-muted`.

Nav rows match list-group §20 tokens (8px radius, 10px 12px pad, 18px icons, 10px icon-label gap). Active = `--gp-primary` + white label (same as `.gp-ds .list-group-item.active`).

**Group with dividers, not new phrase keys.** Do not invent “Learning” / “Activity”. Insert a border-top spacer between leftover clusters. **Keep leftover href order** except one move (below).

**Recommended reorder (state why):** move **Instructor Followings** to sit after **Messages**. It is a follow list, not an account-settings item. It currently sits between Profile and Account. Same href, same `page_name` test. Do not hide it.

Addon / instructor extras stay where they are (after My Courses / after Messages).

### 2.3 Course row → DS card

Each enrolment is one `gp_ds_card` (or one card body row inside a list card — prefer **one card per course** so empty vs one vs many scale).

```
[thumb]  Title                              [icon-btn kebab]
         Lectures N · Quizzes N · duration
         [progress] N%
         Instructor name · stars
         Expiry / Lifetime
                                            [Start Now]
```

- Thumb: 160×100, `object-fit: cover`, radius `--gp-radius`. Keep leftover `get_course_thumbnail_url`.
- Kebab: DS icon-btn. Keep `data-bs-toggle="dropdown"`, `home/course/{slug}/{id}`, `home/instructor_page/{creator}`.
- Progress: `.progress` + `.progress-bar` from `gp-progress.css`. Keep `width: {course_progress}%`. Drop leftover `@keyframes fill-bar`.
- Start Now: `gp_ds_button` primary → `home/lesson/{slug}/{id}`. No raw `<i>` in the helper label.
- Join again: `gp_ds_button` outline + `site_url('home/handle_buy_now/'.$id)` (replace leftover `academy_6.0` host).
- Keep `include 'live_class_scadule.php'`.
- Empty: one dashed `.empty-state` card. Copy from existing phrases only (`get_phrase('Courses')` + composed sentence). Do not invent a key.

---

## 3. Constraints (every phase)

Same standing rules as `legacy-ui-redesign.md`. Short list:

- UI only. No `Home.php`, models, routes, phrase files, `common_scripts.php`.
- Keep form `name` / `id` / `action` and every hook in the old plan §2.3.
- Helpers only: `gp_ds_button` (`primary` / `secondary` / `outline` / `quiet`), `gp_ds_badge`, `gp_ds_alert`, `gp_ds_card`, `gp_ds_table`, `gp_ds_page_title`.
- Student chrome buttons stay **compact**, not marketing §05.
- CSS only under `.gp-ds`. Tokens only — no `#754FFE`, `#0D0C23`, `#1E293B`, leftover Hyper hex.
- Do not restyle public `/home/courses`, public header, or `application/views/backend/user/**`.
- Do not commit unless asked.
- If a visual change needs a logic change: **stop** and report it.

**Type rule:** `letter-spacing: normal; word-spacing: normal` on student titles, nav, body. `word-spacing: 0.16em` **only** on multi-word CTAs (`Start Now`, `Join again`, `Mark all as read`). Compose mashed `get_phrase()` with spaces.

---

## 4. Component map

| Leftover | Use instead |
|----------|-------------|
| `.bread-crumb` photo + H1 + book | Hide H1/book; token the trail (cart pattern) |
| Duplicate leftover `h1` “Courses” | `gp_ds_page_title` + `get_phrase('My Courses')` |
| `.wish-list-search` / leftover purple `.btn-profile-menu` | Already replaced — keep DS nav rows; fix type |
| `.my-course-1-full-body` / leftover row | `gp_ds_card` per course |
| Leftover red kebab | `.icon-btn` 30×30 |
| Leftover `.skill-bar` / `--color-4` | `gp-progress.css` |
| Leftover circular Start Now | `gp_ds_button` primary |
| Leftover `.enrollBtn` `#754FFE` (wishlist) | `span.btn.btn-primary` inside the card `<a>` (no nested link) |
| Leftover Follow `btn-primary` / `btn-fill` | Token both leftover class names; keep `toggleFollow` swap |
| Leftover `badge bg-danger` | `gp_ds_badge` (already) |
| Empty leftover panel | DS empty-state |

---

## 5. Light / Dark

`var(--gp-*)` only. Same token table as the old plan §5.1. Visual check = toggle Light and Dark on the **live** page. Leftover `#0D0C23` breadcrumb text is a phase fail.

---

## 6. Phases (new)

Stop after each phase. Audit the live screenshot, not only the PHP.

### Phase A — Student shell + My Courses (must ship together)

This replaces old Phase 0 leftovers **and** old Phase 1. Do not split them.

**Files**

- Modify: `assets/design-system/gp-student.css` (bump `?v=student-2`)
- Modify: `application/views/frontend/default-new/includes_top.php` (cache query only)
- Modify: `application/views/frontend/default-new/profile_menus.php` (drop inner `.gp-student-page`; add divider spacers; move Followings after Messages)
- Modify: `application/views/frontend/default-new/my_courses.php` (outer `.gp-student-page` around breadcrumb + grid)

**Do**

1. Wrap My Courses as `.gp-student-page` around `breadcrumb.php` + section.
2. Hide leftover breadcrumb H1 + book art; token the trail.
3. `gp_ds_page_title` once. Delete leftover `.my-course-1-full-body h1`.
4. Reset page-wide word-spacing. CTA-only spacing.
5. Sidebar: grouped dividers, Followings after Messages, identity still the same data.
6. One DS card per enrolment; kebab / progress / Start Now / Join again as §2.3.
7. Empty-state when `$enrolments` is empty.
8. Keep `live_class_scadule.php` include.

**Do not** restyle wishlist / followings / messages in this phase (they will still show leftover content, but they inherit the breadcrumb hide + sidebar once those views get the same outer wrap in later phases).

**Test (live, logged in)**

- One title only. No 3D books. No leftover photo band.
- Labels read **My courses**, **Start Now**, **Introduction to Web development** — not mashed.
- No red circle. No leftover circular pill.
- Start Now opens the lesson. Both kebab links work. Join again uses `site_url('home/handle_buy_now/…')`.
- Active sidebar = My Courses. Followings still in the list, now under Messages.
- Light + Dark.

**Done gate:** if the viewport still shows leftover marketing hero **or** leftover Start Now, Phase A is not done.

### Phase B — Followings + Wishlist

**Files:** `instructor_following.php`, `my_wishlist.php`

Same outer `.gp-student-page` wrap + `gp_ds_page_title`. DS tiles (related-card tokens). Keep `#follow-btn-{id}` / `toggleFollow` / `btn-primary`↔`btn-fill`. Keep `#coursesWishlistIcon{id}`, compare `redirectTo`, leftover Enroll as `span.btn` inside the card `<a>`. Empty-states.

**Test:** Follow AJAX; heart toggle; compare; purchased Start Now; Light + Dark.

### Phase C — Notifications + Messages

**Files:** `my_notifications.php`, `my_messages.php`

Wrap + title. Notifications leftover buttons → `gp_ds_button`; keep both `actionTo` URLs and `gp_ds_table`. Messages: keep two-column layout and every send/search/thread hook; leftover Send / plus → helper / icon-btn.

**Test:** Mark all / Remove all; open thread; send reply; new-message plus; `searchMessages`; `?instructor_id=`; Light + Dark.

### Phase D — Purchase history + Invoice

**Files:** `purchase_history.php`, `invoice.php`

Wrap history. `gp_ds_table` or leftover table + token CSS. Invoice button → outline helper. Invoice page: no sidebar; token print chrome; keep `window.print()` and back href. Empty-state on history.

**Test:** Invoice opens; print; back; course title still goes to `/home/course/…`; Light + Dark.

### Phase E — Profile + Account

**Files:** `user_profile.php`, `user_credentials.php`, `account_disable.php`

Wrap + titles. Keep `#profile-photo-input`, `d-hidden` toggle, `#skills` tagsinput, `.text_editor`, password ids, `showAjaxModal('home/account_disable')`. Leftover Save / Upload / danger → helpers (danger stays outline/quiet).

**Test:** Photo toggle; basics save; skills chips; password save; disable modal posts; Light + Dark.

### Phase F — Badges + instructor extras

**Files:** `badges.php`, `instructor_dashboard.php`, `payout_settings.php`

Badges: DS tiles; keep instructor / certificate branches. Dashboard: wrap; leftover status filters → helpers; do not restyle `/user` or `create_course`. Payout: `gp_ds_alert` + keep every `gateways[{identifier}][{index}]`.

**Test:** Badge branches; dashboard filters; payout save; hidden gateways stay hidden; Light + Dark.

---

## 7. Allowed files

- Views listed in the phase
- `assets/design-system/gp-student.css`
- `application/views/frontend/default-new/includes_top.php` (stylesheet query only)

Forbidden: `Home.php`, leftover `style.css` / `custom.css` repo-wide edits, public header, catalog, `backend/user/**`, new phrase keys, new `gp_ds_*` helpers.

---

## 8. Done when

- `/home/my_courses` has **one** title, slim DS breadcrumb, grouped sidebar, DS course cards
- No leftover marketing book hero, leftover red kebab, leftover circular Start Now, leftover `#754FFE` / `#0D0C23`
- Labels are readable words, not mashed strings
- Hooks in the old plan §2.3 still work
- Later student pages use the same outer wrap
- Light + Dark checked per phase
- Public header / catalog / instructor backend untouched
