<?php
    $status_wise_courses = $this->crud_model->get_status_wise_courses();
    $number_of_courses = $status_wise_courses['pending']->num_rows() + $status_wise_courses['active']->num_rows();
    $number_of_lessons = $this->crud_model->get_lessons()->num_rows();
    $number_of_enrolment = $this->crud_model->enrol_history()->num_rows();
    $number_of_students = $this->user_model->get_user()->num_rows();
    $pending_payouts = $this->crud_model->get_pending_payouts()->result_array();
    $active_courses = $status_wise_courses['active']->num_rows();
    $pending_courses = $status_wise_courses['pending']->num_rows();
?>
<?php gp_ds_page_title(get_phrase('Dashboard')); ?>

<div class="gp-dash">
    <div class="gp-dash-stats">
        <a href="<?php echo site_url('admin/courses'); ?>" class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="dripicons-archive"></i></span>
            <span class="gp-dash-stat-value"><?php echo $number_of_courses; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Courses'); ?></span>
        </a>
        <a href="<?php echo site_url('admin/courses'); ?>" class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="dripicons-camcorder"></i></span>
            <span class="gp-dash-stat-value"><?php echo $number_of_lessons; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Lessons'); ?></span>
        </a>
        <a href="<?php echo site_url('admin/enrol_history'); ?>" class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="dripicons-network-3"></i></span>
            <span class="gp-dash-stat-value"><?php echo $number_of_enrolment; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Enrolments'); ?></span>
        </a>
        <a href="<?php echo site_url('admin/users'); ?>" class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="dripicons-user-group"></i></span>
            <span class="gp-dash-stat-value"><?php echo $number_of_students; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Students'); ?></span>
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
        'title' => get_phrase('Admin') . ' ' . get_phrase('revenue') . ' ' . get_phrase('this') . ' ' . get_phrase('year'),
        'body' => ob_get_clean(),
    ]);
    ?>

    <div class="gp-dash-split">
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
            'title' => get_phrase('Course') . ' ' . get_phrase('overview'),
            'body' => ob_get_clean(),
        ]);
        ?>

        <div id="unpaid-instructor-revenue">
            <?php
            $payout_rows = [];
            foreach ($pending_payouts as $pending_payout) {
                $instructor_details = $this->user_model->get_all_user($pending_payout['user_id'])->row_array();
                $payout_rows[] = [
                    '<div class="gp-dash-person"><strong>' . html_escape($instructor_details['first_name'] . ' ' . $instructor_details['last_name']) . '</strong><span>' . html_escape($instructor_details['email']) . '</span></div>',
                    '<div class="gp-dash-person"><strong>' . currency($pending_payout['amount']) . '</strong><span>' . get_phrase('Requested') . ' ' . get_phrase('amount') . '</span></div>',
                ];
            }

            ob_start();
            if (empty($payout_rows)) {
                echo '<div class="gp-dash-empty">';
                echo '<p>' . get_phrase('No') . ' ' . get_phrase('pending') . ' ' . get_phrase('withdrawals') . '</p>';
                echo '<small>' . get_phrase('Instructor') . ' ' . get_phrase('payout') . ' ' . get_phrase('requests') . ' ' . get_phrase('will') . ' ' . get_phrase('show') . ' ' . get_phrase('up') . ' ' . get_phrase('here') . '.</small>';
                echo '</div>';
            } else {
                gp_ds_table([
                    'headers' => [get_phrase('Instructor'), get_phrase('Amount')],
                    'rows' => $payout_rows,
                    'empty' => get_phrase('No') . ' ' . get_phrase('pending') . ' ' . get_phrase('withdrawals'),
                ]);
            }

            gp_ds_card([
                'extra_class' => 'gp-dash-panel',
                'title' => '',
                'header' => '<div class="gp-dash-card-head"><h4 class="header-title">' . get_phrase('Requested') . ' ' . get_phrase('withdrawal') . '</h4><a href="' . site_url('admin/instructor_payout') . '" id="go-to-instructor-revenue">' . get_phrase('View') . ' ' . get_phrase('payouts') . '</a></div>',
                'body' => ob_get_clean(),
            ]);
            ?>
        </div>
    </div>
</div>

<script type="text/javascript">
    $('#unpaid-instructor-revenue').mouseenter(function() {
        $('#go-to-instructor-revenue').show();
    });
    $('#unpaid-instructor-revenue').mouseleave(function() {
        $('#go-to-instructor-revenue').hide();
    });
</script>
