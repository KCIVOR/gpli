<?php
defined('BASEPATH') or exit('No direct script access allowed');

$allowed_tones = ['success', 'warning', 'danger', 'info'];
$tone = isset($tone) ? $tone : 'info';
if (! in_array($tone, $allowed_tones, true)) {
    $tone = 'info';
}
$title = isset($title) ? html_escape($title) : '';
$body  = isset($body) ? $body : '';
?>
<div class="alert alert-<?php echo html_escape($tone); ?>"><div class="dot"></div><div><strong><?php echo $title; ?></strong><?php if ($body !== ''): ?><p><?php echo html_escape($body); ?></p><?php endif; ?></div></div>
