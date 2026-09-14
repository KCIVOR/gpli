<?php if (! gp_landing_toggle('cta_band_section')) return; ?>
<?php $gp_cta = gp_landing_extras()['cta_band']; ?>
<?php $gp_bg = gp_landing_bg_attrs('cta_band'); ?>
<section class="gp-landing gp-landing-cta-band<?php echo $gp_bg['class']; ?>"<?php echo $gp_bg['style']; ?>>
    <div class="container">
        <h2 class="builder-editable" builder-identity="1"><?php echo htmlspecialchars($gp_cta['title']); ?></h2>
        <p class="builder-editable" builder-identity="2"><?php echo htmlspecialchars($gp_cta['text']); ?></p>
        <div class="gp-landing-actions">
            <?php echo gp_ds_button($gp_cta['cta1_label'], ['variant' => 'primary', 'href' => gp_landing_url($gp_cta['cta1_url']), 'extra_class' => 'gp-landing-btn-on-dark'], true); ?>
            <?php echo gp_ds_button($gp_cta['cta2_label'], ['variant' => 'outline', 'href' => gp_landing_url($gp_cta['cta2_url']), 'extra_class' => 'gp-landing-btn-on-dark'], true); ?>
        </div>
        <?php if ($gp_cta['footnote'] !== ''): ?>
            <p class="gp-landing-footnote builder-editable" builder-identity="3"><?php echo htmlspecialchars($gp_cta['footnote']); ?></p>
        <?php endif; ?>
    </div>
</section>
