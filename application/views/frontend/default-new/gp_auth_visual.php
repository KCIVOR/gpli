<?php
    $gp_auth_system = get_settings('system_name');
    $gp_auth_title = site_phrase(get_frontend_settings('banner_title'));
    $gp_auth_sub = site_phrase(get_frontend_settings('banner_sub_title'));
    $gp_auth_course_count = (int) $this->db->where('status', 'active')->count_all_results('course');
    $gp_auth_category_count = (int) $this->db->count_all('category');
    $gp_auth_learner_count = (int) $this->db->where('role_id', 2)->count_all_results('users');

    // Admin-uploaded illustration (Home Page Builder → "Login / Signup
    // Illustration" card) takes priority; falls back to the page's own
    // default artwork (set per-page below, e.g. login-security.gif vs
    // cloud-security.gif) when nothing has been uploaded.
    $gp_auth_uploaded_image = get_frontend_settings('gpli_auth_illustration');
    if ($gp_auth_uploaded_image) {
        $gp_auth_image_url = base_url('uploads/system/' . $gp_auth_uploaded_image);
    } else {
        $gp_auth_image = isset($gp_auth_image) ? $gp_auth_image : 'assets/frontend/default-new/image/login-security.gif';
        $gp_auth_image_url = site_url($gp_auth_image);
    }
?>
<div class="gp-auth-visual">
    <div>
        <div class="kicker"><?php echo htmlspecialchars($gp_auth_system, ENT_QUOTES, 'UTF-8'); ?></div>
        <h2><?php echo htmlspecialchars($gp_auth_title, ENT_QUOTES, 'UTF-8'); ?></h2>
        <?php if ($gp_auth_sub !== ''): ?>
            <p><?php echo htmlspecialchars($gp_auth_sub, ENT_QUOTES, 'UTF-8'); ?></p>
        <?php endif; ?>
        <div class="gp-auth-portrait">
            <img loading="lazy" src="<?php echo $gp_auth_image_url; ?>" alt="">
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
