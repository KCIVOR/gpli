<?php
$payment_details = $this->session->userdata('payment_details');
$payment_gateways = $this->db->where('status', 1)->get('payment_gateways')->result_array();
?>

<div class="gp-payment-page">
	<div class="gp-payment-shell">
		<header class="gp-payment-head">
			<div>
				<div class="eyebrow"><?php echo get_phrase('payment'); ?></div>
				<h1><?php echo get_phrase('make_payment'); ?></h1>
			</div>
			<a href="<?php echo $payment_details['back_url']; ?>" class="icon-btn close-btn-light">
				<i class="fa fa-times"></i>
			</a>
		</header>

		<div class="gp-payment-layout">
			<aside class="gp-payment-aside">
				<?php
					ob_start();
				?>
					<p class="payment-header"><?php echo get_phrase('select_payment_gateway'); ?></p>
					<div class="gp-payment-gateways">
						<?php $counter = 0; ?>
						<?php foreach($payment_gateways as $key => $payment_gateway):
							if($payment_gateway['is_addon']&&!addon_status($payment_gateway['identifier']))continue;

							if($payment_details['is_instructor_payout_user_id'] > 0){
						        $instructor_details = $this->user_model->get_all_user($payment_details['is_instructor_payout_user_id'])->row_array();
						        $test_mode = 0;
						        $keys = json_decode($instructor_details['payment_keys'], true);
						        if (!array_key_exists($payment_gateway['identifier'],$keys))continue;
						        $keys = $keys[$payment_gateway['identifier']];
						        $empty_key_of_instructor = 0;
						        foreach($keys as $key_val){
						        	if(empty($key_val))$empty_key_of_instructor = 1;
						        }
						    }

							$counter += 1; ?>
							<?php if(isset($$empty_key_of_instructor) && $empty_key_of_instructor > 0) continue; ?>

							<div class="payment-gateway <?php echo $payment_gateway['identifier'].'-selector'; ?>" onclick="selectedPaymentGateway('<?php echo $payment_gateway['identifier']; ?>')">
								<img class="tick-icon <?php echo $payment_gateway['identifier']; ?>-icon" src="<?php echo base_url('assets/payment/tick.png'); ?>" alt="">
								<img class="payment-gateway-icon" src="<?php echo base_url('assets/payment/'.$payment_gateway['identifier'].'.png'); ?>" alt="<?php echo html_escape($payment_gateway['identifier']); ?>">
							</div>
						<?php endforeach; ?>
					</div>
				<?php
					gp_ds_card([
						'body' => ob_get_clean(),
						'extra_class' => 'gp-payment-panel',
					]);
				?>
			</aside>

			<div class="gp-payment-main">
				<?php
					ob_start();
				?>
					<p class="payment-header"><?php echo $payment_details['payment_title']; ?></p>
					<div class="gp-payment-items">
						<?php foreach ($payment_details['items'] as $key => $item) : ?>
							<?php $user_details = $this->user_model->get_all_user($item['creator_id'])->row_array(); ?>
							<div class="gp-payment-item item">
								<span class="count-item"><?php echo ++$key; ?></span>
								<div class="gp-payment-item-copy">
									<span class="item-title"><?php echo $item['title']; ?></span>
									<span class="by-owner">
										<?php echo get_phrase('by'); ?>
										<?php echo $user_details['first_name'] . ' ' . $user_details['last_name']; ?>
									</span>
									<?php foreach ($item['sub_items'] as $sub_item) : ?>
										<span class="gp-payment-sub"><?php echo $sub_item['title']; ?></span>
									<?php endforeach; ?>
								</div>
								<span class="item-price">
									<?php if($item['discount_flag'] == 1): ?>
										<del><?php echo currency($item['price']); ?></del>
										<?php echo currency($item['discounted_price']); ?>
									<?php else: ?>
										<?php echo currency($item['actual_price']); ?>
									<?php endif; ?>
								</span>
							</div>
						<?php endforeach; ?>
					</div>

					<div class="gp-payment-total indicated-price">
						<span class="total"><?php echo get_phrase('total'); ?></span>
						<span class="total-price"><?php echo currency($payment_details['total_payable_amount']); ?></span>
					</div>

					<div class="gp-payment-actions">
						<?php foreach($payment_gateways as $key => $payment_gateway):
							if($payment_gateway['is_addon']&&!addon_status($payment_gateway['identifier']))continue;

							if($payment_details['is_instructor_payout_user_id'] > 0){
						        $instructor_details = $this->user_model->get_all_user($payment_details['is_instructor_payout_user_id'])->row_array();
						        $test_mode = 0;
						        $keys = json_decode($instructor_details['payment_keys'], true);
						        if (!array_key_exists($payment_gateway['identifier'],$keys))continue;
						        $keys = $keys[$payment_gateway['identifier']];
						        $empty_key_of_instructor = 0;
						        foreach($keys as $key_val){
						        	if(empty($key_val))$empty_key_of_instructor = 1;
						        }
						        if($empty_key_of_instructor > 0) continue;
						    }

							include $payment_gateway['identifier']."/payment_form.php";
						endforeach; ?>
					</div>
				<?php
					gp_ds_card([
						'body' => ob_get_clean(),
						'extra_class' => 'gp-payment-panel',
					]);
				?>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function selectedPaymentGateway(gateway) {
		$(".payment-gateway").removeClass('selected');
		$('.tick-icon').hide();
		$('.gateway').hide();

		$("."+gateway+"-selector").addClass('selected');
		$('.'+gateway+'-icon').show();
		$('.'+gateway+'-gateway').show();
	}
</script>
