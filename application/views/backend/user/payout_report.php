<?php
gp_ds_page_title(
    get_phrase('Payout') . ' ' . get_phrase('report'),
    gp_ds_button(get_phrase('request_a_new_withdrawal'), [
        'href'    => 'javascript:void(0)',
        'variant' => 'outline',
        'attrs'   => [
            'onclick' => "showAjaxModal('" . site_url('modal/popup/request_withdrawal') . "', '" . get_phrase('request_a_new_withdrawal') . "')",
        ],
    ], true)
);
?>

<div class="gp-users-page">
    <div class="gp-dash-stats">
        <div class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="mdi mdi-currency-usd"></i></span>
            <span class="gp-dash-stat-value"><?php echo $total_pending_amount > 0 ? currency($total_pending_amount) : currency_code_and_symbol() . '' . $total_pending_amount; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Pending') . ' ' . get_phrase('amount'); ?></span>
        </div>
        <div class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="mdi mdi-currency-usd"></i></span>
            <span class="gp-dash-stat-value"><?php echo $total_payout_amount > 0 ? currency($total_payout_amount) : currency_code_and_symbol() . '' . $total_payout_amount; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('total_payout_amount'); ?></span>
        </div>
        <div class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="mdi mdi-currency-usd"></i></span>
            <span class="gp-dash-stat-value"><?php echo $requested_withdrawal_amount > 0 ? currency($requested_withdrawal_amount) : currency_code_and_symbol() . '' . $requested_withdrawal_amount; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Requested') . ' ' . get_phrase('withdrawal'); ?></span>
            <?php if ($requested_withdrawal_amount > 0): ?>
                <?php echo gp_ds_button(get_phrase('delete_requested_withdrawal'), [
                    'href'        => 'javascript:void(0)',
                    'variant'     => 'outline',
                    'extra_class' => 'gp-payout-stat-action',
                    'attrs'       => [
                        'onclick' => "confirm_modal('" . site_url('user/withdrawal/delete') . "');",
                    ],
                ], true); ?>
            <?php endif; ?>
        </div>
    </div>

    <?php
    ob_start();
    foreach ($payouts->result_array() as $key => $payout):
    ?>
        <tr class="gradeU">
            <td><?php echo ++$key; ?></td>
            <td>
                <?php echo currency($payout['amount']); ?>
                <?php if (!$payout['status']): ?>
                    <br><small><?php echo '<strong>' . get_phrase('requested_at') . '</strong>: ' . date('D, d M Y', $payout['date_added']); ?></small>
                <?php endif; ?>
            </td>
            <td>
                <?php if ($payout['status']): ?>
                    <?php echo ucfirst($payout['payment_type']); ?>
                <?php else: ?>
                    <?php gp_ds_badge(get_phrase('pending'), 'warning'); ?>
                <?php endif; ?>
            </td>
            <td>
                <?php if ($payout['status'] && !empty($payout['last_modified'])): ?>
                    <?php echo date('D, d M Y', $payout['last_modified']); ?>
                <?php endif; ?>
            </td>
        </tr>
    <?php
    endforeach;
    $payout_table = gp_ds_table([
        'table_id'    => 'basic-datatable',
        'extra_class' => 'mb-0',
        'headers'     => [
            '#',
            get_phrase('payout_amount'),
            get_phrase('payment_type'),
            get_phrase('date_processed'),
        ],
        'body_html'   => ob_get_clean(),
        'allow_empty' => true,
    ], true);
    gp_ds_card([
        'title'       => get_phrase('Payout') . ' ' . get_phrase('report'),
        'body'        => $payout_table,
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
