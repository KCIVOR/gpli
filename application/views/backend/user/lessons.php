<div class="row">
    <div class="col-xl-12">
        <div class="card">
            <div class="card-body">
                <h4 class="page-title">
                    <i class="mdi mdi-apple-keyboard-command title_icon"></i>
                    <?php echo $page_title; ?>
                    <?php if (!empty($course_id)): ?>
                        <small class="text-muted">#<?php echo html_escape($course_id); ?></small>
                    <?php endif; ?>
                </h4>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-xl-12">
        <div class="card">
            <div class="card-body">
                <div class="mt-2">
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
                    gp_ds_table([
                        'headers' => [
                            '#',
                            get_phrase('title'),
                            get_phrase('lesson_type'),
                            get_phrase('duration'),
                        ],
                        'rows'        => $rows,
                        'empty'       => get_phrase('no_data_found'),
                        'extra_class' => 'table-striped mb-0',
                    ]);
                    ?>
                </div>
            </div>
        </div>
    </div>
</div>
