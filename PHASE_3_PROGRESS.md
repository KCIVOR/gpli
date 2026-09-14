# Phase 3 — Remaining Pages Migration Progress

**Start Date:** Saturday, September 12, 2026  
**Status:** ✅ COMPLETE for remaining working core pages (Phase 5 surfaces deferred)

---

## Current State (re-verified live)

### Pages on the whitelist
**Total: 124 entries** (36 frontend / 74 admin / 14 user)

This is the live `application/config/design_system_pages.php` count after the leftover Phase 3 pass. The earlier “65 / 126” and “Batch 1–10 checkbox” sections were stale — those batches were already on the whitelist before this leftover pass.

#### Frontend (36)
**Already on whitelist before leftover pass (21):**
`courses_page`, `course_page`, `website_faq`, `login`, `sign_up`, `shopping_cart`, `instructor_page`, `purchase_history`, `about_us`, `contact_us`, `privacy_policy`, `terms_and_condition`, `refund_policy`, `my_courses`, `my_wishlist`, `my_messages`, `user_profile`, `forgot_password`, `instructor_following`, `compare`, `invoice`

**Added this leftover pass (15):**
`blogs`, `blog_details`, `user_credentials`, `become_a_instructor`, `payout_settings`, `badges`, `community_index`, `community_shared_post`, `community_my_posts`, `community_saved_posts`, `verification_code`, `new_login_confirmation`, `change_password_from_forgot_password`, `custom_page_viewer`, `404`

#### Admin (74)
**Already on whitelist before leftover pass (31):**
`categories`, `newsletters`, `seo_settings`, `active_courses`, `pending_courses`, `addons`, `sub_categories`, `dashboard`, `courses-server-side`, `users`, `instructors`, `system_settings`, `course_add`, `course_edit`, `blog_category`, `frontend_settings`, `payment_settings`, `instructor_settings`, `theme_settings`, `coupons`, `enrol_history`, `instructor_payout`, `admin_revenue`, `instructor_revenue`, `admins`, `admin_permission`, `invoice`, `enrol_student`, `notification_settings`, `social_login`, `manage_profile`

**Added this leftover pass (43):**
`blog`, `blog_add`, `blog_edit`, `instructors_pending_blog`, `blog_settings`, `drip_content_settings`, `certificate_settings`, `bbb_live_class_settings`, `category_add`, `category_edit`, `sub_category_add`, `sub_category_edit`, `instructor_add`, `instructor_edit`, `user_add`, `user_edit`, `purchase_history`, `video_player`, `manage_language`, `message`, `about`, `available_addons`, `addon_add`, `addon_update`, `application_list`, `admin_add`, `admin_edit`, `coupon_add`, `coupon_edit`, `custom_page`, `add_custom_page`, `edit_custom_page`, `academy_cloud`, `data_center`, `subscribed_user`, `newsletter_history`, `contact`, `wasabi_settings`, `sitemap_settings`, `badges`, `announcements`, `announcement_add`, `announcement_edit`

#### User / Instructor (14)
**Already on whitelist (13):**
`dashboard`, `course_add`, `course_edit`, `student_academic_progress`, `courses-server-side`, `sales_report`, `payout_report`, `payment_settings`, `invoice`, `blog`, `blog_add`, `blog_edit`, `pending_blog`

**Added this leftover pass (1):**
`become_an_instructor` — working User.php page that the stale “13/13 complete” count missed

---

## What was not added (and why)

### Broken routes — Phase 5a (no matching view)
`my_notifications`, `update_user_photo`, `cookie_policy`, `instructor_dashboard`, `create_course`, `manage_course_details`, `lesson_edit` (Home.php), `lessons` (Admin.php + User.php), `open_ai_settings`

### Phase 5 surfaces (other agents)
- Homepage templates `home_1`–`home_7`, `home_builder`, admin `home_page_builder`
- `payment-global/`, `payment_gateway`
- `email/`, `install/`, `components/main/`
- Course player `lessons/` tree and `mobile/` (`quiz_view`, `live_class`)

### Not live `page_name`s (do not invent)
Curriculum / lesson / quiz admin views (`lesson_add`, `quiz_add`, `section_add`, etc.) are AJAX/modal fragments. They inherit `.gp-ds` from already-whitelisted `course_edit`. No controller sets a `curriculum` `page_name` — **UNKNOWN, not invented**.

---

## Migration strategy (unchanged)

**SKIP (different phases):**
- Payment pages → Phase 5b
- Email templates → Phase 5c
- Install pages → Phase 5e
- Homepage builder / `home_1`–`home_7` → Phase 5d
- Broken routes → Phase 5a

---

## Issues Log

### Issues Encountered
None. Whitelist-only; no JS or backend logic changes.

### Component Gaps Found
None identified (no markup/CSS edits in this pass).

### Stop Conditions Triggered
None.

---

## Statistics

- **Whitelist entries:** 124
- **Added this leftover pass:** 59
- **Broken routes still deferred:** 10
- **Phase 5 surfaces:** not in this phase
- **Theme default:** light (`gp-theme-toggle.js` not changed)

---

## Next Actions

1. ✅ Remaining working core pages whitelisted
2. ⏭️ Phase 4 — admin Bootstrap 4 → 5 (separate, high-risk)
3. ⏭️ Phase 5 — broken routes and extended surfaces (other agents / later)

**Last Updated:** Saturday, September 12, 2026
