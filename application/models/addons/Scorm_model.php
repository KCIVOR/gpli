<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Scorm_model extends CI_Model
{

	function __construct()
	{
		parent::__construct();
		$this->load->database();
	}

	public function get_scorm_curriculum_by_course_id($course_id = ""){
		if($course_id > 0){
			$this->db->where('course_id', $course_id);
		}
		return $this->db->get('scorm_curriculum');
	}

	public function remove_curriculum($course_id = ""){
		$this->db->where('course_id', $course_id);
        $this->db->delete('scorm_curriculum');

        //deleted previews course directory
        $scorm_query = $this->get_scorm_curriculum_by_course_id($course_id);
        $this->scorm_model->deleteDir('uploads/scorm/courses/'.$scorm_query->row('identifier'));
	}

	// $assembled_zip: path of a zip already put together from chunks (see
	// Scorm::upload_chunk). When empty, the zip comes from a normal $_FILES upload.
	public function add_curriculum($course_id = "", $assembled_zip = "") {
		$data['scorm_provider'] = html_escape($this->input->post('scorm_provider'));
		$data['identifier'] = md5(rand(10000, 99999));
		$data['course_id'] = $course_id;
		$data['date_added'] = strtotime(date('d M Y'));

		// Create update directory.
		if (!is_dir('uploads/scorm'))
			mkdir('uploads/scorm', 0777, true);
		if (!is_dir('uploads/scorm/zip'))
			mkdir('uploads/scorm/zip', 0777, true);
		if (!is_dir('uploads/scorm/courses'))
			mkdir('uploads/scorm/courses', 0777, true);

		if($data['scorm_provider'] == 'ispring' || $data['scorm_provider'] == 'articulate' || $data['scorm_provider'] == 'adobe_captivate'){
			if ($assembled_zip != "" || !empty($_FILES['scorm_zip']['name'])) {
				$path = "uploads/scorm/zip/".$data['identifier'].'.zip';
				if ($assembled_zip != "") {
					rename($assembled_zip, $path);
				} else {
					move_uploaded_file($_FILES['scorm_zip']['tmp_name'], $path);
				}
				//Unzip uploaded update file and remove zip file.
				$zip = new ZipArchive;
				$res = $zip->open($path);
				$zip->extractTo('uploads/scorm/courses/'.$data['identifier']);
				$zip->close();
				if($path){
					unlink($path);
				}
				$scorm_query = $this->get_scorm_curriculum_by_course_id($course_id);
				if($scorm_query->num_rows() > 0){
					//deleted previews course directory
					$this->deleteDir('uploads/scorm/courses/'.$scorm_query->row('identifier'));

					$this->db->where('course_id', $course_id);
					$this->db->update('scorm_curriculum', $data);
					$this->session->set_flashdata('flash_message', get_phrase('scorm_course_uploaded_successfully'));
					$this->ensure_scorm_lesson($course_id);
					return 'success';
				}else{
					$this->db->insert('scorm_curriculum', $data);
					$this->session->set_flashdata('flash_message', get_phrase('scorm_course_uploaded_successfully'));
					$this->ensure_scorm_lesson($course_id);
					return 'success';
				}
			}else{
				return get_phrase('please_choose_a_scorm_zip_file');
			}
		}else{
			return get_phrase('please_select_a_course_provider');
		}
	}

	public function get_scorm_lesson_id($course_id) {
		return (int) $this->db->select('id')->where(['course_id' => $course_id, 'lesson_type' => 'scorm'])
			->order_by('id', 'asc')->limit(1)->get('lesson')->row('id');
	}

	// A SCORM course is tracked as one lesson so the normal progress/certificate code works.
	public function ensure_scorm_lesson($course_id) {
		if ($this->get_scorm_lesson_id($course_id) > 0) return;
		$section_id = (int) $this->db->select('id')->where('course_id', $course_id)->order_by('order', 'asc')->limit(1)->get('section')->row('id');
		if ($section_id <= 0) {
			$this->db->insert('section', ['course_id' => $course_id, 'title' => 'Course Content', 'order' => 1]);
			$section_id = $this->db->insert_id();
			$sections = json_decode($this->db->get_where('course', ['id' => $course_id])->row('section'), true);
			$sections = is_array($sections) ? $sections : [];
			$sections[] = $section_id;
			$this->db->where('id', $course_id)->update('course', ['section' => json_encode($sections)]);
		}
		$title = $this->db->get_where('course', ['id' => $course_id])->row('title');
		$this->db->insert('lesson', ['course_id' => $course_id, 'section_id' => $section_id, 'title' => $title,
			'lesson_type' => 'scorm', 'order' => 1, 'date_added' => time()]);
	}

	public function save_scorm_progress() {
		$course_id  = (int) $this->input->post('course_id');
		$student_id = (int) $this->session->userdata('user_id');

		if ($course_id <= 0 || $student_id <= 0) {
			return;
		}

		// lesson_location/suspend_data are the package's own opaque bookmark/resume
		// data — never html_escape() these, they must round-trip byte-for-byte back
		// into LMSGetValue or the package's own resume logic will fail to parse them.
		$lesson_status   = $this->input->post('lesson_status');
		$score_raw       = $this->input->post('score_raw');
		$lesson_location = $this->input->post('lesson_location');
		$suspend_data    = $this->input->post('suspend_data');

		$data = ['date_updated' => strtotime(date('d M Y'))];
		// Only touch fields that were actually sent this commit — an intermediate
		// resume-data-only commit shouldn't blank out a previously saved score.
		if ($lesson_status !== null && $lesson_status !== '') {
			$data['lesson_status'] = html_escape($lesson_status);
		}
		if ($score_raw !== null && $score_raw !== '') {
			$data['score_raw'] = (int) $score_raw;
		}
		if ($lesson_location !== null && $lesson_location !== '') {
			$data['lesson_location'] = $lesson_location;
		}
		if ($suspend_data !== null && $suspend_data !== '') {
			$data['suspend_data'] = $suspend_data;
		}

		$existing = $this->db->get_where('scorm_tracking', ['course_id' => $course_id, 'student_id' => $student_id]);
		if ($existing->num_rows() > 0) {
			$this->db->where('course_id', $course_id);
			$this->db->where('student_id', $student_id);
			$this->db->update('scorm_tracking', $data);
		} else {
			$data['course_id']  = $course_id;
			$data['student_id'] = $student_id;
			$data['date_added'] = strtotime(date('d M Y'));
			$this->db->insert('scorm_tracking', $data);
		}
	}

	public function get_scorm_progress($course_id = "", $student_id = "") {
		return $this->db->get_where('scorm_tracking', ['course_id' => $course_id, 'student_id' => $student_id])->row_array();
	}

	public static function deleteDir($dirPath) {
	    if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
	        $dirPath .= '/';
	    }
	    $files = glob($dirPath . '*', GLOB_MARK);
	    foreach ($files as $file) {
	        if (is_dir($file)) {
	            self::deleteDir($file);
	        } else {
	            unlink($file);
	        }
	    }
	    rmdir($dirPath);
	}

}