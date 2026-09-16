<!-- Bootstrap CSS -->
<?php if($language_dir == 'rtl'): ?>
    <link href="<?php echo site_url('assets/playing-page/') ?>css/bootstrap.rtl.min.css" rel="stylesheet" />
<?php else: ?>
    <link href="<?php echo site_url('assets/playing-page/') ?>css/bootstrap.min.css" rel="stylesheet" />
<?php endif; ?>

<!-- Animation CSS -->
<link rel="stylesheet" href="<?php echo site_url('assets/playing-page/') ?>css/animate.min.css" />
<!-- Main CSS -->
<link href="<?php echo site_url('assets/playing-page/') ?>css/style.css" rel="stylesheet" />

<?php if(addon_status('certificate')): ?>
	<!-- Progress Bar Css -->
	<link rel="stylesheet" href="<?php echo site_url('assets/playing-page/') ?>css/jQuery-plugin-progressbar.css" />
	<!-- Custome Css -->
	<link href="<?php echo site_url('assets/playing-page/') ?>css/custom.css" rel="stylesheet" />
<?php endif; ?>

<!-- font awesome 5 -->
<link rel="stylesheet" href="<?php echo base_url().'assets/frontend/default-new/css/fontawesome-all.min.css'; ?>">
<link rel="stylesheet" href="<?php echo base_url().'assets/global/toastr/toastr.css' ?>">

<?php if($language_dir == 'rtl'): ?>
    <link href="<?php echo site_url('assets/playing-page/') ?>css/rtl.css" rel="stylesheet" />
<?php endif; ?>

<link rel="stylesheet" href="<?php echo base_url() . 'assets/frontend/default-new/summernote-0.8.20-dist/summernote-lite.min.css'; ?>">

<script src="<?php echo base_url('assets/design-system/gp-theme-boot.js'); ?>?v=no-system-1"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-tokens.css') . '?v=color-bridge-1'; ?>">
<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-base.css'); ?>">
<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-components-core.css'); ?>">
<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-shell.css'); ?>?v=lesson-topbar-2">
<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-dark-surfaces.css'); ?>">
<script src="<?php echo base_url('assets/design-system/gp-theme-toggle.js'); ?>?v=no-system-1" defer></script>

<script src="<?php echo base_url('assets/backend/js/jquery-3.3.1.min.js'); ?>"></script>
