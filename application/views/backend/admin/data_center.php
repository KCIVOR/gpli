<?php gp_ds_page_title(get_phrase('data_center')); ?>
<div class="gp-settings-page">
<div class="row">
    <div class="col-md-5 col-xl-6">
        <?php
        ob_start();
        ?>
                <p>You can import your demo and your backup data from here.</p>
                <form action="<?php echo site_url('data_center/demo_importer'); ?>" method="post" enctype="multipart/form-data" id="import_backup_data_form">
                    <div class="form-group">
                    	<div class="input-group">
							<div class="custom-file">
								<input type="file" class="custom-file-input" name = "data_file" id="data_file" onchange="changeTitleOfImageUploader(this)" accept=".zip" required>
								<label class="custom-file-label ellipsis" for="data_file"><?php echo get_phrase('choose_your_demo_file'); ?></label>
							</div>
						</div>
                        <span class="gp-settings-file-hint"><?php echo gp_ds_badge('Ex: uploads_v' . get_settings('version') . '.zip', 'neutral', true); ?></span>
                    </div>

                    <div class="form-group mb-0">
                        <?php echo gp_ds_button(get_phrase('import'), [
                            'variant' => 'primary',
                            'type' => 'button',
                            'attrs' => [
                                'onclick' => "jQuery('#data-import-alert-modal').modal('show', {backdrop: 'static'});",
                            ],
                        ], true); ?>
                    </div>
                </form>
        <?php
        gp_ds_card([
            'title' => get_phrase('import_your_data'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
    <div class="col-md-7 col-xl-6">
        <?php
        ob_start();
        ?>
                <div class="gp-settings-backup-head">
                    <h4 class="header-title"><?php echo get_phrase('backup_your_website'); ?></h4>
                    <?php echo gp_ds_button(get_phrase('keep_a_backup'), [
                        'variant' => 'primary',
                        'href' => site_url('data_center/create_backup_file'),
                        'attrs' => [
                            'data-toggle' => 'tooltip',
                            'title' => get_phrase('backup_your_current_data'),
                        ],
                    ], true); ?>
                </div>


                <?php if($this->session->flashdata('imported_message')): ?>
                    <?php echo gp_ds_alert($this->session->flashdata('imported_message'), '', 'success', true); ?>
                <?php endif; ?>



                <?php
                    $all_backups = array_filter(glob('backups/*'), 'is_dir');
                    if(count($all_backups) == 0): ?>
                    <div class="empty-state">
                        <div class="icon"><i class="mdi mdi-folder-multiple-outline"></i></div>
                        <h4><?php echo get_phrase('No backup'); ?></h4>
                    </div>
                <?php endif; ?>

                <?php
                    foreach($all_backups as $key => $dir){
                        ++$key;
                        $dir_arr = explode('/',$dir);
                        $folder_details = explode('_',end($dir_arr)); ?>

                    <div class="file-chip">
                        <span class="name">
                            <i class="mdi mdi-folder"></i>
                            <span class="text-capitalize"><?php echo $folder_details[1]; ?></span>
                        </span>
                        <?php
                            $created_date_arr = explode('-', $folder_details[2]);
                        ?>
                        <span class="gp-settings-backup-date"><?php echo date('d M Y, H:i:s', strtotime($created_date_arr[0].' '.$created_date_arr[1].' '.$created_date_arr[2].' '.$created_date_arr[3].':'.$created_date_arr[4].':'.$created_date_arr[5])); ?></span>
                        <span class="gp-settings-backup-actions">
                            <a href="<?php echo site_url('data_center/download_zip_file/'.end($dir_arr)); ?>" data-toggle="tooltip" title="<?php echo get_phrase('export'); ?>" target="_blank" class="icon-btn">
                                <i class="dripicons-download"></i>
                            </a>
                            <a href="javascript:;" data-toggle="tooltip" title="<?php echo get_phrase('Delete'); ?>" onclick="confirm_modal('<?php echo site_url('data_center/delete_dir/'.end($dir_arr)); ?>')" class="icon-btn">
                                <i class="dripicons-trash"></i>
                            </a>
                        </span>
                    </div>

                <?php } ?>
        <?php
        gp_ds_card([
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
</div>
</div>
