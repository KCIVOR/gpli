<?php
$is_instructor = $this->session->userdata('is_instructor');
$has_completed_tile = ($is_instructor != 1 && !empty($course_completed_badge));
$has_certificate_tile = (addon_status('certificate') && $is_instructor != 1 && !empty($course_certificate_badge));
$has_any_badge = !empty($earned_badge)
    || !empty($sale_badge)
    || !empty($rating_badge)
    || !empty($article_badge)
    || $has_completed_tile
    || $has_certificate_tile;
?>
<div class="gp-student-page">
<?php include "breadcrumb.php"; ?>

<!-------- Wish List body section start ------>
<section class="wish-list-body gp-student-shell">
    <div class="container">
        <?php gp_ds_page_title(get_phrase('Badges')); ?>
        <div class="row">
            <div class="col-lg-3 col-md-4 col-sm-12">
                <?php include "profile_menus.php"; ?>
            </div>
            <div class="col-lg-9 col-md-8 col-sm-12">
                <?php if (!$has_any_badge): ?>
                    <?php
                    ob_start();
                    ?>
                    <h4><?php echo get_phrase('Badges'); ?></h4>
                    <p><?php echo get_phrase('no_data_found'); ?></p>
                    <?php
                    gp_ds_card([
                        'extra_class' => 'gp-student-empty empty-state',
                        'body'        => ob_get_clean(),
                    ]);
                    ?>
                <?php endif; ?>

                       <div class=" user-reward-badges badges-lg row align-items-center">

                             <?php if (!empty($earned_badge)): ?>
                                <div class="col-lg-4 col-md-6 col-sm-6 col-12 mb-3">
                                    <?php
                                    ob_start();
                                    ?>
                                    <div class="gp-student-badge">
                                        <img src="<?php echo base_url('uploads/badges/' . $earned_badge['image']); ?>" alt="<?php echo $earned_badge['title']; ?>">
                                        <h5><?php echo $earned_badge['title']; ?></h5>
                                        <p><?php echo $earned_badge['description']; ?></p>
                                    </div>
                                    <?php
                                    gp_ds_card([
                                        'extra_class' => 'gp-student-badge-card',
                                        'body'        => ob_get_clean(),
                                    ]);
                                    ?>
                                </div>
                            <?php endif; ?>

                             <?php if (!empty($sale_badge)): ?>
                                <div class="col-lg-4 col-md-6 col-sm-6 col-12 mb-3">
                                    <?php
                                    ob_start();
                                    ?>
                                    <div class="gp-student-badge">
                                        <img src="<?php echo base_url('uploads/badges/' . $sale_badge['image']); ?>" alt="<?php echo $sale_badge['title']; ?>">
                                        <h5><?php echo $sale_badge['title']; ?></h5>
                                        <p><?php echo $sale_badge['description']; ?></p>
                                    </div>
                                    <?php
                                    gp_ds_card([
                                        'extra_class' => 'gp-student-badge-card',
                                        'body'        => ob_get_clean(),
                                    ]);
                                    ?>
                                </div>
                            <?php endif; ?>

                            <?php if (!empty($rating_badge)): ?>
                                <div class="col-lg-4 col-md-6 col-sm-6 col-12 mb-3">
                                    <?php
                                    ob_start();
                                    ?>
                                    <div class="gp-student-badge">
                                        <img src="<?php echo base_url('uploads/badges/' . $rating_badge['image']); ?>" alt="<?php echo $rating_badge['title']; ?>">
                                        <h5><?php echo $rating_badge['title']; ?></h5>
                                        <p><?php echo $rating_badge['description']; ?></p>
                                    </div>
                                    <?php
                                    gp_ds_card([
                                        'extra_class' => 'gp-student-badge-card',
                                        'body'        => ob_get_clean(),
                                    ]);
                                    ?>
                                </div>
                            <?php endif; ?>
                            <?php if (!empty($article_badge)): ?>
                                <div class="col-lg-4 col-md-6 col-sm-6 col-12 mb-3">
                                    <?php
                                    ob_start();
                                    ?>
                                    <div class="gp-student-badge">
                                        <img src="<?php echo base_url('uploads/badges/' . $article_badge['image']); ?>" alt="<?php echo $article_badge['title']; ?>">
                                        <h5><?php echo $article_badge['title']; ?></h5>
                                        <p><?php echo $article_badge['description']; ?></p>
                                    </div>
                                    <?php
                                    gp_ds_card([
                                        'extra_class' => 'gp-student-badge-card',
                                        'body'        => ob_get_clean(),
                                    ]);
                                    ?>
                                </div>
                            <?php endif; ?>
                            <?php
                             $is_instructor = $this->session->userdata('is_instructor');
                              if ($is_instructor != 1):
                                    if (!empty($course_completed_badge)): ?>
                                        <div class="col-lg-4 col-md-6 col-sm-6 col-12 mb-3">
                                            <?php
                                            ob_start();
                                            ?>
                                            <div class="gp-student-badge">
                                                <img src="<?php echo base_url('uploads/badges/' . $course_completed_badge['image']); ?>" alt="<?php echo $course_completed_badge['title']; ?>">
                                                <h5><?php echo $course_completed_badge['title']; ?></h5>
                                                <p><?php echo $course_completed_badge['description']; ?></p>
                                            </div>
                                            <?php
                                            gp_ds_card([
                                                'extra_class' => 'gp-student-badge-card',
                                                'body'        => ob_get_clean(),
                                            ]);
                                            ?>
                                        </div>
                             <?php endif; 
                                endif; ?>
                            <?php if (addon_status('certificate')) : ?>
                            <?php
                             $is_instructor = $this->session->userdata('is_instructor');
                              if ($is_instructor != 1):
                                    if (!empty($course_certificate_badge)): ?>
                                        <div class="col-lg-4 col-md-6 col-sm-6 col-12 mb-3">
                                            <?php
                                            ob_start();
                                            ?>
                                            <div class="gp-student-badge">
                                                <img src="<?php echo base_url('uploads/badges/' . $course_certificate_badge['image']); ?>" alt="<?php echo $course_certificate_badge['title']; ?>">
                                                <h5><?php echo $course_certificate_badge['title']; ?></h5>
                                                <p><?php echo $course_certificate_badge['description']; ?></p>
                                            </div>
                                            <?php
                                            gp_ds_card([
                                                'extra_class' => 'gp-student-badge-card',
                                                'body'        => ob_get_clean(),
                                            ]);
                                            ?>
                                        </div>
                             <?php endif; 
                                endif; ?>
                            <?php endif; ?>
                     </div>

            </div>
        </div>
    </div>
</section>
</div>
<!-------- wish list bosy section end ------->
