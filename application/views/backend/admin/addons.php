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
            <a href="#installedAddon" data-toggle="tab" aria-expanded="true" class="nav-link rounded-0 active">
                <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
                <span class="d-none d-lg-block"><?php echo get_phrase('installed_addons'); ?></span>
            </a>
          </li>
          <li class="nav-item">
            <a href="<?php echo site_url('admin/available_addon'); ?>" class="nav-link rounded-0">
                <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                <span class="d-none d-lg-block"><?php echo get_phrase('available_addons'); ?></span>
            </a>
          </li>
        </ul>

        <div class="tab-content">
          <div class="tab-pane active" id="installedAddon">
            <?php
            ob_start();
            foreach ($addons as $addon) :
            ?>
                    <tr class="gradeU">
                      <td><?php echo $addon['name']; ?></td>
                      <td><?php echo $addon['version']; ?></td>
                      <td>
                        <?php if ($addon['status'] == 1) : ?>
                          <?php gp_ds_badge(get_phrase('active'), 'success'); ?>
                        <?php else : ?>
                          <?php gp_ds_badge(get_phrase('deactive'), 'neutral'); ?>
                        <?php endif; ?>
                      </td>
                      <td>
                        <div class="dropright dropright">
                          <button type="button" class="btn btn-sm btn-outline-primary btn-rounded btn-icon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="mdi mdi-dots-vertical"></i>
                          </button>
                          <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="<?php echo site_url('admin/addon/update'); ?>"><?php echo get_phrase('addon_update'); ?></a></li>
                            <?php if ($addon['status'] == 1) : ?>
                              <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/addon/deactivate/' . $addon['id']); ?>');"><?php echo get_phrase('deactive'); ?></a></li>
                            <?php else : ?>
                              <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/addon/activate/' . $addon['id']); ?>');"><?php echo get_phrase('active'); ?></a></li>
                            <?php endif; ?>
                            <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/addon/delete/' . $addon['id']); ?>');"><?php echo get_phrase('delete'); ?></a></li>
                            <li><a class="dropdown-item" href="javascript:;" onclick="showAjaxModal('<?php echo site_url('modal/popup/about_this_addon/' . $addon['id']); ?>', '<?php echo get_phrase('about_this_addon'); ?>')"><?php echo get_phrase('about_this_addon'); ?></a></li>
                          </ul>
                        </div>
                      </td>
                    </tr>
            <?php
            endforeach;
            echo gp_ds_table([
                'table_id' => 'basic-datatable',
                'extra_class' => 'table-striped mb-0',
                'headers' => [
                    get_phrase('name'),
                    get_phrase('version'),
                    get_phrase('status'),
                    get_phrase('actions'),
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
