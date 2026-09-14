<?php gp_ds_page_title(get_phrase('setup_payment_informations')); ?>
<div class="gp-settings-page">
<div class="row">
    <div class="col-md-7">
        <?php
        ob_start();
        ?>
                    <form class="" action="<?php echo site_url('admin/payment_settings/system_currency'); ?>" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label><?php echo get_phrase('system_currency'); ?></label>
                            <select class="form-control select2" data-toggle="select2" id = "system_currency" name="system_currency" required>
                                <option value=""><?php echo get_phrase('select_system_currency'); ?></option>
                                    <?php
                                    $currencies = $this->crud_model->get_currencies();
                                    foreach ($currencies as $currency):?>
                                    <option value="<?php echo $currency['code'];?>"
                                        <?php if (get_settings('system_currency') == $currency['code'])echo 'selected';?>> <?php echo $currency['code'];?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="form-group">
                            <label><?php echo get_phrase('currency_position'); ?></label>
                            <select class="form-control select2" data-toggle="select2" id = "currency_position" name="currency_position" required>
                                <option value="left" <?php if (get_settings('currency_position') == 'left') echo 'selected';?> ><?php echo get_phrase('left'); ?></option>
                                <option value="right" <?php if (get_settings('currency_position') == 'right') echo 'selected';?> ><?php echo get_phrase('right'); ?></option>
                                <option value="left-space" <?php if (get_settings('currency_position') == 'left-space') echo 'selected';?> ><?php echo get_phrase('left_with_a_space'); ?></option>
                                <option value="right-space" <?php if (get_settings('currency_position') == 'right-space') echo 'selected';?> ><?php echo get_phrase('right_with_a_space'); ?></option>
                            </select>
                        </div>

                        <?php echo gp_ds_button(get_phrase('update_system_currency'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
                    </form>
        <?php
        gp_ds_card([
            'title' => get_phrase('system_currency_settings'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>

        <?php foreach($payment_gateways as $payment_gateway): ?>
            <!-- if is addon and deactivate -->
            <?php if($payment_gateway['is_addon'] && !addon_status($payment_gateway['identifier']) || $payment_gateway['identifier'] == 'offline_payment') continue; ?>
            <?php
            ob_start();
            ?>
                        <form class="" action="<?php echo site_url('admin/payment_settings'); ?>" method="post" enctype="multipart/form-data">

                            <input type="hidden" name="identifier" value="<?php echo $payment_gateway['identifier']; ?>">

                            <div class="form-group">
                                <label><?php echo get_phrase('active'); ?></label>
                                <select class="form-control select2" data-toggle="select2" name="status">
                                    <option value="0" <?php if ($payment_gateway['status'] != 1) echo 'selected';?>> <?php echo get_phrase('no');?></option>
                                    <option value="1" <?php if ($payment_gateway['status'] == 1) echo 'selected';?>> <?php echo get_phrase('yes');?></option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label><?php echo get_phrase('want_to_keep_test_mode_enabled'); ?>?</label>
                                <select class="form-control select2" data-toggle="select2" name="enabled_test_mode">
                                    <option value="0" <?php if ($payment_gateway['enabled_test_mode'] != 1) echo 'selected';?>> <?php echo get_phrase('no');?></option>
                                    <option value="1" <?php if ($payment_gateway['enabled_test_mode'] == 1) echo 'selected';?>> <?php echo get_phrase('yes');?></option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label><?php echo get_phrase('select_currency'); ?></label>
                                <select class="form-control select2" data-toggle="select2" name="currency" required>
                                    <option value=""><?php echo get_phrase('select_currency'); ?></option>
                                        <?php
                                        $currencies = $this->crud_model->get_currencies();
                                        foreach ($currencies as $currency):?>
                                        <option value="<?php echo $currency['code'];?>" <?php if ($payment_gateway['currency'] == $currency['code'])echo 'selected';?>>
                                            <?php echo $currency['code'];?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>


                            <?php foreach(json_decode($payment_gateway['keys'], true) as $key => $value): ?>
                                <?php if($key == 'theme_color'): ?>
                                    <div class="form-group">
                                        <label><?php echo get_phrase($key); ?></label>
                                        <input type="color" name="<?php echo $key; ?>" class="form-control" value="<?php echo $value;?>" required />
                                    </div>
                                <?php else: ?>
                                    <div class="form-group">
                                        <label><?php echo get_phrase($key); ?></label>
                                        <input type="text" name="<?php echo $key; ?>" class="form-control" value="<?php echo $value;?>" required />
                                    </div>
                                <?php endif; ?>
                            <?php endforeach; ?>

                            <?php echo gp_ds_button(get_phrase('update') . ' ' . $payment_gateway['title'] . ' ' . get_phrase('settings'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
                        </form>
            <?php
            gp_ds_card([
                'title' => $payment_gateway['title'] . ' ' . get_phrase('settings'),
                'body' => ob_get_clean(),
                'extra_class' => 'gp-dash-panel',
            ]);
            ?>
        <?php endforeach; ?>
    </div>
    <div class="col-md-5">
        <?php echo gp_ds_alert(get_phrase('heads_up'), get_phrase('ensure_that_the_system_currency_and_all_active_payment_gateway_currencies_are_same'), 'info', true); ?>
    </div>
</div>
</div>
