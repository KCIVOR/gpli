<?php gp_ds_page_title(get_phrase('add_your_new_page')); ?>
<div class="gp-settings-page">
<div class="row ">
    <div class="col-md-10">
        <?php
        ob_start();
        ?>
		    	<form action="<?php echo site_url('admin/custom_page/add'); ?>" method="post" enctype="multipart/form-data">
		    		<div class="form-group">
		    			<label for="page_title"><?php echo get_phrase('page_title'); ?></label>
		    			<input type="text" class="form-control" name="page_title" id="page_title" placeholder="<?php echo get_phrase('enter_page_title'); ?>" required>
		    		</div>

		    		<div class="form-group">
		    			<label for="summernote-basic"><?php echo get_phrase('page_content'); ?></label>
		    			<textarea name="page_content" id="summernote-basic"></textarea>
		    		</div>

		    		<div class="form-group">
			    		<label for="button_title"><?php echo get_phrase('button_title'); ?></label>
			    		<input class="form-control" type="text" id="button_title" name="button_title">
			    	</div>

		    		<div class="form-group">
		    			<label for="button_position"><?php echo get_phrase('button_position'); ?></label>
		    			<select class="form-control select2" data-toggle="select2" name="button_position" id="button_position" required>
		    				<option value="footer"><?php echo get_phrase('footer'); ?></option>
		    				<option value="header"><?php echo get_phrase('header'); ?></option>
		    			</select>
		    		</div>

		    		<div class="form-group">
			    		<label for="page_url"><?php echo get_phrase('page_url'); ?></label>
			    		<div class="input-group">
			    			<div class="input-group-prepend">
			    				<span class="input-group-text"><?php echo site_url('page/'); ?></span>
			    			</div>
			    			<input class="form-control" type="text" id="page_url" name="page_url">
			    		</div>
			    	</div>

					<div class="form-group mt-4">
						<?php echo gp_ds_button(get_phrase('add_page'), [
							'variant' => 'primary',
							'type' => 'submit',
						], true); ?>
					</div>
		    	</form>
        <?php
        gp_ds_card([
            'title' => get_phrase('page_information'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
	</div>
</div>
</div>
