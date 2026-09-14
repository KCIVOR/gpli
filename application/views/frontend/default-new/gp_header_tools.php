<?php
    $gp_header_use_ids = !empty($gp_header_use_ids);
    $gp_ds_tools_active = gp_ds_is_active(isset($page_name) ? $page_name : '');
?>
<div class="gp-header-tools">
    <form action="#" method="POST" class="language-control select-box">
        <select onchange="actionTo(`<?php echo site_url('home/switch_language/') ?>${$(this).val()}`)" class="select-control form-select nice-select" aria-label="<?php echo get_phrase('Language'); ?>">
            <?php
            $languages = $this->crud_model->get_all_languages();
            $selected_language = $this->session->userdata('language');
            foreach ($languages as $language): ?>
                <?php if (trim($language) != ""): ?>
                    <option value="<?php echo strtolower($language); ?>" <?php if ($selected_language == $language): ?>selected<?php endif; ?>><?php echo ucwords($language); ?></option>
                <?php endif; ?>
            <?php endforeach; ?>
        </select>
    </form>
    <?php if ($gp_ds_tools_active): ?>
        <div class="gp-theme-row" role="group" aria-label="Theme">
            <button type="button"<?php echo $gp_header_use_ids ? ' id="gp-theme-light"' : ''; ?> data-gp-theme="light" class="gp-theme-btn" aria-label="Light" title="Light">
                <svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>
            </button>
            <button type="button"<?php echo $gp_header_use_ids ? ' id="gp-theme-system"' : ''; ?> data-gp-theme="system" class="gp-theme-btn" aria-label="System" title="System">
                <svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="4" width="18" height="13" rx="2"/><path d="M8 21h8M12 17v4"/></svg>
            </button>
            <button type="button"<?php echo $gp_header_use_ids ? ' id="gp-theme-dark"' : ''; ?> data-gp-theme="dark" class="gp-theme-btn" aria-label="Dark" title="Dark">
                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M21 14.5A8.5 8.5 0 1 1 9.5 3 7 7 0 0 0 21 14.5z"/></svg>
            </button>
        </div>
    <?php endif; ?>
</div>
