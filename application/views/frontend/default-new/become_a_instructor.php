<div class="gp-instructor-apply">
<?php include "breadcrumb.php"; ?>

<section class="gp-instructor-apply-shell">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <?php
                ob_start();
                ?>
                <form class="gp-ds-form gp-instructor-apply-form" action="<?php echo site_url('home/become_an_instructor'); ?>" method="post" enctype="multipart/form-data">
                    <div class="gp-instructor-field">
                        <label for="phone"><?php echo get_phrase('Your Phone'); ?></label>
                        <input id="phone" type="phone" name="phone" placeholder="<?php echo get_phrase('Enter your phone number'); ?>" required>
                    </div>

                    <div class="gp-instructor-field">
                        <label for="document"><?php echo get_phrase('Document'); ?></label>
                        <div class="upload-zone">
                            <input class="gp-instructor-file" id="document" type="file" name="document" required>
                            <div class="gp-instructor-upload-copy" aria-hidden="true">
                                <div class="icon">⇪</div>
                                <h4><?php echo get_phrase('Document'); ?></h4>
                                <p>
                                    <?php echo get_phrase('Provide some documents about your qualifications'); ?>
                                    <span class="browse"><?php echo get_phrase('Browse'); ?></span>
                                    (doc, docs, pdf, txt, png, jpg, jpeg)
                                </p>
                            </div>
                        </div>
                        <div class="file-chip-list" id="gp-instructor-file-chip" hidden>
                            <div class="file-chip">
                                <span class="name" id="gp-instructor-file-name"></span>
                            </div>
                        </div>
                    </div>

                    <div class="gp-instructor-field">
                        <label for="message"><?php echo get_phrase('message'); ?></label>
                        <textarea id="message" name="message" rows="4"></textarea>
                    </div>

                    <?php
                    gp_ds_button(get_phrase('Submit'), [
                        'variant'     => 'primary',
                        'type'        => 'submit',
                        'extra_class' => 'gp-instructor-cta',
                    ]);
                    ?>
                </form>
                <?php
                gp_ds_card([
                    'title'       => get_phrase('Become an instructor'),
                    'extra_class' => 'gp-instructor-apply-card',
                    'body'        => ob_get_clean(),
                ]);
                ?>
            </div>
        </div>
    </div>
</section>
</div>

<script>
(function () {
    var input = document.getElementById('document');
    var chip = document.getElementById('gp-instructor-file-chip');
    var name = document.getElementById('gp-instructor-file-name');
    if (!input || !chip || !name) {
        return;
    }
    input.addEventListener('change', function () {
        if (!this.files || !this.files[0]) {
            chip.hidden = true;
            name.textContent = '';
            return;
        }
        name.textContent = this.files[0].name;
        chip.hidden = false;
    });
})();
</script>
