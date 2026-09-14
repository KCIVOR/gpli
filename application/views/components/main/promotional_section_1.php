<?php if (! (get_frontend_settings('promotional_section') == 1)) return; ?>
<?php $gp_bg = gp_landing_bg_attrs('dual'); ?>
<section class="gp-landing gp-landing-dual-wrap<?php echo $gp_bg['class']; ?>"<?php echo $gp_bg['style']; ?>>
    <div class="container">
        <div class="gp-landing-dual">
            <div class="gp-landing-dual-card gp-landing-dual-learn">
                <h3><?php echo site_phrase('join_now_to_start_learning'); ?></h3>
                <p><?php echo site_phrase('Learn from our quality instructors!'); ?></p>
                <?php if (get_settings('public_signup') == 'enable'): ?>
                    <?php echo gp_ds_button(site_phrase('get_started'), ['variant' => 'primary', 'href' => site_url('sign_up'), 'extra_class' => 'gp-landing-btn-on-dark'], true); ?>
                <?php endif; ?>
            </div>
            <?php if (get_settings('allow_instructor') == 1): ?>
                <div class="gp-landing-dual-card gp-landing-dual-teach">
                    <h3><?php echo site_phrase('become_a_new_instructor'); ?></h3>
                    <p><?php echo site_phrase('Teach_thousands_of_students_and_earn_money!'); ?></p>
                    <?php if (get_settings('public_signup') == 'enable'): ?>
                        <?php if ($this->session->userdata('user_id')): ?>
                            <?php echo gp_ds_button(site_phrase('join_now'), ['variant' => 'outline', 'href' => site_url('user/become_an_instructor')], true); ?>
                        <?php else: ?>
                            <?php echo gp_ds_button(site_phrase('join_now'), ['variant' => 'outline', 'href' => site_url('sign_up?instructor=yes')], true); ?>
                        <?php endif; ?>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>
