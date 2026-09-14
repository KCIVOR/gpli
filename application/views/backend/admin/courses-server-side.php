<?php
gp_ds_page_title(
    get_phrase('Courses'),
    gp_ds_button(get_phrase('add_new_course'), [
        'href' => site_url('admin/course_form/add_course'),
        'variant' => 'primary',
    ], true)
);
?>
<div class="gp-courses-page">
    <div class="gp-dash-stats">
        <a class="gp-dash-stat" href="<?php echo site_url('admin/courses?category_id=all&status=active&instructor_id=all&price=all&button='); ?>">
            <span class="gp-dash-stat-icon"><i class="dripicons-link"></i></span>
            <span class="gp-dash-stat-value"><?php echo $status_wise_courses['active']->num_rows(); ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('active') . ' ' . get_phrase('courses'); ?></span>
        </a>
        <a class="gp-dash-stat" href="<?php echo site_url('admin/courses?category_id=all&status=upcoming&instructor_id=all&price=all&button='); ?>">
            <span class="gp-dash-stat-icon"><i class="dripicons-link-broken"></i></span>
            <span class="gp-dash-stat-value"><?php echo $status_wise_courses['upcoming']->num_rows(); ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('upcoming') . ' ' . get_phrase('courses'); ?></span>
        </a>
        <a class="gp-dash-stat" href="<?php echo site_url('admin/courses?category_id=all&status=pending&instructor_id=all&price=all&button='); ?>">
            <span class="gp-dash-stat-icon"><i class="dripicons-link-broken"></i></span>
            <span class="gp-dash-stat-value"><?php echo $status_wise_courses['pending']->num_rows(); ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('pending') . ' ' . get_phrase('courses'); ?></span>
        </a>
        <a class="gp-dash-stat" href="<?php echo site_url('admin/courses?category_id=all&status=all&instructor_id=all&price=free&button='); ?>">
            <span class="gp-dash-stat-icon"><i class="dripicons-star"></i></span>
            <span class="gp-dash-stat-value"><?php echo $this->crud_model->get_free_and_paid_courses('free')->num_rows(); ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('free') . ' ' . get_phrase('courses'); ?></span>
        </a>
        <a class="gp-dash-stat" href="<?php echo site_url('admin/courses?category_id=all&status=all&instructor_id=all&price=paid&button='); ?>">
            <span class="gp-dash-stat-icon"><i class="dripicons-tags"></i></span>
            <span class="gp-dash-stat-value"><?php echo $this->crud_model->get_free_and_paid_courses('paid')->num_rows(); ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('paid') . ' ' . get_phrase('courses'); ?></span>
        </a>
    </div>

    <?php
    ob_start();
    ?>
    <form class="gp-courses-filters" action="<?php echo site_url('admin/courses'); ?>" method="get">
        <div class="gp-courses-filter">
            <label for="category_id"><?php echo get_phrase('categories'); ?></label>
            <select class="form-control select2" data-toggle="select2" name="category_id" id="category_id">
                <option value="<?php echo 'all'; ?>" <?php if ($selected_category_id == 'all') echo 'selected'; ?>><?php echo get_phrase('all'); ?></option>
                <?php foreach ($categories->result_array() as $category) : ?>
                    <optgroup label="<?php echo $category['name']; ?>">
                        <?php $sub_categories = $this->crud_model->get_sub_categories($category['id']);
                        foreach ($sub_categories as $sub_category) : ?>
                            <option value="<?php echo $sub_category['id']; ?>" <?php if ($selected_category_id == $sub_category['id']) echo 'selected'; ?>><?php echo $sub_category['name']; ?></option>
                        <?php endforeach; ?>
                    </optgroup>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="gp-courses-filter">
            <label for="status"><?php echo get_phrase('status'); ?></label>
            <select class="form-control select2" data-toggle="select2" name="status" id='status'>
                <option value="all" <?php if ($selected_status == 'all') echo 'selected'; ?>><?php echo get_phrase('all'); ?></option>
                <option value="active" <?php if ($selected_status == 'active') echo 'selected'; ?>><?php echo get_phrase('active'); ?></option>
                <option value="pending" <?php if ($selected_status == 'pending') echo 'selected'; ?>><?php echo get_phrase('pending'); ?></option>
                <option value="private" <?php if ($selected_status == 'private') echo 'selected'; ?>><?php echo get_phrase('private'); ?></option>
                <option value="upcoming" <?php if ($selected_status == 'upcoming') echo 'selected'; ?>><?php echo get_phrase('upcoming'); ?></option>
            </select>
        </div>

        <div class="gp-courses-filter">
            <label for="instructor_id"><?php echo get_phrase('instructor'); ?></label>
            <select class="form-control server-side-select2" name="instructor_id" id='instructor_id' action="<?php echo site_url('admin/get_select2_instructor_data/all'); ?>">
                <option value="all" <?php if ($selected_instructor_id == 'all') echo 'selected'; ?>><?php echo get_phrase('all'); ?></option>

                <?php if(isset($_GET['instructor_id']) && $_GET['instructor_id'] != 'all'): ?>
                    <?php $instructor_details = $this->user_model->get_all_user($_GET['instructor_id'])->row_array(); ?>
                    <option value="<?php echo $_GET['instructor_id']; ?>" selected><?php echo $instructor_details['first_name'].' '.$instructor_details['last_name']; ?></option>
                <?php endif; ?>
            </select>
        </div>

        <div class="gp-courses-filter">
            <label for="price"><?php echo get_phrase('price'); ?></label>
            <select class="form-control select2" data-toggle="select2" name="price" id='price'>
                <option value="all" <?php if ($selected_price == 'all') echo 'selected'; ?>><?php echo get_phrase('all'); ?></option>
                <option value="free" <?php if ($selected_price == 'free') echo 'selected'; ?>><?php echo get_phrase('free'); ?></option>
                <option value="paid" <?php if ($selected_price == 'paid') echo 'selected'; ?>><?php echo get_phrase('paid'); ?></option>
            </select>
        </div>

        <div class="gp-courses-filter gp-courses-filter--action">
            <?php echo gp_ds_button(get_phrase('filter'), [
                'variant' => 'primary',
                'type' => 'submit',
                'attrs' => ['name' => 'button'],
            ], true); ?>
        </div>
    </form>
    <?php
    gp_ds_card([
        'title' => '',
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel gp-courses-toolbar',
    ]);
    ?>

    <?php
    ob_start();
    ?>
    <div class="gp-courses-table">
        <table id="course-datatable-server-side" class="table table-striped dt-responsive nowrap" width="100%" data-page-length='25'>
            <thead>
                <tr>
                    <th>#</th>
                    <th><?php echo get_phrase('title'); ?></th>
                    <th><?php echo get_phrase('category'); ?></th>
                    <th><?php echo get_phrase('lesson_and_section'); ?></th>
                    <th><?php echo get_phrase('enrolled_student'); ?></th>
                    <th><?php echo get_phrase('status'); ?></th>
                    <th><?php echo get_phrase('price'); ?></th>
                    <th><?php echo get_phrase('actions'); ?></th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
    <?php
    gp_ds_card([
        'title' => get_phrase('course') . ' ' . get_phrase('list'),
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
