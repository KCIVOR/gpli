<?php gp_ds_page_title(get_phrase('BigBlueButton Live Class Settings')); ?>
<div class="gp-settings-page">

<div class="row ">
    <div class="col-md-6">
        <?php
        ob_start();
        ?>
		    	<form action="<?php echo site_url('admin/bbb_live_class_settings/update'); ?>" method="post" enctype="multipart/form-data">
		    		<div class="form-group">
		    			<label for="endpoint"><?php echo get_phrase('BigBlueButton Endpoint'); ?></label>
		    			<input value="<?php echo get_settings('bbb_setting', true)['endpoint'] ?? ''; ?>" type="text" class="form-control" name="endpoint" id="endpoint" placeholder="https://example.bigbluemeeting.com/bigbluebutton/" required>
		    		</div>

		    		<div class="form-group">
		    			<label for="secret"><?php echo get_phrase('BigBlueButton Shared Secret or Salt'); ?></label>
		    			<input value="<?php echo get_settings('bbb_setting', true)['secret'] ?? ''; ?>" type="text" class="form-control" name="secret" id="secret" placeholder="6IBNH5btxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" required>
		    		</div>

					<div class="form-group mt-4">
						<?php echo gp_ds_button(get_phrase('Save Changes'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
					</div>
		    	</form>
        <?php
        gp_ds_card([
            'title' => get_phrase('BigBlueButton Live Class Settings'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
	</div>
</div>
</div>
