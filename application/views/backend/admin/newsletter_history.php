<?php
gp_ds_page_title(
    $page_title,
    gp_ds_button(get_phrase('Back'), [
        'href' => site_url('admin/newsletters'),
        'variant' => 'outline',
    ], true)
);
?>

<div class="gp-newsletter-page">
    <?php
    gp_ds_card([
        'title' => get_phrase('Histories'),
        'body' => gp_ds_table([
            'table_id' => 'server_side_newsletter_data',
            'extra_class' => 'mb-0',
            'headers' => [
                '#',
                get_phrase('Subject'),
                get_phrase('Email'),
                get_phrase('Status'),
                get_phrase('Action'),
            ],
            'allow_empty' => true,
        ], true),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script>
    $(document).ready(function() {
        var table = $('#server_side_newsletter_data').DataTable({
            responsive: true,
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": "<?php echo base_url('admin/newsletter_history/'.$type) ?>",
                "dataType": "json",
                "type": "POST",
                "data": {
                    '<?php echo $this->security->get_csrf_token_name(); ?>': '<?php echo $this->security->get_csrf_hash(); ?>'
                }
            },
            "columns": [{
                    "data": "key"
                },
                {
                    "data": "subject"
                },
                {
                    "data": "email"
                },
                {
                    "data": "status"
                },
                {
                    "data": "action"
                }
            ]
        });
    });

    function refreshTable(tableId = "server_side_newsletter_data") {
        $('#' + tableId).DataTable().ajax.reload();
    }
</script>
