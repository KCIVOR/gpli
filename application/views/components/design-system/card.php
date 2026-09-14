<?php
defined('BASEPATH') or exit('No direct script access allowed');
$extra_class = isset($extra_class) ? $extra_class : (isset($class) ? $class : '');
$body_class  = isset($body_class) ? $body_class : '';
?>
<div class="card <?php echo html_escape($extra_class); ?>">
    <?php if (! empty($header)): ?>
        <div class="card-header"><?php echo $header; ?></div>
    <?php endif; ?>
    <div class="card-body <?php echo html_escape($body_class); ?>">
        <?php if (! empty($title)): ?>
            <h4 class="<?php echo ! empty($title_class) ? html_escape($title_class) : 'header-title'; ?>"><?php echo $title; ?></h4>
        <?php endif; ?>
        <?php echo isset($body) ? $body : ''; ?>
    </div>
    <?php if (! empty($footer)): ?>
        <div class="card-footer"><?php echo $footer; ?></div>
    <?php endif; ?>
</div>
