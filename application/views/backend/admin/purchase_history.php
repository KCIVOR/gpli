<?php gp_ds_page_title(get_phrase('purchase_history')); ?>

<div class="gp-report-page">
  <?php
  ob_start();
  ?>
  <table id="basic-datatable" class="table table-striped table-centered mb-0">
    <thead>
      <tr>
        <th><?php echo get_phrase('user'); ?></th>
        <th><?php echo get_phrase('course'); ?></th>
        <th><?php echo get_phrase('paid_amount'); ?></th>
        <th><?php echo get_phrase('payment_method'); ?></th>
        <th><?php echo get_phrase('purchased_date'); ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($purchase_history->result_array() as $purchase):
          $user_data = $this->db->get_where('users', array('id' => $purchase['user_id']))->row_array();
          $course_data = $this->db->get_where('course', array('id' => $purchase['course_id']))->row_array();?>
          <tr class="gradeU">
            <td>
                <?php echo $user_data['first_name'].' '.$user_data['last_name']; ?><br>
                <small class="badge badge-light"><?php echo $user_data['email']; ?></small>
            </td>
            <td><a href="<?php echo site_url('home/course/' . rawurlencode(slugify($course_data['title'])) . '/' . $course_data['id']); ?>" target="_blank"><?php echo $course_data['title']; ?></a></td>
            <td>
              <?php echo currency($purchase['amount']+$purchase['tax']); ?><br>
            </td>
            <td><?php echo ucfirst($purchase['payment_type']); ?></td>
            <td><?php echo date('D, d-M-Y', $purchase['date_added']); ?></td>
          </tr>
      <?php endforeach; ?>
  </tbody>
</table>
  <?php
  gp_ds_card([
    'title' => get_phrase('purchase_history'),
    'body' => ob_get_clean(),
    'extra_class' => 'gp-dash-panel',
  ]);
  ?>
</div>
