<?php
    $facebook = get_frontend_settings('facebook');
    $twitter  = get_frontend_settings('twitter');
    $linkedin = get_frontend_settings('linkedin');
    if (! isset($top_10_categories)) {
        $top_10_categories = $this->crud_model->get_top_categories(6, 'sub_category_id');
    }
    $custom_page_menus = $this->crud_model->get_custom_pages('', 'footer');
?>
<footer class="lms2-footer-section gp-site-footer">
    <div class="container">
        <div class="gp-footer-grid">
            <div class="gp-footer-brand">
                <a href="<?php echo base_url('home'); ?>">
                    <img loading="lazy" class="gp-logo-on-light" src="<?php echo base_url('uploads/system/' . get_frontend_settings('dark_logo')); ?>" alt="">
                    <img loading="lazy" class="gp-logo-on-dark" src="<?php echo base_url('uploads/system/' . get_frontend_settings('light_logo')); ?>" alt="">
                </a>
                <p><?php echo get_settings('website_description'); ?></p>
                <?php if (get_settings('phone')): ?>
                    <span><?php echo get_settings('phone'); ?></span>
                <?php endif; ?>
                <?php if (get_settings('system_email')): ?>
                    <span><a href="mailto:<?php echo get_settings('system_email'); ?>"><?php echo get_settings('system_email'); ?></a></span>
                <?php endif; ?>
                <div class="gp-footer-socials">
                    <?php if ($facebook != ''): ?>
                        <a href="<?php echo $facebook; ?>" target="_blank" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                    <?php endif; ?>
                    <?php if ($twitter != ''): ?>
                        <a href="<?php echo $twitter; ?>" target="_blank" aria-label="X"><i class="fa-brands fa-x-twitter"></i></a>
                    <?php endif; ?>
                    <?php if ($linkedin != ''): ?>
                        <a href="<?php echo $linkedin; ?>" target="_blank" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
                    <?php endif; ?>
                </div>
            </div>

            <div class="gp-footer-col">
                <h4><?php echo get_phrase('top_categories'); ?></h4>
                <ul>
                    <?php foreach ($top_10_categories as $key => $top_10_category):
                        if ($key == 6) {
                            break;
                        }
                        $category_details = $this->crud_model->get_category_details_by_id($top_10_category['sub_category_id'])->row_array();
                    ?>
                        <li><a href="<?php echo site_url('home/courses?category=' . $category_details['slug']); ?>"><?php echo $category_details['name']; ?></a></li>
                    <?php endforeach; ?>
                </ul>
            </div>

            <div class="gp-footer-col">
                <h4><?php echo get_phrase('useful_links'); ?></h4>
                <ul>
                    <?php if (get_settings('allow_instructor') == 1): ?>
                        <li><a href="<?php echo site_url('home/become_an_instructor'); ?>"><?php echo site_phrase('Become an instructor'); ?></a></li>
                    <?php endif; ?>
                    <li><a href="<?php echo site_url('blog'); ?>"><?php echo site_phrase('blog'); ?></a></li>
                    <li><a href="<?php echo site_url('home/courses'); ?>"><?php echo site_phrase('all_courses'); ?></a></li>
                    <li><a href="<?php echo site_url('home/posts'); ?>"><?php echo site_phrase('community'); ?></a></li>
                    <?php if (get_settings('public_signup') == 'enable'): ?>
                        <li><a href="<?php echo site_url('sign_up'); ?>"><?php echo site_phrase('sign_up'); ?></a></li>
                    <?php endif; ?>
                    <?php foreach ($custom_page_menus->result_array() as $custom_page_menu): ?>
                        <li><a href="<?php echo site_url('page/' . $custom_page_menu['page_url']); ?>"><?php echo $custom_page_menu['button_title']; ?></a></li>
                    <?php endforeach; ?>
                </ul>
            </div>

            <div class="gp-footer-col gp-footer-contact">
                <h4><?php echo get_phrase('Contact_us'); ?></h4>
                <ul>
                    <li><a href="<?php echo site_url('home/contact_us'); ?>"><?php echo site_phrase('Send message'); ?></a></li>
                    <li><a href="<?php echo site_url('home/about_us'); ?>"><?php echo site_phrase('about_us'); ?></a></li>
                    <li><a href="<?php echo site_url('home/faq'); ?>"><?php echo site_phrase('FAQ'); ?></a></li>
                </ul>
            </div>

            <div class="gp-footer-col gp-footer-subscribe">
                <h4><?php echo get_phrase('SUBSCRIBE'); ?></h4>
                <form class="ajaxForm resetable gp-foot-subscribe" action="<?php echo site_url('home/subscribe_to_our_newsletter'); ?>" method="post" id="newsletter-form">
                    <input type="email" name="email" class="form-control ft2-newsLetter-input" id="subscribe_email" placeholder="<?php echo get_phrase('Email address'); ?>">
                    <?php if (get_frontend_settings('recaptcha_status_v3')): ?>
                        <button data-sitekey="<?php echo get_frontend_settings('recaptcha_sitekey_v3'); ?>" data-callback='onSubmit' data-action='submit' class="ft2-newsLetter-btn g-recaptcha border-0 btn btn-primary" type="button"><?php echo get_phrase('Join'); ?></button>
                    <?php else: ?>
                        <button type="submit" class="ft2-newsLetter-btn border-0 btn btn-primary"><?php echo get_phrase('Join'); ?></button>
                    <?php endif; ?>
                </form>
                <p class="gp-footer-note"><?php echo get_phrase('Subscribe to our newsletter to receive the latest news and promotions.'); ?></p>
            </div>
        </div>

        <div class="gp-footer-bottom">
            <p class="ft2-copyright-info mb-0">
                <?php echo get_phrase('copyright'); ?> ©<?php echo date('Y'); ?>
                <?php if (get_settings('footer_text') != ''): ?><a href="<?php echo get_settings('footer_link'); ?>"><?php echo get_settings('footer_text'); ?></a><?php endif; ?>
                <?php echo get_phrase('all_rights_reserved'); ?>.
            </p>
            <ul class="gp-footer-legal">
                <li><a href="<?php echo site_url('home/privacy_policy'); ?>"><?php echo site_phrase('privacy_policy'); ?></a></li>
                <li><a href="<?php echo site_url('home/terms_and_condition'); ?>"><?php echo site_phrase('terms_and_condition'); ?></a></li>
                <li><a href="<?php echo site_url('home/refund_policy'); ?>"><?php echo site_phrase('refund_policy'); ?></a></li>
            </ul>
        </div>
    </div>
</footer>
