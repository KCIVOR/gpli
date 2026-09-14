<?php $user_details = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array(); ?>
<?php $social_links = json_decode($user_details['social_links'], true); ?>
<div class="gp-student-page">
<?php include "breadcrumb.php"; ?>

<!-------- Wish List body section start ------>
<section class="wish-list-body gp-student-shell">
    <div class="container">
        <?php gp_ds_page_title(get_phrase('Account')); ?>
        <div class="row">
            <div class="col-lg-3 col-md-4 col-sm-12">
                <?php include "profile_menus.php"; ?>
            </div>
            <div class="col-lg-9 col-md-8 col-sm-12">
                <?php
                ob_start();
                ?>
                <div class="gp-student-profile-head">
                    <div class="gp-student-profile-identity">
                        <a href="#"><img loading="lazy" src="<?php echo $this->user_model->get_user_image_url($user_details['id']); ?>" alt=""></a>
                        <div class="gp-student-profile-copy">
                            <a href="#"><h5><?php echo get_phrase('Profile Photo') ?></h5></a>
                            <p><?php echo get_phrase('Update your profile photo and personal details'); ?></p>
                        </div>
                    </div>
                    <?php if(get_settings('account_disable') == 1): ?>
                        <div class="gp-student-profile-actions">
                            <?php
                            gp_ds_button(site_phrase('Account disable'), [
                                'variant'     => 'outline',
                                'type'        => 'button',
                                'extra_class' => 'gp-student-cta',
                                'attrs'       => [
                                    'onclick' => "showAjaxModal('" . site_url('home/account_disable') . "', '" . get_phrase('Account disable') . "')",
                                ],
                            ]);
                            ?>
                        </div>
                    <?php endif; ?>
                </div>
                <?php
                gp_ds_card([
                    'extra_class' => 'gp-student-profile-card mb-3',
                    'body'        => ob_get_clean(),
                ]);

                ob_start();
                ?>
                <form action="<?php echo site_url('home/update_profile/update_credentials'); ?>" method="post">
                    <div class="row">
                        <div class="col-12 mb-3">
                            <label class="text-dark fw-600" for="email"><?php echo site_phrase('email'); ?></label>
                            <div class="input-group">
                                <input type="email" class="form-control bg-white-2" name = "email" id="email" placeholder="<?php echo site_phrase('email'); ?>" value="<?php echo $user_details['email']; ?>" disabled>
                            </div>
                        </div>

                        <hr class="my-4 bg-secondary">

                        <div class="col-12 mb-3">
                            <label class="text-dark fw-600" for="current_password"><?php echo site_phrase('current_password'); ?></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                                <input type="password" class="form-control bg-white-2 text-14px" id="current_password" name = "current_password" placeholder="<?php echo site_phrase('enter_current_password'); ?>">
                            </div>
                        </div>
                        <div class="col-12 mb-3">
                            <label class="text-dark fw-600" for="new_password"><?php echo site_phrase('new_password'); ?></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control bg-white-2 text-14px" id="new_password" name = "new_password" placeholder="<?php echo site_phrase('enter_new_password'); ?>">
                            </div>
                        </div>
                        <div class="col-12 mb-3">
                            <label class="text-dark fw-600" for="confirm_password"><?php echo site_phrase('confirm_password'); ?></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control bg-white-2 text-14px" id="confirm_password" name = "confirm_password" placeholder="<?php echo site_phrase('re-type_your_password'); ?>">
                            </div>
                        </div>

                        <div class="col-12 pt-4">
                            <?php
                            gp_ds_button(site_phrase('save_changes'), [
                                'variant'     => 'primary',
                                'type'        => 'submit',
                                'extra_class' => 'gp-student-cta',
                            ]);
                            ?>
                        </div>
                    </div>
                </form>
                <?php
                gp_ds_card([
                    'title'       => site_phrase('account_information'),
                    'extra_class' => 'gp-student-profile-card',
                    'body'        => ob_get_clean(),
                ]);
                ?>
            </div>
        </div>
    </div>
</section>
</div>
