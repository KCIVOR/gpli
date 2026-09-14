/* Geese Project Design System — landing page scroll-reveal, boot step.
 * Runs synchronously in <head> (same pattern as gp-theme-boot.js) so the
 * "start hidden" CSS only ever applies on browsers that will actually
 * reveal the sections again — no flash, no permanently-invisible content
 * if JS fails or the visitor has asked for reduced motion. */
(function () {
  if (window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  if (!('IntersectionObserver' in window)) return;
  document.documentElement.classList.add('gp-landing-anim');
})();
