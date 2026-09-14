<?php
gp_ds_page_title(
    $page_title,
    gp_ds_button(get_phrase('Delete Selected'), [
        'variant' => 'secondary',
        'type' => 'button',
        'attrs' => [
            'id' => 'delete_selected',
            'style' => 'display: none;',
        ],
    ], true)
);
?>

<div class="gp-contact-page">
    <?php
    gp_ds_card([
        'title' => get_phrase('Contact Users'),
        'body' => gp_ds_table([
            'table_id' => 'server_side_users_data',
            'extra_class' => 'mb-0',
            'headers' => [
                '<input type="checkbox" id="select_all">',
                '#',
                get_phrase('Name'),
                get_phrase('Contact'),
                get_phrase('Message'),
                get_phrase('Action'),
            ],
            'allow_empty' => true,
        ], true),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script>
  $(document).ready(function () {
    var selectedRows = []; // Array to store selected row IDs

    var table = $('#server_side_users_data').DataTable({
      responsive: true,
      "processing": true,
      "serverSide": true,
      "ajax": {
        "url": "<?php echo base_url('admin/contact/data-table') ?>",
        "dataType": "json",
        "type": "GET",
        "data": { '<?php echo $this->security->get_csrf_token_name(); ?>' : '<?php echo $this->security->get_csrf_hash(); ?>' }
      },
      order: [[0, 'desc']],
      "columns": [
        { "data": "checkbox" },
        { "data": "key" },
        { "data": "name" },
        { "data": "contact" },
        { "data": "message" },
        { "data": "action" }
      ],
      language: {
        paginate: {
          previous: '‹',
          next: '›'
        }
      }
    });

    // Function to show or hide delete button based on selected rows
    function toggleDeleteButton() {
      if (selectedRows.length > 0) {
        $('#delete_selected').show();
      } else {
        $('#delete_selected').hide();
      }
    }

    // Header checkbox click event
    $('#select_all').on('click', function () {
      var isChecked = $(this).is(':checked');
      
      $('input[type="checkbox"]', table.rows().nodes()).each(function () {
        var rowId = $(this).data('row-id');
        if (rowId !== undefined) {
          $(this).prop('checked', isChecked);
          
          if (isChecked) {
            if (!selectedRows.includes(rowId)) selectedRows.push(rowId);
          } else {
            selectedRows = [];
          }
        }
      });
      toggleDeleteButton();
    });

    // Checkbox click event for individual rows
    $('#server_side_users_data').on('click', 'input[type="checkbox"]', function () {
      var rowId = $(this).data('row-id');
      if (rowId !== undefined) {
        if ($(this).is(':checked')) {
          if (!selectedRows.includes(rowId)) selectedRows.push(rowId);
        } else {
          selectedRows = selectedRows.filter(id => id !== rowId);
        }
      }
      toggleDeleteButton();
    });

    // Reapply checkbox selection on table reload or sort
    table.on('draw', function () {
      $('input[type="checkbox"]', table.rows().nodes()).each(function () {
        var rowId = $(this).data('row-id');
        if (rowId !== undefined) {
          $(this).prop('checked', selectedRows.includes(rowId));
        }
      });
    });

    // Delete button click event for submission
    $('#delete_selected').on('click', function () {
      if (selectedRows.length > 0) {
          var selected_ids = selectedRows.join(',');
          confirm_modal('<?php echo site_url('admin/contact/delete_selected_contact?selected_ids=') ?>' + selected_ids);
      }
    });
  });
</script>
