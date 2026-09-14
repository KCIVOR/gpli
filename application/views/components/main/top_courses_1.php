<?php if (! (get_frontend_settings('top_course_section') == 1)) return; ?>
<?php
$user_id = $this->session->userdata('user_id');
if (! isset($my_wishlist_items) && $user_id) {
    $wishlist = $this->user_model->get_all_user($user_id)->row('wishlist');
    $my_wishlist_items = $wishlist != '' ? json_decode($wishlist, true) : [];
} elseif (! isset($my_wishlist_items)) {
    $my_wishlist_items = [];
}
$gp_level_tone = ['beginner' => 'success', 'intermediate' => 'warning', 'advanced' => 'danger'];
?>
<section class="gp-landing gp-landing-top-courses">
    <div class="container">
        <div class="gp-landing-head gp-landing-center">
            <div class="gp-landing-eyebrow">Start Learning Today</div>
            <h2><?php echo site_phrase('top_courses'); ?></h2>
            <p><?php echo site_phrase('These_are_the_most_popular_courses_among_Listen_Courses_learners_worldwide'); ?></p>
        </div>
        <div class="gp-landing-tc-grid gp-landing-fn-grid">
            <?php
            $top_courses = $this->crud_model->get_top_courses()->result_array();
            foreach ($top_courses as $top_course):
                $course_duration   = $this->crud_model->get_total_duration_of_lesson_by_course_id($top_course['id']);
                $lessons           = $this->crud_model->get_lessons('course', $top_course['id']);
                $total_rating      = $this->crud_model->get_ratings('course', $top_course['id'], true)->row()->rating;
                $number_of_ratings = $this->crud_model->get_ratings('course', $top_course['id'])->num_rows();
                $average_ceil_rating = $number_of_ratings > 0 ? ceil($total_rating / $number_of_ratings) : 0;
                $gp_course_url = site_url('home/course/' . rawurlencode(slugify($top_course['title'])) . '/' . $top_course['id']);
            ?>
            <div class="gp-landing-tc-card">
                <a href="<?php echo $gp_course_url; ?>" id="top_course_<?php echo $top_course['id']; ?>" class="checkPropagation gp-landing-tc-thumb">
                    <img loading="lazy" src="<?php echo $this->crud_model->get_course_thumbnail_url($top_course['id']); ?>" alt="">
                </a>
                <div class="courses-icon<?php if (in_array($top_course['id'], $my_wishlist_items)) echo ' red-heart'; ?>" id="coursesWishlistIconTopCourse<?php echo $top_course['id']; ?>">
                    <i class="fas fa-heart checkPropagation" onclick="actionTo('<?php echo site_url('home/toggleWishlistItems/' . $top_course['id'] . '/TopCourse'); ?>')"></i>
                </div>
                <div class="gp-landing-tc-body">
                    <?php echo gp_ds_badge(get_phrase($top_course['level']), isset($gp_level_tone[$top_course['level']]) ? $gp_level_tone[$top_course['level']] : 'neutral', true); ?>
                    <h5><a href="<?php echo $gp_course_url; ?>" class="checkPropagation" style="color:inherit; text-decoration:none;"><?php echo $top_course['title']; ?></a></h5>
                    <div class="gp-landing-tc-meta">
                        <span><i class="fa-solid fa-star<?php if ($number_of_ratings > 0) echo ' filled'; ?>"></i> <?php echo $average_ceil_rating; ?> (<?php echo $number_of_ratings; ?>)</span>
                        <?php if ($course_duration): ?><span>· <?php echo $course_duration; ?></span><?php endif; ?>
                        <span>· <?php echo $lessons->num_rows() . ' ' . site_phrase('lessons'); ?></span>
                    </div>
                    <div class="gp-landing-tc-foot">
                        <span class="gp-landing-tc-price">
                            <?php if ($top_course['is_free_course']): ?>
                                <?php echo get_phrase('Free'); ?>
                            <?php elseif ($top_course['discount_flag']): ?>
                                <?php echo currency($top_course['discounted_price']); ?>
                            <?php else: ?>
                                <?php echo currency($top_course['price']); ?>
                            <?php endif; ?>
                        </span>
                        <?php if (is_purchased($top_course['id'])): ?>
                            <?php echo gp_ds_button(get_phrase('Start Now'), ['variant' => 'outline', 'href' => site_url('home/lesson/' . slugify($top_course['title']) . '/' . $top_course['id'])], true); ?>
                        <?php else: ?>
                            <?php echo gp_ds_button(get_phrase('Enroll Now'), ['variant' => 'outline', 'href' => $gp_course_url], true); ?>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
