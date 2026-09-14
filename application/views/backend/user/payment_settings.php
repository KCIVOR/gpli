<?php
$user_data     = $this->user_model->get_user($this->session->userdata('user_id'))->row_array();
$payment_keys  = json_decode($user_data['payment_keys'], true);
$paypal_keys   = $payment_keys['paypal'];
$stripe_keys   = $payment_keys['stripe'];
$razorpay_keys = $payment_keys['razorpay'];
?>
<?php gp_ds_page_title(get_phrase('setup_payment_informations')); ?>

<div class="gp-settings-page">
    <div class="row">
        <div class="col-md-8">
            <?php
            ob_start();
            ?>
            <form action="<?php echo site_url('user/payout_settings/paypal_settings'); ?>" method="post" enctype="multipart/form-data">
                <?php
                $payment_gateways = $this->db->get('payment_gateways')->result_array();
                foreach ($payment_gateways as $key => $payment_gateway):
                    $keys = json_decode($payment_gateway['keys'], true);
                    $user_keys = json_decode($user_data['payment_keys'], true);
                    ?>
                    <div class="<?php if ($payment_gateway['status'] != 1 || !addon_status($payment_gateway['identifier']) && $payment_gateway['is_addon'] == 1) echo 'd-none'; ?>">
                        <h4><?php echo get_phrase($payment_gateway['title']); ?></h4>
                        <?php foreach ($keys as $index => $value):
                            if (array_key_exists($payment_gateway['identifier'], $user_keys)) {
                                if (array_key_exists($index, $user_keys[$payment_gateway['identifier']])) {
                                    $value = $user_keys[$payment_gateway['identifier']][$index];
                                } else {
                                    $value = '';
                                }
                            } else {
                                $value = '';
                            }
                            ?>
                            <div class="form-group row mb-3">
                                <label class="col-md-3 col-form-label" for="<?php echo $payment_gateway['identifier'] . $index; ?>"><?php echo get_phrase($index); ?></label>
                                <div class="col-md-9">
                                    <input type="text" id="<?php echo $payment_gateway['identifier'] . $index; ?>" name="gateways[<?php echo $payment_gateway['identifier']; ?>][<?php echo $index; ?>]" value="<?php echo $value; ?>" class="form-control">
                                    <small class="text-muted"><?php echo get_phrase('required_for_instructor'); ?></small>
                                </div>
                            </div>
                        <?php endforeach; ?>
                        <hr>
                    </div>
                <?php endforeach; ?>
                <?php
                gp_ds_button(get_phrase('save_changes'), [
                    'variant' => 'primary',
                    'type'    => 'submit',
                ]);
                ?>
            </form>
            <?php
            gp_ds_card([
                'title'       => get_phrase('setup_your_payment_settings'),
                'body'        => ob_get_clean(),
                'extra_class' => 'gp-dash-panel',
            ]);
            ?>
        </div>
        <div class="col-md-4">
            <?php gp_ds_alert(get_phrase('be_careful') . '!', 'Just configure the payment gateway you want to use, leave the rest blank. Also, make sure that you have configured your payment settings correctly', 'warning'); ?>
        </div>
    </div>
</div>
