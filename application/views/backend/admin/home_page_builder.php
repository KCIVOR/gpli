<?php gp_ds_page_title(get_phrase('Home page builder')); ?>

<?php
foreach (['feature_trio_section', 'media_strip_section', 'function_grid_section', 'quiz_banner_section', 'why_section', 'cta_band_section'] as $gp_seed_key) {
    $this->crud_model->ensure_frontend_setting($gp_seed_key, '1');
}
$gp_landing_extras_data = gp_landing_extras();
?>

<div class="gp-settings-page">
<div class="row justify-content-center">
    <div class="col-xl-12">
        <?php
        ob_start();
        ?>
        <ul class="nav nav-pills bg-nav-pills nav-justified mb-3">
            <li class="nav-item">
                <a href="#home-page-builder" data-toggle="tab" aria-expanded="true" class="nav-link rounded-0 active py-2">
                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                    <span class="d-none d-lg-block"><?php echo site_phrase('Home page builder'); ?></span>
                </a>
            </li>

            <li class="nav-item">
                <a href="#pre-built-home-settings" data-toggle="tab" aria-expanded="false" class="nav-link rounded-0 py-2">
                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                    <span class="d-none d-lg-block"><?php echo get_phrase('Pre-Built Home settings'); ?></span>
                </a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane show active" id="home-page-builder">
                <div class="row justify-content-center">
                    <div class="col-8 p-4">
                        <a onclick="showAjaxModal('<?php echo site_url('modal/popup/home_page_add'); ?>', '<?php echo get_phrase('Build a new Home page'); ?>')" href="#" class="add-home-page text-center mb-4">
                            <p class="sub-title mb-1"><i class="mdi mdi-plus text-20"></i></p>
                            <h3 class="title text-15 fw-500"><?php echo get_phrase('Build a new Home page'); ?></h3>
                        </a>
                    </div>

                    <?php if ($this->db->get_where('category', ['slug' => 'gpli-leadership'])->num_rows() > 0): ?>
                    <div class="col-12 px-4 mb-3">
                        <div class="alert alert-info d-flex align-items-center justify-content-between flex-wrap gap-2">
                            <span>
                                <i class="mdi mdi-image-multiple mr-1"></i>
                                <?php echo get_phrase('GPLI dummy-data seed: course thumbnails need to be assigned once after importing the migration .sql files.'); ?>
                            </span>
                            <a href="<?php echo site_url('admin/gpli_assign_course_thumbnails'); ?>"
                               class="btn btn-sm btn-info"
                               onclick="return confirm('<?php echo get_phrase('Assign distinct real thumbnails to every seeded GPLI course? Safe to run more than once.'); ?>');">
                                <?php echo get_phrase('Assign GPLI Course Thumbnails'); ?>
                            </a>
                        </div>
                    </div>

                    <?php foreach (gpli_section_backgrounds() as $gpli_section_id => $gpli_section): ?>
                    <?php $gpli_section_bg = get_frontend_settings($gpli_section['key']); ?>
                    <div class="col-xl-4 col-lg-6 px-4 mb-3">
                        <?php
                        ob_start();
                        ?>
                        <div class="row justify-content-center">
                            <form action="<?php echo site_url('admin/gpli_section_background_update/' . $gpli_section_id); ?>" method="post" enctype="multipart/form-data" style="text-align: center;">
                                <div class="form-group mb-2">
                                    <div class="wrapper-image-preview">
                                        <div class="box" style="width: 250px;">
                                            <div class="js--image-preview" style="background-image: url(<?php echo $gpli_section_bg ? base_url('uploads/system/' . $gpli_section_bg) : ''; ?>); background-color: var(--gp-surface-sunk); background-size: cover; background-position: center;"></div>
                                            <div class="upload-options">
                                                <label for="gpli_bg_<?php echo $gpli_section_id; ?>" class="btn"> <i class="mdi mdi-camera"></i> <?php echo get_phrase('Upload'); ?> <br> <small>(<?php echo htmlspecialchars($gpli_section['hint'] ?? '1600 x 900'); ?> <?php echo get_phrase('recommended'); ?>)</small> </label>
                                                <input id="gpli_bg_<?php echo $gpli_section_id; ?>" style="visibility:hidden;" type="file" class="image-upload" name="<?php echo $gpli_section['key']; ?>" accept="image/*">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php echo gp_ds_button(get_phrase('Upload'), [
                                    'variant' => 'primary',
                                    'type' => 'submit',
                                ], true); ?>
                            </form>
                            <?php if ($gpli_section_bg): ?>
                            <a href="<?php echo site_url('admin/gpli_section_background_remove/' . $gpli_section_id); ?>"
                               class="btn btn-sm btn-outline-secondary mt-2"
                               onclick="return confirm('<?php echo get_phrase('Remove this background image? The section will go back to its default look.'); ?>');">
                                <?php echo get_phrase('Remove'); ?>
                            </a>
                            <?php endif; ?>
                        </div>
                        <?php
                        gp_ds_card([
                            'title' => isset($gpli_section['card_title']) ? get_phrase($gpli_section['card_title']) : (get_phrase($gpli_section['label']) . ' ' . get_phrase('Background')),
                            'body' => ob_get_clean(),
                            'extra_class' => 'gp-dash-panel',
                        ]);
                        ?>
                    </div>
                    <?php endforeach; ?>
                    <?php endif; ?>

                    <?php foreach ($this->db->order_by('id', 'desc')->get('home_pages')->result_array() as $home_page): ?>
                        <div class="col-md-6">
                            <?php
                            $home_page_badge = $home_page['title'] . ' (' . ($home_page['is_permanent'] ? 'Pre-Built' : 'Custom-Built') . ')';
                            ob_start();
                            ?>
                                    <span class="gp-home-page-badge">
                                        <?php echo gp_ds_badge($home_page_badge, $home_page['is_permanent'] ? 'warning' : 'success', true); ?>
                                    </span>

                                    <?php if ($home_page['thumbnail'] == ''): ?>
                                        <img class="radius-5px" height="250px" src="<?php echo base_url('uploads/seo-og-images/placeholder.png') ?>">
                                    <?php else: ?>
                                        <img class="radius-5px" height="250px" src="<?php echo base_url($home_page['thumbnail']) ?>">
                                    <?php endif; ?>

                                    <div class="w-100 d-flex flex-row justify-content-evenly align-items-center mt-3 gp-home-page-actions">

                                        <?php if ($home_page['is_permanent'] != 1): ?>
                                            <?php echo gp_ds_button($home_page['status'] == 1 ? get_phrase('Activated') : get_phrase('Active'), [
                                                'variant' => $home_page['status'] == 1 ? 'primary' : 'outline',
                                                'href' => site_url('admin/home_page_builder/status/' . $home_page['id']),
                                                'extra_class' => 'text-center',
                                            ], true); ?>
                                            <?php echo gp_ds_button(get_phrase('Open Builder'), [
                                                'variant' => 'outline',
                                                'href' => site_url('admin/home_page/builder/' . $home_page['id']),
                                                'extra_class' => 'text-center',
                                            ], true); ?>
                                            <?php echo gp_ds_button(get_phrase('Edit'), [
                                                'variant' => 'outline',
                                                'href' => '#',
                                                'extra_class' => 'text-center',
                                                'attrs' => [
                                                    'onclick' => "showAjaxModal('" . site_url('modal/popup/home_page_edit/' . $home_page['id']) . "', '" . get_phrase('Edit Home page') . "')",
                                                ],
                                            ], true); ?>
                                            <?php echo gp_ds_button(get_phrase('Delete'), [
                                                'variant' => 'quiet',
                                                'href' => '#',
                                                'extra_class' => 'text-center',
                                                'attrs' => [
                                                    'onclick' => "confirm_modal('" . site_url('admin/home_page_builder/delete/' . $home_page['id']) . "')",
                                                ],
                                            ], true); ?>
                                        <?php else: ?>
                                            <?php echo gp_ds_button($home_page['status'] == 1 ? get_phrase('Activated') : get_phrase('Active'), [
                                                'variant' => $home_page['status'] == 1 ? 'primary' : 'outline',
                                                'href' => site_url('admin/home_page_builder/status/' . $home_page['id']),
                                                'extra_class' => 'text-center gp-home-page-status-wide',
                                            ], true); ?>
                                        <?php endif; ?>
                                    </div>
                            <?php
                            gp_ds_card([
                                'body' => ob_get_clean(),
                                'extra_class' => 'gp-dash-panel gp-home-page-item',
                                'body_class' => 'text-center position-relative',
                            ]);
                            ?>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <div class="tab-pane" id="pre-built-home-settings">
                <div class="row">
                    <div class="col-md-7">
                        <?php
                        ob_start();
                        ?>
                                <form action="<?php echo site_url('admin/frontend_settings/motivational_speech'); ?>" method="post" enctype="multipart/form-data">
                                    <div id="motivational_speech_area">
                                        <?php $motivational_speeches = count(json_decode(get_frontend_settings('motivational_speech'), true)) > 0 ? json_decode(get_frontend_settings('motivational_speech'), true) : [['title' => '', 'description' => '', 'image' => '']]; ?>
                                        <?php foreach ($motivational_speeches as $key => $motivational_speech): ?>
                                            <div class="d-flex mt-2">
                                                <div class="flex-grow-1 pr-3 mb-3">
                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Title'); ?></label>
                                                        <input type="text" class="form-control" name="titles[]" placeholder="<?php echo get_phrase('Title'); ?>" value="<?php echo $motivational_speech['title']; ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Description'); ?></label>
                                                        <textarea name="descriptions[]" class="form-control" placeholder="<?php echo get_phrase('Description'); ?>"><?php echo $motivational_speech['description']; ?></textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Image'); ?></label>
                                                        <div class="custom-file">
                                                            <input name="previous_images[]" type="hidden" value="<?php echo $motivational_speech['image']; ?>">
                                                            <input type="file" class="custom-file-input" name="images[]" onchange="changeTitleOfImageUploader(this)" accept="image/*">
                                                            <label class="custom-file-label" for="addon_zip"><?php echo get_phrase('Upload image'); ?></label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <?php if ($key == 0): ?>
                                                    <div class="" style="padding-top: 32px;">
                                                        <?php echo gp_ds_button('+', [
                                                            'variant' => 'outline',
                                                            'type' => 'button',
                                                            'extra_class' => 'gp-settings-faq-btn',
                                                            'attrs' => ['onclick' => 'appendMotivational_speech()', 'name' => 'button'],
                                                        ], true); ?>
                                                    </div>
                                                <?php else: ?>
                                                    <div class="" style="padding-top: 32px;">
                                                        <?php echo gp_ds_button('-', [
                                                            'variant' => 'outline',
                                                            'type' => 'button',
                                                            'extra_class' => 'gp-settings-faq-btn',
                                                            'attrs' => ['onclick' => 'removeMotivational_speech(this)', 'name' => 'button'],
                                                        ], true); ?>
                                                    </div>
                                                <?php endif; ?>
                                            </div>
                                        <?php endforeach; ?>

                                        <div id="blank_motivational_speech_field">
                                            <div class="d-flex pt-2 border-top">
                                                <div class="flex-grow-1 pr-3">
                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Title'); ?></label>
                                                        <input type="text" class="form-control" name="titles[]" placeholder="<?php echo get_phrase('faq_question'); ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Description'); ?></label>
                                                        <textarea name="descriptions[]" class="form-control mt-2" placeholder="<?php echo get_phrase('Description'); ?>"></textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <label><?php echo get_phrase('Image'); ?></label>
                                                        <div class="custom-file">
                                                            <input name="previous_images[]" type="hidden" value="">
                                                            <input type="file" class="custom-file-input" name="images[]" onchange="changeTitleOfImageUploader(this)" accept="image/*">
                                                            <label class="custom-file-label" for="addon_zip"><?php echo get_phrase('Upload image'); ?></label>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="" style="padding-top: 32px;">
                                                    <?php echo gp_ds_button('-', [
                                                        'variant' => 'outline',
                                                        'type' => 'button',
                                                        'extra_class' => 'gp-settings-faq-btn',
                                                        'attrs' => ['onclick' => 'removeFaq(this)', 'name' => 'button'],
                                                    ], true); ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group pt-0 mt-0">
                                        <?php echo gp_ds_button(get_phrase('Save changes'), [
                                            'variant' => 'primary',
                                            'type' => 'submit',
                                        ], true); ?>
                                    </div>
                                </form>
                        <?php
                        gp_ds_card([
                            'title' => get_phrase('Motivational Speech'),
                            'body' => ob_get_clean(),
                            'extra_class' => 'gp-dash-panel',
                        ]);
                        ?>
                    </div>
                    <div class="col-md-5">
                        <?php
                        ob_start();
                        ?>
                                <form>
                                    <div class="form-group row">
                                        <label class="col-8" for="upcoming_course_section"><?php echo get_phrase('upcoming_course_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/upcoming_course_section') ?>')" id="upcoming_course_section" data-switch="success" <?php if (get_frontend_settings('upcoming_course_section')) echo 'checked'; ?>>
                                            <label for="upcoming_course_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="top_course_section"><?php echo get_phrase('top_course_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/top_course_section') ?>')" id="top_course_section" data-switch="success" <?php if (get_frontend_settings('top_course_section')) echo 'checked'; ?>>
                                            <label for="top_course_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="latest_course_section"><?php echo get_phrase('latest_course_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/latest_course_section') ?>')" id="latest_course_section" data-switch="success" <?php if (get_frontend_settings('latest_course_section')) echo 'checked'; ?>>
                                            <label for="latest_course_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="top_category_section"><?php echo get_phrase('top_category_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/top_category_section') ?>')" id="top_category_section" data-switch="success" <?php if (get_frontend_settings('top_category_section')) echo 'checked'; ?>>
                                            <label for="top_category_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="top_instructor_section"><?php echo get_phrase('top_instructor_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/top_instructor_section') ?>')" id="top_instructor_section" data-switch="success" <?php if (get_frontend_settings('top_instructor_section')) echo 'checked'; ?>>
                                            <label for="top_instructor_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="faq_section"><?php echo get_phrase('faq_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/faq_section') ?>')" id="faq_section" data-switch="success" <?php if (get_frontend_settings('faq_section')) echo 'checked'; ?>>
                                            <label for="faq_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="motivational_speech_section"><?php echo get_phrase('motivational_speech_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/motivational_speech_section') ?>')" id="motivational_speech_section" data-switch="success" <?php if (get_frontend_settings('motivational_speech_section')) echo 'checked'; ?>>
                                            <label for="motivational_speech_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="blog_visibility_on_the_home_page"><?php echo get_phrase('blog_visibility_on_the_home_page'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/blog_visibility_on_the_home_page') ?>')" id="blog_visibility_on_the_home_page" data-switch="success" <?php if (get_frontend_settings('blog_visibility_on_the_home_page')) echo 'checked'; ?>>
                                            <label for="blog_visibility_on_the_home_page" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="promotional_section"><?php echo get_phrase('promotional_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/promotional_section') ?>')" id="promotional_section" data-switch="success" <?php if (get_frontend_settings('promotional_section')) echo 'checked'; ?>>
                                            <label for="promotional_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-8" for="review_section"><?php echo get_phrase('review_section'); ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/review_section') ?>')" id="review_section" data-switch="success" <?php if (get_frontend_settings('review_section')) echo 'checked'; ?>>
                                            <label for="review_section" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <?php
                                    $gp_landing_toggles = [
                                        'feature_trio_section' => 'Feature trio',
                                        'media_strip_section' => 'Media strip',
                                        'function_grid_section' => 'Courses by function',
                                        'quiz_banner_section' => 'Quiz banner',
                                        'why_section' => 'Why section',
                                        'cta_band_section' => 'CTA band',
                                    ];
                                    foreach ($gp_landing_toggles as $toggle_key => $toggle_label):
                                    ?>
                                    <div class="form-group row">
                                        <label class="col-8" for="<?php echo $toggle_key; ?>"><?php echo $toggle_label; ?></label>
                                        <div class="col-4">
                                            <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/' . $toggle_key); ?>')" id="<?php echo $toggle_key; ?>" data-switch="success" <?php if (gp_landing_toggle($toggle_key)) echo 'checked'; ?>>
                                            <label for="<?php echo $toggle_key; ?>" data-on-label="On" data-off-label="Off"></label>
                                        </div>
                                    </div>
                                    <?php endforeach; ?>
                                </form>
                        <?php
                        gp_ds_card([
                            'title' => get_phrase('Home page section') . ' <small>(' . get_phrase('Enable') . '/' . get_phrase('Disable') . ')</small>',
                            'body' => ob_get_clean(),
                            'extra_class' => 'gp-dash-panel',
                        ]);
                        ?>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-md-12">
                        <?php
                        $extras = $gp_landing_extras_data;
                        ob_start();
                        ?>
                                <form action="<?php echo site_url('admin/frontend_settings/landing_page_extras'); ?>" method="post" enctype="multipart/form-data">

                                    <h4 class="mt-2"><?php echo get_phrase('Hero'); ?></h4>
                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label><?php echo get_phrase('Eyebrow'); ?></label>
                                            <input type="text" class="form-control" name="landing[hero][eyebrow]" value="<?php echo htmlspecialchars($extras['hero']['eyebrow']); ?>">
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label><?php echo get_phrase('Gold accent word(s) in headline'); ?></label>
                                            <input type="text" class="form-control" name="landing[hero][accent]" value="<?php echo htmlspecialchars($extras['hero']['accent']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Primary CTA label'); ?></label>
                                            <input type="text" class="form-control" name="landing[hero][cta1_label]" value="<?php echo htmlspecialchars($extras['hero']['cta1_label']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Primary CTA URL'); ?></label>
                                            <input type="text" class="form-control" name="landing[hero][cta1_url]" value="<?php echo htmlspecialchars($extras['hero']['cta1_url']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Secondary CTA label'); ?></label>
                                            <input type="text" class="form-control" name="landing[hero][cta2_label]" value="<?php echo htmlspecialchars($extras['hero']['cta2_label']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Secondary CTA URL'); ?></label>
                                            <input type="text" class="form-control" name="landing[hero][cta2_url]" value="<?php echo htmlspecialchars($extras['hero']['cta2_url']); ?>">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <?php foreach ($extras['hero']['stats'] as $i => $stat): ?>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Stat') . ' ' . ($i + 1); ?></label>
                                            <input type="text" class="form-control mb-1" placeholder="<?php echo get_phrase('Number'); ?>" name="landing[hero][stats][<?php echo $i; ?>][num]" value="<?php echo htmlspecialchars($stat['num']); ?>">
                                            <input type="text" class="form-control mb-1" placeholder="<?php echo get_phrase('Label'); ?>" name="landing[hero][stats][<?php echo $i; ?>][lbl]" value="<?php echo htmlspecialchars($stat['lbl']); ?>">
                                            <input type="text" class="form-control" placeholder="<?php echo get_phrase('Sub text'); ?>" name="landing[hero][stats][<?php echo $i; ?>][sub]" value="<?php echo htmlspecialchars($stat['sub']); ?>">
                                        </div>
                                        <?php endforeach; ?>
                                    </div>

                                    <h4 class="mt-3"><?php echo get_phrase('Feature trio'); ?></h4>
                                    <div class="row">
                                        <?php foreach ($extras['trio'] as $i => $item): ?>
                                        <div class="col-md-4 form-group">
                                            <input type="text" class="form-control mb-1" placeholder="<?php echo get_phrase('Title'); ?>" name="landing[trio][<?php echo $i; ?>][title]" value="<?php echo htmlspecialchars($item['title']); ?>">
                                            <textarea class="form-control" placeholder="<?php echo get_phrase('Text'); ?>" name="landing[trio][<?php echo $i; ?>][text]"><?php echo htmlspecialchars($item['text']); ?></textarea>
                                        </div>
                                        <?php endforeach; ?>
                                    </div>

                                    <h4 class="mt-3"><?php echo get_phrase('Media strip'); ?></h4>
                                    <div class="row">
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Image 1'); ?></label>
                                            <input type="file" class="form-control" name="landing_media[image_1]" accept="image/*">
                                        </div>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Image 2'); ?></label>
                                            <input type="file" class="form-control" name="landing_media[image_2]" accept="image/*">
                                        </div>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Image 3'); ?></label>
                                            <input type="file" class="form-control" name="landing_media[image_3]" accept="image/*">
                                        </div>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Video URL'); ?></label>
                                            <input type="text" class="form-control" name="landing[media][video_url]" value="<?php echo htmlspecialchars($extras['media']['video_url']); ?>">
                                        </div>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Video title'); ?></label>
                                            <input type="text" class="form-control" name="landing[media][video_title]" value="<?php echo htmlspecialchars($extras['media']['video_title']); ?>">
                                        </div>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Video tag'); ?></label>
                                            <input type="text" class="form-control" name="landing[media][video_tag]" value="<?php echo htmlspecialchars($extras['media']['video_tag']); ?>">
                                        </div>
                                    </div>

                                    <h4 class="mt-3"><?php echo get_phrase('Courses by function — blurbs'); ?></h4>
                                    <div class="row">
                                        <?php foreach ($this->crud_model->get_categories()->result_array() as $gp_cat): ?>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo htmlspecialchars($gp_cat['name']); ?></label>
                                            <textarea class="form-control" name="landing[function_blurbs][<?php echo (int) $gp_cat['id']; ?>]"><?php echo htmlspecialchars(isset($extras['function_blurbs'][$gp_cat['id']]) ? $extras['function_blurbs'][$gp_cat['id']] : ''); ?></textarea>
                                        </div>
                                        <?php endforeach; ?>
                                    </div>

                                    <h4 class="mt-3"><?php echo get_phrase('Leadership quiz banner'); ?></h4>
                                    <div class="row">
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Eyebrow'); ?></label>
                                            <input type="text" class="form-control" name="landing[quiz][eyebrow]" value="<?php echo htmlspecialchars($extras['quiz']['eyebrow']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Title'); ?></label>
                                            <input type="text" class="form-control" name="landing[quiz][title]" value="<?php echo htmlspecialchars($extras['quiz']['title']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Button label'); ?></label>
                                            <input type="text" class="form-control" name="landing[quiz][button_label]" value="<?php echo htmlspecialchars($extras['quiz']['button_label']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Button URL (blank = no button)'); ?></label>
                                            <input type="text" class="form-control" name="landing[quiz][button_url]" value="<?php echo htmlspecialchars($extras['quiz']['button_url']); ?>">
                                        </div>
                                        <div class="col-md-12 form-group">
                                            <label><?php echo get_phrase('Text'); ?></label>
                                            <textarea class="form-control" name="landing[quiz][text]"><?php echo htmlspecialchars($extras['quiz']['text']); ?></textarea>
                                        </div>
                                    </div>

                                    <h4 class="mt-3"><?php echo get_phrase('Why section'); ?></h4>
                                    <div class="row">
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Eyebrow'); ?></label>
                                            <input type="text" class="form-control" name="landing[why][eyebrow]" value="<?php echo htmlspecialchars($extras['why']['eyebrow']); ?>">
                                        </div>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Title'); ?></label>
                                            <input type="text" class="form-control" name="landing[why][title]" value="<?php echo htmlspecialchars($extras['why']['title']); ?>">
                                        </div>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Text'); ?></label>
                                            <input type="text" class="form-control" name="landing[why][text]" value="<?php echo htmlspecialchars($extras['why']['text']); ?>">
                                        </div>
                                        <?php foreach ($extras['why']['tiles'] as $i => $tile): ?>
                                        <div class="col-md-4 form-group">
                                            <label><?php echo get_phrase('Tile') . ' ' . ($i + 1); ?></label>
                                            <input type="text" class="form-control mb-1" placeholder="<?php echo get_phrase('Title'); ?>" name="landing[why][tiles][<?php echo $i; ?>][title]" value="<?php echo htmlspecialchars($tile['title']); ?>">
                                            <textarea class="form-control" placeholder="<?php echo get_phrase('Text'); ?>" name="landing[why][tiles][<?php echo $i; ?>][text]"><?php echo htmlspecialchars($tile['text']); ?></textarea>
                                        </div>
                                        <?php endforeach; ?>
                                        <?php foreach ($extras['why']['stats'] as $i => $stat): ?>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Stat') . ' ' . ($i + 1); ?></label>
                                            <input type="text" class="form-control mb-1" placeholder="<?php echo get_phrase('Number'); ?>" name="landing[why][stats][<?php echo $i; ?>][num]" value="<?php echo htmlspecialchars($stat['num']); ?>">
                                            <input type="text" class="form-control" placeholder="<?php echo get_phrase('Label'); ?>" name="landing[why][stats][<?php echo $i; ?>][lbl]" value="<?php echo htmlspecialchars($stat['lbl']); ?>">
                                        </div>
                                        <?php endforeach; ?>
                                    </div>

                                    <h4 class="mt-3"><?php echo get_phrase('CTA band'); ?></h4>
                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label><?php echo get_phrase('Title'); ?></label>
                                            <input type="text" class="form-control" name="landing[cta_band][title]" value="<?php echo htmlspecialchars($extras['cta_band']['title']); ?>">
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label><?php echo get_phrase('Text'); ?></label>
                                            <input type="text" class="form-control" name="landing[cta_band][text]" value="<?php echo htmlspecialchars($extras['cta_band']['text']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Primary CTA label'); ?></label>
                                            <input type="text" class="form-control" name="landing[cta_band][cta1_label]" value="<?php echo htmlspecialchars($extras['cta_band']['cta1_label']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Primary CTA URL'); ?></label>
                                            <input type="text" class="form-control" name="landing[cta_band][cta1_url]" value="<?php echo htmlspecialchars($extras['cta_band']['cta1_url']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Secondary CTA label'); ?></label>
                                            <input type="text" class="form-control" name="landing[cta_band][cta2_label]" value="<?php echo htmlspecialchars($extras['cta_band']['cta2_label']); ?>">
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo get_phrase('Secondary CTA URL'); ?></label>
                                            <input type="text" class="form-control" name="landing[cta_band][cta2_url]" value="<?php echo htmlspecialchars($extras['cta_band']['cta2_url']); ?>">
                                        </div>
                                        <div class="col-md-12 form-group">
                                            <label><?php echo get_phrase('Footnote'); ?></label>
                                            <input type="text" class="form-control" name="landing[cta_band][footnote]" value="<?php echo htmlspecialchars($extras['cta_band']['footnote']); ?>">
                                        </div>
                                    </div>

                                    <h4 class="mt-3"><?php echo get_phrase('Section backgrounds'); ?> <small><?php echo get_phrase('Optional image or GIF behind a section — a dark overlay is applied automatically so text stays readable'); ?></small></h4>
                                    <div class="row">
                                        <?php
                                        $gp_section_bg_labels = [
                                            'trio' => get_phrase('Feature trio'),
                                            'functions' => get_phrase('Courses by function'),
                                            'categories' => get_phrase('Top categories'),
                                            'quiz' => get_phrase('Leadership quiz banner'),
                                            'why' => get_phrase('Why section'),
                                            'instructors' => get_phrase('Expert instructors'),
                                            'dual' => get_phrase('Promotional (learn/teach) section'),
                                            'cta_band' => get_phrase('CTA band'),
                                        ];
                                        foreach ($gp_section_bg_labels as $gp_bg_key => $gp_bg_label):
                                            $gp_bg_current = $extras['section_bg'][$gp_bg_key];
                                        ?>
                                        <div class="col-md-3 form-group">
                                            <label><?php echo $gp_bg_label; ?></label>
                                            <?php if ($gp_bg_current !== ''): ?>
                                                <div class="mb-1">
                                                    <img src="<?php echo base_url($gp_bg_current); ?>" alt="" style="width:100%; max-height:70px; object-fit:cover; border-radius:6px;">
                                                </div>
                                                <div class="form-check mb-1">
                                                    <input type="checkbox" class="form-check-input" id="gp_bg_clear_<?php echo $gp_bg_key; ?>" name="landing_section_bg_clear[<?php echo $gp_bg_key; ?>]" value="1">
                                                    <label class="form-check-label" for="gp_bg_clear_<?php echo $gp_bg_key; ?>"><?php echo get_phrase('Remove current image'); ?></label>
                                                </div>
                                            <?php endif; ?>
                                            <input type="file" class="form-control" name="landing_section_bg[<?php echo $gp_bg_key; ?>]" accept="image/*,.gif">
                                        </div>
                                        <?php endforeach; ?>
                                    </div>

                                    <div class="form-group pt-2 mt-0">
                                        <?php echo gp_ds_button('Save landing extras', [
                                            'variant' => 'primary',
                                            'type' => 'submit',
                                        ], true); ?>
                                    </div>
                                </form>
                        <?php
                        gp_ds_card([
                            'title' => get_phrase('Landing page extras'),
                            'body' => ob_get_clean(),
                            'extra_class' => 'gp-dash-panel',
                        ]);
                        ?>
                    </div>
                </div>
            </div>
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


<script>
    $(document).ready(function() {
        <?php if (isset($_GET['tab'])): ?>
            $('a[href="#<?php echo $_GET['tab'] ?>"]').trigger('click');
        <?php endif; ?>
    });
</script>
