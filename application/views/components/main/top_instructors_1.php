<?php if (! (get_frontend_settings('top_instructor_section') == 1)) return; ?>
<?php $top_instructor_ids = $this->crud_model->get_top_instructor(10); ?>
<?php if (count($top_instructor_ids) > 0): ?>
<?php $gp_bg = gp_landing_bg_attrs('instructors'); ?>
<section class="gp-landing gp-landing-instructors<?php echo $gp_bg['class']; ?>"<?php echo $gp_bg['style']; ?>>
    <div class="container">
        <div class="gp-landing-head gp-landing-center">
            <div class="gp-landing-eyebrow">Meet the team</div>
            <h2><?php echo get_phrase('Our Expert Instructor'); ?></h2>
            <p><?php echo get_phrase('They efficiently serve large number of students on our platform'); ?></p>
        </div>
        <div class="gp-landing-fn-grid">
            <?php foreach ($top_instructor_ids as $top_instructor_id):
                $top_instructor = $this->user_model->get_all_user($top_instructor_id['creator'])->row_array();
            ?>
                <a class="gp-landing-instr-card" href="<?php echo site_url('home/instructor_page/' . $top_instructor['id']); ?>">
                    <img loading="lazy" src="<?php echo $this->user_model->get_user_image_url($top_instructor['id']); ?>" alt="">
                    <h3><?php echo $top_instructor['first_name'] . ' ' . $top_instructor['last_name']; ?></h3>
                    <p><?php echo $top_instructor['title']; ?></p>
                </a>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php endif; ?>
