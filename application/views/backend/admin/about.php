<?php
  $curl_enabled = function_exists('curl_version');
?>
  <?php gp_ds_page_title(get_phrase('about_this_application')); ?>
  <div class="gp-settings-page">
  <div class="row justify-content-center">
    <div class="col-xl-9">
      <?php
      ob_start();
      ?>
          <div class="gp-settings-about-layout">
            <div class="list-group">
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('software_version'); ?>
                  </span>
                  <span class="gp-settings-about-value"><?php echo get_settings('version'); ?></span>
                </div>
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('check_update'); ?>
                  </span>
                  <span class="gp-settings-about-value">
                      <a href="https://codecanyon.net/user/creativeitem/portfolio"
                        target="_blank" class="gp-settings-help-link">
                          <i class="mdi mdi-telegram"></i>
                            <?php echo get_phrase('check_update'); ?>
                      </a>
                  </span>
                </div>
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('php_version'); ?>
                  </span>
                  <span class="gp-settings-about-value"><?php echo phpversion(); ?></span>
                </div>
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('curl_enable') ?>
                  </span>
                  <span class="gp-settings-about-value">
                    <?php echo $curl_enabled ? gp_ds_badge(get_phrase('enabled'), 'success', true) : gp_ds_badge(get_phrase('disabled'), 'danger', true); ?>
                  </span>
                </div>

                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('purchase_code'); ?>
                  </span>
                  <span class="gp-settings-about-value"><?php echo get_settings('purchase_code'); ?></span>
                </div>

                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('product_license'); ?>
                  </span>
                  <span class="gp-settings-about-value">
                  <?php if($application_details['product_license'] == 'valid'): ?>
                    <?php echo gp_ds_badge(get_phrase($application_details['product_license']), 'success', true); ?>
                  <?php else: ?>
                    <?php echo gp_ds_badge(get_phrase($application_details['product_license']), 'danger', true); ?>
                    <?php echo gp_ds_button(get_phrase('enter_valid_purchase_code'), [
                      'variant' => 'primary',
                      'attrs' => [
                        'onclick' => "showAjaxModal('" . site_url('admin/save_valid_purchase_code') . "', '" . get_phrase('enter_valid_purchase_code') . "');",
                      ],
                    ], true); ?>
                  <?php endif; ?>
                  </span>
                </div>
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('customer_support_status'); ?>
                  </span>
                  <span class="gp-settings-about-value">
                    <?php if (strtolower($application_details['purchase_code_status']) == 'expired'): ?>
                      <?php echo gp_ds_badge(get_phrase($application_details['purchase_code_status']), 'danger', true); ?>
                      <?php echo gp_ds_button(get_phrase('renew_support'), [
                        'variant' => 'outline',
                        'href' => 'https://codecanyon.net/item/academy-course-based-learning-management-system/22703468',
                        'attrs' => ['target' => '_blank'],
                      ], true); ?>
                    <?php elseif (strtolower($application_details['purchase_code_status']) == 'valid'): ?>
                      <?php echo gp_ds_badge(get_phrase($application_details['purchase_code_status']), 'success', true); ?>
                    <?php else: ?>
                      <?php echo gp_ds_badge(get_phrase($application_details['purchase_code_status']), 'danger', true); ?>
                    <?php endif; ?>
                  </span>
                </div>
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('support_expiry_date'); ?>
                  </span>
                    <?php if ($application_details['support_expiry_date'] != "invalid"): ?>
                        <span class="gp-settings-about-value"><?php echo $application_details['support_expiry_date']; ?></span>
                    <?php else: ?>
                        <span class="gp-settings-about-value"><?php echo gp_ds_badge(ucfirst($application_details['support_expiry_date']), 'danger', true); ?></span>
                    <?php endif; ?>
                </div>
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('customer_name') ?>
                  </span>
                  <?php if ($application_details['customer_name'] != "invalid"): ?>
                      <span class="gp-settings-about-value"><?php echo $application_details['customer_name']; ?></span>
                  <?php else: ?>
                      <span class="gp-settings-about-value"><?php echo gp_ds_badge(ucfirst($application_details['customer_name']), 'danger', true); ?></span>
                  <?php endif; ?>
                </div>
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('get_customer_support'); ?>
                  </span>
                  <span class="gp-settings-about-value"><a href="https://support.creativeitem.com" target="_blank" class="gp-settings-help-link"> <i class="mdi mdi-telegram"></i> <?php echo get_phrase('customer_support'); ?> </a></span>
                </div>
                <div class="list-group-item">
                  <span class="gp-settings-about-label">
                    <i class="mdi mdi-square"></i> <?php echo get_phrase('Our Premium Services'); ?>
                  </span>
                  <span class="gp-settings-about-value"><?php echo gp_ds_button(get_phrase('Get Services'), [
                    'variant' => 'outline',
                    'href' => 'https://creativeitem.com/services',
                    'attrs' => ['target' => '_blank'],
                  ], true); ?></span>
                </div>
            </div>
            <img class="gp-settings-about-art" src="<?php echo base_url('assets/backend/images/report.svg'); ?>" width="120" alt="Generic placeholder image">
          </div>
      <?php
      gp_ds_card([
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
      ]);
      ?>
    </div>
  </div>
  </div>
