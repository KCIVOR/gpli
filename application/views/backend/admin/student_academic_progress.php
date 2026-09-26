<?php ob_start(); ?>
<div class="gp-courses-progress">
  <div class="d-flex justify-content-end mb-3">
    <?php echo gp_ds_button(get_phrase('Export CSV'), [
      'variant' => 'outline',
      'href' => site_url('admin/learner_progress') . '?' . http_build_query(['course_id' => (int) $course_details['id'], 'export' => 'csv']),
    ], true); ?>
  </div>
  <div class="table-responsive">
    <table class="studentAcademicProgress table table-striped table-centered mb-4">
      <thead>
        <tr>
          <th><?php echo get_phrase('Student'); ?></th>
          <th><?php echo get_phrase('Date') ?></th>
          <th><?php echo get_phrase('Progress'); ?></th>
          <th class="text-center"><?php echo get_phrase('Actions'); ?></th>
        </tr>
      </thead>
      <?php $enrolments = $this->db->where('course_id', $course_details['id'])->get('enrol')->result_array(); ?>
      <?php $lessons = $this->crud_model->get_lessons('course', $course_details['id']); ?>
      <?php $total_lesson = $lessons->num_rows(); ?>
      <?php $is_scorm = ($course_details['course_type'] == 'scorm'); ?>
      <?php
        $status_labels = [
          'not_started' => ['label' => get_phrase('Not started'), 'tone' => 'neutral'],
          'in_progress' => ['label' => get_phrase('In progress'), 'tone' => 'primary'],
          'completed' => ['label' => get_phrase('Completed'), 'tone' => 'success'],
          'expired' => ['label' => get_phrase('Expired'), 'tone' => 'danger'],
        ];
      ?>
      <tbody>
        <?php
        foreach($enrolments as $enrolment):
          $student = $this->user_model->get_all_user($enrolment['user_id'])->row_array();
          // Same status rule as the student's My Courses and the learner progress report
          $status = course_status($course_details['id'], $enrolment['user_id'], $enrolment['expiry_date']);
          $status_badge = isset($status_labels[$status['status']]) ? $status_labels[$status['status']] : $status_labels['not_started'];

          $watch_history = $this->db->where('course_id', $course_details['id'])->where('student_id', $enrolment['user_id'])->get('watch_histories')->row_array();
          $completed_lesson_arr = isset($watch_history['completed_lesson']) ? json_decode($watch_history['completed_lesson'], true) : [];
          $completed_lesson = is_array($completed_lesson_arr) ? $completed_lesson_arr:[];

          $last_seen = !empty($watch_history['date_updated']) ? (int) $watch_history['date_updated'] : 0;
          $last_seen_day_only = false;
          $test_score = null;
          if ($is_scorm) {
            $tracking = $this->db->get_where('scorm_tracking', ['course_id' => $course_details['id'], 'student_id' => $enrolment['user_id']])->row_array();
            if (!empty($tracking)) {
              if ($tracking['score_raw'] !== null && $tracking['score_raw'] !== '') {
                $test_score = (int) $tracking['score_raw'];
              }
              // SCORM tracking only stores the day
              if (!empty($tracking['date_updated']) && (int) $tracking['date_updated'] > $last_seen) {
                $last_seen = (int) $tracking['date_updated'];
                $last_seen_day_only = true; // SCORM saves the day only, no time
              }
            }
          }

          $date_updated = $last_seen > 0 ? date(!empty($last_seen_day_only) ? 'd M Y' : 'd M Y, H:i a', $last_seen) : get_phrase('Not started yet');
          $completed_date = $status['completed_date'] ? date('d M Y', $status['completed_date']) : get_phrase('Not completed yet');
          ?>
          <tr>
            <td>
              <p class="my-0 gp-courses-progress-name"><?php echo html_escape($student['first_name'].' '.$student['last_name']); ?></p>
              <?php echo gp_ds_badge($student['email'], 'neutral', true); ?>
            </td>
            <td>
              <p class="my-0"><b><?php echo get_phrase('Enrolled from'); ?>-</b> <?php echo date('d M Y', $enrolment['date_added']); ?></p>

              <p class="my-0"><b><?php echo get_phrase('last seen on'); ?>-</b> <?php echo $date_updated; ?></p>

              <p class="my-0"><b><?php echo get_phrase('Completed on'); ?>-</b> <?php echo $completed_date; ?></p>
            </td>
            <td>
              <p class="my-0 mb-1"><?php echo gp_ds_badge($status_badge['label'], $status_badge['tone'], true); ?></p>
              <?php if ($status['percent'] !== null): ?>
                <div class="progress">
                  <div class="progress-bar bg-success" role="progressbar" style="width: <?php echo (int) $status['percent']; ?>%;" aria-valuenow="<?php echo (int) $status['percent']; ?>" aria-valuemin="0" aria-valuemax="100"><?php echo (int) $status['percent']; ?>%</div>
                </div>
              <?php else: ?>
                <p class="my-0"><?php echo get_phrase('In progress'); ?></p>
              <?php endif; ?>

              <?php if ($is_scorm): ?>
                <p class="my-0 mt-1">- <?php echo get_phrase('Test score').': '.($test_score === null ? '&mdash;' : $test_score); ?></p>
              <?php else: ?>
                <p class="my-0 mt-1">- <?php echo get_phrase('Completed lesson').' '.count($completed_lesson).' '.get_phrase('out of').' '.$total_lesson; ?></p>
              <?php endif; ?>

              <?php
                $total_watched_duration = 0; //seconds
                $watched_durations = $this->db->get_where('watched_duration', ['watched_student_id' => $enrolment['user_id'], 'watched_course_id' => $course_details['id']]);
                foreach($watched_durations->result_array() as $watched_duration){
                  $total_watched_duration += count(json_decode($watched_duration['watched_counter'], true))*5;
                }
              ?>

              <p class="my-0">- <?php echo get_phrase('Watched duration').'- <b>'.seconds_to_time_format($total_watched_duration); ?></b></p>



            </td>
            <td class="text-center">
              <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                <a href="javascript:;" onclick="showLargeModal('<?php echo site_url('admin/student_academic_quiz_result/'.$course_details['id'].'/'.$enrolment['user_id']); ?>', '<?php echo get_phrase('Quiz results'); ?>')" class="btn btn-light cursor-pointer" data-toggle="tooltip" title="<?php echo get_phrase('Quiz results'); ?>"><i class="far fa-address-card"></i></a>

                <?php if(addon_status('certificate')): ?>
                  <a href="<?php echo site_url('admin/student_certificate/'.$enrolment['user_id'].'/'.$course_details['id']); ?>" target="_blank" class="btn btn-light cursor-pointer" data-toggle="tooltip" title="<?php echo get_phrase('Certificate'); ?>">
                    <i class="fas fa-graduation-cap"></i>
                  </a>
                <?php endif; ?>
              </div>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</div>
<?php
gp_ds_card([
    'title' => get_phrase('academic') . ' ' . get_phrase('progress'),
    'body' => ob_get_clean(),
    'extra_class' => 'gp-dash-panel',
]);
?>
<script type="text/javascript">
  $('[data-toggle=tooltip]').tooltip();
</script>
