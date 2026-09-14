<?php
    $gp_auth_system = get_settings('system_name');
    $gp_auth_title = site_phrase(get_frontend_settings('banner_title'));
    $gp_auth_sub = site_phrase(get_frontend_settings('banner_sub_title'));
    $gp_auth_course_count = (int) $this->db->where('status', 'active')->count_all_results('course');
    $gp_auth_category_count = (int) $this->db->count_all('category');
    $gp_auth_learner_count = (int) $this->db->where('role_id', 2)->count_all_results('users');
    $gp_auth_image = isset($gp_auth_image) ? $gp_auth_image : 'assets/frontend/default-new/image/login-security.gif';
?>
<div class="gp-auth-visual">
    <div>
        <div class="kicker"><?php echo htmlspecialchars($gp_auth_system, ENT_QUOTES, 'UTF-8'); ?></div>
        <h2><?php echo htmlspecialchars($gp_auth_title, ENT_QUOTES, 'UTF-8'); ?></h2>
        <?php if ($gp_auth_sub !== ''): ?>
            <p><?php echo htmlspecialchars($gp_auth_sub, ENT_QUOTES, 'UTF-8'); ?></p>
        <?php endif; ?>
        <div class="gp-auth-portrait">
            <img loading="lazy" src="<?php echo site_url($gp_auth_image); ?>" alt="">
        </div>
    </div>
    <div class="gp-auth-stats">
        <div>
            <b><?php echo $gp_auth_course_count; ?></b>
            <span><?php echo get_phrase('Courses'); ?></span>
        </div>
        <div>
            <b><?php echo $gp_auth_category_count; ?></b>
            <span><?php echo get_phrase('Categories'); ?></span>
        </div>
        <div>
            <b><?php echo $gp_auth_learner_count; ?></b>
            <span><?php echo get_phrase('Students'); ?></span>
        </div>
    </div>
</div>
