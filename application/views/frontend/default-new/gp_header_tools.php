<?php
    $gp_header_use_ids = !empty($gp_header_use_ids);
    // The desktop header leaves the theme switch out (it lives in the footer); the mobile drawer keeps it.
    $gp_header_show_theme = !isset($gp_header_show_theme) || $gp_header_show_theme;
    $gp_ds_tools_active = gp_ds_is_active(isset($page_name) ? $page_name : '');
?>
<div class="gp-header-tools">
    <?php
    $languages = $this->crud_model->get_all_languages();
    $selected_language = $this->session->userdata('language');
    ?>
    <div class="dropdown gp-lang-dropdown">
        <button type="button" class="btn dropdown-toggle gp-lang-toggle" data-bs-toggle="dropdown" aria-expanded="false" aria-label="<?php echo get_phrase('Language'); ?>">
            <svg width="15" height="15" viewBox="0 0 20 20" fill="none" aria-hidden="true"><circle cx="10" cy="10" r="8" stroke="currentColor" stroke-width="1.4"/><path d="M2 10h16M10 2c2.2 2.2 3.4 5 3.4 8s-1.2 5.8-3.4 8c-2.2-2.2-3.4-5-3.4-8s1.2-5.8 3.4-8Z" stroke="currentColor" stroke-width="1.4"/></svg>
            <span class="gp-lang-toggle-label"><?php echo $selected_language ? ucwords($selected_language) : get_phrase('Language'); ?></span>
        </button>
        <ul class="dropdown-menu dropdown-menu-end gp-lang-menu">
            <?php foreach ($languages as $language): ?>
                <?php if (trim($language) != ""): ?>
                    <?php $gp_lang_current = $selected_language == $language; ?>
                    <li>
                        <a class="dropdown-item gp-lang-item<?php echo $gp_lang_current ? ' gp-lang-item-current' : ''; ?>" href="javascript:void(0)"
                            onclick="actionTo('<?php echo site_url('home/switch_language/') . strtolower($language); ?>')">
                            <span><?php echo ucwords($language); ?></span>
                            <?php if ($gp_lang_current): ?>
                                <svg width="14" height="14" viewBox="0 0 16 16" fill="none" aria-hidden="true"><path d="M3 8.5 6.2 11.5 13 4.5" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg>
                            <?php endif; ?>
                        </a>
                    </li>
                <?php endif; ?>
            <?php endforeach; ?>
        </ul>
    </div>
    <?php if ($gp_header_show_theme) {
        $gp_theme_use_ids = $gp_header_use_ids;
        include "gp_theme_toggle.php";
    } ?>
</div>
