<?php
gp_ds_page_title(
    get_phrase('categories'),
    gp_ds_button(get_phrase('add_category'), [
        'href' => site_url('admin/category_form/add_category'),
        'variant' => 'outline',
    ], true)
);
?>
<div class="gp-courses-page">
    <div class="gp-category-grid">
        <?php foreach ($categories->result_array() as $category) :
            if ($category['parent'] > 0)
                continue;
            $sub_categories = $this->crud_model->get_sub_categories($category['id']); ?>
            <div class="gp-category-card on-hover-action" id="<?php echo $category['id']; ?>">
                <div class="gp-category-card-media">
                    <img src="<?php echo base_url('uploads/thumbnails/category_thumbnails/' . $category['thumbnail']); ?>" alt="<?php echo html_escape($category['name']); ?>">
                </div>
                <div class="gp-category-card-body">
                    <h4 class="gp-category-card-title">
                        <i class="<?php echo $category['font_awesome_class']; ?>"></i>
                        <?php echo $category['name']; ?>
                    </h4>
                    <p class="gp-category-card-meta"><?php echo count($sub_categories) . ' ' . get_phrase('sub_categories'); ?></p>
                </div>

                <?php if (count($sub_categories) > 0) : ?>
                    <ul class="gp-category-subs">
                        <?php foreach ($sub_categories as $sub_category) : ?>
                            <li class="gp-category-sub on-hover-action" id="<?php echo $sub_category['id']; ?>">
                                <span class="gp-category-sub-name">
                                    <i class="<?php echo $sub_category['font_awesome_class']; ?>"></i>
                                    <?php echo $sub_category['name']; ?>
                                </span>
                                <span class="gp-category-sub-actions">
                                    <span class="category-action" id="category-edit-btn-<?php echo $sub_category['id']; ?>">
                                        <a href="<?php echo site_url('admin/category_form/edit_category/' . $sub_category['id']); ?>" class="action-icon"> <i class="mdi mdi-pencil"></i></a>
                                    </span>
                                    <span class="category-action" id="category-delete-btn-<?php echo $sub_category['id']; ?>">
                                        <a href="javascript:;" class="action-icon" onclick="confirm_modal('<?php echo site_url('admin/categories/delete/' . $sub_category['id']); ?>');"> <i class="mdi mdi-delete"></i></a>
                                    </span>
                                </span>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                <?php endif; ?>

                <div class="gp-category-card-actions">
                    <span class="category-action" id="category-edit-btn-<?php echo $category['id']; ?>">
                        <a href="<?php echo site_url('admin/category_form/edit_category/' . $category['id']); ?>" class="action-icon"> <i class="mdi mdi-pencil"></i></a>
                    </span>
                    <span class="category-action" id="category-delete-btn-<?php echo $category['id']; ?>">
                        <a href="javascript:;" class="action-icon" onclick="confirm_modal('<?php echo site_url('admin/categories/delete/' . $category['id']); ?>');"> <i class="mdi mdi-delete"></i></a>
                    </span>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</div>

<script type="text/javascript">
    $('.on-hover-action').mouseenter(function() {
        var id = this.id;
        $('#category-delete-btn-' + id).show();
        $('#category-edit-btn-' + id).show();
    });
    $('.on-hover-action').mouseleave(function() {
        var id = this.id;
        $('#category-delete-btn-' + id).hide();
        $('#category-edit-btn-' + id).hide();
    });
</script>
