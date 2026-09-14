<?php if (! (get_frontend_settings('top_category_section') == 1)) return; ?>
<?php $gp_bg = gp_landing_bg_attrs('categories'); ?>
<section class="gp-landing gp-landing-categories<?php echo $gp_bg['class']; ?>"<?php echo $gp_bg['style']; ?>>
    <div class="container">
        <div class="gp-landing-head gp-landing-center">
            <div class="gp-landing-eyebrow">Browse</div>
            <h2><?php echo site_phrase('top_categories'); ?></h2>
            <p><?php echo site_phrase('These_are_the_most_popular_courses_among_Listen_Courses_learners_worldwide'); ?></p>
        </div>
        <div class="gp-landing-chips">
            <?php
            $top_10_categories = $this->crud_model->get_top_categories(12, 'sub_category_id');
            foreach ($top_10_categories as $top_10_category):
                $category_details = $this->crud_model->get_category_details_by_id($top_10_category['sub_category_id'])->row_array();
            ?>
                <a class="gp-landing-chip" href="<?php echo site_url('home/courses?category=' . $category_details['slug']); ?>">
                    <?php if (! $category_details['sub_category_thumbnail'] && $category_details['font_awesome_class']): ?>
                        <i class="<?php echo $category_details['font_awesome_class']; ?>"></i>
                    <?php endif; ?>
                    <?php echo htmlspecialchars($category_details['name']); ?>
                    <span class="gp-landing-chip-count"><?php echo $top_10_category['course_number'] . ' ' . site_phrase('courses'); ?></span>
                </a>
            <?php endforeach; ?>
        </div>
    </div>
</section>
