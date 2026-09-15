<?php gp_ds_page_title(get_phrase('add_sub_category')); ?>

<div class="gp-courses-page">
    <div class="row justify-content-center">
        <div class="col-xl-7">
            <?php
            ob_start();
            ?>
                    <form action="<?php echo site_url('admin/sub_categories/0/add'); ?>" method="post" role="form">
                        <div class="form-group">
                            <label for="sub_category_code"><?php echo get_phrase('sub_category_code'); ?></label>
                            <input type="text" id="sub_category_code" name="code" class="form-control" readonly value="<?php echo substr(md5(rand(0, 1000000)), 0, 10); ?>">
                        </div>

                        <div class="form-group">
                            <label for="category_id"><?php echo get_phrase('category'); ?></label>
                            <select class="form-control select2" id="category_id" name="category_id" data-init-plugin="select2" required>
                                <?php foreach ($categories->result_array() as $category): ?>
                                    <option value="<?php echo $category['id']; ?>"><?php echo $category['name']; ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="sub_category_title"><?php echo get_phrase('sub_category_title'); ?></label>
                            <input type="text" id="sub_category_title" name="name" class="form-control" required>
                        </div>

                        <?php echo gp_ds_button(get_phrase('add_sub_category'), ['type' => 'submit', 'variant' => 'primary'], true); ?>
                    </form>
            <?php
            $body = ob_get_clean();
            gp_ds_card([
                'title' => get_phrase('add_sub_category_form'),
                'body'  => $body,
            ]);
            ?>
        </div>
    </div>
</div>
