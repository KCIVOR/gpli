<?php
$user_details   = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array();
$lesson_id      = isset($lesson_id) ? $lesson_id : '';
$course_id      = isset($course_id) ? $course_id : '';
$lesson_details = $this->crud_model->get_lessons('lesson', $lesson_id)->row_array();
$sections       = $this->crud_model->get_section('course', $course_id)->result_array();
include 'breadcrumb.php';

$video_type      = isset($lesson_details['video_type']) ? strtolower($lesson_details['video_type']) : '';
$lesson_type     = isset($lesson_details['lesson_type']) ? $lesson_details['lesson_type'] : '';
$attachment_type = isset($lesson_details['attachment_type']) ? strtolower($lesson_details['attachment_type']) : '';

if ($lesson_type === 'video' && $video_type === 'system') {
    $posted_lesson_type = 'system-video';
} elseif ($lesson_type === 'audio') {
    $posted_lesson_type = 'system-audio';
} elseif ($lesson_type === 'text') {
    $posted_lesson_type = 'text-description';
} elseif ($lesson_type === 'other' && $attachment_type === 'iframe') {
    $posted_lesson_type = 'other-iframe';
} elseif ($lesson_type === 'other' && $attachment_type === 'img') {
    $posted_lesson_type = 'other-img';
} elseif ($lesson_type === 'wasabi') {
    $posted_lesson_type = 'wasabi-video';
} elseif ($lesson_type === 'video') {
    $posted_lesson_type = 'video-url';
} else {
    $posted_lesson_type = $lesson_type . '-' . $attachment_type;
}

ob_start();
if (empty($lesson_details)) {
    echo '<p>' . get_phrase('no_data_found') . '</p>';
} else {
    ?>
    <p class="mb-3">
        <a href="<?php echo site_url('home/edit_course/' . $course_id . '/manage_lesson'); ?>"><?php echo get_phrase('manage_lesson'); ?></a>
    </p>
    <form action="<?php echo site_url('home/manage_lessons/edit/' . $course_id . '/' . $lesson_id); ?>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="course_id" value="<?php echo html_escape($course_id); ?>">
        <input type="hidden" name="lesson_type" value="<?php echo html_escape($posted_lesson_type); ?>">

        <div class="mb-4">
            <label class="mb-2" for="title"><?php echo get_phrase('title'); ?></label>
            <input class="form-control" type="text" name="title" id="title" value="<?php echo html_escape($lesson_details['title']); ?>" required>
        </div>

        <div class="mb-4">
            <label class="mb-2" for="section_id"><?php echo get_phrase('section'); ?></label>
            <select class="form-control" name="section_id" id="section_id" required>
                <?php foreach ($sections as $section): ?>
                    <option value="<?php echo (int) $section['id']; ?>" <?php if ((int) $lesson_details['section_id'] === (int) $section['id']) {
                        echo 'selected';
                    } ?>><?php echo html_escape($section['title']); ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <?php if ($lesson_type === 'video' && in_array($video_type, ['youtube', 'vimeo'], true)): ?>
            <input type="hidden" name="lesson_provider" value="<?php echo html_escape($video_type); ?>">
            <div class="mb-4">
                <label class="mb-2" for="video_url"><?php echo get_phrase('video_url'); ?></label>
                <input class="form-control" type="text" name="video_url" id="video_url" value="<?php echo html_escape($lesson_details['video_url']); ?>">
            </div>
            <div class="mb-4">
                <label class="mb-2" for="duration"><?php echo get_phrase('duration'); ?></label>
                <input class="form-control" type="text" name="duration" id="duration" value="<?php echo html_escape($lesson_details['duration']); ?>">
            </div>
        <?php elseif ($lesson_type === 'video' && $video_type === 'html5'): ?>
            <input type="hidden" name="lesson_provider" value="html5">
            <div class="mb-4">
                <label class="mb-2" for="html5_video_url"><?php echo get_phrase('video_url'); ?></label>
                <input class="form-control" type="text" name="html5_video_url" id="html5_video_url" value="<?php echo html_escape($lesson_details['video_url']); ?>">
            </div>
            <div class="mb-4">
                <label class="mb-2" for="html5_duration"><?php echo get_phrase('duration'); ?></label>
                <input class="form-control" type="text" name="html5_duration" id="html5_duration" value="<?php echo html_escape($lesson_details['duration']); ?>">
            </div>
        <?php elseif ($lesson_type === 'video' && $video_type === 'google_drive'): ?>
            <input type="hidden" name="lesson_provider" value="google_drive">
            <div class="mb-4">
                <label class="mb-2" for="google_drive_video_url"><?php echo get_phrase('video_url'); ?></label>
                <input class="form-control" type="text" name="google_drive_video_url" id="google_drive_video_url" value="<?php echo html_escape($lesson_details['video_url']); ?>">
            </div>
            <div class="mb-4">
                <label class="mb-2" for="google_drive_video_duration"><?php echo get_phrase('duration'); ?></label>
                <input class="form-control" type="text" name="google_drive_video_duration" id="google_drive_video_duration" value="<?php echo html_escape($lesson_details['duration']); ?>">
            </div>
        <?php elseif ($lesson_type === 'text'): ?>
            <div class="mb-4">
                <label class="mb-2" for="text_description"><?php echo get_phrase('enter_your_text'); ?></label>
                <textarea class="form-control" name="text_description" id="text_description" rows="4"><?php echo htmlspecialchars_decode_($lesson_details['attachment']); ?></textarea>
            </div>
        <?php elseif ($lesson_type === 'other' && $attachment_type === 'iframe'): ?>
            <div class="mb-4">
                <label class="mb-2" for="iframe_source"><?php echo get_phrase('Iframe code or source URL'); ?></label>
                <input class="form-control" type="text" name="iframe_source" id="iframe_source" value="<?php echo html_escape($lesson_details['attachment']); ?>">
            </div>
        <?php elseif ($lesson_type === 'audio'): ?>
            <div class="mb-4">
                <label class="mb-2" for="system_audio_file_duration"><?php echo get_phrase('duration'); ?></label>
                <input class="form-control" type="text" name="system_audio_file_duration" id="system_audio_file_duration" value="<?php echo html_escape($lesson_details['duration']); ?>">
            </div>
        <?php elseif ($lesson_type === 'wasabi'): ?>
            <div class="mb-4">
                <label class="mb-2" for="wasabi_duration"><?php echo get_phrase('duration'); ?></label>
                <input class="form-control" type="text" name="wasabi_duration" id="wasabi_duration" value="<?php echo html_escape($lesson_details['duration']); ?>">
            </div>
        <?php endif; ?>

        <input type="hidden" name="html5_video_url_for_mobile_application" value="<?php echo html_escape($lesson_details['video_url_for_mobile_application']); ?>">
        <input type="hidden" name="html5_duration_for_mobile_application" value="<?php echo html_escape($lesson_details['duration_for_mobile_application']); ?>">

        <div class="mb-4">
            <label class="mb-2" for="summary"><?php echo get_phrase('summary'); ?></label>
            <textarea class="form-control" name="summary" id="summary" rows="4"><?php echo htmlspecialchars_decode_($lesson_details['summary']); ?></textarea>
        </div>

        <div class="mb-4">
            <label>
                <input type="checkbox" name="free_lesson" id="free_lesson" value="1" <?php if (! empty($lesson_details['is_free'])) {
                    echo 'checked';
                } ?>>
                <?php echo get_phrase('mark_as_free_lesson'); ?>
            </label>
        </div>

        <button class="btn btn-primary" type="submit"><?php echo get_phrase('update_lesson'); ?></button>
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
                <?php gp_ds_card(['title' => get_phrase('update_lesson'), 'body' => $body]); ?>
            </div>
        </div>
    </div>
</section>
