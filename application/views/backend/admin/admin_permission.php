<?php
// DEFINING MODULE FOR SETTING PERMISSION
// MAKE SURE TO KEEP A PERMISSION FOR USERS AND THEME
$modules = [
    'category', 'course', 'user', 'instructor', 'student', 'enrolment', 'revenue', 'messaging', 'blog', 'addon', 'theme', 'settings', 'coupon', 'academy_cloud', 'newsletter', 'contact'
];

?>
<?php
gp_ds_page_title(
    ucwords($page_title),
    gp_ds_button(get_phrase('back_to_admins'), [
        'href' => site_url('admin/admins'),
        'variant' => 'outline',
    ], true)
);
?>

<div class="gp-users-page">
    <div class="row justify-content-center">
        <div class="col-xl-8">
            <?php
            $permission_rows = [];
            foreach ($modules as $module) :
                $module_permission = has_permission($module, $permission_assign_to['id']);
                ob_start();
            ?>
                                        <input type="checkbox" class="" id="<?php echo $permission_assign_to['id'] . '-' . $module; ?>" data-switch="bool" onchange="setPermission('<?php echo $permission_assign_to['id'] . '-' . $module; ?>')" <?php echo $module_permission ? "checked" : ""; ?> />
                                        <label for="<?php echo $permission_assign_to['id']  . '-' . $module; ?>" data-on-label="On" data-off-label="Off"></label>
            <?php
                $switch_html = ob_get_clean();
                $permission_rows[] = [
                    ucwords(get_phrase($module)),
                    $switch_html,
                ];
            endforeach;

            ob_start();
            ?>
                <div class="text-muted">
                    <small> <strong><?php echo get_phrase('note'); ?></strong> : <?php echo get_phrase('you_can_toggle_the_switch_for_enabling_or_disabling_a_feature_to_access'); ?>.</small>
                </div>
                <div class="mt-4">
                    <?php echo gp_ds_table([
                        'extra_class' => 'mb-0',
                        'headers' => [
                            get_phrase('feature'),
                            get_phrase('action'),
                        ],
                        'rows' => $permission_rows,
                    ], true); ?>
                </div>
            <?php
            gp_ds_card([
                'title' => get_phrase('assign_permission_for') . ' : ' . $permission_assign_to['first_name'] . ' ' . $permission_assign_to['last_name'],
                'body' => ob_get_clean(),
                'extra_class' => 'gp-dash-panel',
            ]);
            ?>
        </div>
    </div>
</div>

<script>
    "use strict";

    function setPermission(arg) {
        // CALL THE SERVER SIDE
        $.ajax({
            url: '<?php echo site_url('admin/assign_permission'); ?>',
            type: 'POST',
            data: {
                arg: arg
            },
            success: function(response) {
                $.NotificationApp.send("<?php echo get_phrase('heads_up'); ?>!", '<?php echo get_phrase('permission_updated'); ?>', "top-right", "rgba(0,0,0,0.2)", "info");
            }
        });
    }
</script>
