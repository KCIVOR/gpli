<?php if(get_frontend_settings('recaptcha_status')): ?>
  <script src="https://www.google.com/recaptcha/api.js" async defer></script>
<?php endif; ?>

<section class="gp-auth-shell">
    <?php include 'gp_auth_visual.php'; ?>

    <div class="gp-auth-form-wrap">
        <div class="gp-auth-form">
            <div class="eyebrow"><?php echo get_phrase('Join us'); ?></div>
            <h1><?php echo get_phrase('Create your account'); ?></h1>
            <p class="gp-auth-sub"><?php echo get_phrase('Explore, learn, and grow with us. Enjoy a seamless and enriching educational journey. Lets begin!'); ?></p>

            <form action="<?php echo site_url('login/register'); ?>" method="post" enctype="multipart/form-data" id="signup-form" class="gp-ds-form">
                <div class="gp-auth-row">
                    <div class="gp-auth-field">
                        <label for="first_name"><?php echo get_phrase('First Name'); ?></label>
                        <div class="gp-auth-input-wrap">
                            <input id="first_name" type="text" name="first_name" placeholder="<?php echo get_phrase('Enter your first name'); ?>" required>
                        </div>
                    </div>
                    <div class="gp-auth-field">
                        <label for="last_name"><?php echo get_phrase('Last Name'); ?></label>
                        <div class="gp-auth-input-wrap">
                            <input id="last_name" type="text" name="last_name" placeholder="<?php echo get_phrase('Enter your last name'); ?>" required>
                        </div>
                    </div>
                </div>
                <div class="gp-auth-field">
                    <label for="email"><?php echo get_phrase('Your email'); ?></label>
                    <div class="gp-auth-input-wrap">
                        <input id="email" type="email" name="email" placeholder="<?php echo get_phrase('Enter your email'); ?>" required autocomplete="email">
                    </div>
                </div>
                <div class="gp-auth-field">
                    <label for="password"><?php echo get_phrase('Password'); ?></label>
                    <div class="gp-auth-input-wrap">
                        <input id="password" type="password" name="password" placeholder="<?php echo get_phrase('Enter your valid password'); ?>" required autocomplete="new-password">
                        <button type="button" class="gp-auth-toggle-pw" onclick="if($('#password').attr('type') == 'text'){$('#password').attr('type', 'password'); $(this).text('<?php echo addslashes(get_phrase('Show')); ?>');}else{$('#password').attr('type', 'text'); $(this).text('<?php echo addslashes(get_phrase('Hide')); ?>');}"><?php echo get_phrase('Show'); ?></button>
                    </div>
                </div>

                <?php if(get_settings('allow_instructor')): ?>
                    <div class="gp-auth-field">
                        <label class="gp-auth-check" for="instructor">
                            <input id="instructor" type="checkbox" onchange="$('#become-instructor-fields').toggle()" name="instructor" value="yes" <?php echo isset($_GET['instructor']) ? 'checked':''; ?>>
                            <?php echo get_phrase('Apply to Become an instructor'); ?>
                        </label>
                    </div>

                    <div id="become-instructor-fields" class="<?php echo isset($_GET['instructor']) ?  '':'d-hidden'; ?>">
                        <div class="gp-auth-field">
                            <label for="phone"><?php echo get_phrase('Phone'); ?></label>
                            <div class="gp-auth-input-wrap">
                                <input id="phone" type="phone" name="phone" placeholder="<?php echo get_phrase('Enter your phone number'); ?>">
                            </div>
                        </div>
                        <div class="gp-auth-field">
                            <label for="document"><?php echo get_phrase('Document'); ?> <small>(doc, docs, pdf, txt, png, jpg, jpeg)</small></label>
                            <div class="gp-auth-input-wrap">
                                <input id="document" type="file" name="document">
                                <small class="gp-auth-hint"><?php echo get_phrase('Provide some documents about your qualifications'); ?></small>
                            </div>
                        </div>
                        <div class="gp-auth-field">
                            <label for="instructor-message"><?php echo get_phrase('message'); ?></label>
                            <div class="gp-auth-input-wrap">
                                <textarea id="instructor-message" name="message" rows="4"></textarea>
                            </div>
                        </div>
                    </div>
                <?php endif; ?>

                <?php if(get_frontend_settings('recaptcha_status')): ?>
                    <div class="g-recaptcha" data-sitekey="<?php echo get_frontend_settings('recaptcha_sitekey'); ?>"></div>
                <?php endif; ?>

                <?php if(get_frontend_settings('recaptcha_status_v3')): ?>
                    <?php gp_ds_button(get_phrase('Sign Up'), [
                        'type' => 'submit',
                        'extra_class' => 'g-recaptcha gp-auth-submit',
                        'attrs' => [
                            'data-sitekey' => get_frontend_settings('recaptcha_sitekey_v3'),
                            'data-callback' => 'onSignupSubmit',
                            'data-action' => 'submit',
                        ],
                    ]); ?>
                <?php else: ?>
                    <?php gp_ds_button(get_phrase('Sign Up'), [
                        'type' => 'submit',
                        'extra_class' => 'gp-auth-submit',
                    ]); ?>
                <?php endif; ?>
            </form>

            <?php if(get_settings('fb_social_login')): ?>
                <div class="gp-auth-divider"><?php echo get_phrase('Or'); ?></div>
                <div class="gp-auth-social">
                    <?php include "facebook_login.php"; ?>
                </div>
            <?php endif; ?>

            <p class="gp-auth-foot">
                <?php echo get_phrase('Already you have an account?'); ?>
                <a href="<?php echo site_url('login'); ?>"><?php echo get_phrase('Log In'); ?></a>
            </p>
        </div>
    </div>
</section>

<script>
    function onSignupSubmit(token) {
        document.getElementById("signup-form").submit();
    }
</script>
