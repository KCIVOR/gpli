<?php
$user_id      = isset($user_id) ? $user_id : $this->session->userdata('user_id');
$type         = isset($type) && $type !== '' ? $type : 'active';
$user_details = $this->user_model->get_all_user($user_id)->row_array();

$courses_by_status = $this->crud_model->get_courses_by_user_id($user_id);
$number_of_courses = $this->crud_model->get_instructor_wise_courses($user_id)->num_rows();
$enrolment_result  = $this->crud_model->instructor_wise_enrolment($user_id);
$number_of_enrolment = $enrolment_result ? $enrolment_result->num_rows() : 0;
$total_pending_amount = $this->crud_model->get_total_pending_amount($user_id);

$filtered = $this->crud_model->get_courses_by_instructor_id($user_id, $type);
$rows     = [];
foreach ($filtered->result_array() as $course) {
    $rows[] = [
        html_escape($course['title']),
        html_escape($course['status']),
        '<a href="' . site_url('home/edit_course/' . $course['id']) . '">' . get_phrase('edit_course') . '</a>',
        '<a href="' . site_url('home/edit_course/' . $course['id'] . '/manage_section') . '">' . get_phrase('manage_section') . '</a>',
        '<a href="' . site_url('home/edit_course/' . $course['id'] . '/manage_lesson') . '">' . get_phrase('manage_lesson') . '</a>',
    ];
}

$page_actions = gp_ds_button(get_phrase('create_course'), [
    'variant' => 'primary',
    'href'    => site_url('home/create_course'),
], true) . gp_ds_button(get_phrase('dashboard'), [
    'variant' => 'outline',
    'href'    => site_url('user'),
], true);

$status_counts = '';
if (is_array($courses_by_status)) {
    foreach (['active', 'pending', 'draft'] as $status_key) {
        $count = (isset($courses_by_status[$status_key]) && is_object($courses_by_status[$status_key]))
            ? $courses_by_status[$status_key]->num_rows()
            : 0;
        $label = $status_key . ' (' . (int) $count . ')';
        $status_counts .= gp_ds_button($label, [
            'variant'     => ($type === $status_key ? 'primary' : 'outline'),
            'href'        => site_url('home/dashboard/' . $status_key),
            'extra_class' => 'me-2 mb-2 gp-student-cta',
        ], true);
    }
}

$table = gp_ds_table([
    'headers' => [
        get_phrase('title'),
        get_phrase('status'),
        get_phrase('edit_course'),
        get_phrase('manage_section'),
        get_phrase('manage_lesson'),
    ],
    'rows'  => $rows,
    'empty' => get_phrase('no_data_found'),
], true);
?>
<div class="gp-student-page">
<?php include 'breadcrumb.php'; ?>

<section class="wish-list-body gp-student-shell">
    <div class="container">
        <?php gp_ds_page_title(get_phrase('instructor_dashboard'), $page_actions); ?>
        <div class="row">
            <div class="col-lg-3 col-md-4">
                <?php include 'profile_menus.php'; ?>
            </div>
            <div class="col-lg-9 col-md-8">
                <div class="gp-dash-stats gp-student-instructor-stats">
                    <div class="gp-dash-stat">
                        <span class="gp-dash-stat-icon"><i class="fa-solid fa-book-open-reader"></i></span>
                        <span class="gp-dash-stat-value"><?php echo (int) $number_of_courses; ?></span>
                        <span class="gp-dash-stat-label"><?php echo get_phrase('number_of_courses'); ?></span>
                    </div>
                    <div class="gp-dash-stat">
                        <span class="gp-dash-stat-icon"><i class="fa-solid fa-user-graduate"></i></span>
                        <span class="gp-dash-stat-value"><?php echo (int) $number_of_enrolment; ?></span>
                        <span class="gp-dash-stat-label"><?php echo get_phrase('number_of_enrolment'); ?></span>
                    </div>
                    <div class="gp-dash-stat">
                        <span class="gp-dash-stat-icon"><i class="fa-solid fa-sack-dollar"></i></span>
                        <span class="gp-dash-stat-value"><?php echo html_escape(currency($total_pending_amount)); ?></span>
                        <span class="gp-dash-stat-label"><?php echo get_phrase('pending_balance'); ?></span>
                    </div>
                </div>

                <?php
                gp_ds_card([
                    'extra_class' => 'gp-dash-panel gp-student-instructor-filters',
                    'body'        => '<div class="gp-student-dashboard-filters">' . $status_counts . '</div>',
                ]);
                ?>

                <?php
                gp_ds_card([
                    'title'       => get_phrase('course') . ' ' . get_phrase('list'),
                    'extra_class' => 'gp-dash-panel',
                    'body'        => $table,
                ]);
                ?>
            </div>
        </div>
    </div>
</section>
</div>
