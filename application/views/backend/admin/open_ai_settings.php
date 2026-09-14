<?php
$ai_model_path = APPPATH . 'models/addons/Ai_model.php';
$addon_present = file_exists($ai_model_path);

gp_ds_page_title(get_phrase('openai_settings'));
?>
<div class="gp-settings-page">
<?php
if ($addon_present) {
    $body = '<p>' . get_phrase('openai_settings') . '</p>';
} else {
    $body = '<p>' . get_phrase('addon_not_found') . '</p>'
        . '<p>addons/ai_model</p>';
}

gp_ds_card([
    'title' => get_phrase('openai_settings'),
    'body'  => $body,
]);
?>
</div>
