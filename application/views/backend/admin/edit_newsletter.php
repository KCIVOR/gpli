<div class="gp-newsletter-page gp-newsletter-modal">
<form action="<?php echo site_url('admin/newsletters/edit/'.$newsletter['id']); ?>" method="post">
	<div class="form-group">
		<label for="newsletter_subject"><?php echo get_phrase('Subject'); ?></label>
		<input type="text" value="<?php echo $newsletter['subject']; ?>" name="subject" class="form-control" id="newsletter_subject" required>
	</div>

	<div class="form-group">
		<label for="newsletter_description"><?php echo get_phrase('Description'); ?></label>
		<textarea name="description" id="newsletter_description"><?php echo $newsletter['description']; ?></textarea>
	</div>

	<div class="form-group">
		<?php echo gp_ds_button(get_phrase('Save'), [
			'variant' => 'primary',
			'type' => 'submit',
		], true); ?>
	</div>
</form>
</div>

<script type="text/javascript">
	initSummerNote(['#newsletter_description']);
</script>
