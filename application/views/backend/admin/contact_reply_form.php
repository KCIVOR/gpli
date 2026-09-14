<div class="gp-contact-page gp-contact-modal">
<form action="<?php echo site_url('admin/contact/send_reply/'.$contact['id']); ?>" method="post">
	<div class="mb-3">
        <textarea class="form-control" name="reply_message" rows="10"></textarea>
    </div>
    <div>
        <?php echo gp_ds_button(get_phrase('Send reply'), [
            'variant' => 'primary',
            'type' => 'submit',
        ], true); ?>
    </div>
</form>
</div>
