<?php
	$scorm_course_content_url = "";
	$user_id = $this->session->userdata('user_id');

	if($this->session->userdata('admin_login') == 1 || $this->crud_model->get_course_by_id($param2)->row('user_id') == $user_id){
         $scorm_curriculum = $this->db->get_where('scorm_curriculum', array('course_id' => $param2))->row_array();
    }else{
		$scorm_curriculum['scorm_provider'] = null;
	}

	if($scorm_curriculum['scorm_provider'] == 'ispring'):
		
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
<div class="gp-scorm-frame-wrap">
<iframe sandbox="allow-scripts allow-forms allow-pointer-lock allow-same-origin" id="scorm_iframe" frameBorder="0" src="<?= base_url($scorm_course_content_url); ?>" width="100%" title="Scorm course"></iframe>
</div>
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