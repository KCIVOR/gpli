<div class="gp-settings-page">
<form action="<?php echo site_url('admin/edit_email_template/'.$notification['id'].'/update'); ?>" method="post">
	<?php foreach(json_decode($notification['subject'], true) as $user_type => $subject): ?>
		<div class="form-group">
			<label for="<?= 'subject_label_'.$user_type ?>"><?php echo get_phrase('Email subject'); ?> <small>(<?php echo get_phrase('To '.$user_type); ?></small>)</label>
			<input type="text" name="subject[<?= $user_type; ?>]" id="<?= 'subject_label_'.$user_type ?>" value="<?= $subject; ?>" class="form-control">
		</div>
	<?php endforeach; ?>

	<?php foreach(json_decode($notification['template'], true) as $user_type => $template): ?>
		<div class="form-group">
			<label for="<?= 'template_label_'.$user_type ?>"><?php echo get_phrase('Email template'); ?> <small>(<?php echo get_phrase('To '.$user_type); ?></small>)</label>

			<textarea name="template[<?= $user_type; ?>]" id="<?= 'template_label_'.$user_type ?>" class="form-control"  rows="4"><?= $template; ?></textarea>
		</div>
	<?php endforeach; ?>

	<div class="form-group">
		<?php echo gp_ds_button(get_phrase('Save changes'), [
			'variant' => 'primary',
			'type' => 'submit',
		], true); ?>
	</div>
</form>
</div>

<script type="text/javascript">
	initSummerNote(['textarea']);
</script>
