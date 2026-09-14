<?php
    $instructor_id = $this->session->userdata('user_id');
    $number_of_courses = $this->crud_model->get_instructor_wise_courses($instructor_id)->num_rows();
    $number_of_enrolment_result = $this->crud_model->instructor_wise_enrolment($instructor_id);
    if ($number_of_enrolment_result) {
        $number_of_enrolment = $number_of_enrolment_result->num_rows();
    } else {
        $number_of_enrolment = 0;
    }
    $total_pending_amount = $this->crud_model->get_total_pending_amount($instructor_id);
    $requested_withdrawal_amount = $this->crud_model->get_requested_withdrawal_amount($instructor_id);
    $active_courses = $this->crud_model->get_status_wise_courses_for_instructor('active')->num_rows();
    $pending_courses = $this->crud_model->get_status_wise_courses_for_instructor('pending')->num_rows();
?>
<?php gp_ds_page_title(get_phrase('Dashboard')); ?>

<div class="gp-dash">
    <div class="gp-dash-stats">
        <a href="<?php echo site_url('user/courses'); ?>" class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="dripicons-archive"></i></span>
            <span class="gp-dash-stat-value"><?php echo $number_of_courses; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Courses'); ?></span>
        </a>
        <div class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="dripicons-user-group"></i></span>
            <span class="gp-dash-stat-value"><?php echo $number_of_enrolment; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Enrolments'); ?></span>
        </div>
        <a href="<?php echo site_url('user/payout_report'); ?>" class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="dripicons-inbox"></i></span>
            <span class="gp-dash-stat-value"><?php echo $total_pending_amount > 0 ? currency($total_pending_amount) : currency_code_and_symbol() . '' . $total_pending_amount; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Pending') . ' ' . get_phrase('balance'); ?></span>
        </a>
        <a href="<?php echo site_url('user/payout_report'); ?>" class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="dripicons-pin"></i></span>
            <span class="gp-dash-stat-value"><?php echo $requested_withdrawal_amount > 0 ? currency($requested_withdrawal_amount) : currency_code_and_symbol() . '' . $requested_withdrawal_amount; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Requested') . ' ' . get_phrase('withdrawal'); ?></span>
        </a>
    </div>

    <?php
    ob_start();
    ?>
        <div class="gp-dash-chart">
            <canvas id="task-area-chart"></canvas>
        </div>
    <?php
    gp_ds_card([
        'extra_class' => 'gp-dash-panel',
        'title'       => get_phrase('Instructor') . ' ' . get_phrase('revenue') . ' ' . get_phrase('this') . ' ' . get_phrase('year'),
        'body'        => ob_get_clean(),
    ]);
    ?>

    <?php
    ob_start();
    ?>
        <div class="gp-dash-chart gp-dash-chart--donut">
            <canvas id="project-status-chart"></canvas>
        </div>
        <div class="gp-dash-legend">
            <div class="gp-dash-legend-item">
                <span class="gp-dash-legend-dot gp-dash-legend-dot--active"></span>
                <span class="gp-dash-legend-value"><?php echo $active_courses; ?></span>
                <span class="gp-dash-legend-label"><?php echo get_phrase('Active') . ' ' . get_phrase('courses'); ?></span>
            </div>
            <div class="gp-dash-legend-item">
                <span class="gp-dash-legend-dot gp-dash-legend-dot--pending"></span>
                <span class="gp-dash-legend-value"><?php echo $pending_courses; ?></span>
                <span class="gp-dash-legend-label"><?php echo get_phrase('Pending') . ' ' . get_phrase('courses'); ?></span>
            </div>
        </div>
    <?php
    gp_ds_card([
        'extra_class' => 'gp-dash-panel',
        'title'       => get_phrase('Course') . ' ' . get_phrase('overview'),
        'body'        => ob_get_clean(),
    ]);
    ?>
</div>
