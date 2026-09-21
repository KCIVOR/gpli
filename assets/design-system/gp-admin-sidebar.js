/**
 * Admin / instructor sidebar: clicking a menu item that has sub-pages while the sidebar is the
 * collapsed icon rail expands the sidebar and opens that item's dropdown.
 *
 * Before this, a click on such an icon only flipped MetisMenu's internal "open" state, which the
 * rail's CSS hides, so the icon appeared to do nothing. Nothing in the theme's scripts is changed:
 * the sidebar is expanded through the theme's own menu button (which toggles body.enlarged), then the
 * same click is replayed so MetisMenu opens the item's dropdown as usual. Plain links (no sub-menu),
 * the phone overlay and the full-width sidebar keep their normal behaviour.
 */
(function () {
  'use strict';

  var replaying = false;

  document.addEventListener('click', function (e) {
    if (replaying || !e.target.closest) return;

    var link = e.target.closest('.left-side-menu .side-nav-link');
    if (!link || !link.parentElement) return;

    var hasSubMenu = link.parentElement.querySelector(':scope > ul');
    var inRail = document.body.classList.contains('enlarged') && window.innerWidth >= 768;
    if (!hasSubMenu || !inRail) return;

    var toggle = document.querySelector('.gp-admin-topbar .button-menu-mobile, .button-menu-mobile');
    if (!toggle) return;

    // Expand the sidebar first (theme handler, synchronous), then replay the click on the same link.
    e.preventDefault();
    e.stopPropagation();
    e.stopImmediatePropagation();
    toggle.click();

    replaying = true;
    try {
      link.click();
    } finally {
      replaying = false;
    }
  }, true);
})();
