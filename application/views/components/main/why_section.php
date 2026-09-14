<?php if (! gp_landing_toggle('why_section')) return; ?>
<?php $gp_why = gp_landing_extras()['why']; ?>
<?php $gp_bg = gp_landing_bg_attrs('why'); ?>
<section class="gp-landing gp-landing-why<?php echo $gp_bg['class']; ?>"<?php echo $gp_bg['style']; ?>>
    <div class="container gp-landing-why-body">
        <div>
            <div class="gp-landing-eyebrow builder-editable" builder-identity="1"><?php echo htmlspecialchars($gp_why['eyebrow']); ?></div>
            <h2 class="builder-editable" builder-identity="2"><?php echo htmlspecialchars($gp_why['title']); ?></h2>
            <p class="builder-editable" builder-identity="3"><?php echo htmlspecialchars($gp_why['text']); ?></p>
            <div class="gp-landing-why-tiles">
                <?php foreach ($gp_why['tiles'] as $i => $tile): ?>
                    <div class="gp-landing-why-tile">
                        <div class="gp-landing-dot"><?php echo $i + 1; ?></div>
                        <div>
                            <h4 class="builder-editable" builder-identity="<?php echo 10 + $i; ?>"><?php echo htmlspecialchars($tile['title']); ?></h4>
                            <p class="builder-editable" builder-identity="<?php echo 20 + $i; ?>"><?php echo htmlspecialchars($tile['text']); ?></p>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
        <div class="gp-landing-why-stats">
            <?php foreach ($gp_why['stats'] as $i => $stat): ?>
                <div class="gp-landing-why-stat">
                    <div class="num builder-editable" builder-identity="<?php echo 30 + $i; ?>"><?php echo htmlspecialchars($stat['num']); ?></div>
                    <div class="lbl builder-editable" builder-identity="<?php echo 40 + $i; ?>"><?php echo htmlspecialchars($stat['lbl']); ?></div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
