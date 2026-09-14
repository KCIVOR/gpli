<?php
gp_ds_page_title(
    $page_title,
    gp_ds_button(get_phrase('Newsletter'), [
        'href' => '#',
        'variant' => 'outline',
        'attrs' => [
            'onclick' => "showAjaxModal('" . site_url('admin/newsletter_add_form') . "', '" . get_phrase('Newsletter template') . "')",
        ],
    ], true)
);
?>

<div class="gp-newsletter-page">
    <div id="newsletter_statistics">
        <?php include "newsletter_statistics.php"; ?>
    </div>

    <div class="row">
        <div class="col-lg-8">
            <div id="accordion" class="custom-accordion mb-4">

                <?php $newsletters = $this->db->get('newsletters')->result_array(); ?>
                <?php foreach ($newsletters as $newsletter) : ?>
                    <div class="card mb-0">
                        <div class="card-header py-0" id="headingOne<?= $newsletter['id'] ?>">
                            <h5 class="">
                                <a class="custom-accordion-title d-flex flex-wrap align-items-center <?php echo isset($_GET['tab']) && $_GET['tab'] == $newsletter['id'] ? '' : 'collapsed'; ?> pt-2 pb-2" data-toggle="collapse" href="#collapseOne<?= $newsletter['id']; ?>" aria-expanded="true" aria-controls="collapseOne<?= $newsletter['id'] ?>">
                                    <p class="mb-0">
                                        <i class="mdi mdi-arrow-right-bold-outline"></i>
                                        <?php echo $newsletter['subject']; ?>
                                    </p>

                                    <p class="mb-0 ml-auto" style="min-width: 175px;">
                                        <span class="float-right">
                                            <i class="mdi mdi-chevron-down accordion-arrow"></i>
                                        </span>
                                        <span onclick="stopProp(event)">
                                            <button type="button" class="icon-btn float-right" onclick="confirm_modal('<?php echo site_url('admin/newsletters/delete/' . $newsletter['id']); ?>')" data-toggle="tooltip" title="<?php echo get_phrase('Delete'); ?>">
                                                <i class="mdi mdi-delete"></i>
                                            </button>
                                            <button type="button" class="icon-btn float-right" onclick="showAjaxModal('<?php echo site_url('admin/newsletter_edit_form/' . $newsletter['id']); ?>', '<?php echo get_phrase('Edit newsletter template') ?>')" data-toggle="tooltip" title="<?php echo get_phrase('Edit'); ?>">
                                                <i class="mdi mdi-pencil"></i>
                                            </button>
                                            <button type="button" class="icon-btn float-right" onclick="showAjaxModal('<?php echo site_url('admin/newsletter_send_form/' . $newsletter['id']); ?>', '<?php echo get_phrase('Send Newsletter') ?>')" data-toggle="tooltip" title="<?php echo get_phrase('Send'); ?>">
                                                <i class="mdi mdi-send  mdi-rotate-315"></i>
                                            </button>
                                        </span>
                                    </p>
                                </a>
                            </h5>
                        </div>

                        <div id="collapseOne<?= $newsletter['id'] ?>" class="collapse <?php echo isset($_GET['tab']) && $_GET['tab'] == $newsletter['id'] ? 'show' : ''; ?>" aria-labelledby="headingOne<?= $newsletter['id'] ?>" data-parent="#accordion">
                            <div class="card-body">
                                <?php echo $newsletter['description']; ?>
                            </div>
                        </div>
                    </div> <!-- end card-->
                <?php endforeach; ?>

            </div> <!-- end custom accordions-->
        </div>
        <div class="col-lg-4">
            <div class="gp-newsletter-notice" role="alert">
                <h4 class="alert-heading"><?php echo get_phrase('Heads up'); ?>!</h4>
                <p>If you want to send a newsletter to more than 20 users at once, the system will automatically divide them into chunks of 20. Every minute, the server will initiate a process to send 20 emails at a time. In order to complete this task, the website needs to remain active in a browser until all the emails are successfully sent.</p>
                <hr>
                <p>Alternatively, you have the option to configure a cronjob manually for sending emails, eliminating the need to keep the website open.</p>
                <?php if (is_file('uploads/cronjob/newsletter_cron.php') && file_exists('uploads/cronjob/newsletter_cron.php')) : ?>
                    <p>
                        <code class="gp-newsletter-cron-path">
                            <?php echo realpath(APPPATH . '..') . '/uploads/cronjob/newsletter_cron.php'; ?>
                        </code>
                    </p>
                    <?php echo gp_ds_button(get_phrase('Remove Cronjob file'), [
                        'href' => site_url('admin/cronjob/stop'),
                        'variant' => 'outline',
                    ], true); ?>
                <?php else : ?>
                    <?php echo gp_ds_button(get_phrase('Create Cronjob file'), [
                        'href' => site_url('admin/cronjob/start'),
                        'variant' => 'primary',
                    ], true); ?>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function stopProp(event) {
        event.stopPropagation();
    }
</script>
