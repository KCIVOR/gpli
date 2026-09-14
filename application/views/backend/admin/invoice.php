<?php gp_ds_page_title(get_phrase('invoice')); ?>
<?php
$payout_details = $this->crud_model->get_payouts($payout_id, 'payout')->row_array();
$instructor_details = $this->user_model->get_all_user($payout_details['user_id'])->row_array();
$admin_details = $this->user_model->get_admin_details()->row_array();
?>
<div class="gp-report-page gp-report-invoice">
    <?php
    ob_start();
    ?>

                <!-- Invoice Logo-->
                <div class="clearfix gp-report-invoice-head">
                    <div class="float-left mb-3">
                        <img src="<?php echo base_url('uploads/system/'.get_frontend_settings('dark_logo'));?>" alt="" height="18">
                    </div>
                    <div class="float-right">
                        <h4 class="m-0 d-print-none"><?php echo get_phrase("invoice"); ?></h4>
                    </div>
                </div>

                <!-- Invoice Detail-->
                <div class="row">
                    <div class="col-sm-6">

                    </div><!-- end col -->
                    <div class="col-sm-4 offset-sm-2">
                        <div class="mt-3 float-sm-right gp-report-invoice-meta">
                            <p class="font-13"><strong><?php echo get_phrase("requested_date"); ?>: </strong> &nbsp;&nbsp;&nbsp; <?php echo date('D, d-M-Y', $payout_details['date_added']); ?></p>
                            <p class="font-13"><strong><?php echo get_phrase("payment_status"); ?>: </strong> <?php if ($payout_details['status'] == 1): ?><?php echo gp_ds_badge(get_phrase("paid"), 'success', true); ?><?php else: ?><?php echo gp_ds_badge(get_phrase("unpaid"), 'danger', true); ?><?php endif; ?> </p>
                                <p class="font-13"><strong><?php echo get_phrase("withdrawal_request_id"); ?>: </strong> <span class="float-right"><?php echo sprintf('%04d', $payout_details['id']); ?></span></p>
                            </div>
                        </div><!-- end col -->
                    </div>
                    <!-- end row -->

                    <div class="row mt-4">
                        <div class="col-sm-4">
                            <h6><?php echo get_phrase("instructor_details"); ?></h6>
                            <address>
                                <?php echo $instructor_details['first_name'].' '.$instructor_details['last_name']; ?><br>
                                <?php echo $instructor_details['email']; ?><br>
                            </address>
                        </div> <!-- end col-->

                        <div class="col-sm-4">
                            <h6><?php echo get_phrase("admin_details"); ?></h6>
                            <address>
                                <?php echo $admin_details['first_name'].' '.$admin_details['last_name']; ?><br>
                                <?php echo $admin_details['email']; ?><br>
                            </address>
                        </div> <!-- end col-->
                    </div>
                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table class="table mt-4">
                                    <thead>
                                        <tr><th>#</th>
                                            <th><?php echo get_phrase("type"); ?></th>
                                            <th><?php echo get_phrase("requested_amount"); ?></th>
                                            <th class="text-right"><?php echo get_phrase("total"); ?></th>
                                        </tr></thead>
                                        <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td>
                                                    <b><?php echo get_phrase('withdrawal_request'); ?></b>
                                                </td>
                                                <td>
                                                    <?php echo currency($payout_details['amount']); ?>
                                                </td>
                                                <td class="text-right">
                                                    <?php echo currency($payout_details['amount']); ?>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div> <!-- end table-responsive-->
                            </div> <!-- end col -->
                        </div>
                        <!-- end row -->

                        <div class="row">
                            <div class="col-sm-6">

                            </div> <!-- end col -->
                            <div class="col-sm-6">
                                <div class="float-right mt-3 mt-sm-0 gp-report-invoice-total">
                                    <p><b><?php echo get_phrase("sub_total"); ?>:</b> <span class="float-right">
                                        <?php echo currency($payout_details['amount']); ?>
                                    </span></p>
                                    <h3>
                                        <?php echo currency($payout_details['amount']); ?>
                                    </h3>
                                </div>
                                <div class="clearfix"></div>
                            </div> <!-- end col -->
                        </div>
                        <!-- end row-->

                        <div class="d-print-none mt-4">
                            <div class="text-right">
                                <a href="javascript:window.print()" class="btn btn-primary"><i class="mdi mdi-printer"></i> <?php echo get_phrase('print'); ?></a>
                            </div>
                        </div>
                        <!-- end buttons -->

    <?php
    gp_ds_card([
        'title' => '',
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
