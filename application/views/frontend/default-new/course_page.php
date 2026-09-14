<?php
$course_details = $this->crud_model->get_course_by_id($course_id)->row_array();
$lessons = $this->crud_model->get_lessons('course', $course_details['id']);
$instructor_details = $this->user_model->get_all_user($course_details['creator'])->row_array();
$course_duration = $this->crud_model->get_total_duration_of_lesson_by_course_id($course_details['id']);
$number_of_enrolments = $this->crud_model->enrol_history($course_details['id'])->num_rows();
$total_rating =  $this->crud_model->get_ratings('course', $course_details['id'], true)->row()->rating;
$number_of_ratings = $this->crud_model->get_ratings('course', $course_details['id'])->num_rows();
if ($number_of_ratings > 0) {
    $average_ceil_rating = ceil($total_rating / $number_of_ratings);
} else {
    $average_ceil_rating = 0;
}
$cart_items = $this->session->userdata('cart_items');
if (! is_array($cart_items)) {
    $cart_items = [];
}
$lecture_count = $this->db->get_where('lesson', ['course_id' => $course_details['id'], 'lesson_type !=' => 'quiz'])->num_rows();
$number_of_quiz = $this->db->get_where('lesson', ['course_id' => $course_details['id'], 'lesson_type' => 'quiz'])->num_rows();
?>

<div class="gp-course-page">
<section class="gp-course-hero">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<?php echo site_url(); ?>"><?php echo site_phrase('Home'); ?></a></li>
                <li class="breadcrumb-item"><a href="<?php echo site_url('home/courses'); ?>"><?php echo site_phrase('Courses'); ?></a></li>
                <li class="breadcrumb-item active" aria-current="page"><?php echo site_phrase('Details'); ?></li>
            </ol>
        </nav>

        <h1><?php echo $course_details['title']; ?></h1>
        <p class="gp-course-lead"><?php echo $course_details['short_description']; ?></p>

        <div class="gp-course-meta">
            <div class="gp-course-meta-item">
                <img loading="lazy" src="<?php echo $this->user_model->get_user_image_url($instructor_details['id']); ?>" alt="">
                <span><?php echo get_phrase('Created By'); ?></span>
                <a href="<?php echo site_url('home/instructor_page/' . $course_details['creator']); ?>"><?php echo $instructor_details['first_name'] . ' ' . $instructor_details['last_name']; ?></a>
            </div>
            <div class="gp-course-meta-item">
                <span class="gp-course-stars">
                    <?php for ($i = 1; $i < 6; $i++) : ?>
                        <i class="fa-solid fa-star<?php echo ($i <= $average_ceil_rating) ? ' is-on' : ''; ?>"></i>
                    <?php endfor; ?>
                </span>
                <span>(<?php echo $number_of_ratings . ' ' . get_phrase('Reviews'); ?>)</span>
            </div>
            <?php if ($course_duration) : ?>
                <div class="gp-course-meta-item">
                    <i class="fa-regular fa-clock"></i>
                    <span><?php echo $course_duration; ?></span>
                </div>
            <?php endif; ?>
            <div class="gp-course-meta-item">
                <i class="fa-solid fa-users"></i>
                <span><?php echo $number_of_enrolments; ?> <?php echo get_phrase('Enrolled'); ?></span>
            </div>
            <div class="gp-course-meta-item">
                <i class="fa-solid fa-language"></i>
                <span><?php echo ucfirst($course_details['language']); ?></span>
            </div>
            <div class="gp-course-meta-item">
                <i class="fa-regular fa-calendar"></i>
                <span><?php echo get_phrase('Last Updated'); ?></span>
                <span>
                    <?php if ($course_details['last_modified'] > 0) : ?>
                        <?php echo date('D, d-M-Y', $course_details['last_modified']); ?>
                    <?php else : ?>
                        <?php echo date('D, d-M-Y', $course_details['date_added']); ?>
                    <?php endif; ?>
                </span>
            </div>
        </div>
    </div>
</section>

<section class="gp-course-body">
    <div class="container">
        <div class="gp-course-layout">
            <div class="gp-course-main">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="course-overview-tab" data-bs-toggle="tab" data-bs-target="#course-overview" type="button" role="tab" aria-controls="course-overview" aria-selected="true"><?php echo get_phrase('Overview'); ?></button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="curriculum-tab" data-bs-toggle="tab" data-bs-target="#curriculum" type="button" role="tab" aria-controls="curriculum" aria-selected="false"><?php echo get_phrase('Curriculum'); ?></button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="instructor-tab" data-bs-toggle="tab" data-bs-target="#instructor" type="button" role="tab" aria-controls="contact" aria-selected="false"><?php echo get_phrase('Instructor'); ?></button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button" role="tab" aria-controls="reviews" aria-selected="false"><?php echo get_phrase('Reviews'); ?></button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="additional-info-tab" data-bs-toggle="tab" data-bs-target="#additional-info" type="button" role="tab" aria-controls="additional-info" aria-selected="false"><?php echo get_phrase('Additional Info'); ?></button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="course-overview" role="tabpanel" aria-labelledby="course-overview-tab">
                        <?php include "course_page_info_description.php"; ?>
                    </div>
                    <div class="tab-pane fade" id="curriculum" role="tabpanel" aria-labelledby="curriculum-tab">
                        <?php include "course_page_curriculum.php"; ?>
                    </div>
                    <div class="tab-pane fade" id="instructor" role="tabpanel" aria-labelledby="instructor-tab">
                        <?php include "course_page_instructor.php"; ?>
                    </div>
                    <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                        <div class="reviews">
                            <?php include "course_page_reviews.php"; ?>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="additional-info" role="tabpanel" aria-labelledby="additional-info-tab">
                        <div class="additional-info">
                            <?php include "course_page_custom_field_info.php"; ?>
                        </div>
                    </div>
                </div>
            </div>

            <aside class="gp-course-aside">
                <div class="gp-course-buy">
                    <div class="gp-course-media">
                        <div class="gp-course-play" onclick="lesson_preview('<?php echo site_url('home/course_preview/' . $course_details['id']); ?>', '<?php echo get_phrase($course_details['title']) ?>')">
                            <i class="fa-solid fa-play"></i>
                        </div>
                        <img loading="lazy" src="<?php echo $this->crud_model->get_course_thumbnail_url($course_details['id']); ?>" alt="">
                        <div class="courses-icon <?php if (in_array($course_details['id'], $my_wishlist_items)) echo 'red-heart'; ?>" id="coursesWishlistIcon<?php echo $course_details['id']; ?>">
                            <i class="fa-solid fa-heart cursor-pointer checkPropagation" onclick="actionTo('<?php echo site_url('home/toggleWishlistItems/' . $course_details['id']); ?>')"></i>
                        </div>
                    </div>

                    <div class="gp-course-buy-body">
                        <div class="gp-course-price">
                            <?php if ($course_details['is_free_course']) : ?>
                                <strong><?php echo get_phrase('Free'); ?></strong>
                            <?php elseif ($course_details['discount_flag']) : ?>
                                <strong><?php echo currency($course_details['discounted_price']); ?></strong>
                                <del><?php echo currency($course_details['price']); ?></del>
                            <?php else : ?>
                                <strong><?php echo currency($course_details['price']); ?></strong>
                            <?php endif; ?>
                            <a href="<?php echo base_url('home/compare?course-1=' . slugify($course_details['title']) . '&course-id-1=' . $course_details['id']); ?>" title="<?php echo get_phrase('Compare this course'); ?>" data-bs-toggle="tooltip" class="icon-btn ms-auto">
                                <i class="fa-solid fa-right-left"></i>
                            </a>
                        </div>

                        <div class="gp-course-facts">
                            <div class="gp-course-fact">
                                <span><?php echo get_phrase('Lectures'); ?></span>
                                <strong><?php echo $lecture_count; ?></strong>
                            </div>
                            <?php if ($number_of_quiz > 0) : ?>
                                <div class="gp-course-fact">
                                    <span><?php echo get_phrase('Quizzes'); ?></span>
                                    <strong><?php echo $number_of_quiz; ?></strong>
                                </div>
                            <?php endif; ?>
                            <?php if ($course_details['status'] == 'upcoming'): ?>
                                <div class="gp-course-fact">
                                    <span><?php echo get_phrase('Category'); ?></span>
                                    <strong><?php echo $this->db->where('id', $course_details['sub_category_id'])->get('category')->row('name'); ?></strong>
                                </div>
                                <?php if ($course_details['publish_date']): ?>
                                    <div class="gp-course-fact">
                                        <span><?php echo get_phrase('Publish Date'); ?></span>
                                        <strong><?php echo date('j F Y', strtotime($course_details['publish_date'])); ?></strong>
                                    </div>
                                <?php endif; ?>
                            <?php else: ?>
                                <div class="gp-course-fact">
                                    <span><?php echo get_phrase('Skill level'); ?></span>
                                    <strong><?php echo get_phrase($course_details['level']); ?></strong>
                                </div>
                            <?php endif; ?>
                            <div class="gp-course-fact">
                                <span><?php echo get_phrase('Expiry period'); ?></span>
                                <strong>
                                    <?php if ($course_details['expiry_period'] <= 0) : ?>
                                        <?php echo get_phrase('Lifetime'); ?>
                                    <?php else : ?>
                                        <?php echo $course_details['expiry_period'] . ' ' . get_phrase('Months'); ?>
                                    <?php endif; ?>
                                </strong>
                            </div>
                            <?php if (addon_status('certificate')) : ?>
                                <div class="gp-course-fact">
                                    <span><?php echo get_phrase('Certificate'); ?></span>
                                    <strong><?php echo get_phrase('Yes'); ?></strong>
                                </div>
                            <?php endif; ?>
                        </div>

                        <div class="gp-course-actions">
                            <?php if (is_purchased($course_details['id'])) : ?>
                                <?php gp_ds_button(get_phrase('Start Now'), [
                                    'href' => site_url('home/lesson/' . slugify($course_details['title']) . '/' . $course_details['id']),
                                ]); ?>
                                <?php if ($course_details['is_free_course'] != 1) : ?>
                                    <?php gp_ds_button(get_phrase('Gift someone else'), [
                                        'href' => '#',
                                        'variant' => 'outline',
                                        'attrs' => [
                                            'onclick' => "actionTo('" . site_url('home/handle_buy_now/' . $course_details['id'] . '?gift=1') . "')",
                                        ],
                                    ]); ?>
                                <?php endif; ?>
                            <?php else : ?>
                                <?php if ($course_details['is_free_course'] == 1) : ?>
                                    <?php gp_ds_button(get_phrase('Enroll Now'), [
                                        'href' => site_url('home/get_enrolled_to_free_course/' . $course_details['id']),
                                    ]); ?>
                                <?php else : ?>
                                    <?php gp_ds_button(get_phrase('Remove from cart'), [
                                        'href' => '#',
                                        'variant' => 'outline',
                                        'extra_class' => (! in_array($course_details['id'], $cart_items) ? 'd-hidden ' : '') . 'active',
                                        'attrs' => [
                                            'id' => 'added_to_cart_btn_' . $course_details['id'],
                                            'onclick' => "actionTo('" . site_url('home/handle_cart_items/' . $course_details['id']) . "')",
                                        ],
                                    ]); ?>
                                    <?php gp_ds_button(get_phrase('Add to cart'), [
                                        'href' => '#',
                                        'extra_class' => in_array($course_details['id'], $cart_items) ? 'd-hidden' : '',
                                        'attrs' => [
                                            'id' => 'add_to_cart_btn_' . $course_details['id'],
                                            'onclick' => "actionTo('" . site_url('home/handle_cart_items/' . $course_details['id']) . "')",
                                        ],
                                    ]); ?>
                                    <?php gp_ds_button(get_phrase('Buy Now'), [
                                        'href' => '#',
                                        'variant' => 'secondary',
                                        'attrs' => [
                                            'onclick' => "actionTo('" . site_url('home/handle_buy_now/' . $course_details['id']) . "')",
                                        ],
                                    ]); ?>
                                <?php endif; ?>
                            <?php endif; ?>

                            <?php if (addon_status('affiliate_course')) :
                                $CI    = &get_instance();
                                $CI->load->model('addons/affiliate_course_model');
                                $is_affiliattor = $CI->affiliate_course_model->is_affilator($this->session->userdata('user_id'));
                                if ($is_affiliattor == 1) :
                                    $user_data = $CI->affiliate_course_model->get__affiliator_status_table_info_by_user_id($this->session->userdata('user_id'));
                            ?>
                                    <?php gp_ds_button(site_phrase('Share and Earn'), [
                                        'href' => '#myModel',
                                        'variant' => 'quiet',
                                        'attrs' => [
                                            'id' => 'shareBtn',
                                            'data-bs-toggle' => 'modal',
                                            'data-bs-target' => '#myModel',
                                            'data-bs-placement' => 'top',
                                        ],
                                    ]); ?>
                                <?php endif; ?>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>

                <?php
                if (isset($user_data['unique_identifier'])) :
                    $ref = $user_data['unique_identifier'];
                else :
                    $ref = '';
                endif;
                $share_url = site_url('home/course/' . slugify($course_details['title']) . '/' . $course_details['id']);
                ?>
                <div class="gp-course-share">
                    <p><?php echo site_phrase('Share this course'); ?></p>
                    <a href="https://www.facebook.com/sharer/sharer.php?u=<?php echo $share_url; ?>&ref=<?php echo $ref; ?>" target="_blank" data-bs-toggle="tooltip" title="<?php echo get_phrase('Share on Facebook'); ?>" data-bs-placement="top">
                        <i class="fa-brands fa-facebook-f"></i>
                    </a>
                    <a href="https://twitter.com/intent/tweet?url=<?php echo $share_url; ?>&text=<?php echo $course_details['title']; ?>&ref=<?php echo $ref; ?>" target="_blank" data-bs-toggle="tooltip" title="<?php echo get_phrase('Share on Twitter'); ?>" data-bs-placement="top">
                        <i class="fa-brands fa-x-twitter"></i>
                    </a>
                    <a href="https://api.whatsapp.com/send?text=<?php echo $share_url; ?>&ref=<?php echo $ref; ?>" target="_blank" data-bs-toggle="tooltip" title="<?php echo get_phrase('Share on Whatsapp'); ?>" data-bs-placement="top">
                        <i class="fab fa-whatsapp"></i>
                    </a>
                    <a href="https://www.linkedin.com/shareArticle?url=<?php echo $share_url; ?>&title=<?php echo $course_details['title']; ?>&summary=<?php echo $course_details['short_description']; ?>&ref=<?php echo $ref; ?>" target="_blank" data-bs-toggle="tooltip" title="<?php echo get_phrase('Share on Linkedin'); ?>" data-bs-placement="top">
                        <i class="fa-brands fa-linkedin-in"></i>
                    </a>
                </div>
            </aside>
        </div>
    </div>
</section>

<section class="gp-course-related">
    <div class="container">
        <h2 class="gp-course-related-title"><?php echo get_phrase('Related Courses'); ?></h2>
        <div class="gp-related-grid">
            <?php $related_courses = $this->crud_model->get_related_courses($course_details['category_id'], $course_details['sub_category_id'], $course_details['id'], 12)->result_array(); ?>
            <?php foreach ($related_courses as $key => $course) :
                $course_duration = $this->crud_model->get_total_duration_of_lesson_by_course_id($course['id']);
                $total_rating =  $this->crud_model->get_ratings('course', $course['id'], true)->row()->rating;
                $number_of_ratings = $this->crud_model->get_ratings('course', $course['id'])->num_rows();
                if ($number_of_ratings > 0) {
                    $average_ceil_rating = ceil($total_rating / $number_of_ratings);
                } else {
                    $average_ceil_rating = 0;
                }
            ?>
                <a href="<?php echo site_url('home/course/' . rawurlencode(slugify($course['title'])) . '/' . $course['id']); ?>" class="gp-related-card checkPropagation">
                    <div class="gp-related-card-media">
                        <img loading="lazy" src="<?php echo $this->crud_model->get_course_thumbnail_url($course['id']); ?>" alt="">
                        <div class="courses-icon <?php if (in_array($course['id'], $my_wishlist_items)) echo 'red-heart'; ?>" id="coursesWishlistIcon<?php echo $course['id']; ?>">
                            <i class="fa-solid fa-heart checkPropagation" onclick="actionTo('<?php echo site_url('home/toggleWishlistItems/' . $course['id']); ?>')"></i>
                        </div>
                        <div class="gp-related-level">
                            <?php gp_ds_badge(get_phrase($course['level']), 'primary'); ?>
                        </div>
                    </div>
                    <div class="gp-related-card-body">
                        <h3 class="gp-related-card-title"><?php echo $course['title']; ?></h3>
                        <div class="gp-related-card-meta">
                            <span class="gp-related-card-rating">
                                <i class="fa-solid fa-star<?php echo ($number_of_ratings > 0) ? ' is-on' : ''; ?>"></i>
                                <?php echo $average_ceil_rating; ?>
                                <span>(<?php echo $number_of_ratings; ?> <?php echo get_phrase('Reviews'); ?>)</span>
                            </span>
                            <span data-bs-toggle="tooltip" data-bs-title="<?php echo site_phrase('Compare'); ?>" class="icon-btn checkPropagation" onclick="redirectTo('<?php echo base_url('home/compare?course-1=' . slugify($course['title']) . '&course-id-1=' . $course['id']); ?>');">
                                <i class="fa-solid fa-right-left"></i>
                            </span>
                        </div>
                        <?php if ($course_duration): ?>
                            <p class="gp-related-card-duration"><i class="fa-regular fa-clock"></i> <?php echo $course_duration; ?></p>
                        <?php endif; ?>
                        <div class="gp-related-card-foot">
                            <div class="gp-related-card-price">
                                <?php if ($course['is_free_course']) : ?>
                                    <strong><?php echo get_phrase('Free'); ?></strong>
                                <?php elseif ($course['discount_flag']) : ?>
                                    <strong><?php echo currency($course['discounted_price']); ?></strong>
                                    <del><?php echo currency($course['price']); ?></del>
                                <?php else : ?>
                                    <strong><?php echo currency($course['price']); ?></strong>
                                <?php endif; ?>
                            </div>
                            <?php if (is_purchased($course['id'])): ?>
                                <span class="btn btn-primary checkPropagation" onclick="redirectTo('<?php echo site_url('home/lesson/'.slugify($course['title']).'/'.$course['id']) ?>');"><?php echo get_phrase('Start Now'); ?></span>
                            <?php else: ?>
                                <span class="btn btn-primary"><?php echo site_phrase('Enroll Now'); ?></span>
                            <?php endif; ?>
                        </div>
                    </div>
                </a>
            <?php endforeach; ?>
        </div>
    </div>
</section>
</div>

<?php if (addon_status('affiliate_course') && isset($is_affiliattor) && $is_affiliattor == 1) : ?>
    <?php include 'affiliate_course_modal.php'; ?>
<?php endif; ?>

<?php if (addon_status('team_training')) : ?>
    <?php include 'course_related_packages.php'; ?>
<?php endif; ?>
