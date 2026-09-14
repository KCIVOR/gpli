<?php gp_ds_page_title(get_phrase('manage_language')); ?>

<div class="gp-settings-page">
<div class="row">
	<div class="col-12">
		<?php
		ob_start();
		?>
				<ul class="nav nav-tabs nav-bordered mb-3">
					<?php if (isset($edit_profile)) : ?>
						<li class="nav-item">
							<a href="#edit" data-toggle="tab" aria-expanded="true" class="nav-link active">
								<?php echo get_phrase('edit_phrase'); ?>
							</a>
						</li>
					<?php endif; ?>
					<li class="nav-item">
						<a href="#list" data-toggle="tab" aria-expanded="false" class="nav-link <?php if (!isset($edit_profile)) echo 'active'; ?>">
							<i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
							<span class="d-none d-lg-block"><?php echo get_phrase('language_list'); ?></span>
						</a>
					</li>
					<li class="nav-item">
						<a href="#add_lang" data-toggle="tab" aria-expanded="false" class="nav-link">
							<i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
							<span class="d-none d-lg-block"><?php echo get_phrase('add_language'); ?></span>
						</a>
					</li>
					<li class="nav-item">
						<a href="#import_language" data-toggle="tab" aria-expanded="false" class="nav-link">
							<i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
							<span class="d-none d-lg-block"><?php echo get_phrase('Import language'); ?></span>
						</a>
					</li>
				</ul>

				<div class="tab-content">
					<!----PHRASE EDITING TAB STARTS-->
					<?php if (isset($edit_profile)) :
						$current_editing_language	=	$edit_profile;
					?>
						<div class="tab-pane show active" id="edit">
							<div class="row">
								<?php foreach (openJSONFile($edit_profile) as $key => $value) : ?>
									<div class="col-xl-3 col-lg-6">
										<?php
										ob_start();
										?>
												<p>
													<input type="text" class="form-control" name="updated_phrase" value="<?php echo $value; ?>" id="phrase-<?php echo slugify($key); ?>">
												</p>
												<button type="button" class="icon-btn gp-settings-phrase-save" id="btn-<?php echo slugify($key); ?>" onclick="updatePhrase('<?php echo slugify($key); ?>', '<?php echo $key; ?>')"> <i class="mdi mdi-check-circle"></i> </button>
										<?php
										gp_ds_card([
											'header' => $key,
											'body' => ob_get_clean(),
											'extra_class' => 'gp-settings-phrase-card',
										]);
										?>
									</div>
								<?php endforeach; ?>
							</div>
						</div>
					<?php endif; ?>
					<!----PHRASE EDITING TAB ENDS-->

					<!----TABLE LISTING STARTS-->
					<div class="tab-pane <?php if (!isset($edit_profile)) echo 'show active'; ?>" id="list">
						<?php
						ob_start();
						$language_dirs = get_settings('language_dirs') ? json_decode(get_settings('language_dirs'), true) : ['english' => 'ltr'];
						foreach ($languages as $language) :
							if(array_key_exists($language, $language_dirs)){
								$dir = $language_dirs[$language];
							}else{
								$dir = 'ltr';
							}
							?>
							<tr>
								<td><?php echo ucwords($language); ?></td>
								<td>
									<div class="form-group">
										<form action="#">
											<input onchange="update_language_dir('<?php echo $language; ?>', 'ltr')" name="direction" id="direction_ltr<?php echo $language; ?>" type="radio" value="ltr" <?php if($dir == 'ltr') echo 'checked'; ?>>
											<label for="direction_ltr<?php echo $language; ?>"><?php echo get_phrase('LTR') ?></label>
											&nbsp;&nbsp;
											<input onchange="update_language_dir('<?php echo $language; ?>', 'rtl')" name="direction" id="direction_rtl<?php echo $language; ?>" type="radio" value="rtl" <?php if($dir == 'rtl') echo 'checked'; ?>>
											<label for="direction_rtl<?php echo $language; ?>"><?php echo get_phrase('RTL') ?></label>
										</form>
									</div>
								</td>
								<td>
									<div class="gp-settings-lang-actions">
										<?php
										gp_ds_button(get_phrase('edit_phrase'), [
											'variant' => 'outline',
											'href' => site_url('admin/manage_language/edit_phrase/' . $language),
										]);
										gp_ds_button(get_phrase('export'), [
											'variant' => 'primary',
											'href' => site_url('admin/export_language/' . $language),
										]);
										gp_ds_button(get_phrase('delete_language'), [
											'variant' => 'quiet',
											'href' => 'javascript:;',
											'attrs' => [
												'onclick' => "confirm_modal('" . site_url('admin/manage_language/delete_language/' . $language) . "')",
											],
										]);
										?>
									</div>
								</td>
							</tr>
						<?php endforeach; ?>
						<?php
						echo gp_ds_table([
							'headers' => [
								get_phrase('language'),
								get_phrase('Direction'),
								get_phrase('option'),
							],
							'body_html' => ob_get_clean(),
							'allow_empty' => true,
							'extra_class' => 'mb-0',
						], true);
						?>
					</div>
					<!----TABLE LISTING ENDS--->

					<!----PHRASE CREATION FORM STARTS---->
					<div class="tab-pane" id="add">
						<div class="row">
							<div class="col-xl-6">
								<form class="" action="<?php echo site_url('admin/manage_language/add_phrase') ?>" method="post">
									<div class="form-group mb-3">
										<label for="simpleinput"><?php echo get_phrase('add_new_phrase'); ?></label>
										<input type="text" id="phrase" name="phrase" class="form-control" placeholder="Eg. Contamination">
									</div>
									<?php echo gp_ds_button(get_phrase('save'), ['variant' => 'primary', 'type' => 'submit', 'attrs' => ['name' => 'button']], true); ?>
								</form>
							</div>
						</div>
					</div>
					<!----PHRASE CREATION FORM ENDS--->

					<!----ADD NEW LANGUAGE---->
					<div class="tab-pane" id="add_lang">
						<div class="row">
							<div class="col-xl-6">
								<form class="" action="<?php echo site_url('admin/manage_language/add_language'); ?>" method="post">
									<div class="form-group mb-3">
										<label for="language"><?php echo get_phrase('add_new_language'); ?></label>
										<input type="text" id="language" name="language" class="form-control" placeholder="<?php echo get_phrase('no_special_character_or_space_is_allowed') . '. ' . get_phrase('valid_examples') . ' : French, Spanish, Bengali etc'; ?>">
									</div>
									<?php echo gp_ds_button(get_phrase('save'), ['variant' => 'primary', 'type' => 'submit', 'attrs' => ['name' => 'button']], true); ?>
								</form>
							</div>
						</div>
					</div>
					<!----LANGUAGE ADDING FORM ENDS-->

					<!----ADD NEW LANGUAGE---->
					<div class="tab-pane" id="import_language">
						<div class="row">
							<div class="col-xl-6">
								<p>Import your language files from here.</p>
								<form action="<?php echo site_url('admin/language_import'); ?>" method="post" enctype="multipart/form-data">
									<div class="input-group mb-3">
										<div class="input-group">
											<div class="custom-file">
												<input type="file" class="custom-file-input" name="language_files[]" id="language_files" onchange="changeTitleOfImageUploader(this)" accept=".json" multiple required>
												<label class="custom-file-label ellipsis" for="language_files"><?php echo get_phrase('choose_your_json_file'); ?></label>
											</div>
										</div>
										<span class="gp-settings-import-hint"><?php echo gp_ds_badge('Ex: english.json', 'neutral', true); ?></span>
									</div>

									<div class="form-group">
										<?php echo gp_ds_button(get_phrase('import'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
									</div>
								</form>
							</div>
						</div>
					</div>
					<!----LANGUAGE ADDING FORM ENDS-->
				</div>
		<?php
		gp_ds_card([
			'body' => ob_get_clean(),
			'extra_class' => 'gp-dash-panel',
		]);
		?>
	</div>
</div>
</div>

<script type="text/javascript">
	function updatePhrase(key, key_main) {
		$('#btn-' + key).text('...');
		var updatedValue = $('#phrase-' + key).val();
		var currentEditingLanguage = '<?php echo isset($current_editing_language) ? $current_editing_language:''; ?>';
		$.ajax({
			type: "POST",
			url: "<?php echo site_url('admin/update_phrase_with_ajax'); ?>",
			data: {
				updatedValue: updatedValue,
				currentEditingLanguage: currentEditingLanguage,
				key: key_main
			},
			success: function(response) {
				$('#btn-' + key).html('<i class = "mdi mdi-check-circle"></i>');
				success_notify('<?php echo get_phrase('phrase_updated'); ?>');
			}
		});
	}

	function update_language_dir(language, dir){
		$.ajax({
			type: 'post',
			url: '<?php echo site_url('admin/update_language_direction'); ?>',
			data: {'language':language, 'dir':dir},
			success: function(response){
				success_notify(response);
			}
		});
	}
</script>
