<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Geese Project Design System — Page Whitelist
 *
 * Each array controls which pages get the .gp-ds class applied to their <body>.
 * Add a page_name to the appropriate array to activate the design system for that page.
 *
 * Activation is now shell-level: every frontend/admin/user page gets .gp-ds
 * unless listed in gp_ds_exclude_pages. The arrays below are the live inventory.
 *
 * Rollback for one page = add its page_name to $config['gp_ds_exclude_pages'].
 *
 * Phase 3 complete for remaining working core pages.
 * page_names are live values from Admin.php / Home.php / Blog.php / Login.php /
 * Sign_up.php / Page.php / User.php / addons/Certificate.php, and only added
 * when a matching view file exists.
 */

// Frontend pages (Home.php, Blog.php, Login.php, Sign_up.php, Page.php)
$config['gp_ds_frontend_pages'] = [
    // Phase 1-Pilot + Phase 2a
    'courses_page',
    'course_page',
    'website_faq',
    // Phase 3 Batch 1 — high-traffic
    'login',
    'sign_up',
    'shopping_cart',
    'instructor_page',
    'purchase_history',
    // Phase 3 Batch 4 — content & info
    'about_us',
    'contact_us',
    'privacy_policy',
    'terms_and_condition',
    'refund_policy',
    // Phase 3 Batch 8 — user account
    'my_courses',
    'my_wishlist',
    'my_messages',
    'user_profile',
    'forgot_password',
    'instructor_following',
    'compare',
    'invoice',
    // Phase 3 leftover — blogs
    'blogs',
    'blog_details',
    // Phase 3 leftover — remaining account / instructor surfaces
    'user_credentials',
    'become_a_instructor',
    'payout_settings',
    'badges',
    // Phase 3 leftover — community
    'community_index',
    'community_shared_post',
    'community_my_posts',
    'community_saved_posts',
    // Phase 3 leftover — auth follow-ups
    'verification_code',
    'new_login_confirmation',
    'change_password_from_forgot_password',
    // Phase 3 leftover — custom pages + 404
    'custom_page_viewer',
    '404',
    // Phase 5a — determined broken-route views
    'cookie_policy',
    'update_user_photo',
    // Phase 5d — homepage builder / permanent home variants
    'home_builder',
    'home',
    'home_1',
    'home_2',
    'home_3',
    'home_4',
    'home_5',
    'home_6',
    'home_7',
    'home_elegant',
    'home_fitness',
    'home_language',
    'home_development',
    'home_kindergarten',
    'home_cooking2',
    'home_university2',
    'home_marketplace',
    // Missing Home.php views — built from controller/model signals
    'my_notifications',
    'instructor_dashboard',
    'create_course',
    'manage_course_details',
    'lesson_edit',
    'lessons',
    'payment_gateway',
    'live_class'
];

// Empty = all shared-shell pages are on. Add a page_name here to opt out.
$config['gp_ds_exclude_pages'] = [];

// Admin pages (Admin.php + addons/Certificate.php settings)
$config['gp_ds_admin_pages'] = [
    // Phase 1-Pilot + Phase 2a + Phase 2b
    'categories',
    'newsletters',
    'seo_settings',
    'active_courses',           // view exists; not a live Admin.php page_name (courses list uses courses-server-side)
    'pending_courses',
    'addons',
    'sub_categories',           // view exists; not a live Admin.php page_name
    // Phase 3 Batch 2 — core
    'dashboard',
    'courses-server-side',
    'users',
    'instructors',
    'system_settings',
    // Phase 3 Batch 5 — course management
    'course_add',
    'course_edit',
    // Phase 3 Batch 6 — content
    'blog_category',
    // Phase 3 Batch 9 — settings
    'frontend_settings',
    'payment_settings',
    'instructor_settings',
    'theme_settings',
    // Phase 3 Batch 10 — specialized
    'coupons',
    'enrol_history',
    'instructor_payout',
    'admin_revenue',
    'instructor_revenue',
    'admins',
    'admin_permission',
    'invoice',
    'enrol_student',
    'notification_settings',
    'social_login',
    'manage_profile',
    // Phase 3 leftover — blogs
    'blog',
    'blog_add',
    'blog_edit',
    'instructors_pending_blog',
    'blog_settings',
    // Phase 3 leftover — drip / certificate / live class
    'drip_content_settings',
    'certificate_settings',
    'bbb_live_class_settings',
    // Phase 3 leftover — category / user / instructor forms
    'category_add',
    'category_edit',
    'sub_category_add',
    'sub_category_edit',
    'instructor_add',
    'instructor_edit',
    'user_add',
    'user_edit',
    // Phase 3 leftover — remaining core admin
    'purchase_history',
    'video_player',
    'manage_language',
    'message',
    'about',
    'available_addons',
    'addon_add',
    'addon_update',
    'application_list',
    'admin_add',
    'admin_edit',
    'coupon_add',
    'coupon_edit',
    // Phase 3 leftover — custom pages
    'custom_page',
    'add_custom_page',
    'edit_custom_page',
    // Phase 3 leftover — remaining settings & ops
    'academy_cloud',
    'data_center',
    'subscribed_user',
    'newsletter_history',
    'contact',
    'wasabi_settings',
    'sitemap_settings',
    'badges',
    'announcements',
    'announcement_add',
    'announcement_edit',
    // Phase 5a — determined broken-route view
    'lessons',
    // Missing Admin.php view — addon fields not inferred
    'open_ai_settings',
    'home_page_builder'
];

// User/Instructor pages (User.php)
$config['gp_ds_user_pages'] = [
    // Phase 1-Pilot + Phase 2a + Phase 2b
    'dashboard',
    'course_add',
    'course_edit',
    'student_academic_progress',
    // Phase 3 Batch 3
    'courses-server-side',
    'sales_report',
    'payout_report',
    'payment_settings',
    'invoice',
    // Phase 3 Batch 7
    'blog',
    'blog_add',
    'blog_edit',
    'pending_blog',
    // Phase 3 leftover — was missing from the stale 13/13 count
    'become_an_instructor',
    // Phase 5a — determined broken-route view
    'lessons'
];
