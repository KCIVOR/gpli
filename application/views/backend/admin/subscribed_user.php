<?php gp_ds_page_title($page_title); ?>

<div class="gp-newsletter-page">
    <?php
    gp_ds_card([
        'title' => get_phrase('Subscriber'),
        'body' => gp_ds_table([
            'table_id' => 'server_side_users_data',
            'extra_class' => 'mb-0',
            'headers' => [
                '#',
                get_phrase('Email'),
                get_phrase('User status'),
                get_phrase('actions'),
            ],
            'allow_empty' => true,
        ], true),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script>
  $(document).ready(function () {
     var table = $('#server_side_users_data').DataTable({
      responsive: true,
      "processing": true,
      "serverSide": true,
      "ajax":{
        "url": "<?php echo base_url('admin/subscribed_user') ?>",
        "dataType": "json",
        "type": "POST",
        "data":{  '<?php echo $this->security->get_csrf_token_name(); ?>' : '<?php echo $this->security->get_csrf_hash(); ?>' }
      },
      "columns": [
        { "data": "key" },
        { "data": "email" },
        { "data": "user_status" },
        { "data": "action" }
      ]   
    });
   });

  function refreshServersideTable(tableId){
    $('#'+tableId).DataTable().ajax.reload();
  }
</script>
