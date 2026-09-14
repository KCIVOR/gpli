<form class="form-horizontal form-groups-bordered gp-courses-modal" action="<?php echo site_url('admin/change_course_status/'.$param2); ?>" method="post">
  <div class="form-group">
     <label><?php echo get_phrase('mail') . ' ' . get_phrase('subject'); ?></label>
     <input type="text" name = "mail_subject" class="form-control" placeholder="<?php echo get_phrase('mail') . ' ' . get_phrase('subject'); ?>" required>
  </div>

  <div class="form-group">
    <label><?php echo get_phrase('mail') . ' ' . get_phrase('body'); ?></label>
      <textarea name = "mail_body" class="form-control" required rows="6" placeholder="<?php echo get_phrase('mail') . ' ' . get_phrase('body'); ?>"></textarea>
  </div>

  <input type="hidden" name="course_id" value="<?php echo $param3; ?>">
  <input type="hidden" name="category_id" value="<?php echo $param4; ?>">
  <input type="hidden" name="instructor_id" value="<?php echo $param5; ?>">
  <input type="hidden" name="price" value="all">
  <input type="hidden" name="status" value="<?php echo $param7; ?>">

  <div class="gp-courses-modal-actions">
      <?php echo gp_ds_button(get_phrase('send') . ' ' . get_phrase('mail'), [
          'type' => 'submit',
          'variant' => 'primary',
          'attrs' => ['name' => 'button'],
      ], true); ?>
  </div>
</form>
