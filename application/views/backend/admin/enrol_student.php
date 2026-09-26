<?php gp_ds_page_title(get_phrase('course_enrolment')); ?>

<div class="gp-enrol-page">
    <div class="row justify-content-center">
        <div class="col-xl-7">
            <?php
            ob_start();
            ?>
                <form class="required-form" action="<?php echo site_url('admin/enrol_student/enrol'); ?>" method="post" enctype="multipart/form-data">

                    <div class="form-group">
                        <label for="multiple_user_id"><?php echo get_phrase('users'); ?><span class="required">*</span> </label>
                        <select class="server-side-select2" action="<?php echo base_url('admin/get_select2_user_data'); ?>" name="user_id[]" multiple="multiple" required>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="gp_enrol_program_shortcut">Program <span class="gp-hint">(optional — auto-selects that program's courses below)</span></label>
                        <select class="form-control" id="gp_enrol_program_shortcut">
                            <option value="">-- Select individually --</option>
                            <option value="accelerator">Leadership Accelerator (12 courses)</option>
                            <option value="challenge">Leadership Challenge (12 courses)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="multiple_course_id"><?php echo get_phrase('course_to_enrol'); ?><span class="required">*</span> </label>
                        <select class="select2 form-control select2-multiple" data-toggle="select2" multiple="multiple" data-placeholder="Choose ..." name="course_id[]" id="multiple_course_id" required>
                            <option value=""><?php echo get_phrase('select_a_course'); ?></option>
                            <?php $course_list = $this->db->where('status', 'active')->or_where('status', 'private')->get('course')->result_array();
                                foreach ($course_list as $course): ?>
                                <option value="<?php echo $course['id'] ?>"><?php echo $course['title']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <?php echo gp_ds_button(get_phrase('enrol_student'), [
                        'variant' => 'primary',
                        'type' => 'button',
                        'attrs' => ['onclick' => 'checkRequiredFields()'],
                    ], true); ?>
                </form>

                <script>
                (function () {
                    var GP_PROGRAM_COURSES = {
                        accelerator: [
                            'Business Ethics', 'Taking Initiative', 'Improving Mindfulness',
                            'Creative Problem Solving', 'Developing Creativity', 'Emotional Intelligence',
                            'Conflict Resolution', 'Critical Thinking', 'Communication Strategies',
                            'Interpersonal Skills', 'Goal Setting', 'Leadership And Influence'
                        ],
                        challenge: [
                            'Building Confidence and Assertiveness', 'Self-Leadership', 'Accountability in the Workplace',
                            'Teamwork and Team Building', 'Trust Building & Resilience', 'Supervising Others',
                            'Conflict Resolution', 'Critical Thinking', 'Communication Strategies',
                            'Interpersonal Skills', 'Goal Setting', 'Leadership And Influence'
                        ]
                    };

                    document.addEventListener('DOMContentLoaded', function () {
                        var shortcut = document.getElementById('gp_enrol_program_shortcut');
                        var courseSelect = document.getElementById('multiple_course_id');
                        if (!shortcut || !courseSelect) return;

                        shortcut.addEventListener('change', function () {
                            var titles = GP_PROGRAM_COURSES[shortcut.value];
                            var options = courseSelect.querySelectorAll('option');
                            options.forEach(function (opt) {
                                if (!titles) {
                                    opt.selected = false;
                                    return;
                                }
                                var optText = opt.textContent.trim().toLowerCase();
                                opt.selected = titles.some(function (t) { return t.trim().toLowerCase() === optText; });
                            });
                            if (window.jQuery) {
                                jQuery(courseSelect).trigger('change');
                            }
                        });
                    });
                })();
                </script>
            <?php
            gp_ds_card([
                'title' => get_phrase('enrolment_form'),
                'body'  => ob_get_clean(),
                'extra_class' => 'gp-dash-panel',
            ]);
            ?>
        </div>
    </div>
</div>
