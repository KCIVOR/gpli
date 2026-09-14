<?php if(get_frontend_settings('recaptcha_status')): ?>
  <script src="https://www.google.com/recaptcha/api.js" async defer></script>
<?php endif; ?>

<section class="gp-auth-shell">
    <?php include 'gp_auth_visual.php'; ?>

    <div class="gp-auth-form-wrap">
        <div class="gp-auth-form">
            <div class="eyebrow"><?php echo get_phrase('Welcome back'); ?></div>
            <h1><?php echo get_phrase('Log in to your account'); ?></h1>
            <p class="gp-auth-sub"><?php echo get_phrase('Explore, learn, and grow with us. Enjoy a seamless and enriching educational journey. Lets begin!'); ?></p>

            <form action="<?php echo site_url('login/validate_login'); ?>" method="post" id="login-form" class="gp-ds-form">
                <div class="gp-auth-field">
                    <label for="email"><?php echo get_phrase('Your email'); ?></label>
                    <div class="gp-auth-input-wrap">
                        <input id="email" type="email" name="email" placeholder="<?php echo get_phrase('Enter your email'); ?>" autocomplete="username">
                    </div>
                </div>
                <div class="gp-auth-field">
                    <label for="password"><?php echo get_phrase('Password'); ?></label>
                    <div class="gp-auth-input-wrap">
                        <input id="password" type="password" name="password" placeholder="<?php echo get_phrase('Enter your valid password'); ?>" autocomplete="current-password">
                        <button type="button" class="gp-auth-toggle-pw" onclick="if($('#password').attr('type') == 'text'){$('#password').attr('type', 'password'); $(this).text('<?php echo addslashes(get_phrase('Show')); ?>');}else{$('#password').attr('type', 'text'); $(this).text('<?php echo addslashes(get_phrase('Hide')); ?>');}"><?php echo get_phrase('Show'); ?></button>
                    </div>
                    <a class="gp-auth-forgot" href="<?php echo site_url('login/forgot_password_request'); ?>"><?php echo get_phrase('Forgot password?'); ?></a>
                </div>

                <?php if(get_frontend_settings('recaptcha_status')): ?>
                    <div class="g-recaptcha" data-sitekey="<?php echo get_frontend_settings('recaptcha_sitekey'); ?>"></div>
                <?php endif; ?>

                <?php if(get_frontend_settings('recaptcha_status_v3')): ?>
                    <?php gp_ds_button(get_phrase('Log in'), [
                        'type' => 'submit',
                        'extra_class' => 'g-recaptcha gp-auth-submit',
                        'attrs' => [
                            'data-sitekey' => get_frontend_settings('recaptcha_sitekey_v3'),
                            'data-callback' => 'onLoginSubmit',
                            'data-action' => 'submit',
                        ],
                    ]); ?>
                <?php else: ?>
                    <?php gp_ds_button(get_phrase('Log in'), [
                        'type' => 'submit',
                        'extra_class' => 'gp-auth-submit',
                    ]); ?>
                <?php endif; ?>
            </form>

            <?php if(get_settings('fb_social_login')): ?>
                <div class="gp-auth-divider"><?php echo get_phrase('Or'); ?></div>
            <?php endif; ?>

            <?php if(get_settings('fb_social_login')): ?>
                <div class="gp-auth-social">
                    <?php include "facebook_login.php"; ?>
                </div>
            <?php endif; ?>

            <?php if(get_settings('public_signup') == 'enable'): ?>
                <p class="gp-auth-foot">
                    <?php echo get_phrase('Don`t have an account?'); ?>
                    <a href="<?php echo site_url('sign_up'); ?>"><?php echo get_phrase('Sign up'); ?></a>
                </p>
            <?php endif; ?>
        </div>
    </div>
</section>

<script>
    function onLoginSubmit(token) {
        document.getElementById("login-form").submit();
    }
</script>
