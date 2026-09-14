<?php if(get_frontend_settings('recaptcha_status')): ?>
  <script src="https://www.google.com/recaptcha/api.js" async defer></script>
<?php endif; ?>

<?php $gp_auth_image = 'assets/frontend/default-new/image/cloud-security.gif'; ?>
<section class="gp-auth-shell">
    <?php include 'gp_auth_visual.php'; ?>

    <div class="gp-auth-form-wrap">
        <div class="gp-auth-form">
            <div class="eyebrow"><?php echo get_phrase('Account recovery'); ?></div>
            <h1><?php echo get_phrase('Change Password'); ?></h1>
            <p class="gp-auth-sub"><?php echo get_phrase('Change your password to secure your account'); ?></p>

            <form action="<?php echo site_url('login/change_password/'.$verification_code); ?>" method="post" class="gp-ds-form">
                <div class="gp-auth-field">
                    <label for="new_password"><?php echo get_phrase('New Password'); ?></label>
                    <div class="gp-auth-input-wrap">
                        <input id="new_password" type="password" name="new_password" placeholder="<?php echo get_phrase('Enter a new password'); ?>" autocomplete="new-password">
                    </div>
                </div>
                <div class="gp-auth-field">
                    <label for="confirm_password"><?php echo get_phrase('Confirm your new password'); ?></label>
                    <div class="gp-auth-input-wrap">
                        <input id="confirm_password" type="password" name="confirm_password" placeholder="<?php echo get_phrase('Retype your new password'); ?>" autocomplete="new-password">
                    </div>
                </div>

                <?php if(get_frontend_settings('recaptcha_status')): ?>
                    <div class="g-recaptcha" data-sitekey="<?php echo get_frontend_settings('recaptcha_sitekey'); ?>"></div>
                <?php endif; ?>

                <?php gp_ds_button(get_phrase('Continue'), [
                    'type' => 'submit',
                    'extra_class' => 'gp-auth-submit',
                ]); ?>
            </form>

            <p class="gp-auth-foot">
                <a href="<?php echo site_url('login'); ?>"><?php echo get_phrase('Back to login'); ?></a>
            </p>
        </div>
    </div>
</section>
