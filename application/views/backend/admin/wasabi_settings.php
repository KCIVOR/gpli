<?php gp_ds_page_title(get_phrase('Wasabi storage settings')); ?>
<div class="gp-settings-page">
<div class="row">
    <div class="col-xl-7">
        <?php
        ob_start();
        ?>
                    <form class="required-form" action="<?php echo site_url('admin/wasabi_settings/update'); ?>" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="access_key"><?php echo 'Wasabi S3 '.get_phrase('access_key'); ?><span class="required">*</span></label>
                            <input type="text" name = "access_key" id = "access_key" class="form-control" value="<?php echo get_settings('wasabi_key');  ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="secret_key"><?php echo 'Wasabi S3 '.get_phrase('secret_key'); ?><span class="required">*</span></label>
                            <input type="text" name = "secret_key" id = "secret_key" class="form-control" value="<?php echo get_settings('wasabi_secret_key');  ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="bucket_name"><?php echo 'Wasabi S3 '.get_phrase('bucket_name'); ?><span class="required">*</span></label>
                            <input type="text" name = "bucket_name" id = "bucket_name" class="form-control" value="<?php echo get_settings('wasabi_bucketname');  ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="region_name"><?php echo 'Wasabi S3 '.get_phrase('region_name'); ?><span class="required">*</span></label>
                            <input type="text" name = "region_name" id = "region_name" class="form-control" value="<?php echo get_settings('wasabi_region');  ?>" required>
                        </div>

                        <?php echo gp_ds_button(get_phrase('save'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
                    </form>
        <?php
        gp_ds_card([
            'title' => get_phrase('Wasabi storage settings'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div><!-- end col-->
</div>
</div>
