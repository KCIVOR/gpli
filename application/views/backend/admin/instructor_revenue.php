<?php gp_ds_page_title(get_phrase('instructor_revenue')); ?>

<div class="gp-report-page">
  <?php
  ob_start();
  ?>
  <div class="table-responsive-sm">
    <table id="basic-datatable" class="table table-striped table-centered mb-0">
      <thead>
        <tr>
          <th><?php echo get_phrase('enrolled_course'); ?></th>
          <th><?php echo get_phrase('instructor'); ?></th>
          <th><?php echo get_phrase('total_amount'); ?></th>
          <th><?php echo get_phrase('instructor_revenue'); ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($payment_history as $payment) :
          $course_data = $this->db->get_where('course', array('id' => $payment['course_id']))->row_array();
          $user_data = $this->db->get_where('users', array('id' => $course_data['user_id']))->row_array();

          $payment_keys = json_decode($user_data['payment_keys'], true);
          $paypal_keys = $payment_keys['paypal'];
          $stripe_keys = $payment_keys['stripe'];
          $razorpay_keys = $payment_keys['razorpay'];
          ?>
          <tr class="gradeU">
            <td>
              <strong><a href="<?php echo site_url('home/course/' . slugify($course_data['title']) . '/' . $course_data['id']); ?>" target="_blank"><?php echo $course_data['title']; ?></a></strong><br>
              <small class="text-muted"><?php echo get_phrase('enrolment_date') . ': ' . date('D, d-M-Y', $payment['date_added']); ?></small>
              <?php if ($payment['coupon']) : ?>
                <small class="d-block">
                  <span class="text-muted">
                    <?php echo get_phrase('coupon_applied'); ?> :
                  </span>
                  <i class="fas fa-tags"></i>
                  <?php echo gp_ds_badge($payment['coupon'], 'success', true); ?>
                </small>
              <?php endif; ?>
            </td>
            <td><?php echo $user_data['first_name'] . ' ' . $user_data['last_name']; ?></td>
            <td>
              <?php echo currency($payment['amount']); ?>
            </td>
            <td>
              <?php echo currency($payment['instructor_revenue']); ?>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <?php
  gp_ds_card([
    'title' => get_phrase('instructor_revenue'),
    'body' => ob_get_clean(),
    'extra_class' => 'gp-dash-panel',
  ]);
  ?>
</div>
