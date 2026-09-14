<?php
defined('BASEPATH') or exit('No direct script access allowed');

$allowed_tones = ['primary', 'secondary', 'success', 'warning', 'danger', 'neutral'];
$tone = isset($tone) ? $tone : 'neutral';
if (! in_array($tone, $allowed_tones, true)) {
    $tone = 'neutral';
}
$label = isset($label) ? html_escape($label) : '';
?>
<span class="badge badge-<?php echo html_escape($tone); ?>"><?php echo $label; ?></span>
