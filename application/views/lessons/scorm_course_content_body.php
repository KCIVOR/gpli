<?php
	$scorm_course_content_url = "";
	if(file_exists("uploads/scorm/courses/".$scorm_curriculum['identifier'].'/scormcontent/index.html')):
		// Articulate Rise (and other tools that nest content under scormcontent/) export their real
		// entry point here instead of at the package root, so check for it before the per-provider guesses.
		$scorm_course_content_url = "uploads/scorm/courses/".$scorm_curriculum['identifier'].'/scormcontent/index.html';
	elseif($scorm_curriculum['scorm_provider'] == 'ispring'):
		if(file_exists("uploads/scorm/courses/".$scorm_curriculum['identifier'].'/index_scorm.html')){
			
			$scorm_course_content_url = "uploads/scorm/courses/".$scorm_curriculum['identifier'].'/index_scorm.html';
		 }else{
			 $scorm_course_content_url = "uploads/scorm/courses/".$scorm_curriculum['identifier'].'/story.html';
		 }
	elseif($scorm_curriculum['scorm_provider'] == 'articulate'):
		if(file_exists("uploads/scorm/courses/".$scorm_curriculum['identifier'].'/story.html')){
			$scorm_course_content_url = "uploads/scorm/courses/".$scorm_curriculum['identifier'].'/story.html';
		  }else{
			 $scorm_course_content_url = "uploads/scorm/courses/".$scorm_curriculum['identifier'].'/index.html';
		  }
		
	elseif($scorm_curriculum['scorm_provider'] == 'adobe_captivate'):
		if(file_exists("uploads/scorm/courses/".$scorm_curriculum['identifier'].'/index_scorm.html')){
			$scorm_course_content_url = "uploads/scorm/courses/".$scorm_curriculum['identifier'].'/index_scorm.html';
		}else{
			$scorm_course_content_url = "uploads/scorm/courses/".$scorm_curriculum['identifier'].'/index.html';
		}
		
	endif;
?>
<?php if(addon_status('scorm_course')): ?>
	<div class="col-lg-12 p-0 border-0">
		<div class="gp-scorm-frame-wrap">
		<iframe class="mt-5" sandbox="allow-scripts allow-forms allow-pointer-lock allow-same-origin" id="scorm_iframe" frameBorder="0" src="<?= base_url($scorm_course_content_url); ?>" width="100%" title="Scorm course"></iframe>
		</div>
	</div>
<?php else: ?>
	<div class="col-lg-12">
		<div class="alert alert-warning p-5 mt-5" role="alert">
	        <h4 class="alert-heading"><?= site_phrase('heads_up'); ?>!</h4>
	        <p><?= site_phrase('currently_the_scorm_course_addon_is_deactivate'); ?>. <?= site_phrase('please_activate_the_scorm_course_addon_to_use_it'); ?>.</p>
	    </div>
	</div>
<?php endif ?>
<script type="text/javascript">
	'use strict';
	//For Scorm course body
	$(document).ready(function(){
	  var width = $('#scorm_iframe').width();
	  $('#scorm_iframe').attr("height", width/2);
	  window.onresize = function(event) {
	    var width = $('#scorm_iframe').width();
	    $('#scorm_iframe').attr("height", width/2);
	  };

	  // Force-theme the SCORM package's own (same-origin) content when dark
	  // mode is active — the package's HTML/CSS is authored by the uploader
	  // and has no dark-mode awareness of its own. Uses the classic
	  // "smart invert": invert everything, then invert media back so photos
	  // and video don't render as negatives. No-ops (via try/catch) if the
	  // package ever isn't same-origin.
	  var scormIframe = document.getElementById('scorm_iframe');
	  function gp_apply_scorm_theme(){
	    if (!scormIframe) return;
	    var isDark = document.documentElement.getAttribute('data-theme') === 'dark';
	    try {
	      var doc = scormIframe.contentDocument;
	      if (!doc || !doc.head) return;
	      var style = doc.getElementById('gp-scorm-dark-override');
	      if (isDark) {
	        if (!style) {
	          style = doc.createElement('style');
	          style.id = 'gp-scorm-dark-override';
	          doc.head.appendChild(style);
	        }
	        style.textContent = 'html{filter:invert(1) hue-rotate(180deg);background:#fff;}img,video,picture,canvas,svg,iframe{filter:invert(1) hue-rotate(180deg);}';
	      } else if (style) {
	        style.parentNode.removeChild(style);
	      }
	    } catch (e) {
	      // Cross-origin or not-yet-loaded — leave the package's own theme as authored.
	    }
	  }
	  if (scormIframe) {
	    scormIframe.addEventListener('load', gp_apply_scorm_theme);
	    gp_apply_scorm_theme();
	    new MutationObserver(gp_apply_scorm_theme).observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme'] });
	  }
	});
	//End for Scorm course body
</script>