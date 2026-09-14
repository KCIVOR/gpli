<?php
gp_ds_page_title(
    get_phrase('custom_pages'),
    gp_ds_button(get_phrase('add_a_new_page'), [
        'href' => site_url('admin/add_custom_page'),
        'variant' => 'outline',
    ], true)
);
?>
<div class="gp-settings-page">
<div class="row justify-content-center">
  <div class="col-xl-12">
    <?php
    ob_start();
    foreach ($custom_pages->result_array() as $custom_page) :
    ?>
                <tr class="gradeU">
                  <td><?php echo $custom_page['page_title']; ?></td>
                  <td><?php echo $custom_page['button_title']; ?></td>
                  <td><?php echo get_phrase($custom_page['button_position']); ?></td>
                  <td>
                    <div class="dropright dropright">
                      <button type="button" class="icon-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="mdi mdi-dots-vertical"></i>
                      </button>
                      <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="<?php echo site_url('admin/edit_custom_page/'.$custom_page['custom_page_id']); ?>"><?php echo get_phrase('edit'); ?></a></li>
                        <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/custom_page/delete/' . $custom_page['custom_page_id']); ?>');"><?php echo get_phrase('delete'); ?></a></li>
                      </ul>
                    </div>
                  </td>
                </tr>
    <?php
    endforeach;
    $custom_page_rows = ob_get_clean();

    gp_ds_card([
        'body' => gp_ds_table([
            'table_id' => 'basic-datatable',
            'extra_class' => 'mb-0',
            'headers' => [
                get_phrase('page_title'),
                get_phrase('button_title'),
                get_phrase('button_position'),
                get_phrase('actions'),
            ],
            'body_html' => $custom_page_rows,
            'allow_empty' => true,
        ], true),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
  </div>
</div>
</div>
