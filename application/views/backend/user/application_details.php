<?php
$application_details = $this->user_model->get_applications($param2, 'application')->row_array();
$applicant_details = $this->user_model->get_all_user($application_details['user_id'])->row_array();
$status_html = $application_details['status']
    ? gp_ds_badge(get_phrase('approved'), 'success', true)
    : gp_ds_badge(get_phrase('pending'), 'danger', true);
?>
<div class="gp-users-page gp-users-modal">
    <div class="text-center mb-2">
        <img class="mr-2 rounded-circle" src="<?php echo $this->user_model->get_user_image_url($applicant_details['id']); ?>" alt="" height="80">
    </div>

    <?php
    echo gp_ds_table([
        'extra_class' => 'mb-0',
        'rows' => [
            ['<strong>' . get_phrase('applicant') . '</strong>', $applicant_details['first_name'] . ' ' . $applicant_details['last_name']],
            ['<strong>' . get_phrase('email') . '</strong>', $applicant_details['email']],
            ['<strong>' . get_phrase('phone_number') . '</strong>', $application_details['phone']],
            ['<strong>' . get_phrase('address') . '</strong>', $application_details['address']],
            ['<strong>' . get_phrase('message') . '</strong>', $application_details['message']],
            ['<strong>' . get_phrase('status') . '</strong>', $status_html],
        ],
    ], true);
    ?>
</div>
