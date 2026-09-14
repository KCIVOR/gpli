<style>
.eImage span {
    width: auto !important;
}

.course-item-one .content .title {
    display: -webkit-box !important;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: normal;
}

</style>

<?php include APPPATH . 'views/components/main/hero_section_1.php'; ?>
<?php include APPPATH . 'views/components/main/feature_trio.php'; ?>
<?php include APPPATH . 'views/components/main/media_strip.php'; ?>
<?php include APPPATH . 'views/components/main/top_courses_1.php'; ?>
<?php include APPPATH . 'views/components/main/function_grid.php'; ?>
<?php include APPPATH . 'views/components/main/top_categories_1.php'; ?>
<?php include APPPATH . 'views/components/main/quiz_banner.php'; ?>
<?php include APPPATH . 'views/components/main/why_section.php'; ?>
<?php include APPPATH . 'views/components/main/top_instructors_1.php'; ?>

<?php if (get_frontend_settings('upcoming_course_section') == 1): ?>
<!-- Start Upcoming Courses -->
<?php $upcoming_courses = $this->db->order_by('id', 'desc')->limit(6)->get_where('course', ['status' => 'upcoming']); ?>
<?php if ($upcoming_courses->num_rows() > 0): ?>
<section class="pb-100 eUpcomingCourse ">
    <div class="container">

        <div class="row mb-4 wow  animate__animated animate__fadeInUp opacityOnUp" data-wow-duration="500" data-wow-delay="300">
            <div class="col-lg-12">
                <div class="title-two text-center">
                    <h4 class="title"><?php echo get_phrase('Explore our upcoming courses'); ?></h4>
                    <p><?php echo get_phrase('Discover a world of learning opportunities through our upcoming courses') ?></p>
                </div>
            </div>
        </div>
        <div class="row wow  animate__animated animate__fadeInUp opacityOnUp" data-wow-duration="500" data-wow-delay="500">
            <div class="col-lg-12">
                <!-- Items -->
                <div class="row g-3">
                    <?php
                        foreach ($upcoming_courses->result_array() as $upcoming_course):
                            $instructor_details = $this->user_model->get_all_user($upcoming_course['creator'])->row_array();
                            $course_duration    = $this->crud_model->get_total_duration_of_lesson_by_course_id($upcoming_course['id']);
                            $lessons            = $this->crud_model->get_lessons('course', $upcoming_course['id']);
                        ?>
	                    <?php
                                $image_url = $upcoming_course['upcoming_image_thumbnail']
                                    ? 'uploads/thumbnails/upcoming_thumbnails/' . $upcoming_course['upcoming_image_thumbnail']
                                    : 'uploads/thumbnails/course_thumbnails/placeholder.png';
                            ?>
	                    <div class="col-lg-4 col-md-6 col-sm-6    " data-wow-duration="500" data-wow-delay="300">
	                        <a href="<?php echo site_url('home/course/' . rawurlencode(slugify($upcoming_course['title'])) . '/' . $upcoming_course['id']); ?>"
	                            id="top_course_<?php echo $upcoming_course['id']; ?>" class="course-item-one"
	                            style="background: url('<?php echo $image_url; ?>') no-repeat center center; background-size: cover;">
	                            <div class="ePosition">
	                                <div class="eImage d-flex">
	                                    <span class="px-3"><?php
                                                               echo $this->db->where('id', $upcoming_course['sub_category_id'])->get('category')->row('name');
                                                               ?></span>
	                                </div>
	                            </div>
	                            <div class="content">
	                                <img loading="lazy" src="<?php echo $this->user_model->get_user_image_url($instructor_details['id']); ?>" alt="" />
	                                <h4 class="title pb-0"><?php echo $upcoming_course['title']; ?></h4>
	                                <p class="info ellipsis-line-2 fw-400">
	                                    <?php if ($upcoming_course['publish_date']) {
                                                    echo get_phrase('Release On') . ' : ' . date('j', strtotime($upcoming_course['publish_date'])) . ' ' . get_phrase(date('F', strtotime($upcoming_course['publish_date']))) . ' ' . date('Y', strtotime($upcoming_course['publish_date']));
                                                }
                                            ?>
	                                </p>

	                            </div>
	                        </a>
	                    </div>
	                    <?php endforeach; ?>
                </div>
            </div>
        </div>
    </div>
</section>
<?php endif; ?>
<!-- End Upcoming Courses -->
<?php endif; ?>


<?php include APPPATH . 'views/components/main/latest_courses_1.php'; ?>


<?php if (get_frontend_settings('motivational_speech_section') == 1): ?>
<?php $motivational_speechs = json_decode(get_frontend_settings('motivational_speech'), true); ?>
<?php if (count($motivational_speechs) > 0): ?>
<!---------  Motivetional Speech Start ---------------->
<section class="expert-instructor top-categories pb-100 pt-0 ">
    <div class="container">
        <div class="row mb-4 wow  animate__animated animate__fadeInUp opacityOnUp" data-wow-duration="500" data-wow-delay="300">
            <div class="col-lg-12">
                <div class="title-two text-center">
                    <h4 class="title"><?php echo get_phrase('Think more clearly') ?></h4>
                    <p><?php echo get_phrase('Gather your thoughts, and make your decisions clearly') ?></p>
                </div>
            </div>
        </div>

        <ul class="speech-items">
            <?php $counter = 0; ?>
            <?php foreach ($motivational_speechs as $key => $motivational_speech): ?>
            <?php $counter = $counter + 1; ?>
            <li class="e_border">
                <div class="Espeech-item">
                    <div class="row  wow  animate__animated animate__fadeInUp opacityOnUp" data-wow-duration="1000" data-wow-delay="700">

                        <div class="col-md-1 col-2">
                            <div class="speech-item-content Nspeech">
                                <p class="no"><?php echo $counter; ?></p>
                            </div>
                        </div>
                        <div class="col-lg-8 col-md-6 col-12  order-2 order-md-1">
                            <div class="speech-item-content Nspeech2">
                                <div class="inner">
                                    <h4 class="title">
                                        <?php echo $motivational_speech['title']; ?>
                                    </h4>
                                    <p class="info">
                                        <?php echo nl2br($motivational_speech['description']); ?>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-5 col-10 order-1 order-md-1">
                            <div class="speech-item-img">
                                <img loading="lazy" src="<?php echo site_url('uploads/system/motivations/' . $motivational_speech['image']) ?>" alt="" />
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <?php endforeach; ?>
        </ul>
    </div>
</section>
<!---------  Motivetional Speech end ---------------->
<?php endif; ?>
<?php endif; ?>

<!-- Start Review Section -->
<?php if (get_frontend_settings('review_section') == 1): ?>
<section class="expert-instructor top-categories pb-100 pt-0 ">
    <div class="container">
        <div class="row mb-4 wow  animate__animated animate__fadeInUp opacityOnUp" data-wow-duration="500" data-wow-delay="300">
            <div class="col-lg-12">
                <div class="title-two text-center">
                    <h4 class="title"><?php echo get_phrase('What the people Thinks About Us') ?></h4>
                    <p><?php echo get_phrase('It highlights feedback and testimonials from users, reflecting their experiences and satisfaction.') ?></p>
                </div>
            </div>
        </div>

        <div class="course-group-slider  wow  animate__animated animate__fadeInUp opacityOnUp" data-wow-duration="1000" data-wow-delay="500">
            <?php
                $reviews = $this->db->where('ratable_type', null)->where('ratable_id', null)->get('rating')->result();
                foreach ($reviews as $review):
                    $user_data = $this->db->get_where('users', ['id' => $review->user_id])->row_array();
                ?>
	            <div class="elegant-testimonial-slide">
	                <div class="ele-testimonial-profile-area d-flex">
	                    <div class="profile">
	                        <img src="<?php echo $this->user_model->get_user_image_url($user_data['id']); ?>" alt="">
	                    </div>
	                    <div class="ele-testimonial-profile-name">
	                        <h6 class="name"><?php echo $user_data['first_name'] . ' ' . $user_data['last_name']; ?></h6>
	                        <p class="time"><?php echo date('h:i A', $review->date_added); ?></p>
	                        <ul class="rating d-flex align-items-center">
	                            <?php
                                        for ($i = 1; $i <= 5; $i++):
                                            if ($i <= $review->rating):
                                        ?>
		                            <li><i class="fas fa-star"></i></li>
		                            <?php else: ?>
	                            <li class="thin"><i class="far fa-star"></i></li>
	                            <?php
                                    endif;
                                    endfor;
                                ?>
                        </ul>
                    </div>
                </div>
                <p class="review fw-400"><?php echo $review->review; ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php endif; ?>
<!-- End Review Section -->

<?php include APPPATH . 'views/components/main/faq_section.php'; ?>


<?php if (get_frontend_settings('blog_visibility_on_the_home_page') == 1): ?>
<!------------- Blog Section Start ------------>
<?php $latest_blogs = $this->crud_model->get_latest_blogs(3); ?>
<?php if ($latest_blogs->num_rows() > 0): ?>
<section class="courses blog pb-100 wow  animate__animated animate__fadeInUp opacityOnUp" data-wow-duration="1000" data-wow-delay="500">
    <div class="container">
        <div class="row mb-4 wow  animate__animated animate__fadeInUp opacityOnUp" data-wow-duration="500" data-wow-delay="300">
            <div class="col-lg-12">
                <div class="title-two text-center">
                    <h4 class="title"><?php echo get_phrase('Visit our latest blogs') ?></h4>
                    <p><?php echo site_phrase('Visit our valuable articles to get more information.') ?></p>
                </div>
            </div>
        </div>
        <div class="courses-card">
            <div class="row">
                <?php foreach ($latest_blogs->result_array() as $latest_blog):
                        $user_details  = $this->user_model->get_all_user($latest_blog['user_id'])->row_array();
                    $blog_category = $this->crud_model->get_blog_categories($latest_blog['blog_category_id'])->row_array(); ?>
	                <div class="col-lg-4 col-md-6 mb-3 wow  animate__animated animate__fadeIn" data-wow-duration="1000" data-wow-delay="700">
	                    <a href="<?php echo site_url('blog/details/' . slugify($latest_blog['title']) . '/' . $latest_blog['blog_id']); ?>" class="courses-card-body blogCard">
	                        <div class="courses-card-image">
	                            <?php $blog_thumbnail = 'uploads/blog/thumbnail/' . $latest_blog['thumbnail'];
                                        if (! file_exists($blog_thumbnail) || ! is_file($blog_thumbnail)):
                                            $blog_thumbnail = base_url('uploads/blog/thumbnail/placeholder.png');
                                    endif; ?>
	                            <div class="courses-card-image ">
	                                <img loading="lazy" src="<?php echo $blog_thumbnail; ?>">
	                            </div>
	                            <div class="courses-card-image-text position-absolute">
	                                <h3><?php echo $blog_category['title']; ?></h3>
	                            </div>
	                        </div>
	                        <div class="courses-text">
	                            <h5><?php echo $latest_blog['title']; ?></h5>
	                            <p class="ellipsis-line-2"><?php echo ellipsis(strip_tags(htmlspecialchars_decode_($latest_blog['description'])), 100); ?></p>
	                            <div class="courses-price-border">
	                                <div class="courses-price">
	                                    <div class="courses-price-left">
	                                        <img loading="lazy" class="rounded-circle" src="<?php echo $this->user_model->get_user_image_url($user_details['id']); ?>">
	                                        <div class="designation">
	                                            <h5 class="mb-0"><?php echo $user_details['first_name'] . ' ' . $user_details['last_name']; ?></h5>
	                                            <p><?php echo get_past_time($latest_blog['added_date']); ?></p>
	                                        </div>
	                                    </div>
	                                    <div>
	                                        <svg width="20" height="14" viewBox="0 0 20 14" fill="none" xmlns="http://www.w3.org/2000/svg">
	                                            <path
	                                                d="M18.9222 6.41101L13.0888 0.577677C12.9317 0.425878 12.7212 0.341883 12.5027 0.343782C12.2842 0.34568 12.0752 0.433321 11.9207 0.587828C11.7662 0.742335 11.6785 0.951345 11.6766 1.16984C11.6747 1.38834 11.7587 1.59884 11.9105 1.75601L16.3213 6.16684H1.66634C1.44533 6.16684 1.23337 6.25464 1.07709 6.41092C0.920805 6.5672 0.833008 6.77916 0.833008 7.00018C0.833008 7.22119 0.920805 7.43315 1.07709 7.58943C1.23337 7.74571 1.44533 7.83351 1.66634 7.83351H16.3213L11.9105 12.2443C11.8309 12.3212 11.7674 12.4132 11.7238 12.5148C11.6801 12.6165 11.6571 12.7259 11.6561 12.8365C11.6552 12.9472 11.6763 13.0569 11.7182 13.1593C11.7601 13.2617 11.8219 13.3548 11.9002 13.433C11.9784 13.5112 12.0715 13.5731 12.1739 13.615C12.2763 13.6569 12.386 13.678 12.4967 13.6771C12.6073 13.6761 12.7167 13.6531 12.8183 13.6094C12.92 13.5658 13.012 13.5023 13.0888 13.4227L18.9222 7.58934C19.0784 7.43307 19.1662 7.22115 19.1662 7.00018C19.1662 6.77921 19.0784 6.56728 18.9222 6.41101Z"
	                                                fill="#0D0C23" />
	                                        </svg>

	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </a>
	                </div>
	                <?php endforeach; ?>
            </div>
        </div>
    </div>
</section>
<?php endif; ?>
<?php endif; ?>

<?php include APPPATH . 'views/components/main/promotional_section_1.php'; ?>
<?php include APPPATH . 'views/components/main/cta_band.php'; ?>

<div class="py-4 w-100"></div>
