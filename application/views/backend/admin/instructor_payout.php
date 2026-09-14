<script src="https://js.stripe.com/v3/"></script>

<?php gp_ds_page_title(get_phrase('instructor_payouts')); ?>

<div class="gp-users-page">
    <?php
    ob_start();
    ?>
                <ul class="nav nav-tabs nav-bordered mb-3">
                    <li class="nav-item">
                        <a href="#completed-b1" data-toggle="tab" aria-expanded="true" class="nav-link active">
                            <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                            <span class="d-none d-lg-block"><?php echo get_phrase('completed_payouts'); ?></span>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="#pending-b1" data-toggle="tab" aria-expanded="false" class="nav-link">
                            <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
                            <span class="d-none d-lg-block"><?php echo get_phrase('pending_payouts'); ?> <?php echo gp_ds_badge((string) $pending_payouts->num_rows(), 'danger', true); ?></span>
                        </a>
                    </li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane show active" id="completed-b1">
                        <form class="gp-users-toolbar-form" action="<?php echo site_url('admin/instructor_payout/filter_by_date_range') ?>" method="get">
                            <div class="gp-users-date-field">
                                <div class="form-group">
                                    <div id="reportrange" class="form-control" data-toggle="date-picker-range" data-target-display="#selectedValue"  data-cancel-class="btn-light">
                                        <i class="mdi mdi-calendar"></i>&nbsp;
                                        <span id="selectedValue"><?php echo date("F d, Y" , $timestamp_start) . " - " . date("F d, Y" , $timestamp_end);?></span> <i class="mdi mdi-menu-down"></i>
                                    </div>
                                    <input id="date_range" type="hidden" name="date_range" value="<?php echo date("d F, Y" , $timestamp_start) . " - " . date("d F, Y" , $timestamp_end);?>">
                                </div>
                            </div>
                            <?php echo gp_ds_button(get_phrase('filter'), [
                                'variant' => 'primary',
                                'type' => 'submit',
                                'attrs' => [
                                    'id' => 'submit-button',
                                    'onclick' => 'update_date_range();',
                                ],
                            ], true); ?>
                        </form>
                        <?php
                        ob_start();
                        foreach ($completed_payouts->result_array() as $key => $completed_payout):
                            $completed_payout_user_data = $this->db->get_where('users', array('id' => $completed_payout['user_id']))->row_array();
                        ?>
                                        <tr class="gradeU">
                                            <td> <?php echo ++$key; ?> </td>
                                            <td>
                                                <img src="<?php echo $this->user_model->get_user_image_url($completed_payout_user_data['id']);?>" alt="" height="50" width="50" class="img-fluid rounded-circle img-thumbnail">
                                            </td>
                                            <td>
                                                <strong><?php echo $completed_payout_user_data['first_name'].' '.$completed_payout_user_data['last_name']; ?></strong>
                                            </td>
                                            <td> <?php echo currency($completed_payout['amount']); ?> </td>
                                            <td> <?php echo ucfirst($completed_payout['payment_type']); ?> </td>
                                            <td> <?php echo date('D, d M Y', $completed_payout['date_added']); ?> </td>
                                            <td> <a href="<?php echo site_url('admin/invoice/'.$completed_payout['id']); ?>" class="icon-btn"><i class="mdi mdi-printer-settings"></i></a> </td>
                                        </tr>
                        <?php
                        endforeach;
                        echo gp_ds_table([
                            'table_id' => 'completed-payout',
                            'extra_class' => 'mb-0',
                            'headers' => [
                                '#',
                                get_phrase('image'),
                                get_phrase('instructor'),
                                get_phrase('payout_amount'),
                                get_phrase('payment_type'),
                                get_phrase('payout_date'),
                                get_phrase('action'),
                            ],
                            'body_html' => ob_get_clean(),
                            'allow_empty' => true,
                        ], true);
                        ?>
                    </div>

                    <div class="tab-pane" id="pending-b1">
                        <?php
                        ob_start();
                        foreach ($pending_payouts->result_array() as $key => $pending_payout):
                            $pending_payout_user_data = $this->db->get_where('users', array('id' => $pending_payout['user_id']))->row_array();

                            $payment_keys = json_decode($pending_payout_user_data['payment_keys'], true);
                            $paypal_keys = $payment_keys['paypal'];
                            $stripe_keys = $payment_keys['stripe'];
                            $razorpay_keys = $payment_keys['razorpay'];
                        ?>
                                        <tr class="gradeU">
                                            <td> <?php echo ++$key; ?> </td>
                                            <td>
                                                <img src="<?php echo $this->user_model->get_user_image_url($pending_payout_user_data['id']);?>" alt="" height="50" width="50" class="img-fluid rounded-circle img-thumbnail">
                                            </td>
                                            <td>
                                                <strong><?php echo $pending_payout_user_data['first_name'].' '.$pending_payout_user_data['last_name']; ?></strong>
                                            </td>
                                            <td> <?php echo currency($pending_payout['amount']); ?> </td>
                                            <td> <?php echo date('D, d M Y', $pending_payout['date_added']); ?> </td>
                                            <td>
                                                <?php echo gp_ds_button(get_phrase('pay'), [
                                                    'href' => site_url('admin/instructor_payment/' . $pending_payout['user_id']),
                                                    'variant' => 'primary',
                                                ], true); ?>
                                            </td>
                                        </tr>
                        <?php
                        endforeach;
                        echo gp_ds_table([
                            'table_id' => 'pending-payout',
                            'extra_class' => 'mb-0',
                            'headers' => [
                                '#',
                                get_phrase('image'),
                                get_phrase('instructor'),
                                get_phrase('payout_amount'),
                                get_phrase('payout_date'),
                                get_phrase('option'),
                            ],
                            'body_html' => ob_get_clean(),
                            'allow_empty' => true,
                        ], true);
                        ?>
                    </div>
                </div>
    <?php
    gp_ds_card([
        'title' => get_phrase('list_of_payouts'),
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        initDataTable(['#pending-payout', '#completed-payout']);
    });

    function update_date_range()
    {
        var x = $("#selectedValue").html();
        $("#date_range").val(x);
    }

    function stripe_checkout(stripe_public_key, payout_id){
        var createCheckoutSession = function (stripe) {
            return fetch("<?= site_url('admin/stripe_checkout_for_instructor_revenue/'); ?>"+payout_id, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    checkoutSession: 1,
                }),
            }).then(function (result) {
                return result.json();
            });
        };

        createCheckoutSession().then(function (data) {
            if(data.sessionId){
                Stripe(stripe_public_key).redirectToCheckout({
                    sessionId: data.sessionId,
                }).then(handleResult);
            }else{
                handleResult(data);
            }
        });
    }
</script>
