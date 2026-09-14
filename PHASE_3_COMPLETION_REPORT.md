# Phase 3 — Remaining Working Core Pages — COMPLETE

**Date:** Saturday, September 12, 2026  
**Status:** ✅ COMPLETE for remaining working core pages  
**Scope:** UI-only whitelist. No controller, model, JS, or theme-toggle changes.

---

## Method (re-verified live)

1. Extracted every `$page_data['page_name']` from `Admin.php`, `Home.php`, `Blog.php`, plus `Login.php`, `Sign_up.php`, `Page.php`, `User.php`, and `addons/Certificate.php`.
2. Confirmed each candidate has a matching view:
   - Frontend: `application/views/frontend/default-new/{page_name}.php`
   - Admin: `application/views/backend/admin/{page_name}.php`
   - User: `application/views/backend/user/{page_name}.php`
3. Diffed against the existing whitelist (65 entries).
4. Added only **existing** view `page_name`s. Did not invent pages.

Default theme remains **light** (`gp-theme-toggle.js` untouched).

---

## Starting whitelist (before this leftover pass)

65 entries (21 frontend / 31 admin / 13 user).

---

## Exact `page_name`s added this pass (59)

### Frontend — 15

| Batch | page_name | Source | View |
|---|---|---|---|
| Blogs | `blogs` | Blog.php:29,90,96 | `frontend/default-new/blogs.php` |
| Blogs | `blog_details` | Blog.php:112 | `frontend/default-new/blog_details.php` |
| Account | `user_credentials` | Home.php:442 | `frontend/default-new/user_credentials.php` |
| Account | `become_a_instructor` | Home.php:1974 | `frontend/default-new/become_a_instructor.php` |
| Account | `payout_settings` | Home.php:1998 | `frontend/default-new/payout_settings.php` |
| Account | `badges` | Home.php:2210 | `frontend/default-new/badges.php` |
| Community | `community_index` | Home.php:2265 | `frontend/default-new/community_index.php` |
| Community | `community_shared_post` | Home.php:2310 | `frontend/default-new/community_shared_post.php` |
| Community | `community_my_posts` | Home.php:2362 | `frontend/default-new/community_my_posts.php` |
| Community | `community_saved_posts` | Home.php:2375 | `frontend/default-new/community_saved_posts.php` |
| Auth | `verification_code` | Sign_up.php:46 | `frontend/default-new/verification_code.php` |
| Auth | `new_login_confirmation` | Login.php:105 | `frontend/default-new/new_login_confirmation.php` |
| Auth | `change_password_from_forgot_password` | Login.php:302 | `frontend/default-new/change_password_from_forgot_password.php` |
| Other | `custom_page_viewer` | Page.php:40 | `frontend/default-new/custom_page_viewer.php` |
| Other | `404` | Home.php:1443 | `frontend/default-new/404.php` |

### Admin — 43

| Batch | page_name | Source | View |
|---|---|---|---|
| Blogs | `blog` | Admin.php:2168 | `backend/admin/blog.php` |
| Blogs | `blog_add` | Admin.php:2135 | `backend/admin/blog_add.php` |
| Blogs | `blog_edit` | Admin.php:2143 | `backend/admin/blog_edit.php` |
| Blogs | `instructors_pending_blog` | Admin.php:2185 | `backend/admin/instructors_pending_blog.php` |
| Blogs | `blog_settings` | Admin.php:2197 | `backend/admin/blog_settings.php` |
| Drip / cert / live | `drip_content_settings` | Admin.php:2230 | `backend/admin/drip_content_settings.php` |
| Drip / cert / live | `certificate_settings` | addons/Certificate.php:100 | `backend/admin/certificate_settings.php` |
| Drip / cert / live | `bbb_live_class_settings` | Admin.php:3200 | `backend/admin/bbb_live_class_settings.php` |
| Forms | `category_add` | Admin.php:96 | `backend/admin/category_add.php` |
| Forms | `category_edit` | Admin.php:102 | `backend/admin/category_edit.php` |
| Forms | `sub_category_add` | Admin.php:131 | `backend/admin/sub_category_add.php` |
| Forms | `sub_category_edit` | Admin.php:134 | `backend/admin/sub_category_edit.php` |
| Forms | `instructor_add` | Admin.php:179 | `backend/admin/instructor_add.php` |
| Forms | `instructor_edit` | Admin.php:183 | `backend/admin/instructor_edit.php` |
| Forms | `user_add` | Admin.php:451 | `backend/admin/user_add.php` |
| Forms | `user_edit` | Admin.php:455 | `backend/admin/user_edit.php` |
| Core | `purchase_history` | Admin.php:589 | `backend/admin/purchase_history.php` |
| Core | `video_player` | Admin.php:1324 | `backend/admin/video_player.php` |
| Core | `manage_language` | Admin.php:1382 | `backend/admin/manage_language.php` |
| Core | `message` | Admin.php:1423 | `backend/admin/message.php` |
| Core | `about` | Admin.php:1617 | `backend/admin/about.php` |
| Addons | `available_addons` | Admin.php:1713 | `backend/admin/available_addons.php` |
| Addons | `addon_add` | Admin.php:1733 | `backend/admin/addon_add.php` |
| Addons | `addon_update` | Admin.php:1741 | `backend/admin/addon_update.php` |
| Admins | `application_list` | Admin.php:1796 | `backend/admin/application_list.php` |
| Admins | `admin_add` | Admin.php:1875 | `backend/admin/admin_add.php` |
| Admins | `admin_edit` | Admin.php:1882 | `backend/admin/admin_edit.php` |
| Coupons | `coupon_add` | Admin.php:2034 | `backend/admin/coupon_add.php` |
| Coupons | `coupon_edit` | Admin.php:2039 | `backend/admin/coupon_edit.php` |
| Custom pages | `custom_page` | Admin.php:2256 | `backend/admin/custom_page.php` |
| Custom pages | `add_custom_page` | Admin.php:2263 | `backend/admin/add_custom_page.php` |
| Custom pages | `edit_custom_page` | Admin.php:2271 | `backend/admin/edit_custom_page.php` |
| Settings / ops | `academy_cloud` | Admin.php:2287 | `backend/admin/academy_cloud.php` |
| Settings / ops | `data_center` | Admin.php:2297 | `backend/admin/data_center.php` |
| Settings / ops | `subscribed_user` | Admin.php:2585 | `backend/admin/subscribed_user.php` |
| Settings / ops | `newsletter_history` | Admin.php:2789 | `backend/admin/newsletter_history.php` |
| Settings / ops | `contact` | Admin.php:2868 | `backend/admin/contact.php` |
| Settings / ops | `wasabi_settings` | Admin.php:3181 | `backend/admin/wasabi_settings.php` |
| Settings / ops | `sitemap_settings` | Admin.php:3375 | `backend/admin/sitemap_settings.php` |
| Settings / ops | `badges` | Admin.php:3607 | `backend/admin/badges.php` |
| Announcements | `announcements` | Admin.php:4464 | `backend/admin/announcements.php` |
| Announcements | `announcement_add` | Admin.php:4480 | `backend/admin/announcement_add.php` |
| Announcements | `announcement_edit` | Admin.php:4484 | `backend/admin/announcement_edit.php` |

### User / Instructor — 1

| page_name | Source | View | Note |
|---|---|---|---|
| `become_an_instructor` | User.php:553 | `backend/user/become_an_instructor.php` | Working page omitted from the stale “13/13 complete” count |

---

## Ending whitelist counts

| Area | Before | Added | After |
|---|---|---|---|
| Frontend | 21 | 15 | **36** |
| Admin | 31 | 43 | **74** |
| User | 13 | 1 | **14** |
| **Total** | **65** | **59** | **124** |

Audit §4 said ~126 working pages. The remaining gap is the deferred / broken set below — not missing invented names.

Already-whitelisted leftovers kept as-is (not live `page_name`s, but views exist):

- Admin `active_courses` — `Admin.php` courses() sets `courses-server-side`, not `active_courses`
- Admin `sub_categories` — no controller sets this `page_name`
- User `student_academic_progress` — loaded via `$this->load->view()`, not as a shell `page_name`

---

## Remaining deferred pages and why

### Phase 5a — broken routes (10) — no matching view

| page_name | Controller | Why deferred |
|---|---|---|
| `my_notifications` | Home.php:392 | No `frontend/default-new/my_notifications.php` |
| `update_user_photo` | Home.php:445 | No `frontend/default-new/update_user_photo.php` |
| `cookie_policy` | Home.php:1110 | No `frontend/default-new/cookie_policy.php` |
| `instructor_dashboard` | Home.php:1128 | No `frontend/default-new/instructor_dashboard.php` |
| `create_course` | Home.php:1140 | No `frontend/default-new/create_course.php` |
| `manage_course_details` | Home.php:1156 | No `frontend/default-new/manage_course_details.php` |
| `lesson_edit` | Home.php:1241 | No `frontend/default-new/lesson_edit.php` |
| `lessons` | Admin.php:1308 | No `backend/admin/lessons.php` |
| `lessons` | User.php:460 | No `backend/user/lessons.php` |
| `open_ai_settings` | Admin.php:2372 | No `backend/admin/open_ai_settings.php` |

### Phase 5d — homepage templates / builder

| page_name | Why deferred |
|---|---|
| `home_1` … `home_7` | Explicit Phase 5d skip |
| `home_builder` | Homepage builder surface (Home.php:48) |
| `home_page_builder` | Admin builder (`Admin.php:4054`). View exists; other agents own this surface |

### Phase 5b / 5c / 5e / other trees (not this whitelist)

| page_name / area | Why deferred |
|---|---|
| `payment_gateway` | Home.php:1545 — no `frontend/default-new/payment_gateway.php`; payment-global is Phase 5b |
| `quiz_view` | Home.php:1644 — loaded into `mobile/index`, not the default-new shell |
| `live_class` | Home.php:1664 — loaded into `mobile/index`, not the default-new shell |
| Home.php `lessons` | Home.php:952 — loaded into `lessons/index` (course player tree), not default-new |
| `payment-global/` | Other agents / Phase 5b |
| `email/` | Other agents / Phase 5c |
| `install/` | Other agents / Phase 5e |
| `components/main/` | Other agents / Phase 5d |

### Curriculum / lesson / quiz admin — NOT added (not live `page_name`s)

These view files exist under `backend/admin/` but **no controller sets them as `$page_data['page_name']`**. They are AJAX / modal fragments loaded from already-whitelisted `course_edit`. Adding them to the whitelist would do nothing (the body class comes from the parent page).

Examples (not exhaustive): `lesson_add`, `lesson_edit`, `quiz_add`, `quiz_edit`, `section_add`, `section_edit`, `quiz_questions`, `*_type_lesson_add`, `*_type_lesson_edit`.

**UNKNOWN:** there is no live `curriculum` `page_name` in `Admin.php`, `Home.php`, `Blog.php`, or `User.php`. Not invented.

---

## Files changed

| File | Change |
|---|---|
| `application/config/design_system_pages.php` | Added 59 verified working `page_name`s |
| `PHASE_3_COMPLETION_REPORT.md` | This report (new) |
| `PHASE_3_PROGRESS.md` | Rewritten to match live whitelist (stale batch checkboxes removed) |

**Not changed:** controllers, models, JS, `gp-theme-toggle.js`, CSS, view markup.

---

## Stop conditions

None triggered. No JS behavior or backend logic change was required.

---

## How to test

1. Load any newly listed page while logged into the matching role.
2. Confirm `<body>` has class `gp-ds` and `data-theme="light"` (admin) or `gp-ds` on the frontend body class list.
3. Rollback any single page by removing its `page_name` from the matching array in `design_system_pages.php`.
