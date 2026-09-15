<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Razorpay | <?php echo get_settings('system_name');?></title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">

		<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-tokens.css'); ?>">
		<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-payout-checkout.css'); ?>?v=payout-checkout-1">
		<link name="favicon" type="image/x-icon" href="<?php echo base_url('uploads/system/'.get_settings('favicon'));?>" rel="shortcut icon" />
		<script src="<?php echo base_url('assets/design-system/gp-theme-boot.js'); ?>"></script>

		<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
	</head>
	<body>

		<div class="gp-payout-checkout">
			<img class="gp-payout-checkout-logo" src="<?php echo base_url('assets/payment/razorpay.png'); ?>" alt="Razorpay">

			<div class="package-details">
				<strong><?php echo site_phrase('customer_name');?> | <?php echo $user_details['first_name'].' '.$user_details['last_name'];?></strong> <br>
				<strong><?php echo site_phrase('amount_to_pay');?> | <?php echo $amount_to_pay.' '.get_settings('razorpay_currency');?></strong> <br>

				<?php echo gp_ds_button(get_phrase('pay'), [
					'variant' => 'primary',
					'extra_class' => 'gp-payout-checkout-action',
					'attrs' => ['id' => 'rzp-button1'],
				], true); ?>
			</div>
		</div>
		<?php $preparedData = $this->payment_model->razorpayPrepareData($user_details['id'], true, $amount_to_pay); ?>

		<script>
			var options = {
			"key": "<?php echo $preparedData['key']; ?>", // Enter the Key ID generated from the Dashboard
			"amount": "<?php echo $preparedData['amount']; ?>", // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
			"currency": "<?php echo get_settings('razorpay_currency'); ?>",
			"name": "<?= $preparedData['name']; ?>",
			"order_id": "<?= $preparedData['order_id']; ?>", //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
			"handler": function (response){
				//alert(response.razorpay_payment_id);
				//alert(response.razorpay_order_id);
				//alert(response.razorpay_signature);

		        var redirectUrl = "<?php echo site_url('admin/razorpay_checkout_for_instructor_revenue/'.$user_details['id'].'/'.$payout_id.'/paid/'); ?>" + response.razorpay_order_id + "/" + response.razorpay_payment_id+ "/<?php echo $preparedData['amount']; ?>" + "/" + response.razorpay_signature;
		        window.location = redirectUrl;

			},
			"prefill": {
				"name": "<?= $preparedData['prefill']['name']; ?>",
				"email": "<?= $preparedData['prefill']['email']; ?>"
			},
			"theme": {
				"color": "<?= $preparedData['theme']['color']; ?>"
			}};
			
			var rzp1 = new Razorpay(options);
			rzp1.on('payment.failed', function (response){
				// alert(response.error.code);
				// alert(response.error.description);
				// alert(response.error.source);
				// alert(response.error.step);
				// alert(response.error.reason);
				// alert(response.error.metadata.order_id);
				// alert(response.error.metadata.payment_id);
			});

			document.getElementById('rzp-button1').onclick = function(e){
				rzp1.open();
				e.preventDefault();
			}
		</script>
	</body>
</html>