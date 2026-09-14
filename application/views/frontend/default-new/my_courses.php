<?php $enrolments = $this->user_model->my_courses()->result_array(); ?>
<?php $user_details = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array(); ?>
<div class="gp-student-page">
<?php include "breadcrumb.php"; ?>

<!-------- Wish List body section start ------>
<section class="wish-list-body gp-student-shell">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-4 col-sm-12">
                <?php include "profile_menus.php"; ?>
            </div>
            <div class="col-lg-9 col-md-8 col-sm-12">
                <?php if (empty($enrolments)): ?>
                    <?php
                    ob_start();
                    ?>
                    <p><?php echo get_phrase('no_data_found'); ?></p>
                    <?php
                    gp_ds_card([
                        'title'       => '',
                        'extra_class' => 'gp-student-empty empty-state',
                        'body'        => ob_get_clean(),
                    ]);
                    ?>
                <?php else: ?>
                    <?php foreach($enrolments as $enrolment):
                        $course_details = $this->crud_model->get_course_by_id($enrolment['course_id'])->row_array();
                        $instructor_details = $this->user_model->get_all_user($course_details['creator'])->row_array();
                        $course_duration = $this->crud_model->get_total_duration_of_lesson_by_course_id($course_details['id']);
                        $lectures = $this->db->get_where('lesson', ['course_id' => $course_details['id'], 'lesson_type !=' => 'quiz']);
                        $quizzes = $this->db->get_where('lesson', ['course_id' => $course_details['id'], 'lesson_type' => 'quiz']);
                        $watch_history = $this->crud_model->get_watch_histories($this->session->userdata('user_id'), $course_details['id'])->row_array();
                        $course_progress = course_progress($course_details['id'], $this->session->userdata('user_id'));
                        $dropdown_id = 'dropdownMenuButton'.$course_details['id'];
                        ob_start();
                        ?>
                        <div class="gp-student-course-row">
                            <img loading="lazy" class="gp-student-course-thumb" src="<?php echo $this->crud_model->get_course_thumbnail_url($course_details['id']); ?>" alt="">
                            <div class="gp-student-course-main">
                                <div class="gp-student-course-head">
                                    <h3 class="gp-student-course-title"><?php echo $course_details['title']; ?></h3>
                                    <div class="dropdown">
                                        <button class="icon-btn" type="button" id="<?php echo $dropdown_id; ?>" data-bs-toggle="dropdown" aria-expanded="false">
                                            <i class="fa-solid fa-ellipsis-vertical"></i>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="<?php echo $dropdown_id; ?>">
                                            <li>
                                                <a class="dropdown-item py-2" href="<?php echo site_url('home/course/'.rawurlencode(slugify($course_details['title'])).'/'.$course_details['id']); ?>"><?php echo get_phrase('Go to course page') ?></a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item py-2" href="<?php echo site_url('home/instructor_page/'.$course_details['creator']) ?>"><?php echo get_phrase('Author profile') ?></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="gp-student-course-meta">
                                    <p><i class="far fa-play-circle"></i> <?php echo get_phrase('Lectures').' '.$lectures->num_rows(); ?></p>
                                    <p><i class="far fa-question-circle"></i> <?php echo get_phrase('Quizzes').' '.$quizzes->num_rows(); ?></p>
                                    <p><i class="fa-regular fa-clock"></i> <?php echo $course_duration; ?></p>
                                </div>
                                <div class="gp-student-course-progress">
                                    <div class="progress progress-sm">
                                        <div class="progress-bar" style="width: <?php echo $course_progress; ?>%;"></div>
                                    </div>
                                    <p><?php echo $course_progress; ?>%</p>
                                </div>

                                <?php include 'live_class_scadule.php'; ?>

                                <div class="gp-student-course-foot">
                                    <div class="gp-student-course-instructor">
                                        <?php $my_rating = $this->crud_model->get_user_specific_rating('course', $course_details['id']); ?>
                                        <div class="d-flex align-items-center">
                                            <img loading="lazy" src="<?php echo $this->user_model->get_user_image_url($this->session->userdata('user_id')); ?>" alt="">
                                            <span><?php echo $instructor_details['first_name'].' '.$instructor_details['last_name']; ?></span>
                                            <div class="star">
                                                <?php for($i = 1; $i <= 5; $i++): ?>
                                                    <i class="fa-solid fa-star <?php if($my_rating['rating'] >= $i) echo 'gold'; ?>"></i>
                                                <?php endfor; ?>
                                            </div>
                                        </div>
                                        <?php if($enrolment['expiry_date'] > 0 && $enrolment['expiry_date'] < time()): ?>
                                            <span class="gp-student-expiry"><?php echo get_phrase('Expired') ?> - <b style="color: var(--gp-danger);"><?php echo date('d M Y, H:i A', $enrolment['expiry_date']); ?></b></span>
                                        <?php else: ?>
                                            <?php if($enrolment['expiry_date'] == 0): ?>
                                                <span class="gp-student-expiry"><?php echo get_phrase('Expiry period') ?> - <b class="gp-student-expiry-ok"><?php echo get_phrase('Lifetime Access'); ?></b></span>
                                            <?php else: ?>
                                                <span class="gp-student-expiry"><?php echo get_phrase('Expiration On') ?> - <b><?php echo date('d M Y, H:i A', $enrolment['expiry_date']); ?></b></span>
                                            <?php endif; ?>
                                        <?php endif; ?>
                                    </div>
                                    <div class="gp-student-course-actions">
                                        <?php if($enrolment['expiry_date'] > 0 && $enrolment['expiry_date'] < time()): ?>
                                            <?php gp_ds_button(get_phrase('Join again'), [
                                                'variant'     => 'outline',
                                                'href'        => '#',
                                                'extra_class' => 'gp-student-cta',
                                                'attrs'       => [
                                                    'onclick' => "actionTo('".site_url('home/handle_buy_now/'.$course_details['id'])."')",
                                                ],
                                            ]); ?>
                                        <?php else: ?>
                                            <?php gp_ds_button(get_phrase('Start Now'), [
                                                'variant'     => 'primary',
                                                'href'        => site_url('home/lesson/'.slugify($course_details['title']).'/'.$course_details['id']),
                                                'extra_class' => 'gp-student-cta',
                                            ]); ?>
                                        <?php endif; ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <?php
                        gp_ds_card([
                            'title'       => '',
                            'extra_class' => 'gp-student-course',
                            'body'        => ob_get_clean(),
                        ]);
                    endforeach; ?>
                <?php endif; ?>
            </div>
        </div>
    </div>
</section>
</div>
<!-------- wish list bosy section end ------->
