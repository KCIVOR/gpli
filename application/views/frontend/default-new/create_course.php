<?php
$user_details = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array();
$categories   = $this->crud_model->get_categories();
$languages    = $this->crud_model->get_all_languages();
$course_media_files = themeConfiguration(get_frontend_settings('theme'), 'course_media_files');
include 'breadcrumb.php';

ob_start();
?>
<form action="<?php echo site_url('home/course_action/create'); ?>" method="post" enctype="multipart/form-data">
    <input type="hidden" name="course_type" value="general">

    <div class="mb-4">
        <label class="mb-2" for="title"><?php echo get_phrase('course_title'); ?> <span class="required">*</span></label>
        <input class="form-control" id="title" type="text" name="title" required>
    </div>

    <div class="mb-4">
        <label class="mb-2" for="short_description"><?php echo get_phrase('short_description'); ?></label>
        <textarea class="form-control" id="short_description" name="short_description" rows="3"></textarea>
    </div>

    <div class="mb-4">
        <label class="mb-2" for="description"><?php echo get_phrase('description'); ?></label>
        <textarea class="form-control" id="description" name="description" rows="5"></textarea>
    </div>

    <div class="mb-4">
        <label class="mb-2" for="sub_category_id"><?php echo get_phrase('category'); ?> <span class="required">*</span></label>
        <select class="form-control" name="sub_category_id" id="sub_category_id" required>
            <option value=""><?php echo get_phrase('select_a_category'); ?></option>
            <?php foreach ($categories->result_array() as $category): ?>
                <optgroup label="<?php echo html_escape($category['name']); ?>">
                    <?php foreach ($this->crud_model->get_sub_categories($category['id']) as $sub_category): ?>
                        <option value="<?php echo (int) $sub_category['id']; ?>"><?php echo html_escape($sub_category['name']); ?></option>
                    <?php endforeach; ?>
                </optgroup>
            <?php endforeach; ?>
        </select>
    </div>

    <div class="mb-4">
        <label class="mb-2" for="level"><?php echo get_phrase('level'); ?></label>
        <select class="form-control" name="level" id="level">
            <option value="beginner"><?php echo get_phrase('beginner'); ?></option>
            <option value="advanced"><?php echo get_phrase('advanced'); ?></option>
            <option value="intermediate"><?php echo get_phrase('intermediate'); ?></option>
        </select>
    </div>

    <div class="mb-4">
        <label class="mb-2" for="language_made_in"><?php echo get_phrase('language_made_in'); ?></label>
        <select class="form-control" name="language_made_in" id="language_made_in">
            <?php foreach ($languages as $language): ?>
                <option value="<?php echo html_escape($language); ?>"><?php echo html_escape(ucfirst($language)); ?></option>
            <?php endforeach; ?>
        </select>
    </div>

    <div class="mb-4">
        <label class="mb-2" for="price"><?php echo get_phrase('price'); ?></label>
        <input class="form-control" type="number" name="price" id="price" min="0" value="0">
    </div>

    <div class="mb-4">
        <label class="mb-2">
            <input type="checkbox" name="is_free_course" value="1" id="is_free_course">
            <?php echo get_phrase('is_free_course'); ?>
        </label>
    </div>

    <div class="mb-4">
        <label class="mb-2">
            <input type="checkbox" name="enable_drip_content" value="1" id="enable_drip_content">
            <?php echo get_phrase('enable_drip_content'); ?>
        </label>
    </div>

    <div class="mb-4">
        <label class="mb-2" for="course_overview_provider"><?php echo get_phrase('course_overview_provider'); ?></label>
        <select class="form-control" name="course_overview_provider" id="course_overview_provider">
            <option value="youtube"><?php echo get_phrase('youtube'); ?></option>
            <option value="vimeo"><?php echo get_phrase('vimeo'); ?></option>
            <option value="html5"><?php echo get_phrase('HTML5'); ?></option>
        </select>
    </div>

    <div class="mb-4">
        <label class="mb-2" for="course_overview_url"><?php echo get_phrase('course_overview_url'); ?></label>
        <input class="form-control" type="text" name="course_overview_url" id="course_overview_url">
    </div>

    <div class="mb-4">
        <label class="mb-2" for="meta_keywords"><?php echo get_phrase('meta_keywords'); ?></label>
        <input class="form-control" type="text" name="meta_keywords" id="meta_keywords">
    </div>

    <div class="mb-4">
        <label class="mb-2" for="meta_description"><?php echo get_phrase('meta_description'); ?></label>
        <textarea class="form-control" name="meta_description" id="meta_description" rows="3"></textarea>
    </div>

    <input type="hidden" name="outcomes[]" value="">
    <input type="hidden" name="requirements[]" value="">
    <input type="file" name="upcoming_image_thumbnail" class="d-none">

    <?php if (is_array($course_media_files)): ?>
        <?php foreach ($course_media_files as $course_media => $size): ?>
            <div class="mb-4">
                <label class="mb-2" for="<?php echo html_escape($course_media); ?>"><?php echo get_phrase($course_media); ?> <small>(<?php echo html_escape($size); ?>)</small></label>
                <input class="form-control" type="file" name="<?php echo html_escape($course_media); ?>" id="<?php echo html_escape($course_media); ?>" accept="image/*">
            </div>
        <?php endforeach; ?>
    <?php endif; ?>

    <div class="mb-4 d-flex gap-2 flex-wrap">
        <button type="submit" name="create_course" value="1" class="btn btn-primary"><?php echo get_phrase('submit'); ?></button>
        <button type="submit" class="btn btn-outline"><?php echo get_phrase('save_to_draft'); ?></button>
        <a href="<?php echo site_url('home/dashboard'); ?>" class="btn btn-quiet"><?php echo get_phrase('back'); ?></a>
    </div>
</form>
<?php
$form = ob_get_clean();
?>

<section class="wish-list-body message">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-4">
                <?php include 'profile_menus.php'; ?>
            </div>
            <div class="col-lg-9 col-md-8">
                <?php gp_ds_card(['title' => get_phrase('create_course'), 'body' => $form]); ?>
            </div>
        </div>
    </div>
</section>
