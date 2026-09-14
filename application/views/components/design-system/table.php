<?php
defined('BASEPATH') or exit('No direct script access allowed');
$headers     = isset($headers) && is_array($headers) ? $headers : [];
$rows        = isset($rows) && is_array($rows) ? $rows : [];
$extra_class = isset($extra_class) ? $extra_class : '';
$empty       = (isset($empty) && $empty !== null && $empty !== '') ? $empty : get_phrase('no_data_found');
$table_id    = isset($table_id) ? $table_id : '';
$body_html   = isset($body_html) ? $body_html : '';
$allow_empty = ! empty($allow_empty);
$table_attrs = (isset($table_attrs) && is_array($table_attrs)) ? $table_attrs : [];
$responsive  = ! isset($responsive) || $responsive;
$colspan     = max(1, count($headers));

$class = 'table data-table table-centered w-100';
if ($extra_class !== '') {
    $class .= ' ' . $extra_class;
}

$attr_html = '';
if ($table_id !== '') {
    $attr_html .= ' id="' . html_escape($table_id) . '"';
}
foreach ($table_attrs as $key => $value) {
    if (! is_string($key) || ! preg_match('/^[a-zA-Z][a-zA-Z0-9:_-]*$/', $key)) {
        continue;
    }
    if (in_array(strtolower($key), ['id', 'class'], true)) {
        continue;
    }
    $attr_html .= ' ' . $key . '="' . html_escape($value) . '"';
}

$has_body_html = $body_html !== '';
$show_empty    = ! $has_body_html && empty($rows) && ! $allow_empty;
?>
<?php if ($responsive): ?>
<div class="table-responsive">
<?php endif; ?>
    <table class="<?php echo html_escape($class); ?>"<?php echo $attr_html; ?>>
        <?php if (! empty($headers)): ?>
            <thead>
                <tr>
                    <?php foreach ($headers as $header): ?>
                        <th><?php echo $header; ?></th>
                    <?php endforeach; ?>
                </tr>
            </thead>
        <?php endif; ?>
        <tbody>
            <?php if ($has_body_html): ?>
                <?php echo $body_html; ?>
            <?php elseif ($show_empty): ?>
                <tr>
                    <td colspan="<?php echo (int) $colspan; ?>"><?php echo $empty; ?></td>
                </tr>
            <?php else: ?>
                <?php foreach ($rows as $row): ?>
                    <tr>
                        <?php foreach ((array) $row as $cell): ?>
                            <td><?php echo $cell; ?></td>
                        <?php endforeach; ?>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
<?php if ($responsive): ?>
</div>
<?php endif; ?>
