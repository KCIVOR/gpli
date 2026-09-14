<?php gp_ds_page_title(get_phrase('manage_profile')); ?>

<div class="gp-profile-page">
<div class="row ">
	<div class="col-xl-7">
		<?php
		ob_start();
		foreach ($edit_data as $row):
			$social_links = json_decode($row['social_links'], true); ?>
					<?php echo form_open(site_url('admin/manage_profile/update_profile_info/'.$row['id']) , array('class' => 'form-horizontal form-groups-bordered validate','target'=>'_top' , 'enctype' => 'multipart/form-data'));?>

					<div class="form-group">
						<label><?php echo get_phrase('first_name');?></label>
						<input type="text" class="form-control" name="first_name" value="<?php echo $row['first_name'];?>" required/>
					</div>

					<div class="form-group">
						<label><?php echo get_phrase('last_name');?></label>
						<input type="text" class="form-control" name="last_name" value="<?php echo $row['last_name'];?>" required/>
					</div>

					<div class="form-group">
						<label><?php echo get_phrase('email');?></label>
						<input type="email" class="form-control" name="email" value="<?php echo $row['email'];?>" required/>
					</div>

					<div class="form-group">
						<label><?php echo get_phrase('facebook_link');?></label>
						<input type="text" class="form-control" name="facebook_link" value="<?php echo $social_links['facebook'];?>"/>
					</div>

					<div class="form-group">
						<label><?php echo get_phrase('twitter_link');?></label>
						<input type="text" class="form-control" name="twitter_link" value="<?php echo $social_links['twitter'];?>"/>
					</div>

					<div class="form-group">
						<label><?php echo get_phrase('linkedin_link');?></label>
						<input type="text" class="form-control" name="linkedin_link" value="<?php echo $social_links['linkedin'];?>"/>
					</div>

					<div class="form-group">
						<label><?php echo get_phrase('a_short_title_about_yourself'); ?></label>
						<textarea rows="5" id="short-title" class="form-control" name="title" placeholder="<?php echo get_phrase('a_short_title_about_yourself'); ?>"><?php echo $row['title']; ?></textarea>
					</div>

					<div class="form-group">
                        <label for="skills"><?php echo get_phrase('skills'); ?></label>
                        <input type="text" class="form-control bootstrap-tag-input" id = "skills" name="skills" data-role="tagsinput" value="<?php echo $row['skills'];  ?>"/>
                        <small class="text-muted"><?php echo get_phrase('write_your_skill_and_click_the_enter_button'); ?></small>
                    </div>

					<div class="form-group">
						<label><?php echo get_phrase('biography'); ?></label>
						<textarea rows="5" class="form-control" name="biography" id="biography" placeholder="<?php echo get_phrase('biography'); ?>"><?php echo $row['biography']; ?></textarea>
					</div>


					<div class="form-group">
						<label> <?php echo get_phrase('photo'); ?> <small>(<?php echo get_phrase('the_image_size_should_be_any_square_image'); ?>)</small> </label>
						<div class="d-flex mt-2">
							<div class="">
								<img class = "rounded-circle img-thumbnail" src="<?php echo $this->user_model->get_user_image_url($this->session->userdata('user_id')); ?>" alt="">
							</div>
							<div class="flex-grow-1 pl-2">
								<div class="input-group">
									<div class="custom-file">
										<input type="file" class="custom-file-input" name = "user_image" id="user_image" onchange="changeTitleOfImageUploader(this)" accept="image/*">
										<label class="custom-file-label ellipsis" for=""><?php echo get_phrase('choose_file'); ?></label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="row justify-content-center">
						<?php echo gp_ds_button(get_phrase('update_profile'), [
							'variant' => 'primary',
							'type' => 'submit',
						], true); ?>
					</div>
				</form>
				<?php
			endforeach;
		gp_ds_card([
			'title' => get_phrase('basic_info'),
			'body' => ob_get_clean(),
			'extra_class' => 'gp-dash-panel',
		]);
		?>
	</div>
	<div class="col-xl-5">
		<?php
		ob_start();
		foreach ($edit_data as $row):
			echo form_open(site_url('admin/manage_profile/change_password/'.$row['id']) , array('class' => 'form-horizontal form-groups-bordered validate','target'=>'_top'));
		?>
				<div class="form-group">
					<label><?php echo get_phrase('current_password');?></label>
					<input type="password" class="form-control" name="current_password" value="" required/>
				</div>
				<div class="form-group">
					<label><?php echo get_phrase('new_password');?></label>
					<input type="password" class="form-control" name="new_password" value="" required/>
				</div>
				<div class="form-group">
					<label><?php echo get_phrase('confirm_new_password');?></label>
					<input type="password" class="form-control" name="confirm_password" value="" required/>
				</div>
				<div class="row justify-content-center">
					<?php echo gp_ds_button(get_phrase('update_password'), [
						'variant' => 'primary',
						'type' => 'submit',
					], true); ?>
				</div>
			</form>
		<?php
		endforeach;
		gp_ds_card([
			'title' => get_phrase('update_password'),
			'body' => ob_get_clean(),
			'extra_class' => 'gp-dash-panel',
		]);
		?>
	</div>
</div>
</div>

<script type="text/javascript">
$(document).ready(function () {
	initSummerNote(['#biography']);
});
</script>
