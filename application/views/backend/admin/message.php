<?php gp_ds_page_title(get_phrase('private_message')); ?>

<div class="gp-message-page">
    <?php
    ob_start();
    ?>
        <div class="row gp-message-inbox">
            <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 gp-message-threads">

                <!-- compose new email button -->
                <div class="mail-sidebar-row visible-xs">
                    <?php echo gp_ds_button(get_phrase('new_message'), [
                        'href' => site_url('admin/message/message_new'),
                        'variant' => 'primary',
                        'extra_class' => 'gp-message-compose',
                    ], true); ?>
                </div>
                <hr>


                <!-- message user inbox list -->
                <div class="list-group">

                    <?php
                    $current_user = $this->session->userdata('user_id');
                    $this->db->where('sender', $current_user);
                    $this->db->or_where('receiver', $current_user);
                    $message_threads = $this->db->get('message_thread')->result_array();
                    foreach($message_threads as $row):

                        // defining the user to show
                        if ($row['sender'] == $current_user)
                            $user_to_show_id = $row['receiver'];
                        if ($row['receiver'] == $current_user)
                            $user_to_show_id = $row['sender'];

                        $unread_message_number = $this->crud_model->count_unread_message_of_thread($row['message_thread_code']);
                        $thread_active = isset($current_message_thread_code) && $current_message_thread_code == $row['message_thread_code'];
                        ?>
                        <a class="list-group-item <?php if ($thread_active) echo 'active';?>" href="<?php echo site_url('admin/message/message_read/' . $row['message_thread_code']);?>">

                            <?php
                                $user_details = $this->db->get_where('users' , array('id' => $user_to_show_id))->row_array();
                                echo $user_details['first_name'].' '.$user_details['last_name'];
                            ?>
                            <!-- <span class="badge badge-light pull-right" style="color:#aaa;"><?php echo $user_details['role_id'] == 1 ? get_phrase('admin') : get_phrase('student') ;?></span> -->

                            <?php if ($unread_message_number > 0):?>
                                <?php echo gp_ds_badge((string) $unread_message_number, 'secondary', true); ?>
                            <?php endif;?>
                        </a>
                    <?php endforeach;?>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
                <?php include $message_inner_page_name.'.php';?>
            </div>
        </div>
    <?php
    gp_ds_card([
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
