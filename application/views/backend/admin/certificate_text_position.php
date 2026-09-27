<!DOCTYPE html>
<html>
<head>
	<title><?php echo get_phrase('certificates_text_position'); ?> | <?php echo get_settings('system_title'); ?></title>
	<link rel="shortcut icon" href="<?php echo base_url('uploads/system/').get_frontend_settings('favicon');?>">
	<link href="<?php echo base_url('assets/backend/css/fontawesome-all.min.css') ?>" rel="stylesheet" type="text/css" />
	<script src="<?php echo base_url('assets/backend/js/jquery-3.3.1.min.js'); ?>" charset="utf-8"></script>
	<script>
		// Small local drag-and-drop (mouse + touch), replacing the third-party demo script
		// this page used to load from jqueryscript.net. Same API: $(el).draggableTouch(),
		// plus "dragstart"/"dragend" events carrying {left, top}.
		(function ($) {
			$.fn.draggableTouch = function () {
				return this.each(function () {
					var el = this;
					$(el).on('mousedown touchstart', function (e) {
						var p = e.type === 'touchstart' ? e.originalEvent.touches[0] : e;
						var startX = p.pageX, startY = p.pageY, startLeft = el.offsetLeft, startTop = el.offsetTop;
						$(el).trigger('dragstart', [{left: startLeft, top: startTop}]);
						function move(ev) {
							var q = ev.type === 'touchmove' ? ev.originalEvent.touches[0] : ev;
							el.style.left = (startLeft + q.pageX - startX) + 'px';
							el.style.top = (startTop + q.pageY - startY) + 'px';
							ev.preventDefault();
						}
						function up() {
							$(document).off('mousemove touchmove', move).off('mouseup touchend', up);
							$(el).trigger('dragend', [{left: el.offsetLeft, top: el.offsetTop}]);
						}
						$(document).on('mousemove touchmove', move).on('mouseup touchend', up);
						e.preventDefault();
					});
				});
			};
		})(jQuery);
	</script>
	<style type="text/css">
		@import url('https://fonts.googleapis.com/css2?family=Italianno&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Pinyon+Script&display=swap%27');
        @import url('https://fonts.googleapis.com/css2?family=Miss+Fajardose&display=swap%27');
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap');
		.draggable{
			border: 2px dashed #8d8d8d;
		    padding: 0px 5px;
		    cursor: move;
		    background-color: #15b57e33;
		    top: 0;
		    max-width: 500px;
		}
		.submit-button{
			padding: 12px 15px;
			background-color: #2d32d5;
			border-radius: 5px;
			color: #fff;
			text-decoration: none;
			border: none;
			cursor: pointer;
		}
		.back-button{
			padding: 12px 15px;
			background-color: #848484;
			border-radius: 5px;
			color: #fff;
			text-decoration: none;
			border: none;
			cursor: pointer;
		}
		.hidden-position{
			background-color: #ffd3d3 !important;
		}
		.gp-selected{
			outline: 3px solid #2d32d5;
		}
		.gp-cert-toolbar{
			margin: 10px 20px;
			padding: 12px;
			border: 1px solid #ddd;
			border-radius: 6px;
			max-width: 320px;
			font-family: sans-serif;
			font-size: 14px;
		}
		.gp-cert-toolbar .row{
			display: flex;
			align-items: center;
			justify-content: space-between;
			gap: 8px;
			margin: 6px 0;
		}
		.gp-cert-toolbar button, .gp-cert-toolbar select{
			padding: 4px 10px;
			cursor: pointer;
		}
		.gp-tag-panel{
			margin: 10px 20px;
			padding: 12px;
			border: 1px solid #ddd;
			border-radius: 6px;
			max-width: 320px;
			font-family: sans-serif;
			font-size: 13px;
		}
		.gp-tag-panel .gp-tag{
			display: flex;
			align-items: center;
			justify-content: space-between;
			gap: 8px;
			padding: 4px 0;
			border-bottom: 1px solid #f0f0f0;
		}
		.gp-tag-panel code{
			background: #f3f3f3;
			padding: 1px 5px;
			border-radius: 3px;
		}
		.gp-tag-panel small{
			display: block;
			color: #777;
		}
		.gp-tag-panel button{
			padding: 3px 10px;
			cursor: pointer;
		}
		.gp-tag-panel .gp-custom{
			display: flex;
			gap: 6px;
			margin-top: 10px;
		}
		.gp-tag-panel .gp-custom input{
			flex: 1;
			padding: 4px 6px;
		}
		.gp-cert-toolbar[data-disabled="1"]{
			opacity: .5;
			pointer-events: none;
		}
	</style>
</head>
<body style="display: flex;">
	<div style="width: 750px; position: relative; text-align: center;">
		<div class="certificate-text-position">
			<?php
				// Version the template image so a newly uploaded template shows instead of the
				// browser's cached copy (the ?v= is stripped again on save, see Certificate::position).
				$gp_template_version = file_exists('uploads/certificates/template.jpg') ? filemtime('uploads/certificates/template.jpg') : time();
				echo str_replace('uploads/certificates/template.jpg"', 'uploads/certificates/template.jpg?v=' . $gp_template_version . '"', remove_js(htmlspecialchars_decode(get_settings('certificate-text-positons'))));
			?>
		</div>
		<button class="submit-button" onclick="save_position();"><?php echo get_phrase('update'); ?></button>
	</div>
	<div style="padding: 10px;">
		<div class="gp-cert-toolbar" data-disabled="1">
			<div><b><?php echo get_phrase('selected'); ?>:</b> <span class="gp-sel-name"><?php echo get_phrase('click_a_box_to_select_it'); ?></span></div>
			<div class="row"><span><?php echo get_phrase('font_size'); ?> <b class="gp-size-val"></b></span><span><button type="button" data-act="size" data-step="-2">&minus;</button> <button type="button" data-act="size" data-step="2">+</button></span></div>
			<div class="row"><span><?php echo get_phrase('width'); ?> <b class="gp-width-val"></b></span><span><button type="button" data-act="width" data-step="-20">&minus;</button> <button type="button" data-act="width" data-step="20">+</button> <button type="button" data-act="width-auto"><?php echo get_phrase('auto'); ?></button></span></div>
			<div class="row"><span><?php echo get_phrase('font'); ?></span>
				<select data-act="font">
					<option value=""><?php echo get_phrase('default'); ?></option>
					<option value="Montserrat, sans-serif">Montserrat</option>
					<option value="Arial, sans-serif">Arial</option>
					<option value="Georgia, serif">Georgia</option>
					<option value="&quot;Pinyon Script&quot;, cursive">Pinyon Script</option>
					<option value="&quot;Miss Fajardose&quot;, cursive">Miss Fajardose</option>
					<option value="Italianno, cursive">Italianno</option>
				</select>
			</div>
			<div class="row"><span><?php echo get_phrase('bold'); ?></span><button type="button" data-act="bold"><?php echo get_phrase('on_off'); ?></button></div>
			<div class="row gp-delete-row" style="display: none;"><span><?php echo get_phrase('added_box'); ?></span><button type="button" data-act="delete"><?php echo get_phrase('delete'); ?></button></div>
			<div class="row"><span><?php echo get_phrase('alignment'); ?></span><span><button type="button" data-act="align" data-val="left">L</button> <button type="button" data-act="align" data-val="center">C</button> <button type="button" data-act="align" data-val="right">R</button></span></div>
		</div>
		<?php
			// Tags the certificate page fills in (see views/certificate/index.php)
			$gp_tags = [
				'{student}'         => get_phrase('student_name'),
				'{course}'          => get_phrase('course_title'),
				'{date}'            => get_phrase('completion_date'),
				'{instructor}'      => get_phrase('instructor_name'),
				'{course_level}'    => get_phrase('course_level'),
				'{course_language}' => get_phrase('course_language'),
				'{total_duration}'  => get_phrase('total_duration'),
				'{total_lesson}'    => get_phrase('total_lessons'),
				'{certificate_id}'  => get_phrase('certificate_id'),
				'{score}'           => get_phrase('final_test_score'),
				'{student_email}'   => get_phrase('student_email'),
			];
		?>
		<div class="gp-tag-panel">
			<div><b><?php echo get_phrase('add_a_tag'); ?></b></div>
			<?php foreach ($gp_tags as $gp_tag => $gp_label): ?>
				<div class="gp-tag">
					<span><code><?php echo html_escape($gp_tag); ?></code><small><?php echo html_escape($gp_label); ?></small></span>
					<button type="button" data-add-tag="<?php echo html_escape($gp_tag); ?>"><?php echo get_phrase('add'); ?></button>
				</div>
			<?php endforeach; ?>
			<div style="margin-top: 10px;"><b><?php echo get_phrase('custom_text'); ?></b><small><?php echo get_phrase('your_own_words,_tags_can_be_mixed_in'); ?></small></div>
			<div class="gp-custom">
				<input type="text" maxlength="200" class="gp-custom-text" placeholder="e.g. Certificate ID: {certificate_id}">
				<button type="button" data-add-custom="1"><?php echo get_phrase('add'); ?></button>
			</div>
		</div>
		<h3 style="padding-left: 20px;"><?php echo get_phrase('attention'); ?> !</h3>
		<ul>
			<li><?php echo get_phrase('you_can_change_the_text_positions_by_drag_and_drop'); ?></li>
			<li><?php echo get_phrase('drag_out_of the_certificate_layout_to_keep_an_object_hidden'); ?></li>
			<li><?php echo get_phrase('after_changing_your_text_positions,_click_the_save_button_to_save_the_parts'); ?></li>
		</ul>
	</div>
	<script>
	    $(document).ready(function() {
	    	$('.certificate_text').html("<?php echo get_settings('certificate_template'); ?>");
	    	$('.hidden-position').show();

	    	// Separate course-title box (not in the add-on's default layout). Added once,
	    	// parked below the certificate (= hidden) until the admin drags it into place.
	    	if ($('.certificate-text-position .course_name').length === 0) {
	    		var $layout = $('.certificate-text-position .this-template');
	    		if ($layout.length === 0) { $layout = $('.certificate-text-position'); }
	    		$layout.append('<div class="draggable course_name hidden-position" style="position: absolute; font-size: 24px; top: 560px; left: 0px;">{course}</div>');
	    	}

	        $(".draggable").draggableTouch();

	        // Select a box to resize/restyle it with the toolbar
	        var $sel = null;
	        function refreshToolbar() {
	        	var $tb = $('.gp-cert-toolbar');
	        	if (!$sel) { $tb.attr('data-disabled', '1'); return; }
	        	$tb.attr('data-disabled', '0');
	        	var name = ($sel.attr('class').match(/\b(student_name|course_name|certificate_text|course_completion_date|instructor_name|course_level|course_language|duration_name|lesson_name|qrCode|custom_tag)\b/) || ['', 'box'])[1];
	        	$tb.find('.gp-delete-row').toggle($sel.hasClass('custom_tag'));
	        	$tb.find('.gp-sel-name').text(name.replace(/_/g, ' '));
	        	$tb.find('.gp-size-val').text(parseInt($sel.css('font-size'), 10) + 'px');
	        	$tb.find('.gp-width-val').text($sel[0].style.width ? parseInt($sel[0].style.width, 10) + 'px' : 'auto');
	        }
	        $(document).on('mousedown touchstart', '.draggable', function () {
	        	$('.draggable').removeClass('gp-selected');
	        	$sel = $(this).addClass('gp-selected');
	        	refreshToolbar();
	        });
	        $('.gp-cert-toolbar').on('click', 'button', function () {
	        	if (!$sel) return;
	        	var act = $(this).data('act'), el = $sel[0];
	        	if (act === 'size') {
	        		el.style.fontSize = Math.max(8, Math.min(120, parseInt($sel.css('font-size'), 10) + $(this).data('step'))) + 'px';
	        	} else if (act === 'width') {
	        		var w = el.style.width ? parseInt(el.style.width, 10) : $sel.outerWidth();
	        		el.style.width = Math.max(40, Math.min(750, w + $(this).data('step'))) + 'px';
	        		el.style.maxWidth = 'none';
	        	} else if (act === 'width-auto') {
	        		el.style.width = ''; el.style.maxWidth = '';
	        	} else if (act === 'bold') {
	        		el.style.fontWeight = (parseInt($sel.css('font-weight'), 10) >= 600) ? '400' : '700';
	        	} else if (act === 'delete') {
	        		$sel.remove(); $sel = null; refreshToolbar(); return;
	        	} else if (act === 'align') {
	        		el.style.textAlign = $(this).data('val');
	        	}
	        	refreshToolbar();
	        });
	        $('.gp-cert-toolbar select[data-act=font]').on('change', function () {
	        	if ($sel) { $sel[0].style.fontFamily = this.value; }
	        });

	        // Add a new box (a tag or custom text) near the top-left of the certificate,
	        // selected so it can be styled straight away. .text() keeps it plain text.
	        function addBox(content) {
	        	content = $.trim(content);
	        	if (!content) return;
	        	var $layout = $('.certificate-text-position .this-template');
	        	if ($layout.length === 0) { $layout = $('.certificate-text-position'); }
	        	var $box = $('<div class="draggable custom_tag"></div>').text(content)
	        		.attr('style', 'position: absolute; font-size: 20px; top: 40px; left: 40px;');
	        	$layout.append($box);
	        	$box.draggableTouch();
	        	$('.draggable').removeClass('gp-selected');
	        	$sel = $box.addClass('gp-selected');
	        	refreshToolbar();
	        }
	        $('.gp-tag-panel').on('click', '[data-add-tag]', function () {
	        	addBox($(this).attr('data-add-tag'));
	        });
	        $('.gp-tag-panel').on('click', '[data-add-custom]', function () {
	        	var $in = $('.gp-custom-text');
	        	addBox($in.val());
	        	$in.val('');
	        });
	        //$(".draggable").draggableTouch("disable");

	        $(".draggable").on("dragstart", function(e, pos) {
	            //console.log(pos.left + "," + pos.top);
	        }).on("dragend", function(e, pos) {
	            console.log("dragend:", this, pos.left + "," + pos.top);
	            if(pos.left <= 720 && pos.top <= 520){
	            	if($(this).hasClass('hidden-position')){
	            		$(this).removeClass('hidden-position');
	            	}
	            }else{
	            	if(!$(this).hasClass('hidden-position')){
	            		$(this).addClass('hidden-position');
	            	}
	            }
	        });
	    });

	    function save_position(){
	    	$('.draggable').removeClass('gp-selected');
	    	$('.hidden-position').hide();
	    	var btnText = $('.submit-button').html();
	    	$('.submit-button').html('<?php echo get_phrase('please_wait'); ?>...');
	    	var positionHtml = $('.certificate-text-position').html();
	    	$.ajax({
	    	 	type: 'post',
	    	 	url: "<?php echo site_url('addons/certificate/position/save'); ?>",
	    	 	data: {'text_positions' : positionHtml},
	    	 	success: function(result){
			    	$('.submit-button').html(btnText);
			    	$('.hidden-position').show();
			    	window.location.replace('<?php echo site_url('addons/certificate/settings'); ?>');
			  	}
			});
	    }
	</script>
</body>
</html>