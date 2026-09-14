<?php gp_ds_page_title(get_phrase('instructor_applications')); ?>

<div class="gp-users-page">
    <?php
    ob_start();
    ?>
                <ul class="nav nav-tabs nav-bordered mb-3">
                    <li class="nav-item">
                        <a href="#pending-b1" data-toggle="tab" aria-expanded="false" class="nav-link active">
                            <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
                            <span class="d-none d-lg-block"><?php echo get_phrase('pending_applications'); ?></span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#approved-b1" data-toggle="tab" aria-expanded="true" class="nav-link">
                            <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                            <span class="d-none d-lg-block"><?php echo get_phrase('approved_applications'); ?></span>
                        </a>
                    </li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane show active" id="pending-b1">
                        <?php
                        ob_start();
                        foreach ($pending_applications->result_array() as $key => $pending_application):
                            $user_data = $this->user_model->get_all_user($pending_application['user_id'])->row_array();
                        ?>
                                        <tr class="gradeU">
                                            <td>
                                                <?php echo ++$key; ?>
                                            </td>
                                            <td>
                                                <?php echo $user_data['first_name'].' '.$user_data['last_name']; ?>
                                            </td>
                                            <td>
                                                <?php echo gp_ds_button(get_phrase('application_details'), [
                                                    'href' => 'javascript:;',
                                                    'variant' => 'outline',
                                                    'attrs' => [
                                                        'onclick' => "showAjaxModal('" . site_url('modal/popup/application_details/'.$pending_application['id']) . "', '" . get_phrase('applicant_details') . "')",
                                                    ],
                                                ], true); ?>
                                            </td>
                                            <td>
                                                <?php if (!empty($pending_application['document'])): ?>
                                                    <?php echo gp_ds_button(get_phrase('download'), [
                                                        'href' => base_url().'uploads/document/'.$pending_application['document'],
                                                        'variant' => 'quiet',
                                                        'attrs' => [
                                                            'download' => '',
                                                        ],
                                                    ], true); ?>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if ($pending_application['status'] == 0): ?>
                                                    <?php gp_ds_badge(get_phrase('pending'), 'danger'); ?>
                                                <?php elseif($pending_application['status'] == 1): ?>
                                                    <?php gp_ds_badge(get_phrase('approved'), 'success'); ?>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <div class="dropright dropright">
                                                    <button type="button" class="btn btn-sm btn-outline-primary btn-rounded btn-icon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="mdi mdi-dots-vertical"></i>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url();?>admin/instructor_application/approve/<?php echo $pending_application['id']; ?>');">
                                                                <?php echo get_phrase('approve');?>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url();?>admin/instructor_application/delete/<?php echo $pending_application['id']; ?>');">
                                                                <?php echo get_phrase('delete'); ?>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                        <?php
                        endforeach;
                        echo gp_ds_table([
                            'table_id' => 'pending-application',
                            'extra_class' => 'mb-0',
                            'headers' => [
                                '#',
                                get_phrase('name'),
                                get_phrase('document'),
                                get_phrase('details'),
                                get_phrase('status'),
                                get_phrase('action'),
                            ],
                            'body_html' => ob_get_clean(),
                            'allow_empty' => true,
                        ], true);
                        ?>
                    </div>
                    <div class="tab-pane" id="approved-b1">
                        <?php
                        ob_start();
                        foreach ($approved_applications->result_array() as $key => $approved_application):
                            $user_data = $this->user_model->get_all_user($approved_application['user_id'])->row_array();
                        ?>
                                        <tr class="gradeU">
                                            <td>
                                                <?php echo ++$key; ?>
                                            </td>
                                            <td>
                                                <?php echo $user_data['first_name'].' '.$user_data['last_name']; ?>
                                            </td>
                                            <td>
                                                <?php echo gp_ds_button(get_phrase('application_details'), [
                                                    'href' => 'javascript:;',
                                                    'variant' => 'outline',
                                                    'attrs' => [
                                                        'onclick' => "showAjaxModal('" . site_url('modal/popup/application_details/'.$approved_application['id']) . "', '" . get_phrase('applicant_details') . "')",
                                                    ],
                                                ], true); ?>
                                            </td>
                                            <td>
                                                <?php if (!empty($approved_application['document'])): ?>
                                                    <?php echo gp_ds_button(get_phrase('download'), [
                                                        'href' => base_url().'uploads/document/'.$approved_application['document'],
                                                        'variant' => 'quiet',
                                                        'attrs' => [
                                                            'download' => '',
                                                        ],
                                                    ], true); ?>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if ($approved_application['status'] == 0): ?>
                                                    <?php gp_ds_badge(get_phrase('pending'), 'danger'); ?>
                                                <?php elseif($approved_application['status'] == 1): ?>
                                                    <?php gp_ds_badge(get_phrase('approved'), 'success'); ?>
                                                <?php endif; ?>
                                            </td>
                                        </tr>
                        <?php
                        endforeach;
                        echo gp_ds_table([
                            'table_id' => 'approved-application',
                            'extra_class' => 'mb-0',
                            'headers' => [
                                '#',
                                get_phrase('name'),
                                get_phrase('document'),
                                get_phrase('details'),
                                get_phrase('status'),
                            ],
                            'body_html' => ob_get_clean(),
                            'allow_empty' => true,
                        ], true);
                        ?>
                    </div>
                </div>
    <?php
    gp_ds_card([
        'title' => get_phrase('list_of_applications'),
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        initDataTable(['#pending-application', '#approved-application']);
    });
</script>
