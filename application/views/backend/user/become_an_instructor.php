<?php
    $applications = $this->user_model->get_applications($this->session->userdata('user_id'), 'user');
?>
<?php gp_ds_page_title(get_phrase('Become an instructor')); ?>

<div class="gp-users-page">
<?php if ($this->session->userdata('is_instructor') != 1): ?>
    <?php
    $has_application = $applications->num_rows() > 0;
    ob_start();
    if (! $has_application) {
        include 'application_form.php';
    } else {
        include 'application_list.php';
    }
    gp_ds_card([
        'title'       => $has_application ? get_phrase('your_application') : get_phrase('instructor_application_form'),
        'extra_class' => 'gp-dash-panel',
        'body'        => ob_get_clean(),
    ]);
    ?>
<?php else: ?>
    <?php gp_ds_alert(get_phrase('congratulations') . '!', get_phrase('you_are_already_an_instructor'), 'info'); ?>
<?php endif; ?>
</div>
