<!-- Topbar Start -->
<div class="navbar-custom topnav-navbar topnav-navbar-dark gp-admin-topbar">
    <div class="container-fluid">
        <div class="gp-admin-topbar-left">
            <a class="button-menu-mobile disable-btn">
                <div class="lines">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </a>
            <a href="<?php echo site_url($this->session->userdata('role')); ?>" class="topnav-logo">
                <span class="topnav-logo-lg">
                    <img src="<?php echo base_url('uploads/system/' . get_frontend_settings('small_logo')); ?>" alt="" height="32">
                </span>
                <span class="topnav-logo-sm">
                    <img src="<?php echo base_url('uploads/system/' . get_frontend_settings('small_logo')); ?>" alt="" height="32">
                </span>
            </a>
            <span class="gp-admin-brand d-none d-md-inline-block"><?php echo $this->db->get_where('settings', array('key' => 'system_name'))->row()->value; ?></span>
        </div>

        <ul class="list-unstyled topbar-right-menu gp-admin-topbar-right mb-0">
            <?php
            $gp_ds_active = gp_ds_is_active(isset($page_name) ? $page_name : '');
            if ($gp_ds_active): ?>
            <li class="notification-list gp-admin-theme-item">
                <div class="gp-theme-row" role="group" aria-label="Theme">
                    <button type="button" id="gp-theme-light" data-gp-theme="light" class="gp-theme-btn" aria-label="Light" title="Light">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>
                    </button>
                    <button type="button" id="gp-theme-system" data-gp-theme="system" class="gp-theme-btn" aria-label="System" title="System">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="4" width="18" height="13" rx="2"/><path d="M8 21h8M12 17v4"/></svg>
                    </button>
                    <button type="button" id="gp-theme-dark" data-gp-theme="dark" class="gp-theme-btn" aria-label="Dark" title="Dark">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M21 14.5A8.5 8.5 0 1 1 9.5 3 7 7 0 0 0 21 14.5z"/></svg>
                    </button>
                </div>
            </li>
            <?php endif; ?>

            <li class="dropdown notification-list topbar-dropdown">
                <a class="nav-link dropdown-toggle arrow-none" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                    <span class="align-middle text-18"><i class="fas fa-language"></i></span> <i class="mdi mdi-chevron-down"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated topbar-dropdown-menu gp-admin-menu">

                    <?php $languages = $this->crud_model->get_all_languages();
                    foreach ($languages as $language) : ?>
                        <?php if (trim($language) != "" && $this->session->userdata('language') != strtolower($language)) : ?>
                            <a href="javascript:void(0);" onclick="switch_language('<?php echo strtolower($language); ?>')" class="dropdown-item">
                                <span><?php echo ucwords($language); ?></span>
                            </a>
                        <?php endif; ?>
                    <?php endforeach; ?>

                </div>
            </li>

            <?php if ($this->session->userdata('is_instructor') == 1 || $this->session->userdata('admin_login') == 1) : ?>
                <?php if (addon_status('course_ai')) : ?>
                <li class="dropdown notification-list topbar-dropdown">
                    <?php if ($this->session->userdata('admin_login') == 1) : ?>
                        <a class="nav-link arrow-none" href="#" onclick="AIModal('<?php echo site_url('admin/chat_gpt') ?>', '<i class=&quot;mdi mdi-robot head-robot-icon&quot;></i> <?php echo get_phrase('AI_Writer'); ?>')">
                            <i class="mdi mdi-robot head-robot-icon"></i>
                        </a>
                    <?php else : ?>
                        <a class="nav-link arrow-none" href="#" onclick="AIModal('<?php echo site_url('user/chat_gpt') ?>', '<i class=&quot;mdi mdi-robot head-robot-icon&quot;></i> <?php echo get_phrase('AI_Writer'); ?>')">
                            <i class="mdi mdi-robot head-robot-icon"></i>
                        </a>
                    <?php endif; ?>
                </li>
                <?php endif; ?>

                <li class="dropdown notification-list">
                    <a class="nav-link dropdown-toggle arrow-none" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                        <i class="dripicons-view-apps noti-icon"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated gp-admin-menu">
                        <div class="dropdown-header"><?php echo get_phrase('Quick') . ' ' . get_phrase('actions'); ?></div>
                            <?php if ($this->session->userdata('is_instructor') == 1 && !$this->session->userdata('admin_login')  || has_permission('course')) : ?>
                                    <a href="#" class="dropdown-item" onclick="showAjaxModal('<?= site_url($logged_in_user_role . '/course_form/add_course_shortcut'); ?>', '<?= get_phrase('create_course'); ?>')">
                                        <i class="dripicons-archive"></i>
                                        <span><?= get_phrase('Add') . ' ' . get_phrase('course'); ?></span>
                                    </a>
                                    <a href="#" class="dropdown-item" onclick="showAjaxModal('<?php echo site_url('modal/popup/lesson_types/add_shortcut_lesson'); ?>', '<?php echo get_phrase('add_new_lesson'); ?>')">
                                        <i class="dripicons-media-next"></i>
                                        <span><?= get_phrase('Add') . ' ' . get_phrase('lesson'); ?></span>
                                    </a>
                            <?php endif; ?>

                            <?php if ($this->session->userdata('admin_login') && has_permission('student')) : ?>
                                    <a href="#" class="dropdown-item" onclick="showAjaxModal('<?php echo site_url('modal/popup/shortcut_add_student'); ?>', '<?php echo get_phrase('add_student'); ?>')">
                                        <i class="dripicons-user"></i>
                                        <span><?= get_phrase('Add') . ' ' . get_phrase('student'); ?></span>
                                    </a>
                            <?php endif; ?>

                            <?php if ($this->session->userdata('admin_login') && has_permission('enrolment')) : ?>
                                    <a href="#" class="dropdown-item" onclick="showAjaxModal('<?php echo site_url('modal/popup/shortcut_enrol_student'); ?>', '<?php echo get_phrase('enrol_a_student'); ?>')">
                                        <i class="dripicons-network-3"></i>
                                        <span><?= get_phrase('Enrol') . ' ' . get_phrase('student'); ?></span>
                                    </a>
                            <?php endif; ?>
                    </div>
                </li>
            <?php endif; ?>

            <?php if ($this->session->userdata('admin_login')) : ?>
                <li class="dropdown notification-list topbar-dropdown">
                    <a class="nav-link dropdown-toggle arrow-none" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                        <i class="mdi mdi-help-circle-outline"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated topbar-dropdown-menu gp-admin-menu">

                        <div class="dropdown-header"><?php echo get_phrase('Help') . ' ' . get_phrase('center'); ?></div>

                        <a href="https://creativeitem.com/docs/academy-lms" target="_blank" class="dropdown-item">
                            <i class="mdi mdi-file-document-box-outline"></i>
                            <span><?php echo get_phrase('Read') . ' ' . get_phrase('documentation'); ?></span>
                        </a>

                        <a href="https://www.youtube.com/watch?v=-HHhJUGQPeU&list=PLR1GrQCi5Zqvhh7wgtt-ShMAM1RROYJgE" target="_blank" class="dropdown-item">
                            <i class="mdi mdi-youtube"></i>
                            <span><?php echo get_phrase('Watch') . ' ' . get_phrase('tutorial'); ?></span>
                        </a>

                        <a href="https://support.creativeitem.com" target="_blank" class="dropdown-item">
                            <i class="far fa-life-ring"></i>
                            <span><?php echo get_phrase('Get') . ' ' . get_phrase('support'); ?></span>
                        </a>

                        <a href="https://support.creativeitem.com" target="_blank" class="dropdown-item">
                            <i class="mdi mdi-arrow-right-bold-circle-outline"></i>
                            <span><?php echo get_phrase('Order') . ' ' . get_phrase('customization'); ?></span>
                        </a>

                        <a href="https://support.creativeitem.com" target="_blank" class="dropdown-item">
                            <i class="mdi mdi-tooltip-plus-outline"></i>
                            <span><?php echo get_phrase('Request') . ' ' . get_phrase('feature'); ?></span>
                        </a>

                        <a href="https://codecanyon.net/collections/shared/9236f1b2a5de784f383c9ecd37b2f7b43dbfc225a5f96bc3ef32ac7ab397d392" target="_blank" class="dropdown-item">
                            <i class="mdi mdi-open-in-new"></i>
                            <span><?php echo get_phrase('Browse') . ' ' . get_phrase('addons'); ?></span>
                        </a>

                        <div class="dropdown-divider"></div>

                        <a href="https://creativeitem.com/services" target="_blank" class="dropdown-item">
                            <i class="dripicons-toggles"></i>
                            <span><?php echo get_phrase('Get') . ' ' . get_phrase('services'); ?></span>
                        </a>
                    </div>
                </li>

                <li class="dropdown notification-list">
                    <?php
                    $logged_user_id = $this->session->userdata('user_id');
                    $notifications = $this->db->order_by('status ASC, id desc')->limit(50)->where('to_user', $logged_user_id)->get('notifications');
                    $number_of_unread_notification = $this->db->order_by('status ASC, id desc')->limit(50)->where('status', 0)->where('to_user', $logged_user_id)->get('notifications')->num_rows();
                    ?>
                    <a class="nav-link dropdown-toggle arrow-none" data-toggle="dropdown" href="#" id="topbar-notifydrop" role="button" aria-haspopup="true" aria-expanded="false">
                        <i class="dripicons-bell noti-icon"></i>
                        <span id="newNotificationIcon" class="<?php if ($number_of_unread_notification > 0) echo 'noti-icon-badge'; ?>"></span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated gp-admin-menu gp-admin-notify" aria-labelledby="topbar-notifydrop">

                        <div class="dropdown-header gp-admin-notify-head">
                            <span><?php echo get_phrase('Notifications'); ?></span>
                            <a href="javascript:void(0);" onclick="handleNotification('remove_all')"><?php echo get_phrase('Clear'); ?></a>
                        </div>

                        <div id="headerNotification" class="gp-admin-notify-list">
                            <?php include "header_notification.php"; ?>
                        </div>

                        <div class="dropdown-divider"></div>

                        <a onclick="handleNotification('mark_all_as_read')" href="javascript:void(0);" class="dropdown-item">
                            <?php echo get_phrase('Mark') . ' ' . get_phrase('all') . ' ' . get_phrase('as') . ' ' . get_phrase('read'); ?>
                        </a>

                    </div>
                </li>
            <?php endif; ?>

            <li class="visit_website d-none d-md-flex">
                <a href="<?php echo site_url('home'); ?>" class="btn btn-outline-light"><?php echo get_phrase('Visit') . ' ' . get_phrase('website'); ?></a>
            </li>

            <li class="dropdown notification-list gp-admin-user-item">
                <a class="nav-link dropdown-toggle nav-user arrow-none mr-0" data-toggle="dropdown" id="topbar-userdrop" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    <span class="account-user-avatar">
                        <img src="<?php echo $this->user_model->get_user_image_url($this->session->userdata('user_id')); ?>" alt="user-image" class="rounded-circle">
                    </span>
                    <span class="gp-admin-user-meta">
                        <?php
                        $logged_in_user_details = $this->user_model->get_all_user($this->session->userdata('user_id'))->row_array();
                        ?>
                        <span class="account-user-name"><?php echo $logged_in_user_details['first_name'] . ' ' . $logged_in_user_details['last_name']; ?></span>
                        <span class="account-position">
                            <?php
                            if (strtolower($this->session->userdata('role')) == 'user') {
                                if ($this->session->userdata('is_instructor')) {
                                    echo get_phrase('instructor');
                                } else {
                                    echo get_phrase('student');
                                }
                            } else {
                                echo get_phrase('admin');
                            }
                            ?>
                        </span>
                    </span>
                </a>
                <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated topbar-dropdown-menu profile-dropdown gp-admin-menu" aria-labelledby="topbar-userdrop">
                    <div class="dropdown-header"><?php echo get_phrase('Welcome'); ?></div>

                    <?php if ($this->session->userdata('admin_login') == 1) : ?>
                        <a href="<?php echo site_url(strtolower($this->session->userdata('role')) . '/manage_profile'); ?>" class="dropdown-item">
                            <i class="mdi mdi-account-circle"></i>
                            <span><?php echo get_phrase('My') . ' ' . get_phrase('account'); ?></span>
                        </a>
                    <?php else : ?>
                        <a href="<?php echo site_url('home/profile/user_profile'); ?>" class="dropdown-item">
                            <i class="mdi mdi-account-circle"></i>
                            <span><?php echo get_phrase('My') . ' ' . get_phrase('account'); ?></span>
                        </a>
                    <?php endif; ?>

                    <?php if (strtolower($this->session->userdata('role')) == 'admin') : ?>
                        <a href="<?php echo site_url('admin/system_settings'); ?>" class="dropdown-item">
                            <i class="mdi mdi-settings"></i>
                            <span><?php echo get_phrase('Settings'); ?></span>
                        </a>
                    <?php endif; ?>

                    <div class="dropdown-divider"></div>

                    <a href="<?php echo site_url('login/logout'); ?>" class="dropdown-item gp-admin-menu-danger">
                        <i class="mdi mdi-logout"></i>
                        <span><?php echo get_phrase('Logout'); ?></span>
                    </a>

                </div>
            </li>
        </ul>
    </div>
</div>
<!-- end Topbar -->

<script type="text/javascript">
    function handleNotification(type) {
        $.ajax({
            url: '<?php echo site_url('admin/get_my_notification/'); ?>' + type,
            success: function(response) {
                var responseVal = JSON.parse(response);
                $('#headerNotification').html(responseVal.rendered_view);
                $('#newNotificationIcon').removeClass('noti-icon-badge');
                $('#newNotificationIcon').addClass(responseVal.notification_icon_class);
            }
        });
    }
</script>
