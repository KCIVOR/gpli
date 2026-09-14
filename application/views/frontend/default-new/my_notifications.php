<?php
$logged_user_id = $this->session->userdata('user_id');
?>
<div class="gp-student-page">
<?php include 'breadcrumb.php'; ?>

<?php if (empty($logged_user_id)): ?>
<section class="wish-list-body gp-student-shell">
    <div class="container">
        <?php
        gp_ds_card([
            'title'       => '',
            'extra_class' => 'gp-student-notify-card',
            'body'        => '<p><a href="' . site_url('login') . '">' . get_phrase('login') . '</a></p>',
        ]);
        ?>
    </div>
</section>
</div>
<?php return; endif; ?>

<?php
$user_details  = $this->user_model->get_all_user($logged_user_id)->row_array();
$notifications = $this->db->order_by('status ASC, id desc')->limit(50)->where('to_user', $logged_user_id)->get('notifications');

$rows = [];
foreach ($notifications->result_array() as $notification) {
    $unread = ((int) $notification['status'] === 0);
    $rows[] = [
        html_escape($notification['title']),
        $notification['description'],
        html_escape(get_past_time($notification['created_at'])),
        gp_ds_badge(
            $unread ? get_phrase('unread') : get_phrase('read'),
            $unread ? 'warning' : 'neutral',
            true
        ),
    ];
}

$table = gp_ds_table([
    'headers' => [
        get_phrase('title'),
        get_phrase('description'),
        get_phrase('time'),
        get_phrase('status'),
    ],
    'rows'        => $rows,
    'extra_class' => 'gp-student-notify-table mb-0',
    'empty'       => get_phrase('No notification') . '. ' . get_phrase('Stay tuned!') . ' ' . get_phrase('Notifications about your activity will show up here.'),
], true);
?>

<section class="wish-list-body gp-student-shell">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-4">
                <?php include 'profile_menus.php'; ?>
            </div>
            <div class="col-lg-9 col-md-8">
                <?php
                ob_start();
                ?>
                <div class="gp-student-notify-toolbar">
                    <?php
                    gp_ds_button(get_phrase('Mark all as read'), [
                        'variant'     => 'primary',
                        'href'        => '#',
                        'extra_class' => 'gp-student-cta',
                        'attrs'       => [
                            'onclick' => "actionTo('" . site_url('home/get_my_notification/mark_all_as_read') . "'); return false;",
                        ],
                    ]);
                    gp_ds_button(get_phrase('Remove all'), [
                        'variant'     => 'outline',
                        'href'        => '#',
                        'extra_class' => 'gp-student-cta',
                        'attrs'       => [
                            'onclick' => "actionTo('" . site_url('home/get_my_notification/remove_all') . "'); return false;",
                        ],
                    ]);
                    ?>
                </div>
                <?php echo $table; ?>
                <?php
                gp_ds_card([
                    'title'       => '',
                    'extra_class' => 'gp-student-notify-card',
                    'body'        => ob_get_clean(),
                ]);
                ?>
            </div>
        </div>
    </div>
</section>
</div>
