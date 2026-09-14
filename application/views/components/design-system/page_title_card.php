<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="row">
    <div class="col-xl-12">
        <div class="card gp-page-title-card">
            <div class="card-body">
                <div class="gp-page-title-row">
                    <h4 class="page-title">
                        <i class="mdi mdi-apple-keyboard-command title_icon"></i>
                        <?php echo isset($title) ? $title : ''; ?>
                    </h4>
                    <?php if (! empty($actions)) : ?>
                        <div class="gp-page-title-actions"><?php echo $actions; ?></div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>
