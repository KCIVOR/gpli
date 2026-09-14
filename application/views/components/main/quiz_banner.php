<?php if (! gp_landing_toggle('quiz_banner_section')) return; ?>
<?php $gp_quiz = gp_landing_extras()['quiz']; ?>
<?php $gp_bg = gp_landing_bg_attrs('quiz'); ?>
<section class="gp-landing gp-landing-quiz-wrap<?php echo $gp_bg['class']; ?>"<?php echo $gp_bg['style']; ?>>
    <div class="container">
        <div class="gp-landing-quiz">
            <div class="gp-landing-quiz-copy">
                <div class="gp-landing-eyebrow builder-editable" builder-identity="1"><?php echo htmlspecialchars($gp_quiz['eyebrow']); ?></div>
                <h2 class="builder-editable" builder-identity="2"><?php echo htmlspecialchars($gp_quiz['title']); ?></h2>
                <p class="builder-editable" builder-identity="3"><?php echo htmlspecialchars($gp_quiz['text']); ?></p>
            </div>
            <?php if ($gp_quiz['button_url'] !== ''): ?>
                <div class="gp-landing-quiz-actions">
                    <?php echo gp_ds_button($gp_quiz['button_label'], ['variant' => 'primary', 'href' => gp_landing_url($gp_quiz['button_url']), 'extra_class' => 'gp-landing-btn-on-dark'], true); ?>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>
