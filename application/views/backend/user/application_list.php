<?php
ob_start();
foreach ($applications->result_array() as $key => $application):
    $user_data = $this->user_model->get_all_user($application['user_id'])->row_array();
?>
                <tr class="gradeU">
                    <td><?php echo ++$key; ?></td>
                    <td><?php echo $user_data['first_name'] . ' ' . $user_data['last_name']; ?></td>
                    <td>
                        <?php echo gp_ds_button(get_phrase('application_details'), [
                            'href'    => 'javascript:;',
                            'variant' => 'outline',
                            'attrs'   => [
                                'onclick' => "showAjaxModal('" . site_url('modal/popup/application_details/' . $application['id']) . "', '" . get_phrase('applicant_details') . "')",
                            ],
                        ], true); ?>
                    </td>
                    <td>
                        <?php if (! empty($application['document'])): ?>
                            <?php echo gp_ds_button(get_phrase('download'), [
                                'href'    => base_url() . 'uploads/document/' . $application['document'],
                                'variant' => 'quiet',
                                'attrs'   => [
                                    'download' => '',
                                ],
                            ], true); ?>
                        <?php endif; ?>
                    </td>
                    <td>
                        <?php if ($application['status'] == 0): ?>
                            <?php gp_ds_badge(get_phrase('pending'), 'danger'); ?>
                        <?php elseif ($application['status'] == 1): ?>
                            <?php gp_ds_badge(get_phrase('approved'), 'success'); ?>
                        <?php endif; ?>
                    </td>
                </tr>
<?php
endforeach;
echo gp_ds_table([
    'table_id'     => 'basic-datatable',
    'extra_class'  => 'mb-0',
    'headers'      => [
        '#',
        get_phrase('name'),
        get_phrase('document'),
        get_phrase('details'),
        get_phrase('status'),
    ],
    'body_html'    => ob_get_clean(),
    'allow_empty'  => true,
], true);
?>
