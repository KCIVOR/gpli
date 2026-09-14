<?php
    $cart_items = $this->session->userdata('cart_items');
    if (! is_array($cart_items)) {
        $cart_items = [];
    }
    $cart_count = count($cart_items);
?>

<header class="gp-cart-head">
    <div class="eyebrow"><?php echo site_phrase('shopping_cart'); ?></div>
    <div class="gp-cart-head-row">
        <h1><?php echo get_phrase('Your Cart Items'); ?></h1>
        <p class="gp-cart-count"><?php echo $cart_count . ' ' . get_phrase('Items'); ?></p>
    </div>
</header>

<div class="gp-cart-layout">
    <div class="gp-cart-items">
        <?php
            $total = 0;
            ob_start();
            if ($cart_count === 0):
        ?>
            <div class="gp-cart-empty empty-state">
                <div class="icon" aria-hidden="true">＋</div>
                <p><?php echo get_phrase('You have no items in your cart!'); ?></p>
                <?php gp_ds_button(get_phrase('Courses'), [
                    'href' => site_url('home/courses'),
                    'variant' => 'outline',
                ]); ?>
            </div>
        <?php
            else:
                foreach ($cart_items as $item):
                    $course_details = $this->crud_model->get_course_by_id($item)->row_array();
        ?>
            <div class="gp-cart-item">
                <div class="gp-cart-item-thumb">
                    <img loading="lazy" src="<?php echo $this->crud_model->get_course_thumbnail_url($course_details['id']); ?>" alt="">
                </div>
                <a class="gp-cart-item-copy" href="<?php echo site_url('home/course/' . slugify($course_details['title']) . '/' . $course_details['id']); ?>">
                    <h5><?php echo $course_details['title']; ?></h5>
                    <p class="ellipsis-line-2"><?php echo $course_details['short_description']; ?></p>
                </a>
                <div class="gp-cart-item-price">
                    <?php if ($course_details['is_free_course']): ?>
                        <?php gp_ds_badge(get_phrase('Free'), 'success'); ?>
                    <?php elseif ($course_details['discount_flag']): ?>
                        <?php $total += $course_details['discounted_price']; ?>
                        <strong><?php echo currency($course_details['discounted_price']); ?></strong>
                        <del><?php echo currency($course_details['price']); ?></del>
                    <?php else: ?>
                        <?php $total += $course_details['price']; ?>
                        <strong><?php echo currency($course_details['price']); ?></strong>
                    <?php endif; ?>
                </div>
                <a class="icon-btn" href="#" onclick="actionTo('<?php echo site_url('home/handle_cart_items/'.$course_details['id']); ?>');"><i class="fa-solid fa-trash-can"></i></a>
            </div>
        <?php
                endforeach;
            endif;
            $cart_items_body = ob_get_clean();
            gp_ds_card([
                'body' => $cart_items_body,
                'extra_class' => 'gp-cart-panel',
            ]);
        ?>
    </div>

    <aside class="gp-cart-summary">
        <?php
            ob_start();
        ?>
            <?php if (isset($coupon_code) && !empty($coupon_code)) : ?>
                <?php if($this->crud_model->check_coupon_validity($coupon_code)): ?>
                    <?php $coupon_details = $this->crud_model->get_coupon_details_by_code($coupon_code)->row_array(); ?>
                    <?php $coupon_discounted_price = ($total * $coupon_details['discount_percentage']) / 100; ?>

                    <?php gp_ds_alert(get_phrase('You received').' '.currency($coupon_discounted_price).' ('.$coupon_details['discount_percentage'].'%) '.site_phrase('coupon discount'), '', 'success'); ?>
                    <?php
                        $total = $total - $coupon_discounted_price;
                        $total = ($total > 0) ? $total : 0;
                        $this->session->set_userdata('applied_coupon', $coupon_code);
                    ?>
                <?php else: ?>
                    <?php gp_ds_alert(get_phrase('Your coupon code has expired'), '', 'danger'); ?>
                    <?php $this->session->set_userdata('applied_coupon', null); ?>
                <?php endif; ?>
            <?php else: ?>
                <?php $this->session->set_userdata('applied_coupon', null); ?>
            <?php endif; ?>

            <div class="gp-cart-line">
                <span><?php echo get_phrase('Subtotal'); ?></span>
                <span><?php echo currency($total); ?></span>
            </div>

            <?php if(get_settings('course_selling_tax') > 0): ?>
                <div class="gp-cart-line">
                    <?php
                        $tax = round(($total/100) * get_settings('course_selling_tax'), 2);
                        $total = round($total + ($total/100) * get_settings('course_selling_tax'), 2);
                    ?>
                    <span><?php echo get_phrase('Tax'); ?></span>
                    <span><?php echo currency($tax).' <small>('.get_settings('course_selling_tax').'%)</small>'; ?></span>
                </div>
            <?php endif; ?>
            <div class="gp-cart-line is-total">
                <?php $this->session->set_userdata('total_price_of_checking_out', $total); ?>
                <span><?php echo get_phrase('Total'); ?></span>
                <span><?php echo currency($total); ?></span>
            </div>
            <form class="ajaxForm" action="<?php echo site_url('home/apply_coupon') ?>" method="post">
                <div class="gp-cart-coupon">
                    <input type="text" name="coupon_code" class="form-control" placeholder="<?php echo site_phrase('Apply coupon'); ?>" aria-label="<?php echo site_phrase('Apply coupon'); ?>">
                    <?php gp_ds_button(get_phrase('Apply'), [
                        'type' => 'submit',
                    ]); ?>
                </div>
            </form>

            <?php if (isset($coupon_code) && !empty($coupon_code) && isset($coupon_details) && $coupon_details['discount_percentage'] == 100 && $total == 0 && $coupon_details['expiry_date'] >= time()): ?>
                <div class="gp-cart-actions">
                    <?php gp_ds_button(get_phrase('Enroll Now'), [
                        'href' => site_url('home/coupon_offer_100_percent'),
                        'extra_class' => 'gp-cart-submit',
                    ]); ?>
                </div>
            <?php else: ?>
                <form action="<?php echo site_url('home/course_payment') ?>" method="post">
                    <div class="gp-cart-gift">
                        <input type="checkbox" id="is_gift" name="is_gift" onchange ="
                            if ($(this).prop('checked')==true){ 
                                $('#gift_email_section').removeClass('d-hidden');
                            }else{
                                $('#gift_email_section').addClass('d-hidden');
                            }
                            if ($('#gift_email').prop('required')) {
                                $('#gift_email').prop('required', false);
                            } else {
                                $('#gift_email').prop('required', true);
                            }"
                            value="1" <?php if(isset($_GET['gift'])) echo 'checked'; ?>>
                        <label for="is_gift"><?php echo get_phrase('Send as a gift'); ?></label>
                    </div>
                    <div id="gift_email_section" class="<?php if(isset($_GET['gift'])): else:echo 'd-hidden'; endif; ?>">
                        <input type="email" name="gift_email" id="gift_email" class="form-control" onkeyup="check_gift_user(this)" placeholder="<?php echo site_phrase('Email address'); ?>" <?php if(isset($_GET['gift'])) echo 'required'; ?>>
                        <span id="check_gift_user_message" class="gp-cart-gift-msg"></span>
                    </div>
                    <div class="gp-cart-actions">
                        <?php gp_ds_button(get_phrase('Continue to Payment'), [
                            'type' => 'submit',
                            'extra_class' => 'gp-cart-submit',
                            'attrs' => ['id' => 'payment-button'],
                        ]); ?>
                    </div>
                </form>
            <?php endif; ?>
        <?php
            $cart_summary_body = ob_get_clean();
            gp_ds_card([
                'title' => get_phrase('Total'),
                'body' => $cart_summary_body,
                'extra_class' => 'gp-cart-panel',
            ]);
        ?>
    </aside>
</div>

<script type="text/javascript">
    var timer = 0;
    function check_gift_user(e){
        $('#payment-button').attr('disabled', true);
        $('#check_gift_user_message').html('<?php echo get_phrase('Searching'); ?>...');
        var gift_email = $(e).val().replace(/\s/g, '');

        clearTimeout(timer);
        timer = setTimeout(function(){
            actionTo('<?php echo site_url('home/check_gift_user?gift_email='); ?>'+gift_email, 'post');
            $(e).val(gift_email);
            $('#payment-button').attr('disabled', false);
        }, 2000);
    }
</script>

<?php include "init.php"; ?>
