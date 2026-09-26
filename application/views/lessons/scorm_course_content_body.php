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
		<!-- Shown by gpScormShowResult() the moment the package's pass is saved, so the
		     student doesn't have to reload the page to see their progress/certificate. -->
		<div class="alert alert-success mt-4 mb-0 d-none" id="gp-scorm-passed-alert" role="alert">
			<h4 class="alert-heading"><?= get_phrase('congratulations'); ?>!</h4>
			<p class="mb-2"><?= get_phrase('you_have_passed_this_course'); ?>.</p>
			<a class="btn bg-success text-white px-4 d-none" id="gp-scorm-certificate-btn" target="_blank" href="#"><?= get_phrase('Get Certificate'); ?></a>
		</div>
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
	$gp_scorm_certificate_url = '#';
	if (addon_status('certificate') && $this->session->userdata('user_login')) {
		// Loaded here, after the view started, so it must be reached through the CI instance.
		$gp_CI = &get_instance();
		$gp_CI->load->model('addons/Certificate_model', 'certificate_model');
		$gp_scorm_certificate_url = $gp_CI->certificate_model->get_certificate_url($this->session->userdata('user_id'), $course_details['id']);
	}
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
		var gpScormCommitUrl = '<?php echo site_url('home/save_scorm_progress'); ?>';
		var gpScormCommitted = false;
		var gpScormCommitTimer = null;
		var gpScormCertificateTabUrl = '<?php echo site_url('addons/certificate/certificate_progress/' . $course_details['id']); ?>';
		// What the page showed on load — the banner/tab refresh only fire when this changes,
		// so a student revisiting an already-passed course isn't greeted again.
		var gpScormLastProgress = <?php echo (int) ($watch_history['course_progress'] ?? 0); ?>;
		var gpScormLastCertificateUrl = <?php echo json_encode($gp_scorm_certificate_url, $gp_scorm_json_flags); ?>;

		function gpScormIsFinished() {
			var status = (gpScormData['cmi.core.lesson_status'] || '').toLowerCase();
			return status === 'passed' || status === 'completed';
		}

		// Called with the server's reply to a save — updates the page in place so the
		// student sees their new progress and certificate without reloading.
		function gpScormShowResult(result) {
			if (!result || !window.jQuery) return;
			var $ = window.jQuery;
			if (result.course_progress !== null && result.course_progress !== undefined) {
				var $progress = $('.gp-lesson-progress');
				var label = result.course_progress + '% <?php echo get_phrase('Completed'); ?>';
				if ($progress.length) {
					$progress.text(label);
				} else {
					$('.gp-lesson-title-link').append($('<span class="gp-lesson-progress"></span>').text(label));
				}
			}
			var progressChanged = result.course_progress != gpScormLastProgress;
			var certificateChanged = result.certificate_url && result.certificate_url !== gpScormLastCertificateUrl;
			gpScormLastProgress = result.course_progress;
			if (certificateChanged) gpScormLastCertificateUrl = result.certificate_url;

			if (result.course_progress >= 100 && (progressChanged || certificateChanged)) {
				$('#gp-scorm-passed-alert').removeClass('d-none');
			}
			if (result.certificate_url && result.certificate_url !== '#') {
				$('#gp-scorm-certificate-btn').attr('href', result.certificate_url).removeClass('d-none');
			}
			// Refresh the Certificate tab's content so it isn't stale if it was opened earlier.
			if ((progressChanged || certificateChanged) && $('#certificate-content').length && typeof actionTo === 'function') {
				actionTo(gpScormCertificateTabUrl);
			}
		}

		function gpScormDoCommit(unloading) {
			var status = gpScormData['cmi.core.lesson_status'] || '';
			var score = gpScormData['cmi.core.score.raw'] || '';
			var location = gpScormData['cmi.core.lesson_location'] || '';
			var suspendData = gpScormData['cmi.suspend_data'] || '';
			if (status === '' && score === '' && location === '' && suspendData === '') return;

			var params = new URLSearchParams({
				course_id: gpScormCourseId,
				lesson_status: status,
				score_raw: score,
				lesson_location: location,
				suspend_data: suspendData
			});

			// Once the package reports a pass, use a normal AJAX call so we can read the
			// server's reply and update the page right away (see gpScormShowResult).
			if (!unloading && gpScormIsFinished() && window.jQuery) {
				jQuery.post(gpScormCommitUrl, {
					course_id: gpScormCourseId,
					lesson_status: status,
					score_raw: score,
					lesson_location: location,
					suspend_data: suspendData
				}, gpScormShowResult, 'json');
				return;
			}

			// sendBeacon survives the page actually closing, unlike a normal AJAX call
			// which the browser can cancel mid-flight once the tab is gone — matters
			// most for the beforeunload flush, but safe to use everywhere.
			if (navigator.sendBeacon) {
				var blob = new Blob([params.toString()], { type: 'application/x-www-form-urlencoded' });
				navigator.sendBeacon(gpScormCommitUrl, blob);
			} else if (window.jQuery) {
				jQuery.post(gpScormCommitUrl, {
					course_id: gpScormCourseId,
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
		// A pass is saved after a short 300ms wait instead of 1500ms — just long enough for
		// the package's separate pass/score calls to land in the same save.
		function gpScormCommit(immediate, unloading) {
			if (immediate) {
				clearTimeout(gpScormCommitTimer);
				gpScormCommitted = false;
				gpScormDoCommit(unloading);
				return 'true';
			}
			// A pass arriving while a normal 1500ms save is waiting cuts the wait short.
			if (gpScormCommitted && !gpScormIsFinished()) return 'true';
			gpScormCommitted = true;
			clearTimeout(gpScormCommitTimer);
			gpScormCommitTimer = setTimeout(function () {
				gpScormCommitted = false;
				gpScormDoCommit();
			}, gpScormIsFinished() ? 300 : 1500);
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

		window.addEventListener('beforeunload', function () { gpScormCommit(true, true); });
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