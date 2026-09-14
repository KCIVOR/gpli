<?php
gp_ds_page_title(
    $page_title,
    gp_ds_button(get_phrase('add_student'), [
        'href' => site_url('admin/user_form/add_user_form'),
        'variant' => 'outline',
    ], true)
);
?>

<div class="gp-users-page">
    <?php
    gp_ds_card([
        'title' => get_phrase('student'),
        'body' => gp_ds_table([
            'table_id' => 'server_side_users_data',
            'extra_class' => 'mb-0',
            'headers' => [
                '#',
                get_phrase('photo'),
                get_phrase('name'),
                get_phrase('email'),
                get_phrase('Phone'),
                get_phrase('enrolled_courses'),
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
        "url": "<?php echo base_url('admin/server_side_users_data') ?>",
        "dataType": "json",
        "type": "POST",
        "data":{  '<?php echo $this->security->get_csrf_token_name(); ?>' : '<?php echo $this->security->get_csrf_hash(); ?>' }
      },
      "columns": [
        { "data": "key" },
        { "data": "photo" },
        { "data": "name" },
        { "data": "email" },
        { "data": "phone" },
        { "data": "enrolled_courses" },
        { "data": "action" }
      ],
       dom: 'Blfrtip', // This positions the buttons
       lengthMenu: [ [10, 25, 50, 100, 200, 500, 600], [10, 25, 50, 100, 200, 500, 600] ],
      buttons: [
        {
            extend: 'csv',
            text: 'Export as CSV',
            filename: function () {
                var currentTime = new Date().toISOString().slice(0, 19).replace(/[-T:]/g, '_');  // Get current time and format it
                return 'students-' + currentTime;  // File name will be "users-YYYY_MM_DD_HH_MM_SS"
            },
            exportOptions: {
              columns: ':not(:last-child):not(:nth-child(2))'  // Exclude the last column ("action") and the second column ("photo")
            }
        }
      ] 
    });
   });

  function refreshServersideTable(tableId){
    $('#'+tableId).DataTable().ajax.reload();
  }
</script>
