<?php if (! gp_landing_toggle('feature_trio_section')) return; ?>
<?php $gp_trio = gp_landing_extras()['trio']; ?>
<?php $gp_bg = gp_landing_bg_attrs('trio'); ?>
<section class="gp-landing gp-landing-trio<?php echo $gp_bg['class']; ?>"<?php echo $gp_bg['style']; ?>>
    <div class="container">
        <div class="gp-landing-trio-grid">
            <?php foreach ($gp_trio as $i => $item): ?>
                <div class="gp-landing-feat">
                    <h3 class="builder-editable" builder-identity="<?php echo $i + 1; ?>"><?php echo htmlspecialchars($item['title']); ?></h3>
                    <p class="builder-editable" builder-identity="<?php echo $i + 4; ?>"><?php echo htmlspecialchars($item['text']); ?></p>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
