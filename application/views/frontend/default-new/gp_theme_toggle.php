<?php
/**
 * Light / dark theme switch (used by the mobile drawer and the footer).
 * Set $gp_theme_use_ids = true on exactly one instance per page: gp-theme-toggle.js
 * looks the buttons up by id and binds every [data-gp-theme] button.
 */
$gp_theme_use_ids = !empty($gp_theme_use_ids);
?>
<?php if (gp_ds_is_active(isset($page_name) ? $page_name : '')): ?>
    <div class="gp-theme-row" role="group" aria-label="Theme">
        <button type="button"<?php echo $gp_theme_use_ids ? ' id="gp-theme-light"' : ''; ?> data-gp-theme="light" class="gp-theme-btn" aria-label="Light" title="Light">
            <svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>
        </button>
        <button type="button"<?php echo $gp_theme_use_ids ? ' id="gp-theme-dark"' : ''; ?> data-gp-theme="dark" class="gp-theme-btn" aria-label="Dark" title="Dark">
            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M21 14.5A8.5 8.5 0 1 1 9.5 3 7 7 0 0 0 21 14.5z"/></svg>
        </button>
    </div>
<?php endif; ?>
