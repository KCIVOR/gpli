/**
 * Apply saved theme before first paint.
 * Must load without defer/async. Safe to run in <head> and again after <body>.
 * Colors match --gp-bg in gp-tokens.css (light #FBFAF7 / dark #111015).
 */
(function () {
  'use strict';

  var theme = 'light';
  try {
    var stored = localStorage.getItem('gp-ds-theme');
    if (stored === 'light' || stored === 'dark') {
      theme = stored;
    }
  } catch (e) {}

  var root = document.documentElement;
  root.classList.add('gp-ds');
  root.setAttribute('data-theme', theme);

  var useDark = theme === 'dark';

  root.style.colorScheme = useDark ? 'dark' : 'light';
  root.style.backgroundColor = useDark ? '#111015' : '#FBFAF7';

  if (document.body) {
    document.body.setAttribute('data-theme', theme);
  }
})();
