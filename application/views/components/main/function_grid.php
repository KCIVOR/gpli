<?php if (! gp_landing_toggle('function_grid_section')) return; ?>
<?php
$gp_extras = gp_landing_extras();
$gp_cats = $this->crud_model->get_categories()->result_array();
$gp_bg = gp_landing_bg_attrs('functions');
?>
<section class="gp-landing gp-landing-functions<?php echo $gp_bg['class']; ?>" id="lms-courses"<?php echo $gp_bg['style']; ?>>
    <div class="container">
        <div class="gp-landing-head">
            <div class="gp-landing-eyebrow">The Library</div>
            <h2>Courses by Function</h2>
            <p>Function-specific courses carefully curated to match your company requirements.</p>
        </div>
        <div class="gp-landing-fn-grid">
            <?php foreach ($gp_cats as $gp_cat):
                $count = $this->crud_model->get_category_wise_courses($gp_cat['id'])->num_rows();
                $blurb = isset($gp_extras['function_blurbs'][$gp_cat['id']]) ? $gp_extras['function_blurbs'][$gp_cat['id']] : '';
            ?>
                <a class="gp-landing-fn-card" href="<?php echo site_url('home/courses?category=' . slugify($gp_cat['slug'])); ?>">
                    <h3><?php echo htmlspecialchars($gp_cat['name']); ?></h3>
                    <?php if ($blurb !== ''): ?><p><?php echo htmlspecialchars($blurb); ?></p><?php endif; ?>
                    <span><?php echo (int) $count . ' ' . get_phrase('courses'); ?></span>
                </a>
            <?php endforeach; ?>
        </div>
    </div>
</section>
