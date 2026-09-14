<?php $this->db->where('user_id', $this->session->userdata('user_id'));
$purchase_history = $this->db->get('payment',$per_page, $this->uri->segment(3)); ?>
<?php $user_details = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array(); ?>
<div class="gp-student-page">
<?php include "breadcrumb.php"; ?>

  <!-------- Wish List body section start ------>
<section class="wish-list-body gp-student-shell">
    <div class="container">
        <?php gp_ds_page_title(get_phrase('Purchase history')); ?>
        <div class="row">
            <div class="col-lg-3 col-md-4 col-sm-12">
                <?php include "profile_menus.php"; ?>
            </div>
            <div class="col-lg-9 col-md-8 col-sm-12">
                <?php if ($purchase_history->num_rows() > 0):
                    ob_start();
                    foreach ($purchase_history->result_array() as $each_purchase):
                        $course_details = $this->crud_model->get_course_by_id($each_purchase['course_id'])->row_array();
                        $invoice_btn = gp_ds_button(get_phrase('Invoice'), [
                            'variant'     => 'outline',
                            'href'        => site_url('home/invoice/'.$each_purchase['id']),
                            'extra_class' => 'gp-student-cta',
                        ], true);
                ?>
                    <tr>
                        <td>
                            <div class="gp-student-purchase-course">
                                <img loading="lazy" src="<?php echo $this->crud_model->get_course_thumbnail_url($course_details['id']); ?>" alt="">
                                <a href="<?php echo site_url('home/course/' . rawurlencode(slugify($course_details['title'])) . '/' . $course_details['id']); ?>">
                                    <?php echo $course_details['title']; ?>
                                </a>
                            </div>
                        </td>
                        <td><?php echo ucfirst($each_purchase['payment_type']); ?></td>
                        <td><?php echo currency($each_purchase['amount']); ?></td>
                        <td><?php echo date('d M Y', $each_purchase['date_added']); ?></td>
                        <td><?php echo $invoice_btn; ?></td>
                    </tr>
                <?php
                    endforeach;
                    $purchase_body = ob_get_clean();
                    ob_start();
                    echo gp_ds_table([
                        'headers' => [
                            get_phrase('Purchased courses'),
                            get_phrase('Payment method'),
                            get_phrase('Price'),
                            get_phrase('Purchased Date'),
                            get_phrase('Invoice'),
                        ],
                        'body_html'   => $purchase_body,
                        'extra_class' => 'gp-student-purchase-table mb-0',
                    ], true);
                    gp_ds_card([
                        'body' => ob_get_clean(),
                    ]);
                else:
                    ob_start();
                ?>
                    <h4><?php echo get_phrase('Purchase history'); ?></h4>
                    <p><?php echo get_phrase('no_data_found'); ?></p>
                <?php
                    gp_ds_card([
                        'extra_class' => 'gp-student-empty empty-state',
                        'body'        => ob_get_clean(),
                    ]);
                endif; ?>
            </div>
        </div>
    </div>
</section>
</div>
