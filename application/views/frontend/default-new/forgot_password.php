<?php if(get_frontend_settings('recaptcha_status')): ?>
  <script src="https://www.google.com/recaptcha/api.js" async defer></script>
<?php endif; ?>

<?php $gp_auth_image = 'assets/frontend/default-new/image/cloud-security.gif'; ?>
<section class="gp-auth-shell">
    <?php include 'gp_auth_visual.php'; ?>

    <div class="gp-auth-form-wrap">
        <div class="gp-auth-form">
            <div class="eyebrow"><?php echo get_phrase('Account recovery'); ?></div>
            <h1><?php echo get_phrase('Forgot password'); ?></h1>
            <p class="gp-auth-sub"><?php echo get_phrase('Explore, learn, and grow with us. Enjoy a seamless and enriching educational journey. Lets begin!'); ?></p>

            <form action="<?php echo site_url('login/forgot_password/frontend'); ?>" method="post" id="forgot-password" class="gp-ds-form">
                <div class="gp-auth-field">
                    <label for="email"><?php echo get_phrase('Your email'); ?></label>
                    <div class="gp-auth-input-wrap">
                        <input id="email" type="email" name="email" placeholder="<?php echo get_phrase('Enter your email'); ?>" autocomplete="email">
                    </div>
                </div>

                <?php if(get_frontend_settings('recaptcha_status')): ?>
                    <div class="g-recaptcha" data-sitekey="<?php echo get_frontend_settings('recaptcha_sitekey'); ?>"></div>
                <?php endif; ?>

                <?php if(get_frontend_settings('recaptcha_status_v3')): ?>
                    <?php gp_ds_button(get_phrase('Send Request'), [
                        'type' => 'submit',
                        'extra_class' => 'g-recaptcha gp-auth-submit',
                        'attrs' => [
                            'data-sitekey' => get_frontend_settings('recaptcha_sitekey_v3'),
                            'data-callback' => 'onForgetSubmit',
                            'data-action' => 'submit',
                        ],
                    ]); ?>
                <?php else: ?>
                    <?php gp_ds_button(get_phrase('Send Request'), [
                        'type' => 'submit',
                        'extra_class' => 'gp-auth-submit',
                    ]); ?>
                <?php endif; ?>
            </form>

            <p class="gp-auth-foot">
                <a href="<?php echo site_url('login'); ?>"><?php echo get_phrase('Back to login'); ?></a>
            </p>
        </div>
    </div>
</section>

<script>
    function onForgetSubmit(token) {
        document.getElementById("forgot-password").submit();
    }
</script>
