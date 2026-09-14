<?php
if (! gp_landing_toggle('media_strip_section')) return;
$gp_media = gp_landing_extras()['media'];
$gp_has_media = $gp_media['image_1'] !== '' || $gp_media['image_2'] !== '' || $gp_media['image_3'] !== '' || $gp_media['video_url'] !== '';
if (! $gp_has_media) return;
?>
<section class="gp-landing gp-landing-media">
    <div class="container">
        <div class="gp-landing-head">
            <div class="gp-landing-eyebrow">See it in action</div>
            <h2>Featured session</h2>
        </div>
        <div class="gp-landing-media-grid">
            <div class="gp-landing-media-video">
                <?php $gp_video_thumb = $gp_media['image_1'] !== '' ? $gp_media['image_1'] : $gp_media['image_3']; ?>
                <?php if ($gp_video_thumb !== ''): ?>
                    <img class="builder-editable" builder-identity="1" loading="lazy" src="<?php echo base_url($gp_video_thumb); ?>" alt="">
                <?php endif; ?>
                <?php if ($gp_media['video_url'] !== ''): ?>
                    <a href="<?php echo gp_landing_url($gp_media['video_url']); ?>" target="_blank" rel="noopener" style="position:absolute; inset:0;" aria-label="<?php echo htmlspecialchars($gp_media['video_title']); ?>"></a>
                <?php endif; ?>
                <?php if ($gp_media['video_tag'] !== ''): ?>
                    <span class="gp-landing-media-tag builder-editable" builder-identity="2"><?php echo htmlspecialchars($gp_media['video_tag']); ?></span>
                <?php endif; ?>
                <div class="gp-landing-media-caption builder-editable" builder-identity="3"><?php echo htmlspecialchars($gp_media['video_title']); ?></div>
            </div>
            <?php if ($gp_media['image_2'] !== ''): ?>
                <div class="gp-landing-media-tile">
                    <img class="builder-editable" builder-identity="4" loading="lazy" src="<?php echo base_url($gp_media['image_2']); ?>" alt="">
                </div>
            <?php endif; ?>
            <?php if ($gp_media['image_3'] !== '' && $gp_video_thumb !== $gp_media['image_3']): ?>
                <div class="gp-landing-media-tile">
                    <img class="builder-editable" builder-identity="5" loading="lazy" src="<?php echo base_url($gp_media['image_3']); ?>" alt="">
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>
