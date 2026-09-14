<?php
gp_ds_page_title(
    get_phrase('blog_categories'),
    gp_ds_button(get_phrase('add_new_category'), [
        'href' => '#',
        'variant' => 'outline',
        'tag' => 'button',
        'type' => 'button',
        'attrs' => [
            'onclick' => "showAjaxModal('" . site_url('admin/add_blog_category') . "', '" . get_phrase('add_a_new_category') . "');",
        ],
    ], true)
);
?>

<div class="gp-blog-page">
<div class="row">
	<?php foreach($categories->result_array() as $category): ?>
	    <div class="col-md-4 mb-3">
			<ul class="list-group list-group-numbered gp-blog-category-tile">
				<li class="list-group-item d-flex justify-content-between align-items-start">
					<div class="ml-2 mr-auto">
						<div class="gp-blog-category-title"><?php echo $category['title']; ?></div>
						<span class="mt-1 d-block"><?php echo $category['subtitle']; ?></span>
					</div>
					<div class="ml-auto text-center">
						<?php echo gp_ds_badge((string) $this->crud_model->get_blogs_by_category_id($category['blog_category_id'])->num_rows(), 'primary', true); ?>
						

						<div class="btn-group d-block mt-2">
							<button type="button" class="icon-btn" data-toggle="dropdown" aria-expanded="false">
								<i class="mdi mdi-dots-vertical"></i>
							</button>
							<div class="dropdown-menu dropdown-menu-right">
								<button class="dropdown-item" onclick="showAjaxModal('<?php echo site_url('admin/edit_blog_category/'.$category['blog_category_id']); ?>', '<?php echo get_phrase('edit_category'); ?>');" type="button"><i class="mdi mdi-pencil"></i> <?php echo get_phrase('edit'); ?></button>
								<button class="dropdown-item" onclick="confirm_modal('<?php echo site_url('admin/blog_category/delete/'.$category['blog_category_id']); ?>');" type="button"><i class="mdi mdi-trash-can-outline"></i> <?php echo get_phrase('delete'); ?></button>
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	<?php endforeach; ?>
</div>
</div>
