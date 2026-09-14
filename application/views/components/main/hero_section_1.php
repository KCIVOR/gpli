<?php $gp_h = gp_landing_extras()['hero']; ?>
<section class="gp-landing gp-landing-hero">
    <div class="container">
        <div class="gp-landing-hero-copy">
            <div class="gp-landing-eyebrow builder-editable" builder-identity="1"><?php echo htmlspecialchars($gp_h['eyebrow']); ?></div>
            <h1>
                <?php echo site_phrase(get_frontend_settings('banner_title')); ?>
                <?php if ($gp_h['accent'] !== ''): ?>
                    <span class="gp-landing-accent builder-editable" builder-identity="2"><?php echo htmlspecialchars($gp_h['accent']); ?></span>
                <?php endif; ?>
            </h1>
            <p class="builder-editable" builder-identity="3"><?php echo site_phrase(get_frontend_settings('banner_sub_title')); ?></p>
            <div class="gp-landing-hero-actions">
                <?php echo gp_ds_button($gp_h['cta1_label'], ['variant' => 'primary', 'href' => gp_landing_url($gp_h['cta1_url']), 'extra_class' => 'gp-landing-cta-wide'], true); ?>
                <?php echo gp_ds_button($gp_h['cta2_label'], ['variant' => 'outline', 'href' => gp_landing_url($gp_h['cta2_url'])], true); ?>
            </div>
            <form class="gp-landing-search" action="<?php echo site_url('home/search'); ?>" method="get">
                <input class="form-control" type="text" name="query" placeholder="<?php echo get_phrase('What do you want to learn'); ?>">
                <?php echo gp_ds_button(get_phrase('search'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
            </form>
            <div class="gp-landing-stats">
                <?php foreach ($gp_h['stats'] as $i => $stat): ?>
                    <div class="gp-landing-stat">
                        <div class="num builder-editable" builder-identity="<?php echo 10 + $i; ?>"><?php echo htmlspecialchars($stat['num']); ?></div>
                        <div class="lbl builder-editable" builder-identity="<?php echo 20 + $i; ?>"><?php echo htmlspecialchars($stat['lbl']); ?></div>
                        <div class="sub builder-editable" builder-identity="<?php echo 30 + $i; ?>"><?php echo htmlspecialchars($stat['sub']); ?></div>
                    </div>
                <?php endforeach; ?>
            </div>
            <?php $gp_banner_image = get_current_banner('banner_image'); ?>
            <?php if ($gp_banner_image): ?>
                <div class="gp-landing-hero-banner">
                    <img class="builder-editable" builder-identity="40" loading="lazy" width="100%" src="<?php echo base_url('uploads/system/' . $gp_banner_image); ?>" alt="">
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>
