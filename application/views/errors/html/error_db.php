<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?><!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Database Error</title>
<style type="text/css">

::selection { background-color: #E13300; color: white; }
::-moz-selection { background-color: #E13300; color: white; }

body {
	background-color: #F8FAFC;
	margin: 40px;
	font: 13px/20px normal Helvetica, Arial, sans-serif;
	color: #1F2937;
}

a {
	color: #2563EB;
	background-color: transparent;
	font-weight: normal;
}

h1 {
	color: #1B2A4A;
	background-color: transparent;
	border-bottom: 1px solid #E5E7EB;
	font-size: 19px;
	font-weight: normal;
	margin: 0 0 14px 0;
	padding: 14px 15px 10px 15px;
}

code {
	font-family: Consolas, Monaco, Courier New, Courier, monospace;
	font-size: 12px;
	background-color: #F8FAFC;
	border: 1px solid #E5E7EB;
	color: #1F2937;
	display: block;
	margin: 14px 0 14px 0;
	padding: 12px 10px 12px 10px;
}

#container {
	margin: 10px;
	border: 1px solid #E5E7EB;
	box-shadow: 0 0 8px #E5E7EB;
}

p {
	margin: 12px 15px 12px 15px;
}
</style>
</head>
<body>
	<div id="container">
		<h1><?php echo $heading; ?></h1>
		<?php echo $message; ?>
	</div>
</body>
</html>
