<?php gp_ds_page_title(get_phrase('instructor_settings')); ?>

<div class="gp-users-page">
<div class="row">
    <div class="col-xl-6">
        <?php
        ob_start();
        ?>
                <form action="<?php echo site_url('admin/instructor_settings/update'); ?>" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label><?php echo get_phrase('allow_public_instructor'); ?></label>
                        <select class="form-control select2" data-toggle="select2" name="allow_instructor" required>
                            <option value="1" <?php if(get_settings('allow_instructor') == 1) echo 'selected'; ?>><?php echo get_phrase('yes'); ?></option>
                            <option value="0" <?php if(get_settings('allow_instructor') == 0) echo 'selected'; ?>><?php echo get_phrase('no'); ?></option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="instructor_application_note"><?php echo get_phrase('instructor_application_note'); ?></label>
                        <div class="form-group">
                            <textarea class="form-control" name="instructor_application_note" rows="8" cols="80"><?php echo get_settings('instructor_application_note'); ?></textarea>
                        </div>
                    </div>

                    <?php echo gp_ds_button(get_phrase('update_settings'), [
                        'variant' => 'primary',
                        'type' => 'submit',
                    ], true); ?>
                </form>
        <?php
        gp_ds_card([
            'title' => get_phrase('public_instructor_settings'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>

    <div class="col-xl-6">
        <?php
        ob_start();
        ?>
                <form action="<?php echo site_url('admin/instructor_settings/update'); ?>" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="instructor_revenue"><?php echo get_phrase('instructor_revenue_percentage'); ?></label>
                        <div class="input-group">
                            <input type="number" name = "instructor_revenue" id = "instructor_revenue" class="form-control" onkeyup="calculateAdminRevenue(this.value)" min="0" max="100" value="<?php echo get_settings('instructor_revenue'); ?>">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="mdi mdi-percent"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="admin_revenue"><?php echo get_phrase('admin_revenue_percentage'); ?></label>
                        <div class="input-group">
                            <input type="number" name = "admin_revenue" id = "admin_revenue" class="form-control" value="0" disabled style="background: none; cursor: default;">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="mdi mdi-percent"></i></span>
                            </div>
                        </div>
                    </div>

                    <?php echo gp_ds_button(get_phrase('update_settings'), [
                        'variant' => 'primary',
                        'type' => 'submit',
                    ], true); ?>
                </form>
        <?php
        gp_ds_card([
            'title' => get_phrase('instructor_commission_settings'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
</div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var instructor_revenue = $('#instructor_revenue').val();
        calculateAdminRevenue(instructor_revenue);
    });
    function calculateAdminRevenue(instructor_revenue) {
        if(instructor_revenue <= 100){
            var admin_revenue = 100 - instructor_revenue;
            $('#admin_revenue').val(admin_revenue);
        }else {
            $('#admin_revenue').val(0);
        }
    }
</script>
