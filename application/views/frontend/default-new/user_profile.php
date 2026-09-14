<?php $user_details = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array(); ?>
<?php $social_links = json_decode($user_details['social_links'], true); ?>
<div class="gp-student-page">
<?php include "breadcrumb.php"; ?>

<!-------- Wish List body section start ------>
<section class="wish-list-body gp-student-shell">
    <div class="container">
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
                            <h5><?php echo get_phrase('Profile Photo') ?></h5>
                            <p><?php echo get_phrase('Update your profile photo and personal details'); ?></p>
                        </div>
                    </div>
                    <div class="gp-student-profile-actions">
                        <form action="<?php echo site_url('home/update_profile/update_photo/true') ?>" method="post" enctype="multipart/form-data" class="d-flex align-items-center flex-wrap gap-2">
                            <input type="file" id="profile-photo-input" name="user_image" onchange="
                                $('.photo-upload-btn').toggleClass('d-hidden');
                                $('[for=profile-photo-input]').toggleClass('d-hidden');
                            " class="d-none">
                            <label for="profile-photo-input" class="btn btn-outline gp-student-cta gp-student-upload-btn"><i class="fas fa-upload"></i> <?php echo get_phrase('Upload photo') ?></label>
                            <div class="photo-upload-btn d-hidden">
                                <?php
                                gp_ds_button(get_phrase('Save'), [
                                    'variant'     => 'primary',
                                    'type'        => 'submit',
                                    'extra_class' => 'gp-student-cta',
                                ]);
                                gp_ds_button(get_phrase('Cancel'), [
                                    'variant'     => 'outline',
                                    'type'        => 'reset',
                                    'extra_class' => 'gp-student-cta',
                                    'attrs'       => [
                                        'onclick' => "$('.photo-upload-btn').toggleClass('d-hidden'); $('[for=profile-photo-input]').toggleClass('d-hidden');",
                                    ],
                                ]);
                                ?>
                            </div>
                        </form>
                    </div>
                </div>
                <?php
                gp_ds_card([
                    'title'       => '',
                    'extra_class' => 'gp-student-profile-card gp-student-profile-photo mb-3',
                    'body'        => ob_get_clean(),
                ]);

                ob_start();
                ?>
                <form action="<?php echo site_url('home/update_profile/update_basics'); ?>" method="post" class="gp-student-profile-form">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="text-dark fw-600" for="FristName"><?php echo site_phrase('first_name'); ?></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control bg-white-2 text-14px" name="first_name" id="FristName" placeholder="<?php echo site_phrase('first_name'); ?>" value="<?php echo $user_details['first_name']; ?>">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="text-dark fw-600" for="FristName"><?php echo site_phrase('last_name'); ?></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control bg-white-2 text-14px" name="last_name" placeholder="<?php echo site_phrase('last_name'); ?>" value="<?php echo $user_details['last_name']; ?>">
                            </div>
                        </div>

                        <div class="col-12 mt-3">
                            <?php if ($user_details['is_instructor'] > 0) : ?>
                                <div class="form-group mb-3">
                                    <label class="text-dark fw-600" for="Biography"><?php echo site_phrase('title'); ?></label>
                                    <textarea class="form-control bg-white-2 text-14px" name="title" placeholder="<?php echo site_phrase('short_title_about_yourself'); ?>"><?php echo $user_details['title']; ?></textarea>
                                </div>

                                <div class="form-group mb-3">
                                    <label class="text-dark fw-600" for="skills"><?php echo get_phrase('your_skills'); ?></label>
                                    <input type="text" class=" tagify" id="skills" name="skills" data-role="tagsinput" style="width: 100%;" value="<?php echo $user_details['skills'];  ?>" />
                                    <small class="text-muted"><?php echo get_phrase('write_your_skill_and_click_the_enter_button'); ?></small>
                                </div>

                            <?php endif; ?>

                            <div class="form-group">
                                <label class="text-dark fw-600" for="Biography"><?php echo site_phrase('biography'); ?></label>
                                <textarea class="form-control bg-white-2 text-14px text_editor" name="biography" id="Biography"><?php echo $user_details['biography']; ?></textarea>
                            </div>

                            <div class="gp-student-profile-social">
                            <label class="text-dark fw-600"><?php echo site_phrase('add_your_twitter_link'); ?></label>
                            <div class="input-group mb-3">
                                <span class="input-group-text"><i class="fab fa-twitter"></i></span>
                                <input type="text" class="form-control bg-white-2 text-14px" maxlength="60" name="twitter_link" placeholder="<?php echo site_phrase('twitter_link'); ?>" value="<?php echo $social_links['twitter']; ?>">
                            </div>

                            <label class="text-dark fw-600"><?php echo site_phrase('add_your_facebook_link'); ?></label>
                            <div class="input-group mb-3">
                                <span class="input-group-text"><i class="fab fa-facebook"></i></span>
                                <input type="text" class="form-control bg-white-2 text-14px" maxlength="60" name="facebook_link" placeholder="<?php echo site_phrase('facebook_link'); ?>" value="<?php echo $social_links['facebook']; ?>">
                            </div>

                            <label class="text-dark fw-600"><?php echo site_phrase('add_your_linkedin_link'); ?></label>
                            <div class="input-group mb-3">
                                <span class="input-group-text"><i class="fab fa-linkedin"></i></span>
                                <input type="text" class="form-control bg-white-2 text-14px" maxlength="60" name="linkedin_link" placeholder="<?php echo site_phrase('linkedin_link'); ?>" value="<?php echo $social_links['linkedin']; ?>">
                            </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <?php
                            gp_ds_button(site_phrase('save'), [
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
                    'title'       => site_phrase('Profile Info'),
                    'extra_class' => 'gp-student-profile-card',
                    'body'        => ob_get_clean(),
                ]);
                ?>
            </div>
        </div>
    </div>
</section>
</div>
