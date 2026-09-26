<script type="text/javascript">
	'use strict';

	// Files are sent in 50MB pieces so no single request exceeds
	// Cloudflare's 100MB upload limit; the server joins them back together.
	var SCORM_CHUNK_SIZE = 50 * 1024 * 1024;

	function upload_scorm_curriculum(btn){
		var btn_text = $(btn).text();
		var spinner = '<span class="spinner-border spinner-border-sm mr-1" role="status" aria-hidden="true"></span><?= get_phrase('uploading'); ?>';
		//loading start
		$(btn).html(spinner + '...');
		$(btn).prop("disabled",true);

		var scorm_provider = "";
		if (document.getElementById('ispring').checked) {
			scorm_provider = document.getElementById('ispring').value;
		}else if(document.getElementById('articulate').checked){
			scorm_provider = document.getElementById('articulate').value;
		}else if(document.getElementById('adobe_captivate').checked){
			scorm_provider = document.getElementById('adobe_captivate').value;
		}

		function fail(message){
			$.NotificationApp.send("<?php echo get_phrase('oh_snap'); ?>!", message ,"top-right","rgba(0,0,0,0.2)","error");
			$(btn).html(btn_text);
			$(btn).prop("disabled",false);
		}

		var scorm_zip = $('#scorm_zip').prop('files')[0];
		if (!scorm_provider) { fail("<?= get_phrase('please_select_a_course_provider'); ?>"); return; }
		if (!scorm_zip) { fail("<?= get_phrase('please_choose_a_scorm_zip_file'); ?>"); return; }

		var upload_id = '';
		for (var i = 0; i < 32; i++) { upload_id += Math.floor(Math.random() * 16).toString(16); }
		var total_chunks = Math.max(1, Math.ceil(scorm_zip.size / SCORM_CHUNK_SIZE));

		function send_chunk(index){
			var form_data = new FormData();
			form_data.append('chunk', scorm_zip.slice(index * SCORM_CHUNK_SIZE, (index + 1) * SCORM_CHUNK_SIZE), 'chunk');
			form_data.append('upload_id', upload_id);
			form_data.append('chunk_index', index);
			form_data.append('total_chunks', total_chunks);
			form_data.append('scorm_provider', scorm_provider);
			$.ajax({
				url: '<?= site_url('addons/scorm/upload_chunk/'.$course_details['id']); ?>',
				dataType: 'text',
				cache: false,
				contentType: false,
				processData: false,
				data: form_data,
				type: 'post',
				success: function(response){
					if (response == 'chunk_ok') {
						$(btn).html(spinner + ' ' + Math.round((index + 1) / total_chunks * 100) + '%');
						send_chunk(index + 1);
					} else if (response == 'success') {
						location.reload();
					} else {
						fail(response);
					}
				},
				error: function(xhr){
					fail("<?= get_phrase('upload_failed'); ?> (" + xhr.status + "). <?= get_phrase('please_try_again'); ?>");
				}
			});
		}
		send_chunk(0);
	}
</script>
