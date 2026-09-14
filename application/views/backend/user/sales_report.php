<?php gp_ds_page_title(get_phrase('Sales') . ' ' . get_phrase('report')); ?>

<div class="gp-report-page">
    <?php
    ob_start();
    ?>
    <form class="gp-report-toolbar-form" action="<?php echo site_url('user/sales_report/filter_by_date_range'); ?>" method="get">
        <div class="gp-report-date-field">
            <div class="form-group">
                <div id="reportrange" class="form-control" data-toggle="date-picker-range" data-target-display="#selectedValue" data-cancel-class="btn-light">
                    <i class="mdi mdi-calendar"></i>&nbsp;
                    <span id="selectedValue"><?php echo date("F d, Y", $timestamp_start) . " - " . date("F d, Y", $timestamp_end); ?></span> <i class="mdi mdi-menu-down"></i>
                </div>
                <input id="date_range" type="hidden" name="date_range" value="<?php echo date("d F, Y", $timestamp_start) . " - " . date("d F, Y", $timestamp_end); ?>">
            </div>
        </div>
        <?php echo gp_ds_button(get_phrase('filter'), [
            'variant' => 'primary',
            'type'    => 'submit',
            'attrs'   => [
                'id'      => 'submit-button',
                'onclick' => 'update_date_range();',
            ],
        ], true); ?>
    </form>
    <?php
    gp_ds_card([
        'title'       => '',
        'body'        => ob_get_clean(),
        'extra_class' => 'gp-dash-panel gp-report-toolbar',
    ]);
    ?>

    <?php
    ob_start();
    ?>
    <div class="table-responsive-sm">
        <table id="sales-report-datatable" class="table table-striped table-centered mb-0">
            <thead>
                <tr>
                    <th><?php echo get_phrase('course_name'); ?></th>
                    <th><?php echo get_phrase('instructor_revenue'); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($payment_history as $payment) :
                    $course_data = $this->db->get_where('course', array('id' => $payment['course_id']))->row_array();
                    $user_data = $this->db->get_where('users', array('id' => $payment['user_id']))->row_array(); ?>
                    <tr class="gradeU">
                        <td>
                            <strong><a href="<?php echo site_url('home/course/' . rawurlencode(slugify($course_data['title'])) . '/' . $course_data['id']); ?>" target="_blank"><?php echo $course_data['title']; ?></a></strong><br>
                            <small class="text-muted">
                                <strong><?php echo get_phrase('enrolled_user'); ?></strong>: <?php echo $user_data['first_name'] . ' ' . $user_data['last_name']; ?>
                            </small><br>
                            <small class="text-muted"><strong><?php echo get_phrase('enrolment_date') . '</strong>: ' . date('D, d-M-Y h:i:s', $payment['date_added']); ?></small>
                            <?php if ($payment['coupon']) : ?>
                                <small class="d-block">
                                    <span class="text-muted"><?php echo get_phrase('coupon_applied'); ?> :</span>
                                    <?php echo gp_ds_badge($payment['coupon'], 'success', true); ?>
                                </small>
                            <?php endif; ?>
                        </td>
                        <td>
                            <?php echo currency($payment['instructor_revenue']); ?><br>
                            <small class="text-muted"><strong><?php echo get_phrase('total_amount') . '</strong>: ' . currency($payment['amount']); ?></small>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <?php
    gp_ds_card([
        'title'       => get_phrase('Sales') . ' ' . get_phrase('report'),
        'body'        => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script type="text/javascript">
    function update_date_range() {
        var x = $("#selectedValue").html();
        $("#date_range").val(x);
    }

    $(document).ready(function() {
        initDataTable(["#sales-report-datatable"], 50);
    });
</script>
