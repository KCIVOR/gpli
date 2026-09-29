<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Adds AUTH PLAIN support to CodeIgniter's Email library.
 *
 * CI_Email only speaks AUTH LOGIN. Some mail servers (e.g. the Postfix set up
 * by CyberPanel) only offer AUTH PLAIN, so try LOGIN first and fall back to
 * PLAIN when the server rejects the mechanism.
 */
class REST_Email extends CI_Email
{
	protected function _smtp_authenticate()
	{
		if ( ! $this->_smtp_auth)
		{
			return TRUE;
		}

		if ($this->smtp_user === '' && $this->smtp_pass === '')
		{
			$this->_set_error_message('lang:email_no_smtp_unpw');
			return FALSE;
		}

		$this->_send_data('AUTH LOGIN');
		$reply = $this->_get_smtp_data();

		if (strpos($reply, '503') === 0)	// Already authenticated
		{
			return TRUE;
		}
		elseif (strpos($reply, '334') === 0)
		{
			$this->_send_data(base64_encode($this->smtp_user));
			$reply = $this->_get_smtp_data();

			if (strpos($reply, '334') !== 0)
			{
				$this->_set_error_message('lang:email_smtp_auth_un', $reply);
				return FALSE;
			}

			$this->_send_data(base64_encode($this->smtp_pass));
			$reply = $this->_get_smtp_data();
		}
		else
		{
			// LOGIN not supported by this server, fall back to AUTH PLAIN
			$this->_send_data('AUTH PLAIN '.base64_encode("\0".$this->smtp_user."\0".$this->smtp_pass));
			$reply = $this->_get_smtp_data();
		}

		if (strpos($reply, '235') !== 0)
		{
			$this->_set_error_message('lang:email_smtp_auth_pw', $reply);
			return FALSE;
		}

		if ($this->smtp_keepalive)
		{
			$this->_smtp_auth = FALSE;
		}

		return TRUE;
	}
}
