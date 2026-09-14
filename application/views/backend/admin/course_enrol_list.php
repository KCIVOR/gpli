<?php
ob_start();
?>
<div class="gp-courses-enrol">
    <div class="gp-courses-enrol-toolbar">
        <?php echo gp_ds_button(get_phrase('Export CSV'), [
            'type' => 'button',
            'variant' => 'outline',
            'attrs' => [
                'id' => 'export-button',
                'onclick' => 'export_csv();',
            ],
        ], true); ?>
    </div>

    <?php if (count($enrol_history->result_array()) > 0): ?>
        <div class="table-responsive-sm">
            <table class="table table-striped table-centered mb-0">
                <thead>
                    <tr>
                        <th><?php echo get_phrase('photo'); ?></th>
                        <th><?php echo get_phrase('user') . ' ' . get_phrase('name'); ?></th>
                        <th><?php echo get_phrase('enrollment_date'); ?></th>
                        <th><?php echo get_phrase('Expiry date'); ?></th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($enrol_history->result_array() as $enrol):
                        $user_data = $this->db->get_where('users', array('id' => $enrol['user_id']))->row_array(); ?>
                        <tr class="gradeU" data-enrol-id="<?php echo $enrol['id']; ?>">
                            <td>
                                <img src="<?php echo $this->user_model->get_user_image_url($enrol['user_id']); ?>" alt="" height="50" width="50" class="img-fluid rounded-circle img-thumbnail gp-courses-enrol-photo">
                            </td>
                            <td>
                                <b><?php echo $user_data['first_name'] . ' ' . $user_data['last_name']; ?></b><br>
                                <small><?php echo get_phrase('email') . ': ' . $user_data['email']; ?></small>
                            </td>
                            <td><?php echo date('D, d M Y', $enrol['date_added']); ?></td>
                            <td>
                                <?php if ($enrol['expiry_date']): ?>
                                    <?php echo date('D, d M Y', $enrol['expiry_date']); ?>
                                <?php else: ?>
                                    <?php echo get_phrase('Lifetime access'); ?>
                                <?php endif; ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>

    <?php if (count($enrol_history->result_array()) == 0): ?>
        <div class="empty-state">
            <div class="icon">＋</div>
            <h4><?php echo get_phrase('no_data_found'); ?></h4>
        </div>
    <?php endif; ?>
</div>
<?php
gp_ds_card([
    'title' => get_phrase('enrol') . ' ' . get_phrase('student') . ' ' . get_phrase('list'),
    'body' => ob_get_clean(),
    'extra_class' => 'gp-dash-panel',
]);
?>
<script type="text/javascript">

    function export_csv() {
        // Collect all enrol IDs
        let enrolIds = [];
        document.querySelectorAll('tr.gradeU').forEach(row => {
            let enrolId = row.getAttribute('data-enrol-id');
            if (enrolId) {
                enrolIds.push(enrolId);
            }
        });

        // Send the enrol IDs to the server using AJAX
        $.ajax({
            url: "<?php echo site_url('admin/export_enrol_history_csv'); ?>",
            method: "POST",
            data: { enrol_ids: enrolIds },
            success: function(response) {
                // Trigger download
                let blob = new Blob([response], { type: 'text/csv' });
                let link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = 'enrol_history.csv';
                link.click();
            },
            error: function(xhr, status, error) {
                console.error('Error generating CSV:', error);
            }
        });
    }

</script>
