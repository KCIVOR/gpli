<?php
	$scorm_course_content_url = "";
	if(file_exists("uploads/scorm/courses/".$scorm_curriculum['identifier'].'/scormdriver/indexAPI.html')):
		// The package's own imsmanifest.xml declares this as its real launch resource for a
		// reason: it's the file that actually performs the LMS handshake (LMSInitialize, score/
		// status reporting, resume) before showing the content — going straight to scormcontent/
		// index.html below skips that connection entirely, so prefer this whenever it exists.
		$scorm_course_content_url = "uploads/scorm/courses/".$scorm_curriculum['identifier'].'/scormdriver/indexAPI.html';
	elseif(file_exists("uploads/scorm/courses/".$scorm_curriculum['identifier'].'/scormcontent/index.html')):
		// No driver wrapper in this package — fall back to the raw content directly (no SCORM
		// API connection is possible in this case; score/resume simply won't be reported).
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
<?php
	$gp_scorm_saved_progress = [];
	if (addon_status('scorm_course') && $this->session->userdata('user_login')) {
		$this->load->model('addons/Scorm_model', 'scorm_model');
		$gp_scorm_saved_progress = $this->scorm_model->get_scorm_progress($course_details['id'], $this->session->userdata('user_id')) ?: [];
	}
	$gp_scorm_json_flags = JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP;
?>
<script type="text/javascript">
	'use strict';
	// SCORM 1.2 runtime API — the package's own driver looks for `window.API` on this
	// (its parent) window and calls these methods directly; without this, any quiz/score
	// (and, for resume, the package's own bookmark/suspend_data) has nowhere to report
	// to or read back from, so progress is silently dropped and every visit restarts.
	(function () {
		// Seeded with whatever was saved last time, so LMSGetValue can answer the
		// package's own "where was I?" questions on init instead of always saying
		// "nowhere, start over".
		var gpScormData = {
			// Tells the package whether this is a first-time attempt or a returning
			// student — without this, the driver won't even look at the saved
			// bookmark/suspend_data below, regardless of whether it's populated.
			'cmi.core.entry': <?php echo json_encode(empty($gp_scorm_saved_progress) ? 'ab-initio' : 'resume', $gp_scorm_json_flags); ?>,
			'cmi.core.lesson_status': <?php echo json_encode($gp_scorm_saved_progress['lesson_status'] ?? '', $gp_scorm_json_flags); ?>,
			'cmi.core.score.raw': <?php echo json_encode(isset($gp_scorm_saved_progress['score_raw']) ? (string) $gp_scorm_saved_progress['score_raw'] : '', $gp_scorm_json_flags); ?>,
			'cmi.core.lesson_location': <?php echo json_encode($gp_scorm_saved_progress['lesson_location'] ?? '', $gp_scorm_json_flags); ?>,
			'cmi.suspend_data': <?php echo json_encode($gp_scorm_saved_progress['suspend_data'] ?? '', $gp_scorm_json_flags); ?>
		};
		var gpScormCourseId = <?php echo (int) $course_details['id']; ?>;
		var gpScormLessonId = <?php echo (int) $lesson_details['id']; ?>;
		var gpScormCommitUrl = '<?php echo site_url('home/save_scorm_progress'); ?>';
		var gpScormCommitted = false;
		var gpScormCommitTimer = null;

		function gpScormDoCommit() {
			var status = gpScormData['cmi.core.lesson_status'] || '';
			var score = gpScormData['cmi.core.score.raw'] || '';
			var location = gpScormData['cmi.core.lesson_location'] || '';
			var suspendData = gpScormData['cmi.suspend_data'] || '';
			if (status === '' && score === '' && location === '' && suspendData === '') return;

			var params = new URLSearchParams({
				course_id: gpScormCourseId,
				lesson_id: gpScormLessonId,
				lesson_status: status,
				score_raw: score,
				lesson_location: location,
				suspend_data: suspendData
			});

			// sendBeacon survives the page actually closing, unlike a normal AJAX call
			// which the browser can cancel mid-flight once the tab is gone — matters
			// most for the beforeunload/LMSFinish flush, but safe to use everywhere.
			if (navigator.sendBeacon) {
				var blob = new Blob([params.toString()], { type: 'application/x-www-form-urlencoded' });
				navigator.sendBeacon(gpScormCommitUrl, blob);
			} else if (window.jQuery) {
				jQuery.post(gpScormCommitUrl, {
					course_id: gpScormCourseId,
					lesson_id: gpScormLessonId,
					lesson_status: status,
					score_raw: score,
					lesson_location: location,
					suspend_data: suspendData
				});
			}
		}

		// Resume data (bookmark/suspend_data) can be set very frequently during normal
		// navigation — debounce so we save "where they are" without firing an AJAX call
		// on every single slide transition. The final LMSFinish/beforeunload calls flush
		// immediately (see below) so nothing is lost if the tab closes mid-debounce.
		function gpScormCommit(immediate) {
			if (immediate) {
				clearTimeout(gpScormCommitTimer);
				gpScormDoCommit();
				return 'true';
			}
			if (gpScormCommitted) return 'true';
			gpScormCommitted = true;
			clearTimeout(gpScormCommitTimer);
			gpScormCommitTimer = setTimeout(function () {
				gpScormCommitted = false;
				gpScormDoCommit();
			}, 1500);
			return 'true';
		}

		window.API = {
			LMSInitialize: function () { return 'true'; },
			LMSFinish: function () { return gpScormCommit(true); },
			LMSGetValue: function (key) { return gpScormData[key] !== undefined ? gpScormData[key] : ''; },
			LMSSetValue: function (key, value) {
				gpScormData[key] = value;
				return 'true';
			},
			LMSCommit: function () { return gpScormCommit(); },
			LMSGetLastError: function () { return '0'; },
			LMSGetErrorString: function () { return ''; },
			LMSGetDiagnostic: function () { return ''; }
		};

		window.addEventListener('beforeunload', function () { gpScormCommit(true); });
	})();
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