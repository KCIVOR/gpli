<?php
$user_details = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array();
$course_id    = isset($course_id) ? $course_id : '';
$type         = isset($type) && $type !== '' ? $type : 'edit_course';
$course       = $this->crud_model->get_course_by_id($course_id)->row_array();
$categories   = $this->crud_model->get_categories();
$languages    = $this->crud_model->get_all_languages();
$course_media_files = themeConfiguration(get_frontend_settings('theme'), 'course_media_files');
include 'breadcrumb.php';

$nav = '<div class="mb-4 d-flex gap-2 flex-wrap">'
    . '<a class="btn ' . ($type === 'edit_course' ? 'btn-primary' : 'btn-outline') . '" href="' . site_url('home/edit_course/' . $course_id) . '">' . get_phrase('edit_course') . '</a>'
    . '<a class="btn ' . ($type === 'manage_section' ? 'btn-primary' : 'btn-outline') . '" href="' . site_url('home/edit_course/' . $course_id . '/manage_section') . '">' . get_phrase('manage_section') . '</a>'
    . '<a class="btn ' . ($type === 'manage_lesson' ? 'btn-primary' : 'btn-outline') . '" href="' . site_url('home/edit_course/' . $course_id . '/manage_lesson') . '">' . get_phrase('manage_lesson') . '</a>'
    . '<a class="btn btn-quiet" href="' . site_url('home/dashboard') . '">' . get_phrase('instructor_dashboard') . '</a>'
    . '</div>';

ob_start();
echo $nav;

if (empty($course)) {
    echo '<p>' . get_phrase('no_data_found') . '</p>';
} elseif ($type === 'manage_section') {
    $sections = $this->crud_model->get_section('course', $course_id)->result_array();
    $rows     = [];
    foreach ($sections as $section) {
        $rows[] = [
            html_escape($section['title']),
            '<a href="javascript:void(0)" onclick="confirm_modal(\'' . site_url('home/sections/delete/' . $course_id . '/' . $section['id']) . '\')">' . get_phrase('delete') . '</a>',
        ];
    }
    echo gp_ds_table([
        'headers' => [get_phrase('title'), get_phrase('delete')],
        'rows'    => $rows,
        'empty'   => get_phrase('no_data_found'),
    ], true);
    echo '<p class="mt-3"><a href="' . site_url('user/course_form/course_edit/' . $course_id) . '">' . get_phrase('edit_course') . '</a></p>';
} elseif ($type === 'manage_lesson') {
    $lessons = $this->crud_model->get_lessons('course', $course_id)->result_array();
    $rows    = [];
    foreach ($lessons as $lesson) {
        $rows[] = [
            html_escape($lesson['title']),
            html_escape($lesson['lesson_type']),
            '<a href="' . site_url('home/lesson_editing_form/' . $lesson['id'] . '/' . $course_id) . '">' . get_phrase('update_lesson') . '</a>',
            '<a href="javascript:void(0)" onclick="confirm_modal(\'' . site_url('home/manage_lessons/delete/' . $course_id . '/' . $lesson['id']) . '\')">' . get_phrase('delete') . '</a>',
        ];
    }
    echo gp_ds_table([
        'headers' => [get_phrase('title'), get_phrase('lesson_type'), get_phrase('update_lesson'), get_phrase('delete')],
        'rows'    => $rows,
        'empty'   => get_phrase('no_data_found'),
    ], true);
} else {
    ?>
    <form action="<?php echo site_url('home/course_action/edit/' . $course_id); ?>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="course_type" value="<?php echo html_escape($course['course_type']); ?>">

        <div class="mb-4">
            <label class="mb-2" for="title"><?php echo get_phrase('course_title'); ?> <span class="required">*</span></label>
            <input class="form-control" id="title" type="text" name="title" value="<?php echo html_escape($course['title']); ?>" required>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="short_description"><?php echo get_phrase('short_description'); ?></label>
            <textarea class="form-control" id="short_description" name="short_description" rows="3"><?php echo html_escape($course['short_description']); ?></textarea>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="description"><?php echo get_phrase('description'); ?></label>
            <textarea class="form-control" id="description" name="description" rows="5"><?php echo htmlspecialchars_decode_($course['description']); ?></textarea>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="sub_category_id"><?php echo get_phrase('category'); ?> <span class="required">*</span></label>
            <select class="form-control" name="sub_category_id" id="sub_category_id" required>
                <option value=""><?php echo get_phrase('select_a_category'); ?></option>
                <?php foreach ($categories->result_array() as $category): ?>
                    <optgroup label="<?php echo html_escape($category['name']); ?>">
                        <?php foreach ($this->crud_model->get_sub_categories($category['id']) as $sub_category): ?>
                            <option value="<?php echo (int) $sub_category['id']; ?>" <?php if ((int) $course['sub_category_id'] === (int) $sub_category['id']) {
                                echo 'selected';
                            } ?>><?php echo html_escape($sub_category['name']); ?></option>
                        <?php endforeach; ?>
                    </optgroup>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="level"><?php echo get_phrase('level'); ?></label>
            <select class="form-control" name="level" id="level">
                <?php foreach (['beginner', 'advanced', 'intermediate'] as $level): ?>
                    <option value="<?php echo $level; ?>" <?php if ($course['level'] === $level) {
                        echo 'selected';
                    } ?>><?php echo get_phrase($level); ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="language_made_in"><?php echo get_phrase('language_made_in'); ?></label>
            <select class="form-control" name="language_made_in" id="language_made_in">
                <?php foreach ($languages as $language): ?>
                    <option value="<?php echo html_escape($language); ?>" <?php if ($course['language'] === $language) {
                        echo 'selected';
                    } ?>><?php echo html_escape(ucfirst($language)); ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="price"><?php echo get_phrase('price'); ?></label>
            <input class="form-control" type="number" name="price" id="price" min="0" value="<?php echo html_escape($course['price']); ?>">
        </div>

        <div class="mb-4">
            <label class="mb-2">
                <input type="checkbox" name="is_free_course" value="1" id="is_free_course" <?php if (! empty($course['is_free_course'])) {
                    echo 'checked';
                } ?>>
                <?php echo get_phrase('is_free_course'); ?>
            </label>
        </div>

        <div class="mb-4">
            <label class="mb-2">
                <input type="checkbox" name="enable_drip_content" value="1" id="enable_drip_content" <?php if (! empty($course['enable_drip_content'])) {
                    echo 'checked';
                } ?>>
                <?php echo get_phrase('enable_drip_content'); ?>
            </label>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="course_overview_provider"><?php echo get_phrase('course_overview_provider'); ?></label>
            <select class="form-control" name="course_overview_provider" id="course_overview_provider">
                <?php foreach (['youtube', 'vimeo', 'html5'] as $provider): ?>
                    <option value="<?php echo $provider; ?>" <?php if ($course['course_overview_provider'] === $provider) {
                        echo 'selected';
                    } ?>><?php echo get_phrase($provider === 'html5' ? 'HTML5' : $provider); ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="course_overview_url"><?php echo get_phrase('course_overview_url'); ?></label>
            <input class="form-control" type="text" name="course_overview_url" id="course_overview_url" value="<?php echo html_escape($course['video_url']); ?>">
        </div>

        <div class="mb-4">
            <label class="mb-2" for="meta_keywords"><?php echo get_phrase('meta_keywords'); ?></label>
            <input class="form-control" type="text" name="meta_keywords" id="meta_keywords" value="<?php echo html_escape($course['meta_keywords']); ?>">
        </div>

        <div class="mb-4">
            <label class="mb-2" for="meta_description"><?php echo get_phrase('meta_description'); ?></label>
            <textarea class="form-control" name="meta_description" id="meta_description" rows="3"><?php echo html_escape($course['meta_description']); ?></textarea>
        </div>

        <?php
        $existing_outcomes = json_decode($course['outcomes'], true);
        if (is_array($existing_outcomes) && count($existing_outcomes) > 0) {
            foreach ($existing_outcomes as $outcome) {
                echo '<input type="hidden" name="outcomes[]" value="' . html_escape($outcome) . '">';
            }
        } else {
            echo '<input type="hidden" name="outcomes[]" value="">';
        }
        $existing_requirements = json_decode($course['requirements'], true);
        if (is_array($existing_requirements) && count($existing_requirements) > 0) {
            foreach ($existing_requirements as $requirement) {
                echo '<input type="hidden" name="requirements[]" value="' . html_escape($requirement) . '">';
            }
        } else {
            echo '<input type="hidden" name="requirements[]" value="">';
        }
        ?>
        <input type="file" name="upcoming_image_thumbnail" class="d-none">
        <?php if (! empty($course['upcoming_image_thumbnail'])): ?>
            <input type="hidden" name="old_upcoming_image_thumbnail" value="<?php echo html_escape($course['upcoming_image_thumbnail']); ?>">
        <?php endif; ?>

        <?php if (is_array($course_media_files)): ?>
            <?php foreach ($course_media_files as $course_media => $size): ?>
                <div class="mb-4">
                    <label class="mb-2" for="<?php echo html_escape($course_media); ?>"><?php echo get_phrase($course_media); ?> <small>(<?php echo html_escape($size); ?>)</small></label>
                    <input class="form-control" type="file" name="<?php echo html_escape($course_media); ?>" id="<?php echo html_escape($course_media); ?>" accept="image/*">
                </div>
            <?php endforeach; ?>
        <?php endif; ?>

        <div class="mb-4 d-flex gap-2 flex-wrap">
            <button type="submit" name="publish" value="1" class="btn btn-primary"><?php echo get_phrase('submit'); ?></button>
            <button type="submit" class="btn btn-outline"><?php echo get_phrase('save_to_draft'); ?></button>
        </div>
    </form>
    <?php
}

$body = ob_get_clean();
?>

<section class="wish-list-body message">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-4">
                <?php include 'profile_menus.php'; ?>
            </div>
            <div class="col-lg-9 col-md-8">
                <?php gp_ds_card(['title' => html_escape(! empty($course['title']) ? $course['title'] : get_phrase('edit_course')), 'body' => $body]); ?>
            </div>
        </div>
    </div>
</section>
