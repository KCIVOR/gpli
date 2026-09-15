<?php include "breadcrumb.php"; ?>

<?php if(get_frontend_settings('recaptcha_status')): ?>
  <script src="https://www.google.com/recaptcha/api.js" async defer></script>
<?php endif; ?>

<section class="gp-contact-page">
    <div class="container">
        <div class="gp-contact-heading">
            <h3><?php echo get_phrase('Contact Us') ?></h3>
            <p><?php echo get_phrase('Connect with us to experience seamless communication. We value open dialogue and are eager to engage with you. Whether you have questions, ideas, or feedback, we are here to listen and respond.') ?></p>
        </div>

        <div class="gp-contact-grid">
            <div class="gp-contact-info">
                <img class="gp-contact-info-img" loading="lazy" src="<?php echo site_url('assets/frontend/default-new/'); ?>image/contact-img.png" alt="">

                <?php $contact_info = json_decode(get_frontend_settings('contact_info'), true); ?>
                <div class="gp-contact-info-grid">
                    <div class="gp-contact-info-item">
                        <div class="gp-contact-info-icon"><i class="fas fa-envelope"></i></div>
                        <div class="gp-contact-info-text">
                            <h4><?php echo get_phrase('Email'); ?></h4>
                            <?php echo nl2br($contact_info['email']); ?>
                        </div>
                    </div>
                    <div class="gp-contact-info-item">
                        <div class="gp-contact-info-icon"><i class="fa-solid fa-phone"></i></div>
                        <div class="gp-contact-info-text">
                            <h4><?php echo get_phrase('Get In Touch'); ?></h4>
                            <?php echo nl2br($contact_info['phone']); ?>
                        </div>
                    </div>
                    <div class="gp-contact-info-item">
                        <div class="gp-contact-info-icon"><i class="fa-solid fa-location-dot"></i></div>
                        <div class="gp-contact-info-text">
                            <h4><?php echo get_phrase('Our Address'); ?></h4>
                            <?php echo nl2br($contact_info['address']); ?>
                        </div>
                    </div>
                    <div class="gp-contact-info-item">
                        <div class="gp-contact-info-icon"><i class="fa-solid fa-house"></i></div>
                        <div class="gp-contact-info-text">
                            <h4><?php echo get_phrase('Office Hours'); ?></h4>
                            <?php echo nl2br($contact_info['office_hours']); ?>
                        </div>
                    </div>
                </div>
            </div>

            <div class="gp-contact-form-card">
                <form action="<?php echo site_url('home/contact_us/submit'); ?>" method="post" class="form-section" id="contactus-form">
                    <div class="gp-contact-form-row">
                        <div class="mb-3">
                            <input name="first_name" type="text" class="form-control" id="first_name" placeholder="<?php echo get_phrase('First Name') ?>">
                        </div>
                        <div class="mb-3">
                            <input name="last_name" type="text" class="form-control" id="last_name" placeholder="<?php echo get_phrase('Last Name') ?>">
                        </div>
                    </div>
                    <div class="gp-contact-form-row">
                        <div class="mb-3">
                            <input name="email" type="text" class="form-control" id="email" placeholder="<?php echo get_phrase('Email address') ?>">
                        </div>
                        <div class="mb-3">
                            <input name="phone" type="text" class="form-control" id="phone" placeholder="<?php echo get_phrase('Phone') ?>">
                        </div>
                    </div>
                    <div class="mb-3">
                        <input name="address" type="text" class="form-control" id="address" placeholder="Address">
                    </div>
                    <div class="mb-3">
                        <textarea name="message" class="form-control" aria-label="With textarea" id="message" placeholder="<?php echo get_phrase('Write your message'); ?>"></textarea>
                    </div>
                    <div class="gp-contact-agree form-check">
                        <input name="i_agree" class="form-check-input" type="checkbox" value="1" id="i_agree">
                        <label class="form-check-label" for="i_agree">
                            <?php echo get_phrase('I agree that my submitted data is being collected and stored.'); ?>
                        </label>
                    </div>
                    <?php if(get_frontend_settings('recaptcha_status')): ?>
                        <div class="g-recaptcha mb-3" data-sitekey="<?php echo get_frontend_settings('recaptcha_sitekey'); ?>"></div>
                    <?php endif; ?>
                    <?php if(get_frontend_settings('recaptcha_status_v3')): ?>
                        <?php echo gp_ds_button(get_phrase('Submit'), [
                            'type' => 'button',
                            'variant' => 'primary',
                            'extra_class' => 'g-recaptcha',
                            'attrs' => [
                                'data-sitekey' => get_frontend_settings('recaptcha_sitekey_v3'),
                                'data-callback' => 'onContactSubmit',
                                'data-action' => 'submit',
                            ],
                        ], true); ?>
                    <?php else: ?>
                        <?php echo gp_ds_button(get_phrase('Submit'), ['type' => 'submit', 'variant' => 'primary'], true); ?>
                    <?php endif; ?>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    function onContactSubmit(token) {
        document.getElementById("contactus-form").submit();
    }
</script>