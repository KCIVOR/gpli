/* Geese Project Design System — landing page scroll-reveal.
 * Reveals each .gp-landing section (except the hero, which animates on
 * load instead) the first time it scrolls into view, then stops watching
 * it — a one-time entrance, not a replay-on-every-scroll effect. */
document.addEventListener('DOMContentLoaded', function () {
  if (!document.documentElement.classList.contains('gp-landing-anim')) return;

  var sections = document.querySelectorAll('.gp-ds section.gp-landing:not(.gp-landing-hero)');
  if (! sections.length) return;

  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('gp-landing-in');
        io.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -60px 0px' });

  sections.forEach(function (el) { io.observe(el); });
});
