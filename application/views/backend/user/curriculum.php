<?php
$sections = $this->crud_model->get_section('course', $course_id)->result_array();
?>
<div class="gp-curriculum">
    <div class="gp-curriculum-toolbar">
        <?php echo gp_ds_button(get_phrase('add_section'), [
            'href' => 'javascript:void(0)',
            'variant' => 'outline',
            'attrs' => [
                'onclick' => "showAjaxModal('" . site_url('modal/popup/section_add/'.$course_id) . "', '" . get_phrase('add_new_section') . "')",
            ],
        ], true); ?>
        <?php echo gp_ds_button(get_phrase('add_lesson'), [
            'href' => 'javascript:void(0)',
            'variant' => 'outline',
            'attrs' => [
                'onclick' => "showAjaxModal('" . site_url('modal/popup/lesson_types/'.$course_id) . "', '" . get_phrase('add_new_lesson') . "')",
            ],
        ], true); ?>
        <?php if (count($sections) > 0): ?>
            <?php echo gp_ds_button(get_phrase('add_quiz'), [
                'href' => 'javascript:void(0)',
                'variant' => 'outline',
                'attrs' => [
                    'onclick' => "showAjaxModal('" . site_url('modal/popup/quiz_add/'.$course_id) . "', '" . get_phrase('add_new_quiz') . "')",
                ],
            ], true); ?>
            <?php echo gp_ds_button(get_phrase('sort_sections'), [
                'href' => 'javascript:void(0)',
                'variant' => 'outline',
                'attrs' => [
                    'onclick' => "showLargeModal('" . site_url('modal/popup/sort_section/'.$course_id) . "', '" . get_phrase('sort_sections') . "')",
                ],
            ], true); ?>
        <?php endif; ?>
    </div>

    <?php if (count($sections) === 0): ?>
        <div class="empty-state">
            <div class="icon">＋</div>
            <h4><?php echo get_phrase('no_data_found'); ?></h4>
            <p><?php echo get_phrase('add_section'); ?></p>
            <?php echo gp_ds_button(get_phrase('add_section'), [
                'href' => 'javascript:void(0)',
                'variant' => 'primary',
                'attrs' => [
                    'onclick' => "showAjaxModal('" . site_url('modal/popup/section_add/'.$course_id) . "', '" . get_phrase('add_new_section') . "')",
                ],
            ], true); ?>
        </div>
    <?php endif; ?>

    <div class="gp-curriculum-list">
        <?php
        $lesson_counter = 0;
        $quiz_counter   = 0;
        foreach ($sections as $key => $section): ?>
            <div class="card gp-curriculum-section on-hover-action" id="section-<?php echo $section['id']; ?>">
                <div class="card-body">
                    <?php if (date('d-M-Y-H-i-s', $section['start_date']) != date('d-M-Y-H-i-s', $section['end_date'])): ?>
                        <p class="gp-curriculum-study-plan">
                            <?php echo get_phrase('Study plan'); ?>
                            <?php if (date('d-M-Y', $section['start_date']) == date('d-M-Y', $section['end_date'])): ?>
                                — <?php echo date('d M Y', $section['start_date']); ?>
                                <br>
                                <?php echo date('h:i A', $section['start_date']) . ' ' . get_phrase('To') . ' ' . date('h:i A', $section['end_date']); ?>
                            <?php else: ?>
                                <br>
                                <?php echo date('d M Y h:i A', $section['start_date']) . ' - ' . date('d M Y h:i A', $section['end_date']); ?>
                            <?php endif; ?>
                        </p>
                    <?php endif; ?>

                    <div class="gp-curriculum-section-head">
                        <h5 class="card-title mb-0">
                            <span class="gp-curriculum-kicker"><?php echo get_phrase('section') . ' ' . ++$key; ?></span>
                            <?php echo $section['title']; ?>
                        </h5>
                        <div class="card-widgets gp-curriculum-section-actions justify-content-center alignToTitle display-none" id="widgets-of-section-<?php echo $section['id']; ?>">
                            <a href="javascript:;" onclick="showLargeModal('<?php echo site_url('modal/popup/sort_lesson/'.$section['id']); ?>', '<?php echo get_phrase('sort_lessons'); ?>')" data-toggle="tooltip" title="<?php echo get_phrase('sort_lesson'); ?>"><i class="mdi mdi-sort-variant"></i></a>
                            <a href="javascript:;" onclick="showAjaxModal('<?php echo site_url('modal/popup/section_edit/'.$section['id'].'/'.$course_id); ?>', '<?php echo get_phrase('update_section'); ?>')" data-toggle="tooltip" title="<?php echo get_phrase('edit_section'); ?>"><i class="mdi mdi-pencil-outline"></i></a>
                            <a href="javascript:;" onclick="confirm_modal('<?php echo site_url('user/sections/'.$course_id.'/delete'.'/'.$section['id']); ?>');" data-toggle="tooltip" title="<?php echo get_phrase('delete_section'); ?>"><i class="mdi mdi-window-close"></i></a>
                        </div>
                    </div>

                    <div class="gp-curriculum-lessons">
                        <?php
                        $lessons = $this->crud_model->get_lessons('section', $section['id'])->result_array();
                        foreach ($lessons as $index => $lesson): ?>
                            <div class="card gp-curriculum-lesson text-secondary on-hover-action" id="<?php echo 'lesson-'.$lesson['id']; ?>">
                                <div class="card-body thinner-card-body">
                                    <div class="card-widgets gp-curriculum-lesson-actions display-none" id="widgets-of-lesson-<?php echo $lesson['id']; ?>">
                                        <?php if ($lesson['lesson_type'] == 'quiz'): ?>
                                            <a href="<?php echo site_url('home/lesson/'.slugify($course_details['title']).'/'.$course_details['id'].'/'.$lesson['id']); ?>" target="_blank" data-toggle="tooltip" title="<?php echo get_phrase('quiz_results'); ?>"><i class="mdi mdi-file-document-box-outline"></i></a>
                                            <a href="javascript:;" onclick="showLargeModal('<?php echo site_url('modal/popup/quiz_questions/'.$lesson['id']); ?>', '<?php echo get_phrase('manage_quiz_questions'); ?>')" data-toggle="tooltip" title="<?php echo get_phrase('quiz_questions'); ?>"><i class="mdi mdi-comment-question-outline"></i></a>
                                            <a href="javascript:;" onclick="showAjaxModal('<?php echo site_url('modal/popup/quiz_edit/'.$lesson['id'].'/'.$course_id); ?>', '<?php echo get_phrase('update_quiz_information'); ?>')" data-toggle="tooltip" title="<?php echo get_phrase('edit'); ?>"><i class="mdi mdi-pencil-outline"></i></a>
                                        <?php else: ?>
                                            <a href="javascript:;" onclick="showAjaxModal('<?php echo site_url('modal/popup/resource_files/'.$lesson['id']); ?>', '<?php echo get_phrase('Add new resource file'); ?>')" data-toggle="tooltip" title="<?php echo get_phrase('Resource files'); ?>"><i class="mdi mdi-folder-open"></i></a>
                                            <a href="javascript:;" onclick="showAjaxModal('<?php echo site_url('modal/popup/lesson_edit/'.$lesson['id'].'/'.$course_id); ?>', '<?php echo get_phrase('update_lesson'); ?>')" data-toggle="tooltip" title="<?php echo get_phrase('edit'); ?>"><i class="mdi mdi-pencil-outline"></i></a>
                                        <?php endif; ?>
                                        <a href="javascript:;" onclick="confirm_modal('<?php echo site_url('user/lessons/'.$course_id.'/delete'.'/'.$lesson['id']); ?>');" data-toggle="tooltip" title="<?php echo get_phrase('delete'); ?>"><i class="mdi mdi-window-close"></i></a>
                                    </div>
                                    <h5 class="card-title mb-0">
                                        <span class="gp-curriculum-kicker">
                                            <?php
                                            if ($lesson['lesson_type'] == 'quiz') {
                                                $quiz_counter++;
                                                $lesson_type = $lesson['lesson_type'];
                                            } else {
                                                $lesson_counter++;
                                                if ($lesson['attachment_type'] == 'txt' || $lesson['attachment_type'] == 'pdf' || $lesson['attachment_type'] == 'doc' || $lesson['attachment_type'] == 'img') {
                                                    $lesson_type = $lesson['attachment_type'];
                                                } else {
                                                    $lesson_type = 'video';
                                                }
                                            }
                                            ?>
                                            <img src="<?php echo base_url('assets/backend/lesson_icon/'.$lesson_type.'.png'); ?>" alt="" height="16">
                                            <?php echo $lesson['lesson_type'] == 'quiz' ? get_phrase('quiz') . ' ' . $quiz_counter : get_phrase('lesson') . ' ' . $lesson_counter; ?>
                                        </span>
                                        <?php echo $lesson['title']; ?>
                                    </h5>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</div>
