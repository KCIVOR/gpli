<?php
gp_ds_page_title(
    $page_title,
    gp_ds_button(get_phrase('add_admin'), [
        'href' => site_url('admin/admin_form/add_admin_form'),
        'variant' => 'outline',
    ], true) . ' ' . gp_ds_button(get_phrase('Export CSV'), [
        'variant' => 'primary',
        'type' => 'button',
        'attrs' => [
            'id' => 'export-csv-button',
            'onclick' => 'export_csv()',
        ],
    ], true)
);
?>

<div class="gp-users-page">
    <?php
    ob_start();
    foreach ($admins as $key => $user):
    ?>
                                <tr class="gradeU" data-admin-id="<?php echo $user['id']; ?>">
                                    <td><?php echo $key + 1; ?></td>
                                    <td>
                                        <img src="<?php echo $this->user_model->get_user_image_url($user['id']); ?>" alt="" height="50" width="50" class="img-fluid rounded-circle img-thumbnail">
                                    </td>
                                    <td><?php echo $user['first_name'] . ' ' . $user['last_name']; ?></td>
                                    <td><?php echo $user['email']; ?></td>
                                    <td><?php echo $user['phone']; ?></td>
                                    <td>
                                        <?php if (!is_root_admin($user['id'])): ?>
                                            <div class="dropright dropright">
                                                <button type="button" class="btn btn-sm btn-outline-primary btn-rounded btn-icon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="mdi mdi-dots-vertical"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a class="dropdown-item" href="<?php echo site_url('admin/permissions?permission_assing_to=' . $user['id']); ?>"><?php echo get_phrase('assign_permission'); ?></a></li>
                                                    <li><a class="dropdown-item" href="<?php echo site_url('admin/admin_form/edit_admin_form/' . $user['id']); ?>"><?php echo get_phrase('edit'); ?></a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/admins/delete/' . $user['id']); ?>');"><?php echo get_phrase('delete'); ?></a></li>
                                                </ul>
                                            </div>
                                        <?php else: ?>
                                            <?php gp_ds_badge(ucwords(get_phrase('root_admin')), 'success'); ?>
                                        <?php endif; ?>
                                    </td>
                                </tr>
    <?php
    endforeach;
    $admin_rows = ob_get_clean();

    gp_ds_card([
        'title' => get_phrase('admins'),
        'body' => gp_ds_table([
            'table_id' => 'basic-datatable',
            'extra_class' => 'mb-0',
            'headers' => [
                '#',
                get_phrase('photo'),
                get_phrase('name'),
                get_phrase('email'),
                get_phrase('Phone'),
                get_phrase('actions'),
            ],
            'body_html' => $admin_rows,
            'allow_empty' => true,
        ], true),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script>
    function export_csv() {
        let adminIds = [];
        document.querySelectorAll('tr.gradeU').forEach(row => {
            let adminId = row.getAttribute('data-admin-id');
            if (adminId) {
                adminIds.push(adminId);
            }
        });
        // Send the enrol IDs to the server using AJAX
        $.ajax({
            url: "<?php echo site_url('admin/export_admins_csv'); ?>",
            method: "POST",
            data: { admin_ids: adminIds },
            success: function(response) {
                // Trigger download
                let blob = new Blob([response], { type: 'text/csv' });
                let link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = 'admins.csv';
                link.click();
            },
            error: function(xhr, status, error) {
                console.error('Error generating CSV:', error);
            }
        });
    }
</script>
