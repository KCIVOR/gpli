<?php include "breadcrumb.php"; ?>

<?php $website_faqs = json_decode(get_frontend_settings('website_faqs'), true); ?>
<?php if (count($website_faqs) > 0): ?>
<!---------- Questions Section Start  -------------->
<section class="gp-faq-page">
    <div class="container">
        <div class="gp-faq-page-intro">
            <div class="gp-faq-page-eyebrow"><?php echo get_phrase('FAQS') ?></div>
            <h2><?php echo get_phrase('Looking for answers?') ?></h2>
        </div>
        <div class="gp-faq-page-list" id="accordionFaq">
            <?php foreach ($website_faqs as $key => $faq):
                $gp_open = $key === 0;
            ?>
                <div class="gp-faq-page-item">
                    <button class="gp-faq-page-q" type="button"
                        data-bs-toggle="collapse" data-bs-target="#faqItempanel<?php echo $key; ?>"
                        aria-expanded="<?php echo $gp_open ? 'true' : 'false'; ?>" aria-controls="faqItempanel<?php echo $key; ?>">
                        <span class="gp-faq-page-num"><?php echo sprintf('%02d', $key + 1); ?></span>
                        <span class="gp-faq-page-q-text"><?php echo $faq['question']; ?></span>
                        <span class="gp-faq-page-icon"></span>
                    </button>
                    <div id="faqItempanel<?php echo $key; ?>" class="collapse<?php echo $gp_open ? ' show' : ''; ?>"
                        data-bs-parent="#accordionFaq">
                        <div class="gp-faq-page-a"><p><?php echo nl2br($faq['answer']); ?></p></div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
        <div class="gp-faq-page-cta">
            <div>
                <h3><?php echo get_phrase('Still have questions?'); ?></h3>
                <p><?php echo get_phrase("Can't find the answer you're looking for? Our team is happy to help."); ?></p>
            </div>
            <?php echo gp_ds_button(get_phrase('Contact us'), ['variant' => 'primary', 'href' => site_url('home/contact_us')], true); ?>
        </div>
    </div>
</section>
<!---------- Questions Section End  -------------->
<?php endif; ?>
