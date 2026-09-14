<?php if (! (get_frontend_settings('latest_course_section') == 1)) return; ?>
<?php
$gp_latest_courses = $this->crud_model->get_latest_10_course();
if (count($gp_latest_courses) === 0) return;
if (! isset($my_wishlist_items)) {
    $user_id = $this->session->userdata('user_id');
    if ($user_id) {
        $wishlist = $this->user_model->get_all_user($user_id)->row('wishlist');
        $my_wishlist_items = $wishlist != '' ? json_decode($wishlist, true) : [];
    } else {
        $my_wishlist_items = [];
    }
}
$gp_level_tone = ['beginner' => 'success', 'intermediate' => 'warning', 'advanced' => 'danger'];
?>
<section class="gp-landing gp-landing-top-courses">
    <div class="container">
        <div class="gp-landing-head gp-landing-center">
            <div class="gp-landing-eyebrow">Fresh on the Platform</div>
            <h2><?php echo site_phrase('top') . ' 10 ' . site_phrase('latest_courses'); ?></h2>
            <p><?php echo get_phrase('These_are_the_most_popular_courses_among_Listen_Courses_learners_worldwide'); ?></p>
        </div>
        <div class="gp-landing-carousel-wrap">
            <button type="button" class="gp-landing-carousel-nav gp-landing-carousel-prev" aria-label="<?php echo get_phrase('Previous'); ?>"
                onclick="document.getElementById('gpLatestCoursesTrack').scrollBy({left:-296,behavior:'smooth'})">
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none"><path d="M11.25 3.75 5.625 9l5.625 5.25" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>
            </button>
            <div class="gp-landing-tc-track" id="gpLatestCoursesTrack">
                <?php foreach ($gp_latest_courses as $latest_course):
                    $course_duration    = $this->crud_model->get_total_duration_of_lesson_by_course_id($latest_course['id']);
                    $lessons            = $this->crud_model->get_lessons('course', $latest_course['id']);
                    $total_rating       = $this->crud_model->get_ratings('course', $latest_course['id'], true)->row()->rating;
                    $number_of_ratings  = $this->crud_model->get_ratings('course', $latest_course['id'])->num_rows();
                    $average_ceil_rating = $number_of_ratings > 0 ? ceil($total_rating / $number_of_ratings) : 0;
                    $gp_course_url = site_url('home/course/' . rawurlencode(slugify($latest_course['title'])) . '/' . $latest_course['id']);
                ?>
                <div class="gp-landing-tc-card gp-landing-tc-slide">
                    <a href="<?php echo $gp_course_url; ?>" id="latest_course_<?php echo $latest_course['id']; ?>" class="checkPropagation gp-landing-tc-thumb">
                        <img loading="lazy" src="<?php echo $this->crud_model->get_course_thumbnail_url($latest_course['id']); ?>" alt="">
                    </a>
                    <div class="courses-icon<?php if (in_array($latest_course['id'], $my_wishlist_items)) echo ' red-heart'; ?>" id="coursesWishlistIconLatestCourse<?php echo $latest_course['id']; ?>">
                        <i class="fa-solid fa-heart checkPropagation" onclick="actionTo('<?php echo site_url('home/toggleWishlistItems/' . $latest_course['id'] . '/LatestCourse'); ?>')"></i>
                    </div>
                    <div class="gp-landing-tc-body">
                        <?php echo gp_ds_badge(get_phrase($latest_course['level']), isset($gp_level_tone[$latest_course['level']]) ? $gp_level_tone[$latest_course['level']] : 'neutral', true); ?>
                        <h5><a href="<?php echo $gp_course_url; ?>" class="checkPropagation" style="color:inherit; text-decoration:none;"><?php echo $latest_course['title']; ?></a></h5>
                        <div class="gp-landing-tc-meta">
                            <span><i class="fa-solid fa-star<?php if ($number_of_ratings > 0) echo ' filled'; ?>"></i> <?php echo $average_ceil_rating; ?> (<?php echo $number_of_ratings; ?>)</span>
                            <?php if ($course_duration): ?><span>· <?php echo $course_duration; ?></span><?php endif; ?>
                            <span>· <?php echo $lessons->num_rows() . ' ' . site_phrase('lessons'); ?></span>
                        </div>
                        <div class="gp-landing-tc-foot">
                            <span class="gp-landing-tc-price">
                                <?php if ($latest_course['is_free_course']): ?>
                                    <?php echo get_phrase('Free'); ?>
                                <?php elseif ($latest_course['discount_flag']): ?>
                                    <?php echo currency($latest_course['discounted_price']); ?>
                                <?php else: ?>
                                    <?php echo currency($latest_course['price']); ?>
                                <?php endif; ?>
                            </span>
                            <?php if (is_purchased($latest_course['id'])): ?>
                                <?php echo gp_ds_button(get_phrase('Start Now'), ['variant' => 'outline', 'href' => site_url('home/lesson/' . slugify($latest_course['title']) . '/' . $latest_course['id'])], true); ?>
                            <?php else: ?>
                                <?php echo gp_ds_button(get_phrase('Enroll Now'), ['variant' => 'outline', 'href' => $gp_course_url], true); ?>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
            <button type="button" class="gp-landing-carousel-nav gp-landing-carousel-next" aria-label="<?php echo get_phrase('Next'); ?>"
                onclick="document.getElementById('gpLatestCoursesTrack').scrollBy({left:296,behavior:'smooth'})">
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none"><path d="M6.75 3.75 12.375 9 6.75 14.25" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>
            </button>
        </div>
        <div class="gp-landing-tc-viewall">
            <?php echo gp_ds_button(get_phrase('View all courses'), ['variant' => 'outline', 'href' => site_url('home/courses')], true); ?>
        </div>
    </div>
</section>
