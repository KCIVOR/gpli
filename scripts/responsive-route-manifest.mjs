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
