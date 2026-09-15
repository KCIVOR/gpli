/**
 * Geese Project Design System — Theme Toggle
 * Phase 0 — Light/Dark theme switcher (System option removed per design direction)
 * Inert on any page without .gp-ds class
 */

(function() {
  'use strict';

  // Only initialize if the page has .gp-ds class
  var root = document.documentElement;
  var body = document.body;
  
  if (!body.classList.contains('gp-ds')) {
    return; // Exit immediately if .gp-ds is not present
  }

  var buttons = {
    light: document.getElementById('gp-theme-light'),
    dark: document.getElementById('gp-theme-dark')
  };

  /**
   * Apply theme mode to the body element
   * @param {string} mode - 'light' or 'dark'
   */
  function applyTheme(mode) {
    document.documentElement.setAttribute('data-theme', mode);
    document.documentElement.classList.add('gp-ds');
    body.setAttribute('data-theme', mode);

    var useDark = mode === 'dark';
    document.documentElement.style.colorScheme = useDark ? 'dark' : 'light';
    document.documentElement.style.backgroundColor = useDark ? '#111015' : '#FBFAF7';

    document.querySelectorAll('[data-gp-theme]').forEach(function(btn) {
      btn.classList.toggle('active', btn.getAttribute('data-gp-theme') === mode);
    });

    Object.keys(buttons).forEach(function(key) {
      if (buttons[key]) {
        buttons[key].classList.toggle('active', key === mode);
      }
    });

    // Persist to localStorage
    try {
      localStorage.setItem('gp-ds-theme', mode);
    } catch (e) {
      console.warn('Unable to save theme preference:', e);
    }
  }

  /**
   * Initialize theme from localStorage or default to light.
   * A previously-stored 'system' value (from before the System option was
   * removed) falls back to 'light' here, same as any other unrecognized value.
   */
  function initTheme() {
    var savedTheme = 'light';
    try {
      var stored = localStorage.getItem('gp-ds-theme');
      if (stored === 'light' || stored === 'dark') {
        savedTheme = stored;
      }
    } catch (e) {
      console.warn('Unable to read theme preference:', e);
    }
    applyTheme(savedTheme);
  }

  /**
   * Attach event listeners to theme buttons
   */
  function attachListeners() {
    document.querySelectorAll('[data-gp-theme]').forEach(function(btn) {
      btn.addEventListener('click', function() {
        applyTheme(btn.getAttribute('data-gp-theme'));
      });
    });

    if (buttons.light && !buttons.light.hasAttribute('data-gp-theme')) {
      buttons.light.addEventListener('click', function() {
        applyTheme('light');
      });
    }
    if (buttons.dark && !buttons.dark.hasAttribute('data-gp-theme')) {
      buttons.dark.addEventListener('click', function() {
        applyTheme('dark');
      });
    }
  }

  // Initialize on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
      initTheme();
      attachListeners();
    });
  } else {
    initTheme();
    attachListeners();
  }
})();
