<?php
if (isset($user_details) && is_object($user_details) && method_exists($user_details, 'row_array')) {
    $user_details = $user_details->row_array();
}
?>

<?php include "breadcrumb.php"; ?>

<section class="wish-list-body message">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-4">
                <?php include "profile_menus.php"; ?>
            </div>
            <div class="col-lg-9 col-md-8">
                <div class="profile">
                    <div class="profile-ful-body common-card">
                        <div class="profile-parrent mt-5">
                            <div class="profile-child">
                               <a href="#"><img loading="lazy" src="<?php echo $this->user_model->get_user_image_url($user_details['id']); ?>"></a>
                                <div class="child-text">
                                    <a href="#"><h5><?php echo get_phrase('Profile Photo') ?></h5></a>
                                    <p><?php echo get_phrase('Update your profile photo and personal details'); ?></p>
                                </div>
                            </div>

                            <div class="profile-child-btn">
                                <form action="<?php echo site_url('home/update_profile/update_photo') ?>" method="post" enctype="multipart/form-data" class="d-flex align-items-center">
                                    <input type="file" id="profile-photo-input" name="user_image" onchange="
                                        $('.photo-upload-btn').toggleClass('d-hidden');
                                        $('[for=profile-photo-input]').toggleClass('d-hidden');
                                    " class="d-none">
                                    <label for="profile-photo-input" class="btn btn-light float-end" type="button" style="background-color: var(--bs-gray-200);"><i class="fas fa-upload"></i> <?php echo get_phrase('Upload photo') ?></label>
                                    <div class="photo-upload-btn d-hidden">
                                        <button type="submit" class="purchase-btn ms-1 float-end"><?php echo get_phrase('Save') ?></button>
                                        <button type="reset" onclick="
                                            $('.photo-upload-btn').toggleClass('d-hidden');
                                            $('[for=profile-photo-input]').toggleClass('d-hidden');
                                        " class="purchase-btn float-end"><?php echo get_phrase('Cancel') ?></button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
