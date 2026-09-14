<?php
defined('BASEPATH') or exit('No direct script access allowed');

$allowed_variants = ['primary', 'secondary', 'outline', 'quiet'];
$variant = isset($variant) ? $variant : 'primary';
if (! in_array($variant, $allowed_variants, true)) {
    $variant = 'primary';
}

$href        = isset($href) ? $href : '';
$extra_class = isset($extra_class) ? $extra_class : '';
$attrs       = isset($attrs) && is_array($attrs) ? $attrs : [];
$tag         = isset($tag) ? $tag : '';
if ($tag !== 'a' && $tag !== 'button') {
    $tag = ($href !== '') ? 'a' : 'button';
}
$type = (isset($type) && $type !== '') ? $type : 'button';

$class = 'btn btn-' . $variant;
if ($extra_class !== '') {
    $class .= ' ' . $extra_class;
}

$attr_html = '';
foreach ($attrs as $key => $value) {
    if (! is_string($key) || ! preg_match('/^[a-zA-Z][a-zA-Z0-9:_-]*$/', $key)) {
        continue;
    }
    if (in_array(strtolower($key), ['href', 'class', 'type'], true)) {
        continue;
    }
    $attr_html .= ' ' . $key . '="' . html_escape($value) . '"';
}

$label = isset($label) ? html_escape($label) : '';
?>
<?php if ($tag === 'a'): ?>
<a href="<?php echo html_escape($href); ?>" class="<?php echo html_escape($class); ?>"<?php echo $attr_html; ?>><?php echo $label; ?></a>
<?php else: ?>
<button type="<?php echo html_escape($type); ?>" class="<?php echo html_escape($class); ?>"<?php echo $attr_html; ?>><?php echo $label; ?></button>
<?php endif; ?>
