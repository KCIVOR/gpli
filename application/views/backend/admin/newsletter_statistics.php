<div class="gp-dash-stats">
    <a href="<?php echo site_url('admin/newsletter_history/pending') ?>" class="gp-dash-stat">
        <span class="gp-dash-stat-value"><?php echo $this->db->where('status', 'pending')->get('newsletter_histories')->num_rows(); ?></span>
        <span class="gp-dash-stat-label"><?php echo get_phrase('Total Pending'); ?></span>
        <span class="gp-newsletter-stat-note"><?php echo get_phrase('Waiting to be sent') ?></span>
    </a>

    <a href="<?php echo site_url('admin/newsletter_history/sent') ?>" class="gp-dash-stat">
        <span class="gp-dash-stat-value"><?php echo $this->db->where('status', 'sent')->get('newsletter_histories')->num_rows(); ?></span>
        <span class="gp-dash-stat-label"><?php echo get_phrase('Total Success'); ?></span>
        <span class="gp-newsletter-stat-note"><?php echo get_phrase('Successfully sent') ?></span>
    </a>

    <a href="<?php echo site_url('admin/newsletter_history/faild') ?>" class="gp-dash-stat">
        <span class="gp-dash-stat-value"><?php echo $this->db->where('status', 'faild')->get('newsletter_histories')->num_rows(); ?></span>
        <span class="gp-dash-stat-label"><?php echo get_phrase('Total Faild'); ?></span>
        <span class="gp-newsletter-stat-note"><?php echo get_phrase('Waiting for the next cue') ?></span>
    </a>

    <a href="<?php echo site_url('admin/newsletter_history/unable') ?>" class="gp-dash-stat">
        <span class="gp-dash-stat-value"><?php echo $this->db->where('status', 'unable')->get('newsletter_histories')->num_rows(); ?></span>
        <span class="gp-dash-stat-label"><?php echo get_phrase('Unable to send'); ?></span>
        <span class="gp-newsletter-stat-note"><?php echo get_phrase('10 attempts failed, Click here to send email manually') ?></span>
    </a>
</div>
