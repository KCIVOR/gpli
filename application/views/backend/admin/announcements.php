<?php
gp_ds_page_title(
    $page_title,
    gp_ds_button(get_phrase('add_announcement'), [
        'href' => site_url('admin/announcement_form/add_announcement_form'),
        'variant' => 'outline',
    ], true)
);
?>

<div class="gp-announce-page">
    <?php
    ob_start();
    if (count($announcements) > 0):
        ob_start();
        foreach ($announcements as $key => $announcement):
    ?>
                            <tr>
                                <td><?php echo ++$key; ?></td>

                                <td>
                                     <?php echo $announcement['course_names']; ?>
                                </td>

                                <td>
                                    <?php echo $announcement['title']; ?>
                                </td>

                                <td>
                                    <?php $description = strip_tags($announcement['description']);
                                            echo strlen($description) > 20 ? substr($description, 0, 20) . '...'
                                                : $description;
                                    ?>
                                </td>

                                <td>
                                    <?php if ($announcement['is_pinned']): ?>
                                        <?php gp_ds_badge(get_phrase('yes'), 'success'); ?>
                                    <?php else: ?>
                                        <?php gp_ds_badge(get_phrase('no'), 'neutral'); ?>
                                    <?php endif; ?>
                                </td>

                                <td>
                                    <div class="dropright dropright">
                                        <button type="button" class="btn btn-sm btn-outline-primary btn-rounded btn-icon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="mdi mdi-dots-vertical"></i>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <a class="dropdown-item" href="<?php echo site_url('admin/announcement_form/edit_announcement_form/'.$announcement['id']); ?>">
                                                        <?php echo get_phrase('edit'); ?>
                                                </a>
                                            </li>

                                            <li><a class="dropdown-item" href="#" onclick="confirm_modal('<?php echo site_url('admin/announcements/delete/' . $announcement['id']); ?>');"><?php echo get_phrase('delete'); ?></a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
    <?php
        endforeach;
        echo gp_ds_table([
            'table_id' => 'course-datatable',
            'extra_class' => 'table-striped dt-responsive nowrap mb-0',
            'headers' => [
                '#',
                get_phrase('course_name'),
                get_phrase('title'),
                get_phrase('description'),
                get_phrase('pinned'),
                get_phrase('actions'),
            ],
            'body_html' => ob_get_clean(),
            'allow_empty' => true,
            'attrs' => [
                'data-page-length' => '10',
            ],
        ], true);
    endif;
    if (count($announcements) == 0):
    ?>
                    <div class="img-fluid w-100 text-center">
                        <img src="<?php echo base_url('assets/backend/images/file-search.svg'); ?>" alt="">
                        <p><?php echo get_phrase('no_data_found'); ?></p>
                    </div>
    <?php
    endif;
    gp_ds_card([
        'title' => get_phrase('announcements'),
        'body' => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
