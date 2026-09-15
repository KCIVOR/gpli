<!DOCTYPE html>
<html>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title><?php echo get_settings('system_name'); ?></title>

	<?php include 'includes_top.php'; ?>
</head>

<body class="gp-ds">
<script src="<?php echo base_url('assets/design-system/gp-theme-boot.js'); ?>?v=no-system-1"></script>
	<div class="container-fluid">
		<div class="gp-theme-row py-2">
			<button type="button" id="gp-theme-light" class="gp-theme-btn">Light</button>
			<button type="button" id="gp-theme-dark" class="gp-theme-btn">Dark</button>
		</div>
		<!-- HEADER -->
		<?php include $page_name . '.php'; ?>
	</div>
	<!-- all the js files -->
	<?php include 'includes_bottom.php'; ?>
	<?php include 'payment_model.php'; ?>
</body>

</html>
