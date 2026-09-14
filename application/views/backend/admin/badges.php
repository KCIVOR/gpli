<style type="text/css">
  .scrollable-tab .nav .nav-link {
	min-width: 180px;
}
</style>

<?php $homepage_banner = themeConfiguration(get_frontend_settings('theme'), 'homepage'); ?>
<?php gp_ds_page_title(get_phrase('gamification_badges_settings')); ?>

<div class="gp-settings-page">
<div class="row justify-content-center">
    <div class="col-xl-12">
        <?php
        ob_start();
        ?>

                <div class="scrollable-tab-section" id="basicwizard">
                    <div class="scrollable-tab" style="height: 50px; overflow-y: hidden;">

                        <ul class="nav nav-pills bg-nav-pills nav-justified mb-3" id="badgeTabs" style="width: fit-content;">
                            <li class="nav-item">
                                <a href="#courseCount" data-toggle="tab" aria-expanded="true" class="nav-link rounded-0 active py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo site_phrase('Number of Course'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#coursesRating" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo site_phrase('Number of Course Rating '); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#courseSale" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Number of Course Sale'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#articles" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Number Of Blogs'); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#courseCompleted" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Student Course Completed'); ?></span>
                                </a>
                            </li>
                            <?php if (addon_status('certificate')) : ?>
                            <li class="nav-item">
                                <a href="#certificate" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block"><?php echo get_phrase('Certificate'); ?></span>
                                </a>
                            </li>
                        	<?php endif; ?>
                        </ul>

                    </div>
                </div>

                <div class="tab-content">
                    <div class="tab-pane show active" id="courseCount">
                        <div class="row">
                             
                             <div class="col-lg-12">
                                    <div class="d-flex justify-content-between">
                                        <h4 class="mb-3 header-title"><?php echo site_phrase('Number of Course Badges'); ?></h4>
                                        <?php echo gp_ds_button(get_phrase('Add Badges'), [
                                            'variant' => 'outline',
                                            'href' => 'javascript:;',
                                            'extra_class' => 'alignToTitle',
                                            'attrs' => [
                                                'onclick' => "showAjaxModal('" . site_url('admin/badges_add?type=course_count') . "', '" . get_phrase('add_a_badges') . "');",
                                            ],
                                        ], true); ?>
                                    </div>
                                    <?php ob_start(); ?>
                                              <?php foreach ($badgesList as $badge): ?>
                                                    <?php if ($badge['type'] == 'course_count'): ?>
                                                        <tr>
                                                            <td>
                                                                <?php if (!empty($badge['image'])): ?>
                                                                    <img src="<?php echo base_url('uploads/badges/'.$badge['image']); ?>" alt="" width="40" height= '40'>
                                                                <?php endif; ?>
                                                            </td>
                                                            <td><?php echo $badge['title']; ?></td>
                                                            <td >
                                                                <p style="text-transform: lowercase"><?php echo $badge['condition_from']. ' '.  get_phrase('to') . ' '.$badge['condition_to'].' '.get_phrase('Courses'); ?></p>
                                                            </td>
                                                           
                                                           
                                                            <td><?php echo $badge['description']; ?></td>
                                                            <td>
                                                                <div class="dropright dropright">
                                                                    <button type="button" class="icon-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        <i class="mdi mdi-dots-vertical"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu">

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="showAjaxModal('<?php echo site_url('admin/badges_edit/' . $badge['id']); ?>' , '<?php echo get_phrase('Update '); ?>');">
                                                                            <?php echo get_phrase('edit'); ?>
                                                                        </a>
                                                                    </li>

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="confirm_modal('<?php echo site_url('admin/badges/delete/' . $badge['id']); ?>');">
                                                                            <?php echo get_phrase('delete'); ?>
                                                                        </a>
                                                                    </li>
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    <?php endif; ?>
                                                <?php endforeach; ?>

                                    <?php
                                    echo gp_ds_table([
                                        'headers' => [
                                            get_phrase('Image'),
                                            get_phrase('Title'),
                                            get_phrase('Condition'),
                                            get_phrase('Description'),
                                            get_phrase('Action'),
                                        ],
                                        'body_html' => ob_get_clean(),
                                        'allow_empty' => true,
                                        'extra_class' => 'mb-0',
                                    ], true);
                                    ?>
                             </div>
                        </div>
                    </div>
                    <div class="tab-pane " id="coursesRating">
                        <div class="row">
                             <div class="col-lg-12">
                                     <div class="d-flex justify-content-between">
                                        <h4 class="mb-3 header-title"><?php echo site_phrase('Number of Course Rating'); ?></h4>
                                        <?php echo gp_ds_button(get_phrase('Add Badges'), [
                                            'variant' => 'outline',
                                            'href' => 'javascript:;',
                                            'extra_class' => 'alignToTitle',
                                            'attrs' => [
                                                'onclick' => "showAjaxModal('" . site_url('admin/badges_add?type=courses_rating') . "', '" . get_phrase('add_a_badges') . "');",
                                            ],
                                        ], true); ?>
                                    </div>
                                    <?php ob_start(); ?>
                                              <?php foreach ($badgesList as $badge): ?>
                                                    <?php if ($badge['type'] == 'courses_rating'): ?>
                                                        <tr>
                                                            <td>
                                                                <?php if (!empty($badge['image'])): ?>
                                                                    <img src="<?php echo base_url('uploads/badges/'.$badge['image']); ?>" alt="" width="40" height= '40'>
                                                                <?php endif; ?>
                                                            </td>
                                                            <td><?php echo $badge['title']; ?></td>
                                                            <td >
                                                                <p style="text-transform: lowercase"><?php echo $badge['condition_from']. ' '.  get_phrase('to') . ' '.$badge['condition_to'].' '.get_phrase('course_review'); ?></p>
                                                            </td>
                                                           
                                                            <td><?php echo $badge['description']; ?></td>
                                                            <td>
                                                                <div class="dropright dropright">
                                                                    <button type="button" class="icon-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        <i class="mdi mdi-dots-vertical"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu">

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="showAjaxModal('<?php echo site_url('admin/badges_edit/' . $badge['id']); ?>' , '<?php echo get_phrase('Update '); ?>');">
                                                                            <?php echo get_phrase('edit'); ?>
                                                                        </a>
                                                                    </li>

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="confirm_modal('<?php echo site_url('admin/badges/delete/' . $badge['id']); ?>');">
                                                                            <?php echo get_phrase('delete'); ?>
                                                                        </a>
                                                                    </li>

                                                                       
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    <?php endif; ?>
                                                <?php endforeach; ?>

                                    <?php
                                    echo gp_ds_table([
                                        'headers' => [
                                            get_phrase('Image'),
                                            get_phrase('Title'),
                                            get_phrase('Condition'),
                                            get_phrase('Description'),
                                            get_phrase('Action'),
                                        ],
                                        'body_html' => ob_get_clean(),
                                        'allow_empty' => true,
                                        'extra_class' => 'mb-0',
                                    ], true);
                                    ?>
                             </div>
                        </div>
                    </div>
                    <div class="tab-pane " id="courseSale">
                        <div class="row">
                             <div class="col-lg-12">
                                 <div class="d-flex justify-content-between">
                                        <h4 class="mb-3 header-title"><?php echo site_phrase('Number of Course Sale'); ?></h4>
                                        <?php echo gp_ds_button(get_phrase('Add Badges'), [
                                            'variant' => 'outline',
                                            'href' => 'javascript:;',
                                            'extra_class' => 'alignToTitle',
                                            'attrs' => [
                                                'onclick' => "showAjaxModal('" . site_url('admin/badges_add?type=courses_sale') . "', '" . get_phrase('add_a_badges') . "');",
                                            ],
                                        ], true); ?>
                                    </div>
                                    <?php ob_start(); ?>
                                              <?php foreach ($badgesList as $badge): ?>
                                                    <?php if ($badge['type'] == 'courses_sale'): ?>
                                                        <tr>
                                                            <td>
                                                                <?php if (!empty($badge['image'])): ?>
                                                                    <img src="<?php echo base_url('uploads/badges/'.$badge['image']); ?>" alt="" width="40" height= '40'>
                                                                <?php endif; ?>
                                                            </td>
                                                            <td><?php echo $badge['title']; ?></td>
                                                            <td >
                                                                <p style="text-transform: lowercase"><?php echo $badge['condition_from']. ' '.  get_phrase('to') . ' '.$badge['condition_to'].' '.get_phrase('course_sale'); ?></p>
                                                            </td>
                                                           
                                                           
                                                            <td><?php echo $badge['description']; ?></td>
                                                            <td>
                                                                <div class="dropright dropright">
                                                                    <button type="button" class="icon-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        <i class="mdi mdi-dots-vertical"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu">

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="showAjaxModal('<?php echo site_url('admin/badges_edit/' . $badge['id']); ?>' , '<?php echo get_phrase('Update '); ?>');">
                                                                            <?php echo get_phrase('edit'); ?>
                                                                        </a>
                                                                    </li>

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="confirm_modal('<?php echo site_url('admin/badges/delete/' . $badge['id']); ?>');">
                                                                            <?php echo get_phrase('delete'); ?>
                                                                        </a>
                                                                    </li>

                                                                       
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    <?php endif; ?>
                                                <?php endforeach; ?>

                                    <?php
                                    echo gp_ds_table([
                                        'headers' => [
                                            get_phrase('Image'),
                                            get_phrase('Title'),
                                            get_phrase('Condition'),
                                            get_phrase('Description'),
                                            get_phrase('Action'),
                                        ],
                                        'body_html' => ob_get_clean(),
                                        'allow_empty' => true,
                                        'extra_class' => 'mb-0',
                                    ], true);
                                    ?>
                             </div>
                        </div>
                    </div>
                    <div class="tab-pane " id="articles">
                        <div class="row">
                             <div class="col-lg-12">
                                    <div class="d-flex justify-content-between">
                                        <h4 class="mb-3 header-title"><?php echo site_phrase('Number of Blogs'); ?></h4>
                                        <?php echo gp_ds_button(get_phrase('Add Badges'), [
                                            'variant' => 'outline',
                                            'href' => 'javascript:;',
                                            'extra_class' => 'alignToTitle',
                                            'attrs' => [
                                                'onclick' => "showAjaxModal('" . site_url('admin/badges_add?type=articles') . "', '" . get_phrase('add_a_badges') . "');",
                                            ],
                                        ], true); ?>
                                    </div>
                                    <?php ob_start(); ?>
                                              <?php foreach ($badgesList as $badge): ?>
                                                    <?php if ($badge['type'] == 'articles'): ?>
                                                        <tr>
                                                            <td>
                                                                <?php if (!empty($badge['image'])): ?>
                                                                    <img src="<?php echo base_url('uploads/badges/'.$badge['image']); ?>" alt="" width="40" height= '40'>
                                                                <?php endif; ?>
                                                            </td>
                                                            <td><?php echo $badge['title']; ?></td>
                                                            <td >
                                                                <p style="text-transform: lowercase"><?php echo $badge['condition_from']. ' '.  get_phrase('to') . ' '.$badge['condition_to'].' '.get_phrase('Blogs'); ?></p>
                                                            </td>
                                                           
                                                           
                                                            <td><?php echo $badge['description']; ?></td>
                                                            <td>
                                                                <div class="dropright dropright">
                                                                    <button type="button" class="icon-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        <i class="mdi mdi-dots-vertical"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu">

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="showAjaxModal('<?php echo site_url('admin/badges_edit/' . $badge['id']); ?>' , '<?php echo get_phrase('Update '); ?>');">
                                                                            <?php echo get_phrase('edit'); ?>
                                                                        </a>
                                                                    </li>

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="confirm_modal('<?php echo site_url('admin/badges/delete/' . $badge['id']); ?>');">
                                                                            <?php echo get_phrase('delete'); ?>
                                                                        </a>
                                                                    </li>


                                                                       
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    <?php endif; ?>
                                                <?php endforeach; ?>

                                    <?php
                                    echo gp_ds_table([
                                        'headers' => [
                                            get_phrase('Image'),
                                            get_phrase('Title'),
                                            get_phrase('Condition'),
                                            get_phrase('Description'),
                                            get_phrase('Action'),
                                        ],
                                        'body_html' => ob_get_clean(),
                                        'allow_empty' => true,
                                        'extra_class' => 'mb-0',
                                    ], true);
                                    ?>
                             </div>
                        </div>
                    </div>
                    <div class="tab-pane " id="courseCompleted">
                        <div class="row">
                             <div class="col-lg-12">
                                     <div class="d-flex justify-content-between">
                                        <h4 class="mb-3 header-title"><?php echo site_phrase('Number of Course Completed'); ?></h4>
                                        <?php echo gp_ds_button(get_phrase('Add Badges'), [
                                            'variant' => 'outline',
                                            'href' => 'javascript:;',
                                            'extra_class' => 'alignToTitle',
                                            'attrs' => [
                                                'onclick' => "showAjaxModal('" . site_url('admin/badges_add?type=course_completed') . "', '" . get_phrase('add_a_badges') . "');",
                                            ],
                                        ], true); ?>
                                    </div>
                                    <?php ob_start(); ?>
                                              <?php foreach ($badgesList as $badge): ?>
                                                    <?php if ($badge['type'] == 'course_completed'): ?>
                                                        <tr>
                                                            <td>
                                                                <?php if (!empty($badge['image'])): ?>
                                                                    <img src="<?php echo base_url('uploads/badges/'.$badge['image']); ?>" alt="" width="40" height= '40'>
                                                                <?php endif; ?>
                                                            </td>
                                                            <td><?php echo $badge['title']; ?></td>
                                                            <td >
                                                                <p style="text-transform: lowercase"><?php echo $badge['condition_from']. ' '.  get_phrase('to') . ' '.$badge['condition_to'].' '.get_phrase('course_completed'); ?></p>
                                                            </td>
                                                           
                                                           
                                                            <td><?php echo $badge['description']; ?></td>
                                                            <td>
                                                                <div class="dropright dropright">
                                                                    <button type="button" class="icon-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        <i class="mdi mdi-dots-vertical"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu">

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="showAjaxModal('<?php echo site_url('admin/badges_edit/' . $badge['id']); ?>' , '<?php echo get_phrase('Update '); ?>');">
                                                                            <?php echo get_phrase('edit'); ?>
                                                                        </a>
                                                                    </li>

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="confirm_modal('<?php echo site_url('admin/badges/delete/' . $badge['id']); ?>');">
                                                                            <?php echo get_phrase('delete'); ?>
                                                                        </a>
                                                                    </li>


                                                                       
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    <?php endif; ?>
                                                <?php endforeach; ?>

                                    <?php
                                    echo gp_ds_table([
                                        'headers' => [
                                            get_phrase('Image'),
                                            get_phrase('Title'),
                                            get_phrase('Condition'),
                                            get_phrase('Description'),
                                            get_phrase('Action'),
                                        ],
                                        'body_html' => ob_get_clean(),
                                        'allow_empty' => true,
                                        'extra_class' => 'mb-0',
                                    ], true);
                                    ?>
                             </div>
                        </div>
                    </div>
                    <?php if (addon_status('certificate')) : ?>
                    <div class="tab-pane " id="certificate">
                        <div class="row">
                             <div class="col-lg-12">
                                    <div class="d-flex justify-content-between">
                                        <h4 class="mb-3 header-title"><?php echo site_phrase('Number of Course Certificate'); ?></h4>
                                        <?php echo gp_ds_button(get_phrase('Add Badges'), [
                                            'variant' => 'outline',
                                            'href' => 'javascript:;',
                                            'extra_class' => 'alignToTitle',
                                            'attrs' => [
                                                'onclick' => "showAjaxModal('" . site_url('admin/badges_add?type=certificate') . "', '" . get_phrase('add_a_badges') . "');",
                                            ],
                                        ], true); ?>
                                    </div>
                                    <?php ob_start(); ?>
                                              <?php foreach ($badgesList as $badge): ?>
                                                    <?php if ($badge['type'] == 'certificate'): ?>
                                                        <tr>
                                                            <td>
                                                                <?php if (!empty($badge['image'])): ?>
                                                                    <img src="<?php echo base_url('uploads/badges/'.$badge['image']); ?>" alt="" width="40" height= '40'>
                                                                <?php endif; ?>
                                                            </td>
                                                            <td><?php echo $badge['title']; ?></td>
                                                            <td >
                                                                <p style="text-transform: lowercase"><?php echo $badge['condition_from']. ' '.  get_phrase('to') . ' '.$badge['condition_to'].' '.get_phrase('course_completed'); ?></p>
                                                            </td>
                                                           
                                                           
                                                            <td><?php echo $badge['description']; ?></td>
                                                            <td>
                                                                <div class="dropright dropright">
                                                                    <button type="button" class="icon-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        <i class="mdi mdi-dots-vertical"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu">

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="showAjaxModal('<?php echo site_url('admin/badges_edit/' . $badge['id']); ?>' , '<?php echo get_phrase('Update '); ?>');">
                                                                            <?php echo get_phrase('edit'); ?>
                                                                        </a>
                                                                    </li>

                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:;" onclick="confirm_modal('<?php echo site_url('admin/badges/delete/' . $badge['id']); ?>');">
                                                                            <?php echo get_phrase('delete'); ?>
                                                                        </a>
                                                                    </li>


                                                                       
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    <?php endif; ?>
                                                <?php endforeach; ?>

                                    <?php
                                    echo gp_ds_table([
                                        'headers' => [
                                            get_phrase('Image'),
                                            get_phrase('Title'),
                                            get_phrase('Condition'),
                                            get_phrase('Description'),
                                            get_phrase('Action'),
                                        ],
                                        'body_html' => ob_get_clean(),
                                        'allow_empty' => true,
                                        'extra_class' => 'mb-0',
                                    ], true);
                                    ?>
                             </div>
                        </div>
                    </div>
                    <?php endif; ?>
                    
                </div>

        <?php
        gp_ds_card([
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
</div>
</div>




<script type="text/javascript">
    <?php if(isset($_GET['tab'])): ?>
        $('.ajax_loader').addClass('start_ajax_loading');
        const tabClickInterval = setInterval(function(){
            if(!$("a[href$=<?= $_GET['tab']; ?>]").hasClass('active')){
                $("a[href$=<?= $_GET['tab']; ?>]").click();
            }else{
                $('.ajax_loader').removeClass('start_ajax_loading');
                clearInterval(tabClickInterval);
            }
        }, 1000);
    <?php endif; ?>

</script>
