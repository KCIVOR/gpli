<?php gp_ds_page_title(get_phrase('instructors_pending_blog')); ?>

<div class="gp-blog-page">
    <?php
    ob_start();
    foreach ($pending_blogs->result_array() as $key => $blog) :
        $user_details = $this->user_model->get_all_user($blog['user_id'])->row_array();
    ?>
                                <tr>
                                    <td><?php echo $key + 1; ?></td>
                                    <td>
                                    	<a href="<?php echo site_url('home/instructor_page/'.$blog['user_id']); ?>" target="_blank">
	                                    	<div class="d-flex">
	                                    		<div>
	                                        		<img src="<?php echo $this->user_model->get_user_image_url($user_details['id']); ?>" alt="" height="50" width="50" class="img-fluid rounded-circle img-thumbnail">
	                                        	</div>
		                                        <div class="pl-1 pt-1">
			                                    	<?php echo $user_details['first_name'] . ' ' . $user_details['last_name']; ?>
			                                    	<p><?php echo $user_details['email']; ?></p>
			                                    </div>
			                                </div>
			                            </a>
                                    </td>
                                    <td>
                                        <a href="<?php echo site_url('blog/details/'.slugify($blog['title']).'/'.$blog['blog_id']); ?>" target="_blank"><?php echo $blog['title']; ?></a><br>
                                        <small class="text-muted"><?php echo date('d M Y', $blog['added_date']); ?></small>
                                    </td>
                                    <td><?php echo $this->crud_model->get_blog_categories($blog['blog_category_id'])->row('title'); ?></td>
                                    <td>
                                        <?php gp_ds_badge(get_phrase($blog['status']), 'danger'); ?>
                                    </td>
                                    <td>
                                        <div class="dropright dropright">
                                            <button type="button" class="btn btn-sm btn-outline-primary btn-rounded btn-icon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="mdi mdi-dots-vertical"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/instructors_pending_blog/approval_request/' . $blog['blog_id']); ?>');">
                                                	<?php echo get_phrase('approved'); ?>
                                                </a></li>
                                                <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/instructors_pending_blog/delete/' . $blog['blog_id']); ?>');"><?php echo get_phrase('delete'); ?></a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
    <?php
    endforeach;
    $pending_rows = ob_get_clean();

    gp_ds_card([
        'title' => get_phrase('total_pending') . ' ' . $pending_blogs->num_rows() . ' ' . get_phrase('blogs'),
        'body' => gp_ds_table([
            'table_id' => 'basic-datatable',
            'extra_class' => 'mb-0',
            'headers' => [
                '#',
                get_phrase('creator'),
                get_phrase('title'),
                get_phrase('category'),
                get_phrase('status'),
                get_phrase('actions'),
            ],
            'body_html' => $pending_rows,
            'allow_empty' => true,
        ], true),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
