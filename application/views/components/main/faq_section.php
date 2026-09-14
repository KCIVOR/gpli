<?php if (! (get_frontend_settings('faq_section') == 1)) return; ?>
<?php $gp_faqs = json_decode(get_frontend_settings('website_faqs'), true); ?>
<?php if (! is_array($gp_faqs) || count($gp_faqs) === 0) return; ?>
<section class="gp-landing gp-landing-faq">
    <div class="container">
        <div class="gp-landing-faq-grid">
            <div class="gp-landing-faq-intro">
                <div class="gp-landing-eyebrow">FAQ</div>
                <h2><?php echo get_phrase('Frequently Asked Questions'); ?></h2>
                <p><?php echo get_phrase('Have something to know?') . ' ' . get_phrase('Check here if you have any questions about us.'); ?></p>
                <div class="gp-landing-faq-contact">
                    <div class="gp-landing-faq-contact-icon">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none"><path d="M2.5 5.5 9.15 10a1.5 1.5 0 0 0 1.7 0L17.5 5.5M4 15.5h12A1.5 1.5 0 0 0 17.5 14V6a1.5 1.5 0 0 0-1.5-1.5H4A1.5 1.5 0 0 0 2.5 6v8A1.5 1.5 0 0 0 4 15.5Z" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </div>
                    <h4><?php echo get_phrase('Still have questions?'); ?></h4>
                    <p><?php echo get_phrase("Can't find the answer you're looking for? Our team is happy to help."); ?></p>
                    <?php echo gp_ds_button(get_phrase('Contact us'), ['variant' => 'outline', 'href' => site_url('home/contact_us')], true); ?>
                </div>
            </div>
            <div class="gp-landing-faq-list" id="accordionFaq">
                <?php foreach ($gp_faqs as $key => $gp_faq):
                    if ($key > 4) break;
                    $gp_open = $key === 0;
                ?>
                    <div class="gp-landing-faq-item">
                        <button class="gp-landing-faq-q" type="button"
                            data-bs-toggle="collapse" data-bs-target="#faqItempanel<?php echo $key; ?>"
                            aria-expanded="<?php echo $gp_open ? 'true' : 'false'; ?>" aria-controls="faqItempanel<?php echo $key; ?>">
                            <span class="gp-landing-faq-num"><?php echo sprintf('%02d', $key + 1); ?></span>
                            <span class="gp-landing-faq-q-text"><?php echo $gp_faq['question']; ?></span>
                            <span class="gp-landing-faq-icon"></span>
                        </button>
                        <div id="faqItempanel<?php echo $key; ?>" class="collapse<?php echo $gp_open ? ' show' : ''; ?>"
                            data-bs-parent="#accordionFaq">
                            <div class="gp-landing-faq-a"><p><?php echo nl2br($gp_faq['answer']); ?></p></div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</section>
