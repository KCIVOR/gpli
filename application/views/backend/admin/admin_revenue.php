<?php gp_ds_page_title(get_phrase('admin_revenue')); ?>

<div class="gp-report-page">
    <?php
    ob_start();
    ?>
    <form class="gp-report-toolbar-form" action="<?php echo site_url('admin/admin_revenue/filter_by_date_range') ?>" method="get">
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
            'type' => 'submit',
            'attrs' => [
                'id' => 'submit-button',
                'onclick' => 'update_date_range();',
            ],
        ], true); ?>
    </form>
    <?php
    gp_ds_card([
        'title' => '',
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel gp-report-toolbar',
    ]);
    ?>

    <?php
    ob_start();
    ?>
    <div class="table-responsive-sm">
        <table id="basic-datatable" class="table table-striped table-centered mb-0">
            <thead>
                <tr>
                    <th><?php echo get_phrase('enrolled_course'); ?></th>
                    <th><?php echo get_phrase('total_amount'); ?></th>
                    <th><?php echo get_phrase('admin_revenue'); ?></th>
                    <th><?php echo get_phrase('enrolment_date'); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($payment_history as $payment) :
                    $user_data = $this->db->get_where('users', array('id' => $payment['user_id']))->row_array();
                    $course_data = $this->db->get_where('course', array('id' => $payment['course_id']))->row_array(); ?>
                    <tr class="gradeU">
                        <td>
                            <strong><a href="<?php echo site_url('admin/course_form/course_edit/' . $course_data['id']); ?>" target="_blank"><?php echo $course_data['title']; ?></a></strong>
                            <?php if ($payment['coupon']) : ?>
                                <small>
                                    <i class="fas fa-tags"></i>
                                    <?php echo gp_ds_badge($payment['coupon'], 'success', true); ?>
                                </small>
                            <?php endif; ?>
                        </td>
                        <td><?php echo currency($payment['amount']); ?></td>
                        <td><?php echo currency($payment['admin_revenue']); ?></td>
                        <td><?php echo date('D, d-M-Y', $payment['date_added']); ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <?php
    gp_ds_card([
        'title' => get_phrase('admin_revenue'),
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script type="text/javascript">
    function update_date_range() {
        var x = $("#selectedValue").html();
        $("#date_range").val(x);
    }
</script>
