<?php
$curl_enabled = function_exists('curl_version');
$installed_themes = $this->crud_model->get_installed_themes();
$uninstalled_themes = $this->crud_model->get_uninstalled_themes();
?>

<?php
gp_ds_page_title(
    get_phrase('theme_settings'),
    gp_ds_button(get_phrase('buy_new_theme'), [
        'href' => 'https://academy-lms.com/themes',
        'variant' => 'outline',
        'attrs' => [
            'target' => '_blank',
        ],
    ], true) . ' ' . gp_ds_button(get_phrase('upload_your_theme_file'), [
        'href' => 'javascript:;',
        'variant' => 'outline',
        'attrs' => [
            'onclick' => "showAjaxModal('" . site_url('admin/upload_theme') . "', '" . get_phrase('upload_your_theme_file') . "');",
        ],
    ], true)
);
?>

<div class="gp-themes-page">
<?php foreach ($uninstalled_themes as $key => $uninstalled_theme) : ?>
  <div class="gp-themes-uninstalled" role="alert">
    <div>
      <i class="dripicons-information mr-2"></i>
      <strong><?php echo ucfirst(substr($uninstalled_theme, 0, -4)); ?></strong>
      <?php echo get_phrase('theme_is_showed_up') . '. ' . get_phrase('hit_the_install_button_for_installing'); ?>.
    </div>
    <?php echo gp_ds_button(get_phrase('install') . ' ' . ucfirst(substr($uninstalled_theme, 0, -4)) . ' ' . get_phrase('theme'), [
        'href' => site_url('admin/install_theme/' . $uninstalled_theme),
        'variant' => 'primary',
    ], true); ?>
  </div>
<?php endforeach; ?>

    <?php
    ob_start();
    ?>
            <div class="row">
              <?php foreach ($installed_themes as $key => $installed_theme) : ?>
                <div class="col-xl-4 mb-3">
                  <div class="gp-themes-tile">
                    <img class="card-img-top" src="<?php echo base_url('assets/frontend/' . $installed_theme . '/preview.png'); ?>" alt="">
                    <div class="pt-3">
                      <h5 class="gp-themes-tile-title"><?php echo ucfirst($installed_theme); ?></h5>
                      <div class="gp-themes-tile-actions">
                            <?php if (get_frontend_settings('theme') == $installed_theme) : ?>
                              <?php echo gp_ds_button(get_phrase('active_theme'), [
                                  'href' => 'javascript:;',
                                  'variant' => 'primary',
                              ], true); ?>
                            <?php else : ?>
                              <?php echo gp_ds_button(get_phrase('activate'), [
                                  'href' => 'javascript:;',
                                  'variant' => 'outline',
                                  'attrs' => [
                                      'onclick' => "activate_theme('" . $installed_theme . "')",
                                  ],
                              ], true); ?>
                              <?php echo gp_ds_button(get_phrase('remove'), [
                                  'href' => 'javascript:;',
                                  'variant' => 'secondary',
                                  'attrs' => [
                                      'onclick' => "confirm_modal('" . site_url('admin/theme_actions/remove/' . $installed_theme) . "');",
                                  ],
                              ], true); ?>
                            <?php endif; ?>
                      </div>
                    </div>
                  </div>
                </div>
              <?php endforeach; ?>
            </div>
    <?php
    gp_ds_card([
        'title' => get_phrase('installed_themes'),
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script type="text/javascript">
  function activate_theme(theme) {
    $.ajax({
      url: '<?php echo site_url('admin/theme_actions/activate/'); ?>'+theme,
      type: 'POST',
      data: {
        theme: theme
      },
      success: function(response) {
        if (response) {
          success_notify(theme.toUpperCase() + ' <?php echo get_phrase('theme_successfully_activated') ?>');
          setTimeout(
            function() {
              location.reload();
            }, 1000);
        } else {
          error_notify('<?php echo get_phrase('you_do_not_have_right_to_access_this_theme'); ?>');
        }
      }
    });
  }
</script>
