<!---------- Header Section start  ---------->
<?php 

validate_cart_items();
$cart_items = $this->session->userdata('cart_items'); 
 
?>
<?php $user_id = $this->session->userdata('user_id'); ?>
<?php $user_login = $this->session->userdata('user_login'); ?>
<?php $admin_login = $this->session->userdata('admin_login'); ?>
<?php if($user_id > 0){$user_details = $this->user_model->get_all_user($user_id)->row_array();} ?>
<header class="gp-site-header">
  <section class="menubar">
    <?php include "header_lg_device.php"; ?>
    <!-- Offcanves Menu  -->
    <?php include "header_sm_device.php"; ?>
  </section>
</header>
<!---------- Header Section End  ---------->