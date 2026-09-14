<?php
$lessons_title = $page_title;
if (!empty($course_id)) {
    $lessons_title .= ' #' . html_escape($course_id);
}
gp_ds_page_title($lessons_title);
?>

<div class="gp-courses-page">
    <?php
    $lesson_rows = (isset($lessons) && is_object($lessons) && method_exists($lessons, 'result_array'))
        ? $lessons->result_array()
        : [];
    $rows = [];
    foreach ($lesson_rows as $key => $lesson) {
        $rows[] = [
            $key + 1,
            html_escape($lesson['title']),
            html_escape($lesson['lesson_type']),
            isset($lesson['duration']) ? html_escape($lesson['duration']) : '',
        ];
    }
    $table = gp_ds_table([
        'headers' => [
            '#',
            get_phrase('title'),
            get_phrase('lesson_type'),
            get_phrase('duration'),
        ],
        'rows'        => $rows,
        'empty'       => get_phrase('no_data_found'),
        'extra_class' => 'table-striped mb-0',
    ], true);
    gp_ds_card([
        'title' => get_phrase('lesson') . ' ' . get_phrase('list'),
        'body' => $table,
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
