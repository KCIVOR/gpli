<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Scorm extends CI_Controller {
    public function __construct()
    {
        parent::__construct();
        $this->load->model('addons/scorm_model');
        $this->load->library('session');
        
        if (!$this->session->userdata('user_id')) {
            redirect(site_url('home/login'), 'refresh');
        }
    }
    function add_curriculum($course_id = ""){
        $user_id = $this->session->userdata('user_id');
        if (class_exists('ZipArchive')) {
            if($this->session->userdata('admin_login') == 1 || $this->crud_model->get_course_by_id($course_id)->row('user_id') == $user_id){
                echo $this->scorm_model->add_curriculum($course_id);
            }else{
                echo get_phrase('no_access');
            }
        }else{
            echo get_phrase('your_server_is_unable_to_extract_the_zip_file').'. '.get_phrase('please_enable_the_zip_extension_on_your_server').', '.get_phrase('then_try_again');
        }
    }

    // Receives a SCORM zip in small pieces so no single request goes over
    // Cloudflare's 100MB request limit. Pieces arrive in order and are appended
    // to one .part file; after the last piece the zip is processed as usual.
    function upload_chunk($course_id = ""){
        $user_id = $this->session->userdata('user_id');
        if(!($this->session->userdata('admin_login') == 1 || $this->crud_model->get_course_by_id($course_id)->row('user_id') == $user_id)){
            echo get_phrase('no_access');
            return;
        }
        if (!class_exists('ZipArchive')) {
            echo get_phrase('your_server_is_unable_to_extract_the_zip_file').'. '.get_phrase('please_enable_the_zip_extension_on_your_server').', '.get_phrase('then_try_again');
            return;
        }

        $upload_id = $this->input->post('upload_id');
        $index     = (int) $this->input->post('chunk_index');
        $total     = (int) $this->input->post('total_chunks');
        if (!preg_match('/^[a-f0-9]{32}$/', (string) $upload_id) || $total < 1 || $index < 0 || $index >= $total) {
            echo 'invalid_upload';
            return;
        }
        if (empty($_FILES['chunk']['tmp_name']) || $_FILES['chunk']['error'] != UPLOAD_ERR_OK) {
            echo get_phrase('upload_failed').', '.get_phrase('please_try_again');
            return;
        }

        if (!is_dir('uploads/scorm/zip'))
            mkdir('uploads/scorm/zip', 0777, true);
        $part_path = 'uploads/scorm/zip/'.$upload_id.'.part';

        // First piece starts a fresh file; later pieces must follow an existing one.
        if ($index > 0 && !file_exists($part_path)) {
            echo get_phrase('upload_failed').', '.get_phrase('please_try_again');
            return;
        }
        $out = fopen($part_path, $index == 0 ? 'wb' : 'ab');
        $in  = fopen($_FILES['chunk']['tmp_name'], 'rb');
        stream_copy_to_stream($in, $out);
        fclose($in);
        fclose($out);

        if ($index < $total - 1) {
            echo 'chunk_ok';
            return;
        }

        $result = $this->scorm_model->add_curriculum($course_id, $part_path);
        if (file_exists($part_path)) {
            unlink($part_path);
        }
        echo $result;
    }

    function remove_curriculum($course_id = ""){
        $user_id = $this->session->userdata('user_id');
        if($this->session->userdata('admin_login') == 1 || $this->crud_model->get_course_by_id($course_id)->row('user_id') == $user_id){
             $this->scorm_model->remove_curriculum($course_id);
        }
        $this->session->set_flashdata('flash_message', get_phrase('scorm_course_removed_successfully'));
        redirect(site_url($this->session->userdata('role').'/course_form/course_edit/'.$course_id), 'refresh');
    }

}