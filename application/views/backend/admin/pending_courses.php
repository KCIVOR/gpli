<?php
    $courses = $this->crud_model->get_courses();
    gp_ds_page_title(
        $page_title,
        gp_ds_button(get_phrase('add_course'), [
            'href' => site_url('admin/course_form/add_course'),
            'variant' => 'primary',
        ], true)
    );
?>

<div class="gp-courses-page">
    <?php
    ob_start();
    $pending_courses = 0;
    foreach ($courses->result_array() as $course):
        if ($course['status'] != 'pending') continue;
        $pending_courses++;
    ?>
        <tr>
            <td><?php echo $course['title']; ?></td>
            <td>
                <?php
                $category_details = $this->crud_model->get_categories($course['category_id'])->row_array();
                echo $category_details['name'];
                ?>
            </td>
            <td>
                <?php
                $subcategory_details = $this->crud_model->get_category_details_by_id($course['sub_category_id'])->row_array();
                echo $subcategory_details['name'];
                ?>
            </td>
            <td>
                <?php
                if ($course['user_id'] > 0) {
                    $instructor_details = $this->user_model->get_all_user($course['user_id'])->row_array();
                    echo $instructor_details['first_name'].' '.$instructor_details['last_name'];
                } else {
                    $admin_details = $this->user_model->get_admin_details();
                    echo $admin_details['first_name'].' '.$admin_details['last_name'];
                }
                ?>
            </td>
            <td>
                <?php
                $sections = $this->crud_model->get_section('course', $course['id']);
                echo $sections->num_rows();
                ?>
            </td>
            <td>
                <?php
                $lessons = $this->crud_model->get_lessons('course', $course['id']);
                echo $lessons->num_rows();
                ?>
            </td>
            <td>
                <?php
                $enrol_history = $this->crud_model->enrol_history($course['id']);
                echo $enrol_history->num_rows();
                ?>
            </td>
            <td>
                <div class="dropright">
                    <button type="button" class="btn btn-sm btn-outline-primary btn-rounded btn-icon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="mdi mdi-dots-vertical"></i>
                    </button>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item" href="<?php echo site_url('home/course/'.slugify($course['title']).'/'.$course['id']); ?>" target="_blank">
                                <?php echo get_phrase('view_course_on_frontend');?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo site_url('admin/sections/'.$course['id']); ?>">
                                <?php echo get_phrase('manage_section');?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo site_url('admin/lessons/'.$course['id']); ?>">
                                <?php echo get_phrase('manage_lesson');?>
                            </a>
                        </li>
                        <li>
                            <?php if ($course['user_id'] != $this->session->userdata('user_id')): ?>
                                <a class="dropdown-item" href="#" onclick="showAjaxModal('<?php echo base_url();?>modal/popup/mail_on_course_status_changing_modal/active/<?php echo $course['id'];?>');">
                                    <?php echo get_phrase('mark_as_active');?>
                                </a>
                            <?php else: ?>
                                <a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url();?>admin/change_course_status_for_admin/active/<?php echo $course['id'];?>', 'generic_confirmation');">
                                    <?php echo get_phrase('mark_as_active');?>
                                </a>
                            <?php endif; ?>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo site_url('admin/course_form/course_edit/'.$course['id']) ?>">
                                <?php echo get_phrase('edit');?>
                            </a>
                        </li>
                        <li class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/course_actions/delete/'.$course['id']); ?>');">
                                <?php echo get_phrase('delete');?>
                            </a>
                        </li>
                    </ul>
                </div>
            </td>
        </tr>
    <?php endforeach; ?>
    <?php
    $course_rows = ob_get_clean();
    gp_ds_card([
        'title' => get_phrase('pending_courses'),
        'body' => gp_ds_table([
            'headers' => [
                get_phrase('title'),
                get_phrase('category'),
                get_phrase('sub_category'),
                get_phrase('instructor'),
                get_phrase('number_of_sections'),
                get_phrase('number_of_lessons'),
                get_phrase('number_of_enrolled_users'),
                get_phrase('action'),
            ],
            'body_html' => $course_rows,
            'allow_empty' => $pending_courses > 0,
            'empty' => get_phrase('no_data_found'),
        ], true),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script type="text/javascript">
    function ajax_get_sub_category(category_id) {
        $.ajax({
            url: '<?php echo site_url('admin/ajax_get_sub_category/');?>' + category_id ,
            success: function(response)
            {
                jQuery('#sub_category_id').html(response);
                console.log(response);
            }
        });
    }
</script>
