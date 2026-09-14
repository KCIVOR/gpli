<?php foreach($notifications->result_array() as $notification): ?>
    <div class="dropdown-item notify-item cursor-pointer <?php if($notification['status'] == 0) echo 'unread' ?>">
        <?php if($notification['type'] == 'signup'): ?>
            <div class="notify-icon">
                <img src="<?php echo $this->user_model->get_user_image_url($notification['from_user']); ?>" class="img-fluid rounded-circle" alt="User image" />
            </div>
        <?php else: ?>
            <div class="notify-icon">
                <i class="mdi mdi-comment-account-outline"></i>
            </div>
        <?php endif; ?>
        <p class="notify-details">
            <?php echo $notification['title']; ?>
            <small><?php echo get_past_time($notification['created_at']); ?></small>
        </p>
        <div class="user-msg">
            <?php echo ($notification['description']); ?>
        </div>
    </div>
<?php endforeach; ?>

<?php if($notifications->num_rows() == 0): ?>
    <div class="gp-admin-notify-empty">
        <p><?php echo get_phrase('No notification'); ?></p>
        <small><?php echo get_phrase('Stay tuned!'); ?> <?php echo get_phrase('Notifications about your activity will show up here.'); ?></small>
        <a href="<?php echo site_url('admin/notification_settings'); ?>"><?php echo get_phrase('Notification Settings'); ?></a>
    </div>
<?php endif; ?>
