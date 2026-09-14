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

$stat_body = '<div class="row gp-student-stats">'
    . '<div class="col-md-4 mb-3"><p>' . get_phrase('number_of_courses') . '</p><h3>' . (int) $number_of_courses . '</h3></div>'
    . '<div class="col-md-4 mb-3"><p>' . get_phrase('number_of_enrolment') . '</p><h3>' . (int) $number_of_enrolment . '</h3></div>'
    . '<div class="col-md-4 mb-3"><p>' . get_phrase('pending_balance') . '</p><h3>' . html_escape(currency($total_pending_amount)) . '</h3></div>'
    . '</div>';

$action_links = '<div class="gp-student-dashboard-actions mb-3">'
    . gp_ds_button(get_phrase('create_course'), [
        'variant'     => 'outline',
        'href'        => site_url('home/create_course'),
        'extra_class' => 'gp-student-cta me-2 mb-2',
    ], true)
    . gp_ds_button(get_phrase('dashboard'), [
        'variant'     => 'outline',
        'href'        => site_url('user'),
        'extra_class' => 'gp-student-cta me-2 mb-2',
    ], true)
    . '</div>';

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
        <?php gp_ds_page_title(get_phrase('instructor_dashboard')); ?>
        <div class="row">
            <div class="col-lg-3 col-md-4">
                <?php include 'profile_menus.php'; ?>
            </div>
            <div class="col-lg-9 col-md-8">
                <?php
                gp_ds_card([
                    'body'  => $stat_body
                        . $action_links
                        . '<div class="gp-student-dashboard-filters mb-3">' . $status_counts . '</div>'
                        . $table,
                ]);
                ?>
            </div>
        </div>
    </div>
</section>
</div>
