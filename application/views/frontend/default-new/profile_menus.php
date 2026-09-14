<?php
if (! isset($user_details) || ! is_array($user_details)) {
    $user_details = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array();
}

$this->db->where('receiver', $this->session->userdata('user_id'));
$this->db->where('read_status !=', 1);
$unreaded_message = $this->db->get('message')->num_rows();
?>

<?php ob_start(); ?>
    <div class="gp-student-identity">
        <img loading="lazy" class="gp-student-avatar" src="<?php echo $this->user_model->get_user_image_url($this->session->userdata('user_id')); ?>" alt="">
        <h4><?php echo $user_details['first_name'].' '.$user_details['last_name']; ?></h4>
        <span><?php echo $user_details['email']; ?></span>
    </div>
    <nav class="gp-student-nav">
        <a class="gp-student-nav-link <?php if($page_name == 'my_courses') echo 'active'; ?>" href="<?php echo site_url('home/my_courses'); ?>">
            <span class="gp-student-nav-main">
                <i class="fa-solid fa-book-open-reader"></i>
                <span><?php echo get_phrase('My Courses'); ?></span>
            </span>
        </a>

        <?php if (addon_status('course_bundle')) : ?>
            <a class="gp-student-nav-link <?php if ($page_name == 'my_bundles' || $page_name == 'bundle_invoice') echo 'active'; ?>" href="<?php echo site_url('home/my_bundles'); ?>">
                <span class="gp-student-nav-main">
                    <i class="fas fa-cubes"></i>
                    <span><?php echo get_phrase('Course Bundles'); ?></span>
                </span>
            </a>
        <?php endif; ?>

        <?php if (addon_status('bootcamp')) : ?>
            <a class="gp-student-nav-link <?php if ($page_name == 'my_bootcamp' || $page_name == 'my_bootcamp_details') echo 'active'; ?>" href="<?php echo site_url('addons/bootcamp/my_bootcamp'); ?>">
                <span class="gp-student-nav-main">
                    <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                        <g clip-path="url(#clip0_38_2)">
                            <path
                                d="M5.25 10.5C6.9045 10.5 8.25 9.1545 8.25 7.5C8.25 5.8455 6.9045 4.5 5.25 4.5C3.5955 4.5 2.25 5.8455 2.25 7.5C2.25 9.1545 3.5955 10.5 5.25 10.5ZM5.25 6C6.07725 6 6.75 6.67275 6.75 7.5C6.75 8.32725 6.07725 9 5.25 9C4.42275 9 3.75 8.32725 3.75 7.5C3.75 6.67275 4.42275 6 5.25 6ZM10.5 17.25C10.5 17.6647 10.164 18 9.75 18C9.336 18 9 17.6647 9 17.25C9 15.1823 7.31775 13.5 5.25 13.5C3.18225 13.5 1.5 15.1823 1.5 17.25C1.5 17.6647 1.164 18 0.75 18C0.336 18 0 17.6647 0 17.25C0 14.3558 2.355 12 5.25 12C8.145 12 10.5 14.3558 10.5 17.25ZM18 3.75V9.75C18 11.8177 16.3178 13.5 14.25 13.5H11.25C10.836 13.5 10.5 13.1647 10.5 12.75V11.25C10.5 10.8353 10.836 10.5 11.25 10.5H13.5C13.914 10.5 14.25 10.8353 14.25 11.25V12C15.4905 12 16.5 10.9905 16.5 9.75V3.75C16.5 2.5095 15.4905 1.5 14.25 1.5H7.09875C6.29775 1.5 5.55075 1.93125 5.1495 2.62575C4.94175 2.98425 4.4835 3.108 4.125 2.89875C3.76575 2.69175 3.6435 2.23275 3.85125 1.87425C4.52025 0.7185 5.7645 0 7.0995 0H14.2508C16.3185 0 18 1.68225 18 3.75Z"
                                fill="currentColor" />
                        </g>
                        <defs>
                            <clipPath id="clip0_38_2">
                                <rect width="18" height="18" fill="white" />
                            </clipPath>
                        </defs>
                    </svg>
                    <span><?php echo get_phrase('Bootcamp'); ?></span>
                </span>
            </a>
        <?php endif; ?>

        <?php if (addon_status('team_training')) : ?>
            <a class="gp-student-nav-link <?php if ($page_name == 'my_teams' || $page_name == 'my_selected_team') echo 'active'; ?>" href="<?php echo site_url('addons/team_training/my_teams'); ?>">
                <span class="gp-student-nav-main">
                    <i class="fas fa-users"></i>
                    <span><?php echo get_phrase('My Teams'); ?></span>
                </span>
            </a>
        <?php endif; ?>

        <?php if (addon_status('tutor_booking')) : ?>
            <a class="gp-student-nav-link <?php if( $page_name=='booked_schedule_student' ) echo 'active'; ?>" href="<?php echo site_url('my_bookings'); ?>">
                <span class="gp-student-nav-main">
                    <i class="far fa-calendar-check"></i>
                    <span><?php echo get_phrase('Booked Tuition'); ?></span>
                </span>
            </a>
        <?php endif; ?>

        <?php if(addon_status('ebook')): ?>
            <a class="gp-student-nav-link <?php if($page_name == 'my_ebooks') echo 'active'; ?>" href="<?php echo site_url('home/my_ebooks'); ?>">
                <span class="gp-student-nav-main">
                    <i class="fas fa-book"></i>
                    <span><?php echo get_phrase('My Ebooks'); ?></span>
                </span>
            </a>
        <?php endif; ?>

        <a class="gp-student-nav-link <?php if($page_name == 'my_wishlist') echo 'active'; ?>" href="<?php echo site_url('home/my_wishlist'); ?>">
            <span class="gp-student-nav-main">
                <i class="fa-regular fa-heart"></i>
                <span><?php echo get_phrase('Wishlist'); ?></span>
            </span>
        </a>

        <div class="gp-student-nav-divider border-top" aria-hidden="true"></div>

        <a class="gp-student-nav-link <?php if($page_name == 'my_notifications') echo 'active'; ?>" href="<?php echo site_url('home/my_notifications'); ?>">
            <span class="gp-student-nav-main">
                <i class="fa-regular fa-bell"></i>
                <span><?php echo get_phrase('my_notifications'); ?></span>
            </span>
        </a>

        <a class="gp-student-nav-link <?php if($page_name == 'my_messages') echo 'active'; ?>" href="<?php echo site_url('home/my_messages'); ?>">
            <span class="gp-student-nav-main">
                <i class="fa-regular fa-comment-dots"></i>
                <span><?php echo get_phrase('Messages'); ?></span>
            </span>
            <?php if($unreaded_message > 0): ?>
                <?php echo gp_ds_badge((string) $unreaded_message, 'danger', true); ?>
            <?php endif; ?>
        </a>

        <a class="gp-student-nav-link <?php if($page_name == 'instructor_following') echo 'active'; ?>" href="<?php echo site_url('home/instructor_following'); ?>">
            <span class="gp-student-nav-main">
                <i class="fas fa-users"></i>
                <span><?php echo get_phrase('Instructor Followings'); ?></span>
            </span>
        </a>

        <div class="gp-student-nav-divider border-top" aria-hidden="true"></div>

        <?php if (addon_status('affiliate_course')) :
            $CI    = &get_instance();
            $CI->load->model('addons/affiliate_course_model');
            $is_affilator = $CI->affiliate_course_model->is_affilator($this->session->userdata('user_id'));
            if ($is_affilator == 1) : ?>
                <a class="gp-student-nav-link <?php if ($page_name == 'affiliate_course_history') echo 'active'; ?>" href="<?php echo site_url('addons/affiliate_course/affiliate_course_history'); ?>">
                    <span class="gp-student-nav-main">
                        <i class="fas fa-poll"></i>
                        <span><?php echo site_phrase('Affiliate History '); ?></span>
                    </span>
                </a>
            <?php endif; ?>
        <?php else: ?>
            <?php $is_affilator = 0; ?>
        <?php endif;?>

        <?php if($is_affilator == 1 || $user_details['is_instructor'] == 1): ?>
            <a class="gp-student-nav-link <?php if ($page_name == 'instructor_dashboard' || $page_name == 'create_course' || $page_name == 'manage_course_details' || $page_name == 'lesson_edit') echo 'active'; ?>" href="<?php echo site_url('home/dashboard'); ?>">
                <span class="gp-student-nav-main">
                    <i class="fa-solid fa-chalkboard-user"></i>
                    <span><?php echo get_phrase('instructor_dashboard'); ?></span>
                </span>
            </a>
            <a class="gp-student-nav-link <?php if ($page_name == 'payment_settings') echo 'active'; ?>" href="<?php echo site_url('home/payout_settings'); ?>">
                <span class="gp-student-nav-main">
                    <i class="fa-solid fa-gear"></i>
                    <span><?php echo site_phrase('Payout Settings'); ?></span>
                </span>
            </a>
            <div class="gp-student-nav-divider border-top" aria-hidden="true"></div>
        <?php endif; ?>

        <a class="gp-student-nav-link <?php if($page_name == 'purchase_history') echo 'active'; ?>" href="<?php echo site_url('home/purchase_history'); ?>">
            <span class="gp-student-nav-main">
                <i class="fas fa-history"></i>
                <span><?php echo get_phrase('Purchase history'); ?></span>
            </span>
        </a>

        <a class="gp-student-nav-link <?php if($page_name == 'badges') echo 'active'; ?>" href="<?php echo site_url('home/badges'); ?>">
            <span class="gp-student-nav-main">
                <i class="fas fa-ribbon"></i>
                <span><?php echo get_phrase('Badges'); ?></span>
            </span>
        </a>

        <a class="gp-student-nav-link <?php if($page_name == 'user_profile') echo 'active'; ?>" href="<?php echo site_url('home/profile/user_profile'); ?>">
            <span class="gp-student-nav-main">
                <i class="fa-regular fa-user"></i>
                <span><?php echo get_phrase('Profile'); ?></span>
            </span>
        </a>

        <a class="gp-student-nav-link <?php if($page_name == 'user_credentials') echo 'active'; ?>" href="<?php echo site_url('home/profile/user_credentials'); ?>">
            <span class="gp-student-nav-main">
                <i class="fas fa-key"></i>
                <span><?php echo get_phrase('Account'); ?></span>
            </span>
        </a>
    </nav>
<?php
gp_ds_card([
    'title'       => '',
    'extra_class' => 'gp-student-sidebar',
    'body_class'  => 'gp-student-sidebar-body',
    'body'        => ob_get_clean(),
]);
?>
