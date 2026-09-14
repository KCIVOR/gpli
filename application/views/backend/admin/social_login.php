<?php gp_ds_page_title(get_phrase('social_login_configuration')); ?>
<div class="gp-settings-page">
<div class="row">
    <div class="col-xl-6">
        <?php
        ob_start();
        if (strpos(site_url(), 'https') !== 0):
            echo gp_ds_alert(
                'SSL(https) ' . get_phrase('issue') . ' !',
                get_phrase('you_must_use_an_SSL_supported_server_to_use_the_Facebook_login_feature'),
                'danger',
                true
            );
        endif;
        ?>
                    <form class="required-form" action="<?php echo site_url('admin/social_login_settings/update'); ?>" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="smtp_protocol"><?php echo get_phrase('facebook_login'); ?><span class="required">*</span></label>
                            <br>
                            <input type="radio" id="fb_social_login_active" name="fb_social_login" value="1" <?php if(get_settings('fb_social_login') == 1)echo 'checked'; ?>>
                            <label for="fb_social_login_active"><?php echo get_phrase('active'); ?></label>

                            <input type="radio" id="fb_social_login_disabled" name="fb_social_login" value="0" <?php if(get_settings('fb_social_login') != 1)echo 'checked'; ?>>
                            <label for="fb_social_login_disabled"><?php echo get_phrase('inactive'); ?></label>
                        </div>

                        <div class="form-group">
                            <label for="fb_app_id"><?php echo get_phrase('facebook_app_id'); ?><span class="required">*</span></label>
                            <input type="text" name = "fb_app_id" id = "fb_app_id" class="form-control" value="<?php echo get_settings('fb_app_id');  ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="fb_app_secret"><?php echo get_phrase('facebook_app_secret'); ?><span class="required">*</span></label>
                            <input type="text" name = "fb_app_secret" id = "fb_app_secret" class="form-control" value="<?php echo get_settings('fb_app_secret');  ?>" required>
                        </div>

                        <?php echo gp_ds_button(get_phrase('save_changes'), [
                            'variant' => 'primary',
                            'type' => 'button',
                            'attrs' => ['onclick' => 'checkRequiredFields()'],
                        ], true); ?>
                    </form>
        <?php
        gp_ds_card([
            'title' => get_phrase('facebook_login') . ' <a target="_blank" href="https://developers.facebook.com/docs/development/create-an-app/"><i class="mdi mdi-information-outline" data-toggle="tooltip" data-placement="top" title="' . get_phrase('facebook_app_creation_instruction') . '"></i></a>',
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
</div>
</div>
