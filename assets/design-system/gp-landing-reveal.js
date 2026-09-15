/* Geese Project Design System — landing page scroll-reveal.
 * Reveals each .gp-landing section (except the hero, which animates on
 * load instead) every time it scrolls into view, and re-hides it once it
 * scrolls back out — a repeating entrance, so the transition plays again
 * each time a section comes into the viewport (scrolling down, then back
 * up and down again), not just once per page load. */
document.addEventListener('DOMContentLoaded', function () {
  if (!document.documentElement.classList.contains('gp-landing-anim')) return;

  var sections = document.querySelectorAll('.gp-ds section.gp-landing:not(.gp-landing-hero)');
  if (! sections.length) return;

  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      entry.target.classList.toggle('gp-landing-in', entry.isIntersecting);
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -60px 0px' });

  sections.forEach(function (el) { io.observe(el); });
});
