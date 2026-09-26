<?php
// Shared by admin/learner_progress and user/learner_progress (the instructor wrapper sets $gp_lp_base = 'user')
$gp_lp_base = (isset($gp_lp_base) && $gp_lp_base === 'user') ? 'user' : 'admin';
$gp_lp_url  = site_url($gp_lp_base . '/learner_progress');

// Active filters, without empty values, for paging and export links
$gp_lp_query = array_filter([
    'course_id'     => $filters['course_id'] ? $filters['course_id'] : '',
    'student'       => $filters['student'],
    'status'        => $filters['status'],
    'enrolled_from' => $filters['enrolled_from'],
    'enrolled_to'   => $filters['enrolled_to'],
], 'strlen');

$gp_lp_statuses = [
    'not_started' => ['label' => get_phrase('Not started'), 'tone' => 'neutral'],
    'in_progress' => ['label' => get_phrase('In progress'), 'tone' => 'primary'],
    'completed'   => ['label' => get_phrase('Completed'), 'tone' => 'success'],
    'expired'     => ['label' => get_phrase('Expired'), 'tone' => 'danger'],
];

$gp_lp_export_url = $gp_lp_url . '?' . http_build_query(array_merge($gp_lp_query, ['export' => 'csv']));

gp_ds_page_title(get_phrase('Learner progress'), gp_ds_button(get_phrase('Export CSV'), [
    'variant' => 'outline',
    'href'    => $gp_lp_export_url,
], true));
?>

<div class="gp-report-page gp-learner-progress-page">
    <div class="gp-dash-stats gp-learner-progress-stats">
        <?php foreach ([
            'enrolled'     => ['icon' => 'dripicons-user-group', 'label' => get_phrase('Enrolled')],
            'in_progress'  => ['icon' => 'dripicons-hourglass', 'label' => get_phrase('In progress')],
            'completed'    => ['icon' => 'dripicons-checkmark', 'label' => get_phrase('Completed')],
            'not_started'  => ['icon' => 'dripicons-clock', 'label' => get_phrase('Not started')],
            'expired'      => ['icon' => 'dripicons-warning', 'label' => get_phrase('Expired')],
            'certificates' => ['icon' => 'dripicons-graduation', 'label' => get_phrase('Certificates')],
        ] as $gp_lp_key => $gp_lp_tile): ?>
            <div class="gp-dash-stat">
                <span class="gp-dash-stat-icon"><i class="<?php echo $gp_lp_tile['icon']; ?>"></i></span>
                <span class="gp-dash-stat-value"><?php echo (int) $report['summary'][$gp_lp_key]; ?></span>
                <span class="gp-dash-stat-label"><?php echo $gp_lp_tile['label']; ?></span>
            </div>
        <?php endforeach; ?>
    </div>

    <?php ob_start(); ?>
    <form class="gp-report-toolbar-form gp-learner-progress-filters" action="<?php echo $gp_lp_url; ?>" method="get">
        <select name="course_id" class="form-control" aria-label="<?php echo get_phrase('Course'); ?>">
            <option value=""><?php echo get_phrase('All courses'); ?></option>
            <?php foreach ($courses as $gp_lp_course): ?>
                <option value="<?php echo (int) $gp_lp_course['id']; ?>" <?php if ((int) $filters['course_id'] === (int) $gp_lp_course['id']) echo 'selected'; ?>><?php echo html_escape($gp_lp_course['title'], false); ?></option>
            <?php endforeach; ?>
        </select>
        <input type="text" name="student" class="form-control" value="<?php echo html_escape($filters['student']); ?>" placeholder="<?php echo get_phrase('Student name or email'); ?>" aria-label="<?php echo get_phrase('Student'); ?>">
        <select name="status" class="form-control" aria-label="<?php echo get_phrase('Status'); ?>">
            <option value=""><?php echo get_phrase('All statuses'); ?></option>
            <?php foreach ($gp_lp_statuses as $gp_lp_value => $gp_lp_status): ?>
                <option value="<?php echo $gp_lp_value; ?>" <?php if ($filters['status'] === $gp_lp_value) echo 'selected'; ?>><?php echo $gp_lp_status['label']; ?></option>
            <?php endforeach; ?>
        </select>
        <label class="gp-learner-progress-date">
            <span><?php echo get_phrase('Enrolled from'); ?></span>
            <input type="date" name="enrolled_from" class="form-control" value="<?php echo html_escape($filters['enrolled_from']); ?>">
        </label>
        <label class="gp-learner-progress-date">
            <span><?php echo get_phrase('Enrolled to'); ?></span>
            <input type="date" name="enrolled_to" class="form-control" value="<?php echo html_escape($filters['enrolled_to']); ?>">
        </label>
        <?php echo gp_ds_button(get_phrase('Apply'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
        <?php echo gp_ds_button(get_phrase('Reset'), ['variant' => 'quiet', 'href' => $gp_lp_url], true); ?>
    </form>

    <?php if ($report['capped']): ?>
        <div class="alert alert-warning mt-3 mb-0" role="alert">
            <?php echo get_phrase('Too many results; only the first 2,000 enrolments are shown. Narrow by course or date.'); ?>
        </div>
    <?php endif; ?>

    <?php
    ob_start();
    foreach ($report['rows'] as $gp_lp_row):
        $gp_lp_status = isset($gp_lp_statuses[$gp_lp_row['status']]) ? $gp_lp_statuses[$gp_lp_row['status']] : $gp_lp_statuses['not_started'];
        ?>
        <tr>
            <td>
                <b><?php echo html_escape($gp_lp_row['student_name']); ?></b><br>
                <small class="text-muted"><?php echo html_escape($gp_lp_row['email']); ?></small>
            </td>
            <td><?php echo html_escape($gp_lp_row['course_title'], false); ?></td>
            <td><?php echo gp_ds_badge($gp_lp_status['label'], $gp_lp_status['tone'], true); ?></td>
            <td><?php echo $gp_lp_row['percent'] === null ? '&mdash;' : (int) $gp_lp_row['percent'] . '%'; ?></td>
            <td><?php echo $gp_lp_row['score'] === null ? '&mdash;' : (int) $gp_lp_row['score']; ?></td>
            <td><?php echo date('d M Y', $gp_lp_row['enrolled']); ?></td>
            <td><?php echo $gp_lp_row['last_activity'] ? date('d M Y', $gp_lp_row['last_activity']) : '&mdash;'; ?></td>
            <td><?php echo $gp_lp_row['completed_date'] ? date('d M Y', $gp_lp_row['completed_date']) : '&mdash;'; ?></td>
            <td>
                <?php if ($gp_lp_row['certificate_url']): ?>
                    <a href="<?php echo html_escape($gp_lp_row['certificate_url']); ?>" target="_blank" rel="noopener"><?php echo get_phrase('View'); ?></a>
                <?php else: ?>
                    &mdash;
                <?php endif; ?>
            </td>
        </tr>
    <?php
    endforeach;
    $gp_lp_body = ob_get_clean();

    gp_ds_table([
        'headers'     => [
            get_phrase('Student'),
            get_phrase('Course'),
            get_phrase('Status'),
            get_phrase('Progress'),
            get_phrase('Test score'),
            get_phrase('Enrolled'),
            get_phrase('Last activity'),
            get_phrase('Completed on'),
            get_phrase('Certificate'),
        ],
        'body_html'   => $gp_lp_body,
        'empty'       => get_phrase('no_data_found'),
        'extra_class' => 'table-striped mb-0',
    ]);
    ?>

    <?php if ($report['pages'] > 1): ?>
        <nav class="gp-learner-progress-pager mt-3" aria-label="<?php echo get_phrase('Pages'); ?>">
            <ul class="pagination mb-0">
                <?php for ($gp_lp_page = 1; $gp_lp_page <= $report['pages']; $gp_lp_page++): ?>
                    <li class="page-item <?php if ($gp_lp_page == $report['page']) echo 'active'; ?>">
                        <a class="page-link" href="<?php echo $gp_lp_url . '?' . html_escape(http_build_query(array_merge($gp_lp_query, ['page' => $gp_lp_page]))); ?>"><?php echo $gp_lp_page; ?></a>
                    </li>
                <?php endfor; ?>
            </ul>
        </nav>
    <?php endif; ?>
    <p class="text-muted mt-2 mb-0"><?php echo get_phrase('Results') . ': ' . (int) $report['total']; ?></p>
    <?php
    gp_ds_card([
        'title'       => get_phrase('Learners'),
        'body'        => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
