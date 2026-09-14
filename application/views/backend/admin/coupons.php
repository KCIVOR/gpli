<?php
gp_ds_page_title(
    get_phrase('coupons'),
    gp_ds_button(get_phrase('add') . ' ' . get_phrase('coupon'), [
        'href' => site_url('admin/coupon_form/add_coupon_form'),
        'variant' => 'outline',
    ], true)
);
?>
<div class="gp-courses-page">
    <?php
    ob_start();
    ?>
                <div class="table-responsive-sm gp-courses-table">
                    <table id="basic-datatable" class="table table-striped table-centered mb-0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th><?php echo get_phrase('coupon') . ' ' . get_phrase('code'); ?></th>
                                <th><?php echo get_phrase('discount') . ' ' . get_phrase('percentage'); ?></th>
                                <th><?php echo get_phrase('validity') . ' ' . get_phrase('till'); ?></th>
                                <th><?php echo get_phrase('actions'); ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            foreach ($coupons as $key => $coupon) : ?>
                                <tr>
                                    <td><?php echo $key + 1; ?></td>
                                    <td><strong><?php echo $coupon['code']; ?></strong></td>
                                    <td><?php echo $coupon['discount_percentage']; ?>%</td>
                                    <td><?php echo date('D, d-M-Y', $coupon['expiry_date']); ?></td>
                                    <td>
                                        <div class="dropright dropright">
                                            <button type="button" class="btn action-icon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="mdi mdi-dots-vertical"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="<?php echo site_url('admin/coupon_form/edit_coupon_form/' . $coupon['id']) ?>"><?php echo get_phrase('edit'); ?></a></li>
                                                <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/coupons/delete/' . $coupon['id']); ?>');"><?php echo get_phrase('delete'); ?></a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
    <?php
    gp_ds_card([
        'title' => get_phrase('coupon') . ' ' . get_phrase('list'),
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
