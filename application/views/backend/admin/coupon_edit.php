<?php
gp_ds_page_title(
    get_phrase('edit') . ' ' . get_phrase('coupon'),
    gp_ds_button(get_phrase('back') . ' ' . get_phrase('to') . ' ' . get_phrase('coupons'), [
        'href' => site_url('admin/coupons'),
        'variant' => 'quiet',
    ], true)
);
?>

<div class="gp-courses-page">
    <div class="row justify-content-center">
        <div class="col-xl-7">
            <?php
            ob_start();
            ?>
                    <form class="required-form gp-coupon-form" action="<?php echo site_url('admin/coupons/edit/' . $coupon['id']); ?>" method="post" enctype="multipart/form-data">

                        <div class="form-group">
                            <label for="code"><?php echo get_phrase('coupon') . ' ' . get_phrase('code'); ?><span class="required">*</span></label>
                            <input type="text" class="form-control" id="code" name="code" value="<?php echo $coupon['code']; ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="discount_percentage"><?php echo get_phrase('discount') . ' ' . get_phrase('percentage'); ?></label>
                            <div class="input-group">
                                <input type="number" name="discount_percentage" id="discount_percentage" class="form-control" value="<?php echo $coupon['discount_percentage']; ?>" min="1" max="100">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-percent"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="expiry_date"><?php echo get_phrase('expiry') . ' ' . get_phrase('date'); ?><span class="required">*</span></label>
                            <input type="text" name="expiry_date" class="form-control date" id="expiry_date" data-toggle="date-picker" data-single-date-picker="true" value="<?php echo date('m/d/Y', $coupon['expiry_date']); ?>">
                        </div>

                        <?php echo gp_ds_button(get_phrase('submit'), [
                            'type' => 'submit',
                            'variant' => 'primary',
                        ], true); ?>
                    </form>
            <?php
            $body = ob_get_clean();
            gp_ds_card([
                'title' => get_phrase('coupon') . ' ' . get_phrase('edit') . ' ' . get_phrase('form'),
                'body'  => $body,
                'extra_class' => 'gp-dash-panel',
            ]);
            ?>
        </div><!-- end col-->
    </div>
</div>
