<?php
$course_details = $this->crud_model->get_course_by_id($payment_info['course_id'])->row_array();
$buyer_details = $this->user_model->get_all_user($payment_info['user_id'])->row_array();
$sub_category_details = $this->crud_model->get_category_details_by_id($course_details['sub_category_id'])->row_array();
$instructor_details = $this->user_model->get_all_user($course_details['user_id'])->row_array();
$line_price = $payment_info['admin_revenue'] + $payment_info['instructor_revenue'];
?>

<!------------ Invoice section start ----->
<div class="gp-student-page gp-student-invoice">
<section class="invoice gp-student-shell">
    <div class="container print-content">
        <?php ob_start(); ?>
        <div class="invoice-heading">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-6">
                    <h3 class="text-uppercase"><?php echo get_phrase('invoice') ?></h3>
                    <div class="invoice-no">
                        <h6 class="invoice-color"><?php echo get_phrase('Invoice ID') ?> :</h6>
                        <h6>#<?php echo $payment_info['id']; ?></h6>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-6">
                    <div class="invioce-logo d-flex justify-content-end">
                        <a href="#"><img loading="lazy" src="<?php echo base_url('uploads/system/').get_frontend_settings('dark_logo');?>" alt="" style="height: 55px; width: auto;"></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="invoice-bill">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-7 col-8">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-6">
                            <p><?php echo get_phrase('Billed To') ?>:</p>
                            <h6><?php echo $buyer_details['first_name'].' '.$buyer_details['last_name']; ?></h6>
                            <h6><?php echo $buyer_details['email']; ?></h6>
                            <h6><?php echo $buyer_details['address']; ?></h6>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-6">
                            <p><?php echo get_phrase('Date Of Issue') ?>:</p>
                            <h6><?php echo date('d-M-Y', $payment_info['date_added']) ?></h6>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-5 col-4">
                    <div class="invoice-total text-end">
                        <p><?php echo get_phrase('Invoice Total') ?></p>
                        <h2><?php echo currency($payment_info['amount']); ?></h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="invoice-dec">
            <div class="invoice-bill--scroll-bar">
                <?php
                echo gp_ds_table([
                    'headers' => [
                        get_phrase('Course'),
                        get_phrase('Instructor'),
                        get_phrase('QTY'),
                        get_phrase('Price'),
                    ],
                    'rows' => [[
                        $course_details['title'],
                        $instructor_details['first_name'].' '.$instructor_details['last_name'],
                        '1',
                        currency($line_price),
                    ]],
                    'extra_class' => 'gp-student-invoice-table mb-0',
                ], true);
                ?>
            </div>
            <div class="invoice-2-payment">
                <div class="row">
                    <div class="col-6">
                        <h5><?php echo get_phrase('Paid By'); ?>:</h5>
                        <h6><?php echo gp_ds_badge(ucfirst($payment_info['payment_type']), 'neutral', true); ?></h6>
                    </div>
                    <div class="col-6">
                        <div class="row justify-content-end">
                            <div class="col-lg-6 col-12">
                                <div class="invoice-2-last-total">
                                    <div class="row">
                                        <div class="col-lg-7 col-md-7 col-sm-7 col-7">
                                            <h5><?php echo get_phrase('Subtotal') ?></h5>
                                            <h5><?php echo get_phrase('Tax'); ?></h5>
                                        </div>
                                        <div class="col-lg-1 col-md-1 col-sm-1 col-1">
                                            <h5 class="text-end">:</h5>
                                            <h5 class="text-end">:</h5>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-3 pe-0">
                                            <h4><?php echo currency($line_price); ?></h4>
                                            <h4><?php echo currency($payment_info['tax']); ?></h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-end">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="invoice-right-total">
                                    <div class="row">
                                        <div class="col-lg-7 col-md-7 col-sm-7 col-7">
                                            <h5 class="invoice-ml text-end"><?php echo get_phrase('Grand Total') ?></h5>
                                        </div>
                                        <div class="col-lg-1 col-md-1 col-sm-1 col-1">
                                            <h5 class="text-end">:</h5>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 col-3 pe-0">
                                            <h5 class="text-end"><?php echo currency($payment_info['amount']); ?></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="print-d-none gp-student-invoice-actions">
                <?php
                gp_ds_button(get_phrase('Print'), [
                    'variant'     => 'outline',
                    'href'        => '#',
                    'extra_class' => 'gp-student-cta',
                    'attrs'       => [
                        'onclick' => 'window.print()',
                    ],
                ]);
                gp_ds_button(get_phrase('Back'), [
                    'variant'     => 'outline',
                    'href'        => site_url('home/purchase_history'),
                    'extra_class' => 'gp-student-cta',
                ]);
                ?>
            </div>
        </div>
        <?php
        gp_ds_card([
            'extra_class' => 'gp-student-invoice-card',
            'body'        => ob_get_clean(),
        ]);
        ?>
    </div>
</section>
</div>
<!------------ Invoice secton end -------->
