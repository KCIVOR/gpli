<div class="gp-cookie-banner" id="cookieConsentContainer" style="display: none;">
    <div class="gp-cookie-banner-desc">
        <p>
            <?php echo get_frontend_settings('cookie_note'); ?>
            <a class="gp-cookie-banner-link" href="<?php echo site_url('home/cookie_policy'); ?>"><?php echo site_phrase('cookie_policy'); ?></a>
        </p>
    </div>
    <div class="gp-cookie-banner-actions">
        <?php echo gp_ds_button(site_phrase('accept'), ['variant' => 'primary', 'extra_class' => 'gp-cookie-banner-btn', 'attrs' => ['onclick' => 'cookieAccept();']], true); ?>
    </div>
</div>
<script>
$(document).ready(function() {
    if (localStorage.getItem("accept_cookie_academy")) {
        //localStorage.removeItem("accept_cookie_academy");
    } else {
        $('#cookieConsentContainer').fadeIn(1000);
    }
});

function cookieAccept() {
    if (typeof(Storage) !== "undefined") {
        localStorage.setItem("accept_cookie_academy", true);
        localStorage.setItem("accept_cookie_time", "<?php echo date('m/d/Y'); ?>");
        $('#cookieConsentContainer').fadeOut(1200);
    }
}
</script>
