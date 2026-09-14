/**
 * Bootstrap 5 admin bridge — Phase 4
 * Maps legacy Bootstrap 4 data-* attributes and jQuery plugin calls to Bootstrap 5.
 * Re-runs after DataTables draws and other AJAX DOM inserts (row ⋮ menus).
 */
(function () {
  'use strict';

  if (typeof bootstrap === 'undefined' || typeof jQuery === 'undefined') {
    return;
  }

  var $ = jQuery;

  function migrateDataAttributes(root) {
    var scope = root || document;
    if (!scope.querySelectorAll) {
      return;
    }
    scope.querySelectorAll('[data-toggle]:not([data-bs-toggle])').forEach(function (el) {
      el.setAttribute('data-bs-toggle', el.getAttribute('data-toggle'));
    });
    scope.querySelectorAll('[data-target]:not([data-bs-target])').forEach(function (el) {
      el.setAttribute('data-bs-target', el.getAttribute('data-target'));
    });
    scope.querySelectorAll('[data-dismiss]:not([data-bs-dismiss])').forEach(function (el) {
      el.setAttribute('data-bs-dismiss', el.getAttribute('data-dismiss'));
    });
    scope.querySelectorAll('[data-parent]:not([data-bs-parent])').forEach(function (el) {
      el.setAttribute('data-bs-parent', el.getAttribute('data-parent'));
    });
  }

  function initNewTooltips(root) {
    var scope = root || document;
    if (!scope.querySelectorAll) {
      return;
    }
    scope.querySelectorAll('[data-bs-toggle="tooltip"], [data-toggle="tooltip"]').forEach(function (el) {
      if (!bootstrap.Tooltip.getInstance(el)) {
        new bootstrap.Tooltip(el);
      }
    });
  }

  function hydrate(root) {
    migrateDataAttributes(root);
    initNewTooltips(root);
  }

  hydrate(document);

  /* jQuery modal bridge (showAjaxModal, confirm_modal, etc.) */
  if (!$.fn.modal || !$.fn.modal.Constructor || !$.fn.modal.Constructor.VERSION || $.fn.modal.Constructor.VERSION.charAt(0) === '4') {
    $.fn.modal = function (option) {
      return this.each(function () {
        var instance = bootstrap.Modal.getOrCreateInstance(this);
        if (option === 'show' || (option && option.show)) {
          instance.show();
        } else if (option === 'hide') {
          instance.hide();
        } else if (option === 'toggle') {
          instance.toggle();
        }
      });
    };
  }

  $.fn.tooltip = function (option) {
    return this.each(function () {
      var existing = bootstrap.Tooltip.getInstance(this);
      if (existing) {
        existing.dispose();
      }
      var opts = typeof option === 'object' ? option : {};
      new bootstrap.Tooltip(this, opts);
    });
  };

  $.fn.popover = function (option) {
    return this.each(function () {
      var existing = bootstrap.Popover.getInstance(this);
      if (existing) {
        existing.dispose();
      }
      var opts = typeof option === 'object' ? option : {};
      new bootstrap.Popover(this, opts);
    });
  };

  /* DataTables AJAX rows are inserted after the first hydrate — re-run per draw. */
  $(document).on('init.dt draw.dt', function (e) {
    hydrate(e.target);
  });

  /* Other AJAX-injected markup (modals, notifications). */
  if (typeof window.onDomChange === 'function') {
    window.onDomChange(function () {
      hydrate(document);
    });
  }

  $(function () {
    hydrate(document);
  });
})();
