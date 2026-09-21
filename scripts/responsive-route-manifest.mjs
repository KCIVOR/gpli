// Fixed route manifest for the responsive design-system audit.
// Phase 0: public routes only, each proven reachable locally (2026-09-21).
// Authenticated roles are added in Phase 4+ and must never carry credentials.

export const viewports = [
  { name: 'desktop', width: 1440, height: 900 },
  { name: 'tablet-landscape', width: 1024, height: 768 },
  { name: 'tablet-portrait', width: 768, height: 1024 },
  { name: 'mobile', width: 390, height: 844 },
  { name: 'mobile-narrow', width: 360, height: 800 },
];

export const themes = ['light', 'dark'];

export const routes = [
  { name: 'home', path: '/', wrapper: '.gp-landing', stylesheet: 'gp-landing.css', role: 'public' },
  { name: 'catalog', path: '/home/courses', wrapper: '.gp-catalog-page', stylesheet: 'gp-courses.css', role: 'public' },
  { name: 'course-detail', path: '/home/course/introduction-to-time-blocking/75', wrapper: '.gp-course-page', stylesheet: 'gp-course-detail.css', role: 'public' },
  { name: 'faq', path: '/home/faq', wrapper: '.gp-faq-page', stylesheet: 'gp-faq.css', role: 'public' },
  { name: 'about', path: '/home/about_us', wrapper: '.gp-policy-page', stylesheet: 'gp-legal-pages.css', role: 'public' },
  { name: 'contact', path: '/home/contact_us', wrapper: '.gp-contact-grid', stylesheet: 'gp-contact-us.css', role: 'public' },
  { name: 'blog', path: '/blog', wrapper: '.gp-blog-hero', stylesheet: 'gp-blog.css', role: 'public' },
];

// Phase 2 additions (commerce). Cart is inspected empty: adding items mutates the session.
routes.push(
  { name: 'cart', path: '/home/shopping_cart', wrapper: '.gp-cart', stylesheet: 'gp-cart.css', role: 'public' },
  { name: 'compare', path: '/home/compare', wrapper: '.compare-card', stylesheet: 'gp-compare.css', role: 'public' },
  { name: 'compare-populated', path: '/home/compare?course-id-1=75&course-id-2=74', wrapper: '.compare-card', stylesheet: 'gp-compare.css', role: 'public' },
);

// Phase 3 additions: public content, legal and account pages proven reachable 2026-09-22.
// `become_an_instructor` renders an empty page for guests, so it needs a student session (blocked).
routes.push(
  { name: 'login', path: '/login', wrapper: '.gp-auth-form-wrap', stylesheet: 'gp-auth.css', role: 'public' },
  { name: 'sign-up', path: '/sign_up', wrapper: '.gp-auth-form-wrap', stylesheet: 'gp-auth.css', role: 'public' },
  { name: 'forgot-password', path: '/home/forgot_password', wrapper: '.gp-auth-form-wrap', stylesheet: 'gp-auth.css', role: 'public' },
  { name: 'privacy-policy', path: '/home/privacy_policy', wrapper: '.gp-policy-page', stylesheet: 'gp-legal-pages.css', role: 'public' },
  { name: 'terms', path: '/home/terms_and_condition', wrapper: '.gp-policy-page', stylesheet: 'gp-legal-pages.css', role: 'public' },
  { name: 'refund-policy', path: '/home/refund_policy', wrapper: '.gp-policy-page', stylesheet: 'gp-legal-pages.css', role: 'public' },
  { name: 'cookie-policy', path: '/home/cookie_policy', wrapper: '.privacy-policy', stylesheet: 'gp-legal-pages.css', role: 'public' },
  { name: 'community-posts', path: '/home/posts', wrapper: '.courses-list-view', stylesheet: 'gp-community.css', role: 'public' },
  { name: 'become-instructor', path: '/home/become_an_instructor', wrapper: '.gp-instructor-apply-form', stylesheet: 'gp-instructor-apply.css', role: 'student' },
);

// Phase 4 additions: authenticated shell probes. Read-only list/dashboard pages only.
// Sessions come from tmp/auth/<role>.json (see scripts/save-auth-session.mjs); no credentials live here.
// `wrapper` is the shared shell content region; Phase 5 adds page-family owners.
routes.push(
  { name: 'admin-dashboard', path: '/admin/dashboard', wrapper: '.content-page', stylesheet: 'gp-admin-shell.css', role: 'admin' },
  { name: 'admin-courses', path: '/admin/courses', wrapper: '.content-page', stylesheet: 'gp-admin-courses.css', role: 'admin' },
  { name: 'admin-users', path: '/admin/users', wrapper: '.content-page', stylesheet: 'gp-admin-users.css', role: 'admin' },
  { name: 'admin-enrol-history', path: '/admin/enrol_history', wrapper: '.content-page', stylesheet: 'gp-admin-enrol.css', role: 'admin' },
  { name: 'admin-message', path: '/admin/message', wrapper: '.content-page', stylesheet: 'gp-admin-message.css', role: 'admin' },
  { name: 'instructor-dashboard', path: '/user/dashboard', wrapper: '.content-page', stylesheet: 'gp-dashboard.css', role: 'instructor' },
  { name: 'instructor-courses', path: '/user/courses', wrapper: '.content-page', stylesheet: 'gp-admin-courses.css', role: 'instructor' },
);

// Phase 5 additions: more admin page families (read-only views; forms are only viewed, never submitted).
routes.push(
  { name: 'admin-categories', path: '/admin/categories', wrapper: '.content-page', stylesheet: 'gp-admin-courses.css', role: 'admin' },
  { name: 'admin-instructors', path: '/admin/instructors', wrapper: '.content-page', stylesheet: 'gp-admin-users.css', role: 'admin' },
  { name: 'admin-coupons', path: '/admin/coupons', wrapper: '.content-page', stylesheet: 'gp-admin-courses.css', role: 'admin' },
  { name: 'admin-course-edit', path: '/admin/course_form/course_edit/75', wrapper: '.content-page', stylesheet: 'gp-admin-courses.css', role: 'admin' },
  { name: 'admin-system-settings', path: '/admin/system_settings', wrapper: '.content-page', stylesheet: 'gp-admin-settings.css', role: 'admin' },
  { name: 'admin-payment-settings', path: '/admin/payment_settings', wrapper: '.content-page', stylesheet: 'gp-admin-settings.css', role: 'admin' },
  { name: 'admin-profile', path: '/admin/manage_profile', wrapper: '.content-page', stylesheet: 'gp-admin-profile.css', role: 'admin' },
  { name: 'admin-revenue', path: '/admin/admin_revenue', wrapper: '.content-page', stylesheet: 'gp-admin-report.css', role: 'admin' },
  { name: 'admin-instructor-revenue', path: '/admin/instructor_revenue', wrapper: '.content-page', stylesheet: 'gp-admin-report.css', role: 'admin' },
);

// Phase 5: pages whose add/edit actions open ajax modals (open-only probe), plus content/newsletter/blog families.
routes.push(
  { name: 'admin-blog-category', path: '/admin/blog_category', wrapper: '.content-page', stylesheet: 'gp-admin-blog.css', role: 'admin' },
  { name: 'admin-badges', path: '/admin/badges', wrapper: '.content-page', stylesheet: 'gp-admin-settings.css', role: 'admin' },
  { name: 'admin-newsletters', path: '/admin/newsletters', wrapper: '.content-page', stylesheet: 'gp-admin-newsletter.css', role: 'admin' },
  { name: 'admin-blog', path: '/admin/blog', wrapper: '.content-page', stylesheet: 'gp-admin-blog.css', role: 'admin' },
  { name: 'admin-frontend-settings', path: '/admin/frontend_settings', wrapper: '.content-page', stylesheet: 'gp-admin-settings.css', role: 'admin' },
);
