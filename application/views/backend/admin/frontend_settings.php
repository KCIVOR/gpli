<?php $homepage_banner = themeConfiguration(get_frontend_settings('theme'), 'homepage'); ?>
<?php gp_ds_page_title(get_phrase('website_settings')); ?>

<div class="gp-settings-page">
<div class="row justify-content-center">
    <div class="col-xl-12">
        <?php
        ob_start();
        ?>

                <div class="scrollable-tab-section" id="basicwizard">

                    <button type="button" class="scrollable-tab-btn-left"><i class="mdi mdi-arrow-left"></i></button>

                    <div class="scrollable-tab" style="height: 50px; overflow-y: hidden;">

                        <ul class="nav nav-pills bg-nav-pills nav-justified mb-3" style="width: fit-content;">
                            <li class="nav-item">
                                <a href="#frontendsettings" data-toggle="tab" aria-expanded="true" class="nav-link rounded-0 active py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo site_phrase('Frontend Settings'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#websitefaqs" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Website FAQS'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#contact_information" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Contact Information'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#recaptcha" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Recaptcha'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#logo_and_images" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Logo & Images'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#custom_codes" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Custom Codes'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#water_mark" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Video Watermark'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#review" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Review'); ?></span>
                                </a>
                            </li>
                        </ul>

                    </div>

                    <button type="button" class="scrollable-tab-btn-right"><i class="mdi mdi-arrow-right"></i></button>
                </div>

                <div class="tab-content">
                    <div class="tab-pane show active" id="frontendsettings">
                        <h4 class="mb-3 header-title"><?php echo get_phrase('frontend_website_settings');?></h4>
                        <form class="required-form" action="<?php echo site_url('admin/frontend_settings/frontend_update'); ?>" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="banner_title"><?php echo get_phrase('banner_title'); ?><span class="required">*</span></label>
                                <input type="text" name = "banner_title" id = "banner_title" class="form-control" value="<?php echo get_frontend_settings('banner_title');  ?>" required>
                            </div>
                            <div class="form-group">
                                <label for="banner_sub_title"><?php echo get_phrase('banner_sub_title'); ?><span class="required">*</span></label>
                                <input type="text" name = "banner_sub_title" id = "banner_sub_title" class="form-control" value="<?php echo get_frontend_settings('banner_sub_title');  ?>" required>
                            </div>

                            <div class="form-group">
                                <label for="cookie_status"><?php echo get_phrase('cookie_status'); ?><span class="required">*</span></label><br>
                                <input type="radio" value="active" name="cookie_status" <?php if(get_frontend_settings('cookie_status') == 'active') echo 'checked'; ?>> <?php echo get_phrase('active'); ?>
                                &nbsp;&nbsp;
                                <input type="radio" value="inactive" name="cookie_status" <?php if(get_frontend_settings('cookie_status') == 'inactive') echo 'checked'; ?>> <?php echo get_phrase('inactive'); ?>
                            </div>
                            <div class="form-group">
                                <label for="cookie_note"><?php echo get_phrase('cookie_note'); ?></label>
                                <textarea name="cookie_note" id = "cookie_note" class="form-control" rows="5"><?php echo get_frontend_settings('cookie_note'); ?></textarea>
                            </div>

                            <div class="form-group">
                                <label for="facebook"><?php echo get_phrase('facebook'); ?></label>
                                <input type="text" name = "facebook" id = "facebook" class="form-control" value="<?php echo get_frontend_settings('facebook');  ?>">
                            </div>

                            <div class="form-group">
                                <label for="twitter"><?php echo get_phrase('twitter'); ?></label>
                                <input type="text" name = "twitter" id = "twitter" class="form-control" value="<?php echo get_frontend_settings('twitter');  ?>">
                            </div>

                            <div class="form-group">
                                <label for="linkedin"><?php echo get_phrase('linkedin'); ?></label>
                                <input type="text" name = "linkedin" id = "linkedin" class="form-control" value="<?php echo get_frontend_settings('linkedin');  ?>">
                            </div>

                            <div class="form-group">
                                <label for="cookie_policy"><?php echo get_phrase('cookie_policy'); ?></label>
                                <textarea name="cookie_policy" id = "cookie_policy" class="form-control" rows="5"><?php echo get_frontend_settings('cookie_policy'); ?></textarea>
                            </div>
                            <div class="form-group">
                                <label for="about_us"><?php echo get_phrase('about_us'); ?></label>
                                <textarea name="about_us" id = "about_us" class="form-control" rows="5"><?php echo get_frontend_settings('about_us'); ?></textarea>
                            </div>
                            <div class="form-group">
                                <label for="terms_and_condition"><?php echo get_phrase('terms_and_condition'); ?></label>
                                <textarea name="terms_and_condition" id ="terms_and_condition" class="form-control" rows="5"><?php echo get_frontend_settings('terms_and_condition'); ?></textarea>
                            </div>
                            <div class="form-group">
                                <label for="privacy_policy"><?php echo get_phrase('privacy_policy'); ?></label>
                                <textarea name="privacy_policy" id = "privacy_policy" class="form-control" rows="5"><?php echo get_frontend_settings('privacy_policy'); ?></textarea>
                            </div>

                            <div class="form-group">
                                <label for="refund_policy"><?php echo get_phrase('refund_policy'); ?></label>
                                <textarea name="refund_policy" id = "refund_policy" class="form-control" rows="5"><?php echo get_frontend_settings('refund_policy'); ?></textarea>
                            </div>

                            <div class="row justify-content-center">
                                <div class="col-md-4">
                                    <?php echo gp_ds_button(get_phrase('update_settings'), [
                                        'variant' => 'primary',
                                        'type' => 'button',
                                        'attrs' => ['onclick' => 'checkRequiredFields()'],
                                    ], true); ?>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="tab-pane" id="websitefaqs">
                        <h4 class="mb-3 header-title"><?php echo get_phrase('Website FAQS');?></h4>
                        <form action="<?php echo site_url('admin/frontend_settings/website_faq'); ?>" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-8">
                                    <div id = "faq_area">
                                        <?php $faqs = count(json_decode(get_frontend_settings('website_faqs'), true)) > 0 ? json_decode(get_frontend_settings('website_faqs'), true):[['question' => '', 'answer' => '']]; ?>
                                        <?php foreach($faqs as $key => $faq): ?>
                                            <div class="d-flex mt-2">
                                                <div class="flex-grow-1 px-3 mb-3">
                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Question'); ?></label>
                                                        <input type="text" class="form-control" name="questions[]" id="questions" placeholder="<?php echo get_phrase('faq_question'); ?>" value="<?php echo $faq['question']; ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Answer'); ?></label>
                                                        <textarea name="answers[]" class="form-control" placeholder="<?php echo get_phrase('answer'); ?>"><?php echo $faq['answer']; ?></textarea>
                                                    </div>
                                                </div>

                                                <?php if($key == 0): ?>
                                                    <div class="" style="padding-top: 32px;">
                                                        <?php echo gp_ds_button('+', [
                                                            'variant' => 'outline',
                                                            'type' => 'button',
                                                            'extra_class' => 'gp-settings-faq-btn',
                                                            'attrs' => ['onclick' => 'appendFaq()', 'name' => 'button'],
                                                        ], true); ?>
                                                    </div>
                                                <?php else: ?>
                                                    <div class="" style="padding-top: 32px;">
                                                        <?php echo gp_ds_button('-', [
                                                            'variant' => 'outline',
                                                            'type' => 'button',
                                                            'extra_class' => 'gp-settings-faq-btn',
                                                            'attrs' => ['onclick' => 'removeFaq(this)', 'name' => 'button'],
                                                        ], true); ?>
                                                    </div>
                                                <?php endif; ?>
                                            </div>
                                        <?php endforeach; ?>

                                        <div id = "blank_faq_field">
                                            <div class="d-flex pt-2 border-top">
                                                <div class="flex-grow-1 px-3">
                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Question'); ?></label>
                                                        <input type="text" class="form-control" name="questions[]" id="questions" placeholder="<?php echo get_phrase('faq_question'); ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Answer'); ?></label>
                                                        <textarea name="answers[]" class="form-control mt-2" placeholder="<?php echo get_phrase('answer'); ?>"></textarea>
                                                    </div>

                                                </div>
                                                <div class="" style="padding-top: 32px;">
                                                    <?php echo gp_ds_button('-', [
                                                        'variant' => 'outline',
                                                        'type' => 'button',
                                                        'extra_class' => 'gp-settings-faq-btn',
                                                        'attrs' => ['onclick' => 'removeFaq(this)', 'name' => 'button'],
                                                    ], true); ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group pt-0 mt-0">
                                        <?php echo gp_ds_button(get_phrase('Save changes'), [
                                            'variant' => 'primary',
                                            'type' => 'submit',
                                            'extra_class' => 'ml-3',
                                        ], true); ?>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="tab-pane" id="contact_information">
                        <h4 class="mb-3 header-title"><?php echo get_phrase('Contact Information');?></h4>
                        <?php
                            $contact_info = get_frontend_settings('contact_info');
                            if($contact_info){
                                $contact_info = json_decode($contact_info, true);
                            }else{
                                $contact_info = ['email' => '', 'phone' => '', 'address' => '', 'office_hours' => ''];
                            }
                        ?>
                        <form action="<?php echo site_url('admin/frontend_settings/contact_info'); ?>" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-7">
                                    <div class="mb-3">
                                        <label><?php echo get_phrase('Contact Email') ?></label>
                                        <textarea name="email" rows="2" class="form-control"><?php echo $contact_info['email']; ?></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label><?php echo get_phrase('Phone Number') ?></label>
                                        <textarea name="phone" rows="2" class="form-control"><?php echo $contact_info['phone']; ?></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label><?php echo get_phrase('Address') ?></label>
                                        <textarea name="address" rows="2" class="form-control"><?php echo $contact_info['address']; ?></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label><?php echo get_phrase('Office Hours') ?></label>
                                        <textarea name="office_hours" rows="2" class="form-control"><?php echo $contact_info['office_hours']; ?></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <?php echo gp_ds_button(get_phrase('Submit'), [
                                            'variant' => 'primary',
                                            'type' => 'submit',
                                        ], true); ?>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>


                    <div class="tab-pane" id="recaptcha">
                        <h4 class="mb-3 header-title"><?php echo get_phrase('recaptcha_settings');?></h4>

                        <form action="<?php echo site_url('admin/frontend_settings/recaptcha_update'); ?>" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label><?php echo get_phrase('recaptcha_status'); ?><span class="required">*</span></label><br>
                                <input type="radio" id="recaptcha_off" value="off" name="recaptcha_status" <?php if(get_frontend_settings('recaptcha_status') == 0 && get_frontend_settings('recaptcha_status_v3') == 0) echo 'checked'; ?>> <label for="recaptcha_off"><?php echo get_phrase('off'); ?></label>
                                &nbsp;&nbsp;
                                <input type="radio" id="recaptcha_on_v2" value="v2" name="recaptcha_status" <?php if(get_frontend_settings('recaptcha_status') == 1) echo 'checked'; ?>> <label for="recaptcha_on_v2"><?php echo get_phrase('on_(v2)'); ?></label>
                                &nbsp;&nbsp;
                                <input type="radio" id="recaptcha_on_v3" value="v3" name="recaptcha_status" <?php if(get_frontend_settings('recaptcha_status_v3') == 1) echo 'checked'; ?>> <label for="recaptcha_on_v3"><?php echo get_phrase('on_(v3)'); ?></label>
                            </div>

                            <div class="form-group">
                                <label for="recaptcha_sitekey"><?php echo get_phrase('recaptcha_sitekey'); ?> (v2)<span class="required">*</span></label>
                                <input type="text" name = "recaptcha_sitekey" id = "recaptcha_sitekey" class="form-control" value="<?php echo get_frontend_settings('recaptcha_sitekey');  ?>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="recaptcha_secretkey"><?php echo get_phrase('recaptcha_secretkey'); ?> (v2)<span class="required">*</span></label>
                                <input type="text" name = "recaptcha_secretkey" id = "recaptcha_secretkey" class="form-control" value="<?php echo get_frontend_settings('recaptcha_secretkey');  ?>" required>
                            </div>

                            <div class="form-group">
                                <label for="recaptcha_sitekey_v3"><?php echo get_phrase('recaptcha_sitekey'); ?> (v3)<span class="required">*</span></label>
                                <input type="text" name = "recaptcha_sitekey_v3" id = "recaptcha_sitekey_v3" class="form-control" value="<?php echo get_frontend_settings('recaptcha_sitekey_v3');  ?>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="recaptcha_secretkey_v3"><?php echo get_phrase('recaptcha_secretkey'); ?> (v3)<span class="required">*</span></label>
                                <input type="text" name = "recaptcha_secretkey_v3" id = "recaptcha_secretkey_v3" class="form-control" value="<?php echo get_frontend_settings('recaptcha_secretkey_v3');  ?>" required>
                            </div>

                            <div class="row justify-content-center">
                                <div class="col-md-4">
                                    <?php echo gp_ds_button(get_phrase('update_recaptcha_settings'), [
                                        'variant' => 'primary',
                                        'type' => 'submit',
                                    ], true); ?>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane" id="logo_and_images">
                        <div class="row justify-content-center">
                            <?php if (count($homepage_banner) > 0):
                              if ($homepage_banner['homepage_banner_image']):?>
                              <div class="col-xl-4 col-lg-6">
                                  <?php
                                  ob_start();
                                  ?>
                                              <div class="row justify-content-center">
                                                  <form action="<?php echo site_url('admin/frontend_settings/banner_image_update'); ?>" method="post" enctype="multipart/form-data" style="text-align: center;">
                                                      <div class="form-group mb-2">
                                                          <div class="wrapper-image-preview">
                                                              <div class="box" style="width: 250px;">
                                                                  <div class="js--image-preview" style="background-image: url(<?php echo base_url('uploads/system/'.get_current_banner('banner_image'));?>);"></div>
                                                                  <div class="upload-options">
                                                                      <label for="banner_image" class="btn"> <i class="mdi mdi-camera"></i> <?php echo get_phrase('upload_banner_image'); ?> <br> <small>(<?php echo $homepage_banner['homepage_banner_image_size']; ?>)</small> </label>
                                                                      <input id="banner_image" style="visibility:hidden;" type="file" class="image-upload" name="banner_image" accept="image/*">
                                                                  </div>
                                                              </div>
                                                          </div>
                                                      </div>
                                                      <?php echo gp_ds_button(get_phrase('upload_banner_image'), [
                                                          'variant' => 'primary',
                                                          'type' => 'submit',
                                                      ], true); ?>
                                                  </form>
                                              </div>
                                  <?php
                                  gp_ds_card([
                                      'title' => get_phrase('update_banner_image'),
                                      'body' => ob_get_clean(),
                                      'extra_class' => 'gp-dash-panel',
                                  ]);
                                  ?>
                              </div>
                              <?php endif; ?>
                            <?php endif; ?>

                            <div class="col-xl-4 col-lg-6">
                                <?php
                                ob_start();
                                ?>
                                            <div class="row justify-content-center">
                                                <form action="<?php echo site_url('admin/frontend_settings/light_logo'); ?>" method="post" enctype="multipart/form-data" style="text-align: center;">
                                                    <div class="form-group mb-2">
                                                        <div class="wrapper-image-preview">
                                                            <div class="box" style="width: 250px;">
                                                                <div class="js--image-preview" style="background-image: url(<?php echo base_url('uploads/system/'.get_frontend_settings('light_logo')); ?>);"></div>
                                                                <div class="upload-options">
                                                                    <label for="light_logo" class="btn"> <i class="mdi mdi-camera"></i> <?php echo get_phrase('upload_light_logo'); ?> <br> <small>(330 X 70)</small> </label>
                                                                    <input id="light_logo" style="visibility:hidden;" type="file" class="image-upload" name="light_logo" accept="image/*">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <?php echo gp_ds_button(get_phrase('upload_light_logo'), [
                                                        'variant' => 'primary',
                                                        'type' => 'submit',
                                                    ], true); ?>
                                                </form>
                                            </div>
                                <?php
                                gp_ds_card([
                                    'title' => get_phrase('update_light_logo'),
                                    'body' => ob_get_clean(),
                                    'extra_class' => 'gp-dash-panel',
                                ]);
                                ?>
                            </div>

                            <div class="col-xl-4 col-lg-6">
                                <?php
                                ob_start();
                                ?>
                                            <div class="row justify-content-center">
                                                <form action="<?php echo site_url('admin/frontend_settings/dark_logo'); ?>" method="post" enctype="multipart/form-data" style="text-align: center;">
                                                    <div class="form-group mb-2">
                                                        <div class="wrapper-image-preview">
                                                            <div class="box" style="width: 250px;">
                                                                <div class="js--image-preview" style="background-image: url(<?php echo base_url('uploads/system/'.get_frontend_settings('dark_logo')); ?>);"></div>
                                                                <div class="upload-options">
                                                                    <label for="dark_logo" class="btn"> <i class="mdi mdi-camera"></i> <?php echo get_phrase('upload_dark_logo'); ?> <br> <small>(330 X 70)</small> </label>
                                                                    <input id="dark_logo" style="visibility:hidden;" type="file" class="image-upload" name="dark_logo" accept="image/*">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <?php echo gp_ds_button(get_phrase('upload_dark_logo'), [
                                                        'variant' => 'primary',
                                                        'type' => 'submit',
                                                    ], true); ?>
                                                </form>
                                            </div>
                                <?php
                                gp_ds_card([
                                    'title' => get_phrase('update_dark_logo'),
                                    'body' => ob_get_clean(),
                                    'extra_class' => 'gp-dash-panel',
                                ]);
                                ?>
                            </div>

                            <div class="col-xl-4 col-lg-6">
                                <?php
                                ob_start();
                                ?>
                                            <div class="row justify-content-center">
                                                <form action="<?php echo site_url('admin/frontend_settings/small_logo'); ?>" method="post" enctype="multipart/form-data" style="text-align: center;">
                                                    <div class="form-group mb-2">
                                                        <div class="wrapper-image-preview">
                                                            <div class="box" style="width: 250px;">
                                                                <div class="js--image-preview" style="background-image: url(<?php echo base_url('uploads/system/'.get_frontend_settings('small_logo')); ?>);"></div>
                                                                <div class="upload-options">
                                                                    <label for="small_logo" class="btn"> <i class="mdi mdi-camera"></i> <?php echo get_phrase('upload_small_logo'); ?> <br> <small>(49 X 58)</small> </label>
                                                                    <input id="small_logo" style="visibility:hidden;" type="file" class="image-upload" name="small_logo" accept="image/*">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <?php echo gp_ds_button(get_phrase('upload_small_logo'), [
                                                        'variant' => 'primary',
                                                        'type' => 'submit',
                                                    ], true); ?>
                                                </form>
                                            </div>
                                <?php
                                gp_ds_card([
                                    'title' => get_phrase('update_small_logo'),
                                    'body' => ob_get_clean(),
                                    'extra_class' => 'gp-dash-panel',
                                ]);
                                ?>
                            </div>

                            <div class="col-xl-4 col-lg-6">
                                <?php
                                ob_start();
                                ?>
                                            <div class="row justify-content-center">
                                                <form action="<?php echo site_url('admin/frontend_settings/favicon'); ?>" method="post" enctype="multipart/form-data" style="text-align: center;">
                                                    <div class="form-group mb-2">
                                                        <div class="wrapper-image-preview">
                                                            <div class="box" style="width: 250px;">
                                                                <div class="js--image-preview" style="background-image: url(<?php echo base_url('uploads/system/'.get_frontend_settings('favicon')); ?>);"></div>
                                                                <div class="upload-options">
                                                                    <label for="favicon" class="btn"> <i class="mdi mdi-camera"></i> <?php echo get_phrase('upload_favicon'); ?> <br> <small>(90 X 90)</small> </label>
                                                                    <input id="favicon" style="visibility:hidden;" type="file" class="image-upload" name="favicon" accept="image/*">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <?php echo gp_ds_button(get_phrase('upload_favicon'), [
                                                        'variant' => 'primary',
                                                        'type' => 'submit',
                                                    ], true); ?>
                                                </form>
                                            </div>
                                <?php
                                gp_ds_card([
                                    'title' => get_phrase('update_favicon'),
                                    'body' => ob_get_clean(),
                                    'extra_class' => 'gp-dash-panel',
                                ]);
                                ?>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="custom_codes">
                        <h4 class="mb-1 header-title"><?php echo get_phrase('Custom Codes') ?></h4>
                        <small><?php echo get_phrase('You can modify your theme style and add external embed code from here'); ?></small>
                        <div class="row mt-3">
                            <div class="col-md-7">
                                <form action="<?php echo site_url('admin/frontend_settings/custom_codes'); ?>" method="post">
                                    <div class="form-group">
                                        <label><?php echo get_phrase('Enter your custom css'); ?> <small>(<?php echo get_phrase('Only css code'); ?>)</small></label>
                                        <textarea name="custom_css" rows="8" class="form-control" placeholder="h3{ color: black; }"><?php echo get_frontend_settings('custom_css'); ?></textarea>
                                        <small><?php echo get_phrase('These codes are applicable for all pages of the frontend site'); ?></small>
                                    </div>

                                    <div class="form-group">
                                        <label><?php echo get_phrase('Enter your embed or widget code'); ?></label>
                                        <textarea name="embed_code" rows="8" class="form-control" placeholder="<?php echo get_phrase('Enter your embed or widget code here') ?>"><?php echo get_frontend_settings('embed_code'); ?></textarea>
                                        <small><?php echo get_phrase('These codes are applicable for all pages of the frontend site'); ?></small>
                                    </div>

                                    <div class="form-group">
                                        <?php echo gp_ds_button(get_phrase('Save changes'), [
                                            'variant' => 'primary',
                                            'type' => 'submit',
                                        ], true); ?>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Video Water Mark -->
                    <div class="tab-pane" id="water_mark">
                        <h4 class="mb-3 header-title"><?php echo get_phrase('video_watermark_settings');?></h4>
                        <form  action="<?php echo site_url('admin/frontend_settings/water_mark'); ?>" method="post" enctype="multipart/form-data">
                             <div class="form-group mb-3">
                                <label for="water_mark_status"><?php echo get_phrase('watermark_status'); ?></label><br>
                                <input type="radio" value="active" name="water_mark_status" <?php if(get_frontend_settings('water_mark_status') == 'active') echo 'checked'; ?>> <?php echo get_phrase('active'); ?>
                                &nbsp;&nbsp;
                                <input type="radio" value="inactive" name="water_mark_status" <?php if(get_frontend_settings('water_mark_status') == 'inactive') echo 'checked'; ?>> <?php echo get_phrase('inactive'); ?>
                                
                             </div>

                             <div class="form-group">
                                <label for="water_mark_speed"><?php echo get_phrase('Watermark Animation Speed'); ?><span class="required">*</span></label>
                                <input type="text" name = "water_mark_speed" id = "water_mark_speed" class="form-control" value="<?php echo get_frontend_settings('water_mark_speed');  ?>" required>
                                <p class="text-muted"><?php echo get_phrase('Set the watermark animation speed in milliseconds (e.g., 1000 for 1 second, 3000 for 3 seconds).') ?></p>
                            </div>
                             <div class="form-group">
                                <label for="water_mark_opacity"><?php echo get_phrase('Opacity Level of Watermark'); ?><span class="required">*</span></label>
                                <input type="text" name = "water_mark_opacity" id = "water_mark_opacity" class="form-control" value="<?php echo get_frontend_settings('water_mark_opacity');  ?>" required>
                                <p class="text-muted"><?php echo  get_phrase('Set the watermark opacity between 0 (completely transparent) and 1 (fully visible). For example: 0.3, 0.5, 0.8.')?></p>

                            </div>

                               <?php
                                    $water_mark_value = get_frontend_settings('water_mark');
                                    $watermark_type = (strpos($water_mark_value, '.png') !== false || strpos($water_mark_value, '.jpg') !== false || strpos($water_mark_value, '.jpeg') !== false || strpos($water_mark_value, '.gif') !== false) ? 'image' : 'text';
                                    $water_mark_text = $watermark_type == 'text' ? $water_mark_value : '';
                                ?>


                              <label for="form-label mt-5"><?php echo get_phrase('Watermark Text / Image'); ?></label><br>

                                <ul class="video_test d-flex mb-3">
                                    <li class="text">
                                        <div class="form-check">
                                            <input class="form-check-input me-1" type="radio" name="water_mark_type" id="flexRadioText" value="text" <?php echo $watermark_type == 'text' ? 'checked' : ''; ?>>
                                            <label class="form-check-label me-3" for="flexRadioText">
                                                <?php echo get_phrase('Text'); ?>
                                            </label>
                                        </div>
                                        
                                    </li>
                                    <li>&nbsp;&nbsp; ---OR--- &nbsp;&nbsp;</li>
                                    <li class="image">
                                        <div class="form-check">
                                            <input class="form-check-input me-1" type="radio" name="water_mark_type" id="flexRadioImage" value="image" <?php echo $watermark_type == 'image' ? 'checked' : ''; ?>>
                                            <label class="form-check-label me-3" for="flexRadioImage">
                                                <?php echo get_phrase('Image'); ?>
                                            </label>
                                        </div>
                                    </li>
                                </ul>
                                <!-- Text input -->
                                <div class="eText mb-2" id="textWatermark" style="<?php echo $watermark_type == 'text' ? 'display: block;' : 'display: none;'; ?>">
                                    <input type="text" class="form-control" name="water_mark" value="<?php echo $water_mark_text; ?>">

                                    <div class="form-group mt-1">
                                       <label for="water_mark_color"><?php echo get_phrase('Text Color'); ?></label>
                                         <input type="color" name = "water_mark_color" id = "water_mark_color" class="form-control" value="<?php echo get_frontend_settings('water_mark_color');  ?>">
                                         <p class="text-muted"><?php echo get_phrase('Click the color box to set the watermark text color according to your preference.')?></p>

                                     </div>
                                </div>
                                <!-- Image upload -->
                                <div class="eImage form-group mb-2" id="imageWatermark" style="<?php echo $watermark_type == 'image' ? 'display: block;' : 'display: none;'; ?>">
                                    <div class="wrapper-image-preview">
                                        <div class="boxs">
                                            <div class="js--image-preview" style="background-image: url(<?php echo base_url('uploads/system/' . $water_mark_value); ?>);"></div>
                                            <div class="upload-option">
                                                <label for="water_mark_image" class="btn"> <i class="mdi mdi-camera"></i> <?php echo get_phrase('upload_watermark_logo'); ?> <br> <small>(330 X 70)</small> </label>
                                                <input id="water_mark_image" style="visibility:hidden;" type="file" class="" name="water_mark_image" accept="image/*">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            <div class="form-group">
                                <?php echo gp_ds_button(get_phrase('Save changes'), [
                                    'variant' => 'primary',
                                    'type' => 'submit',
                                ], true); ?>
                            </div>

                        </form>
                    </div>
                    <!-- Video Water Mark -->
                    <!-- Fake Review -->
                    <div class="tab-pane" id="review">
                        <div class="d-flex justify-content-between">
                            <h4 class="mb-3 header-title"><?php echo get_phrase('Review List');?></h4>
                            <?php echo gp_ds_button(get_phrase('Add Review'), [
                                'variant' => 'outline',
                                'href' => 'javascript:;',
                                'extra_class' => 'alignToTitle',
                                'attrs' => [
                                    'onclick' => "showAjaxModal('" . site_url('admin/review_add') . "', '" . get_phrase('add_a_review') . "');",
                                ],
                            ], true); ?>
                        </div>
                        <!--  -->
                        <div class="mt-4">
                            <?php
                                $users = $this->db->where('ratable_type', NULL)->get('rating')->result();
                                if (!empty($users)) {
                                    ob_start();
                                    $counter = 1;
                                    foreach ($users as $user):
                                        $user_data = $this->db->get_where('users', ['id' => $user->user_id])->row_array();
                            ?>
                                                <tr class="gradeU" data-enrol-id="<?php echo $user->id; ?>">
                                                   <td><?php echo $counter++; ?></td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <div class="mt-1">
                                                                <b><?php echo $user_data['first_name'].' '.$user_data['last_name']; ?></b><br>
                                                                <small><?php echo $user_data['email']; ?></small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <p><?php echo $user->rating; ?></p>
                                                    </td>
                                                    <td>
                                                        <div class="pl-1 pt-1">
                                                            <p><?php echo $user->review; ?></p>
                                                        </div>
                                                    </td>
                                                    <td>
                                                    <div class="dropright dropright">
                                                        <button type="button" class="icon-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <i class="mdi mdi-dots-vertical"></i>
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                        <li>
                                                            <a class="dropdown-item" href="javascript:;" onclick="showAjaxModal('<?php echo site_url('admin/review_edit/'.$user->id); ?>', '<?php echo get_phrase('update_review'); ?>');">
                                                                <?php echo get_phrase('Edit');?>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a class="dropdown-item" href="javascript:;" onclick="confirm_modal('<?php echo site_url('admin/review/delete/' . $user->id); ?>');">
                                                                <?php echo get_phrase('delete'); ?>
                                                            </a>
                                                        </li>
                                                        </ul>
                                                          </div>
                                                    </td>
                                                </tr>
                            <?php
                                    endforeach;
                                    echo gp_ds_table([
                                        'headers' => [
                                            get_phrase('#'),
                                            get_phrase('Name'),
                                            get_phrase('Rating'),
                                            get_phrase('Review'),
                                            get_phrase('actions'),
                                        ],
                                        'body_html' => ob_get_clean(),
                                        'allow_empty' => true,
                                        'extra_class' => 'mb-0',
                                    ], true);
                                } else {
                            ?>
                                    <div class="empty-state">
                                        <div class="icon"><i class="mdi mdi-file-search-outline"></i></div>
                                        <h4><?php echo get_phrase('no_data_found'); ?></h4>
                                    </div>
                            <?php } ?>
                            </div>

                        <!--  -->
                    </div>
                    <!-- Fake Review -->

                </div>

        <?php
        gp_ds_card([
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
</div>
</div>



<script type="text/javascript">
    $(document).ready(function () {
        initSummerNote(['#about_us', '#terms_and_condition', '#privacy_policy', '#cookie_policy', '#refund_policy']);

        <?php if(isset($_GET['tab'])): ?>
            $('a[href="#<?php echo $_GET['tab'] ?>"]').trigger('click');
        <?php endif; ?>
    });




    <?php if(isset($_GET['tab'])): ?>
        $('.ajax_loader').addClass('start_ajax_loading');
        const tabClickInterval = setInterval(function(){
            if(!$("a[href$=<?= $_GET['tab']; ?>]").hasClass('active')){
                $("a[href$=<?= $_GET['tab']; ?>]").click();
            }else{
                $('.ajax_loader').removeClass('start_ajax_loading');
                clearInterval(tabClickInterval);
            }
        }, 1000);
    <?php endif; ?>

</script>


<script>
    
  $(document).ready(function () {
    $('input[name="water_mark_type"]').change(function () {
        if ($(this).val() == 'text') {
            $('.eText').show();
            $('.eImage').hide();
        } else {
            $('.eText').hide();
            $('.eImage').show();
        }
    });
    $('input[name="water_mark_type"]:checked').trigger('change');
});

</script>
