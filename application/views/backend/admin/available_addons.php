<?php
gp_ds_page_title(
    get_phrase('addon_manager'),
    gp_ds_button(get_phrase('buy_new_addon'), [
        'href' => 'https://1.envato.market/B32Ry',
        'variant' => 'outline',
        'attrs' => [
            'target' => '_blank',
        ],
    ], true) . ' ' . gp_ds_button(get_phrase('install_addon'), [
        'href' => site_url('admin/addon/add'),
        'variant' => 'outline',
    ], true)
);
?>

<div class="gp-addons-page">
    <?php
    ob_start();
    ?>
        <ul class="nav nav-tabs nav-bordered mb-3 mb-3">
          <li class="nav-item">
            <a href="<?php echo site_url('admin/addon'); ?>" class="nav-link rounded-0">
                <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
                <span class="d-none d-lg-block"><?php echo get_phrase('installed_addons'); ?></span>
            </a>
          </li>
          <li class="nav-item">
            <a href="#availableAddon" data-toggle="tab" aria-expanded="true" class="nav-link rounded-0 active">
                <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                <span class="d-none d-lg-block"><?php echo get_phrase('available_addons'); ?></span>
            </a>
          </li>
        </ul>

        <div class="tab-content">
          <div class="tab-pane active" id="availableAddon">
            <?php
            ob_start();
            foreach ($items as $item):
                if (isset($item['previews']['icon_with_video_preview']['icon_url'])) {
                    $icon_url = $item['previews']['icon_with_video_preview']['icon_url'];
                } else {
                    $icon_url = $item['previews']['icon_with_landscape_preview']['icon_url'];
                }

                if (is_array($item['attributes'][2]['value'])) {
                    $demo_url = $item['attributes'][1]['value'];
                } else {
                    $demo_url = $item['attributes'][2]['value'];
                }
            ?>
                      <tr>
                        <td>
                            <img src="<?php echo $icon_url; ?>" alt="contact-img" title="contact-img" class="rounded mr-3" height="48" />
                            <p class="m-0 d-inline-block align-middle font-16">
                                <a target="_blank" href="<?php echo $item['url']; ?>" class="text-body">
                                  <?php
                                    echo $item['name'];
                                    if ($item['id'] == '22703468') {
                                      echo ' | ';
                                      gp_ds_badge('Main product', 'primary');
                                    }
                                  ?>
                                </a>
                                <br/>

                                <span class="text-muted">
                                  <span class="text-muted text-13">
                                    <?php echo nice_number($item['number_of_sales']); ?> Sales |
                                  </span>

                                  <span>
                                    <?php for ($i = 1; $i <= 5; $i++): ?>
                                      <?php if ($i <= $item['rating'] || $item['rating'] >= 4.5): ?>
                                        <span class="text-warning mdi mdi-star"></span>
                                      <?php else: ?>
                                        <span class="text-light mdi mdi-star"></span>
                                      <?php endif; ?>
                                    <?php endfor; ?>
                                  </span>

                                </span>


                            </p>

                        </td>
                        <td>
                            $<?php echo $item['price_cents'] / 100; ?>
                        </td>

                        <td class="table-action">
                          <a href="<?php echo $item['url']; ?>" data-toggle="tooltip" title="Buy now" class="action-icon" target="_blank"><i class="mdi mdi-cart-outline"></i></a>
                          <a href="<?php echo $demo_url; ?>" data-toggle="tooltip" title="Watch demo" class="action-icon" target="_blank"><i class="mdi mdi-open-in-new"></i></a>
                        </td>
                      </tr>
            <?php
            endforeach;
            echo gp_ds_table([
                'table_id' => 'products-datatable',
                'extra_class' => 'dt-responsive nowrap mb-0',
                'headers' => [
                    'Product',
                    'Price',
                    'Action',
                ],
                'body_html' => ob_get_clean(),
                'allow_empty' => true,
            ], true);
            ?>
          </div>
        </div>
    <?php
    gp_ds_card([
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
