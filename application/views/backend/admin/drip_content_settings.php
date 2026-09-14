<?php gp_ds_page_title(get_phrase('drip_content_settings')); ?>
<div class="gp-settings-page">
<div class="row">
	<div class="col-lg-7">
		<?php
		ob_start();
		?>
				<form action="<?php echo site_url('admin/drip_content_settings/update'); ?>" method="post">
					<div class="form-group">
						<label><?php echo get_phrase('lesson_completion_role'); ?><span class="required">*</span></label>
						<br>
						<input type="radio" onchange="$('.toggleMinimumWatchField').toggleClass('d-hidden');" value="percentage" id="video_percentage_wise" name="lesson_completion_role" <?php if($drip_content_settings['lesson_completion_role'] == 'percentage') echo 'checked'; ?>>
						<label for="video_percentage_wise"><?php echo get_phrase('video_percentage_wise'); ?></label>
						&nbsp;&nbsp;
						<input type="radio" onchange="$('.toggleMinimumWatchField').toggleClass('d-hidden');" value="duration" id="video_duration_wise" name="lesson_completion_role" <?php if($drip_content_settings['lesson_completion_role'] == 'duration') echo 'checked'; ?>>
						<label for="video_duration_wise"><?php echo get_phrase('video_duration_wise'); ?></label>
					</div>

					<div class="form-group toggleMinimumWatchField <?php if($drip_content_settings['lesson_completion_role'] != 'duration') echo 'd-hidden'; ?>">
						<label for="minimum_duration"><?php echo get_phrase('minimum_duration_to_watch'); ?><span class="required">*</span></label>
						<div class="input-group">
							<input type="text" value="<?php echo seconds_to_time_format($drip_content_settings['minimum_duration']); ?>" id="minimum_duration" class="form-control" name="minimum_duration" data-toggle="timepicker" data-show-meridian="false">
							<div class="input-group-append">
								<span class="input-group-text"><i class="dripicons-clock"></i></span>
							</div>
						</div>
					</div>

					<div class="form-group toggleMinimumWatchField <?php if($drip_content_settings['lesson_completion_role'] != 'percentage') echo 'd-hidden'; ?>">
						<label for="minimum_percentage"><?php echo get_phrase('minimum_percentage_to_watch'); ?><span class="required">*</span></label>
						<div class="input-group">
							<input type="text" value="<?php echo $drip_content_settings['minimum_percentage']; ?>" id="minimum_percentage" name="minimum_percentage" class="form-control">
							<div class="input-group-append">
								<span class="input-group-text"><i class="mdi mdi-percent"></i></span>
							</div>
						</div>
					</div>

					<div class="form-group">
                        <label for="locked_lesson_message"><?php echo get_phrase('message_for_locked_lesson'); ?></label>
                        <textarea name="locked_lesson_message" id = "locked_lesson_message" class="form-control" rows="5"><?php echo $drip_content_settings['locked_lesson_message']; ?></textarea>
                    </div>

                    <?php echo gp_ds_button(get_phrase('save_changes'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
				</form>
		<?php
		gp_ds_card([
			'title' => get_phrase('manage_your_drip_content_settings'),
			'body' => ob_get_clean(),
			'extra_class' => 'gp-dash-panel',
		]);
		?>
	</div>
	<div class="col-lg-5">
		<?php echo gp_ds_alert(get_phrase('attention'), get_phrase('the_auto_checkmark_is_only_applicable_for_video_lessons') . '.', 'info', true); ?>
		<a href="https://creativeitem.com/docs/academy-lms/drip-content-settings" target="_blank" class="gp-settings-help-link"><?php echo get_phrase('learn_more'); ?></a>
	</div>
</div>
</div>

<script type="text/javascript">
	$(document).ready(function () {
	    initSummerNote(['#locked_lesson_message']);
	  });
</script>
