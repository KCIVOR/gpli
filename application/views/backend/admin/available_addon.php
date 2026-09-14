<?php gp_ds_page_title(get_phrase('available_addons')); ?>

<div class="gp-addons-page">
<div class="row justify-content-center">
  <div class="col-md-12">
    <?php
    ob_start();
    ?>
        <iframe scrolling="yes" class="gp-addons-iframe" frameborder="none" src="http://academy-lms.com/mobile.php"></iframe>
    <?php
    gp_ds_card([
        'title' => get_phrase('all_available_addon'),
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
  </div>
</div>
</div>
