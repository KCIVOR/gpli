<?php
gp_ds_page_title(
    get_phrase('install_an_addon'),
    gp_ds_button(get_phrase('back_to_addon_list'), [
        'href' => site_url('admin/addon'),
        'variant' => 'outline',
    ], true)
);
?>

<div class="gp-addons-page">
<div class="row justify-content-center">
    <div class="col-xl-5">
        <?php if (!class_exists('ZipArchive')) : ?>
            <?php gp_ds_alert('N.B', get_phrase('you_need_to_enable_the_zip_extension_on_your_server_to_install_addons') . '.', 'danger'); ?>
        <?php endif; ?>
        <?php
        ob_start();
        ?>
                    <form action="<?php echo site_url('admin/addon/install'); ?>" method="post" enctype="multipart/form-data">
                        <?php if ($_SERVER['SERVER_NAME'] == 'localhost' || $_SERVER['SERVER_NAME'] == '127.0.0.1') : ?>
                        <?php else : ?>
                            <div class="form-group mb-3">
                                <label><?php echo get_phrase('purchase_code'); ?></label>
                                <input type="text" name="purchase_code" class="form-control" placeholder="<?php echo get_phrase('enter_your_valid_purchase_code'); ?>">
                            </div>
                        <?php endif; ?>
                        <div class="form-group mb-3">
                            <label><?php echo get_phrase('zip_file'); ?></label>
                            <div class="input-group">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="addon_zip" name="addon_zip" required onchange="changeTitleOfImageUploader(this)" required accept=".zip">
                                    <label class="custom-file-label" for="addon_zip"><?php echo get_phrase('upload_addon_file'); ?></label>
                                </div>
                            </div>
                        </div>

                        <?php echo gp_ds_button(get_phrase('install_addon'), [
                            'variant' => 'primary',
                            'type' => 'submit',
                            'extra_class' => 'float-right',
                        ], true); ?>
                        <?php echo gp_ds_button(get_phrase('back'), [
                            'href' => site_url('admin/addon'),
                            'variant' => 'secondary',
                            'extra_class' => 'float-left',
                        ], true); ?>
                    </form>
        <?php
        gp_ds_card([
            'title' => get_phrase('upload_addon_file') . ' (' . get_phrase('zip_file') . ') ',
            'body'  => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
</div>
</div>
