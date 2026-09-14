<!DOCTYPE html>
<html>
<head>
  <title><?php echo json_decode($notification['subject'], true)[$user_type]; ?></title>
</head>
<body style="margin:0; padding:0; background-color:#FBFAF7; font-family:Inter, Arial, sans-serif; color:#171613;">
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#FBFAF7; margin:0; padding:0;">
    <tr>
      <td align="center" style="padding:40px 16px;">
        <table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" style="max-width:600px; width:100%; background-color:#ffffff; border:1px solid #E4E1D8;">
          <tr>
            <td align="center" style="padding:40px 40px 20px 40px;">
              <img src="<?= base_url('uploads/system/'.get_frontend_settings('dark_logo')); ?>" alt="Website Logo" width="250" height="auto" style="display:block; border:0;">
            </td>
          </tr>
          <tr>
            <td align="center" style="padding:0 40px 20px 40px; font-family:Manrope, Arial, sans-serif; font-size:25px; font-weight:800; line-height:1.3; color:#171613;">
              <?php echo json_decode($notification['subject'], true)[$user_type]; ?>
            </td>
          </tr>
          <tr>
            <td align="left" style="padding:0 40px 20px 40px; font-family:Inter, Arial, sans-serif; font-size:16px; line-height:1.6; color:#6B6B65;">
              <?php
                $msg = json_decode($notification['template'], true)[$user_type];
                foreach($replaces as $key => $value):
                  $msg = str_replace('['.$key.']',$value,$msg);
                endforeach;
              ?>
              <!-- Start and end hidden div are needed for tracking system notification. SO don't remove -->
              <div class="system_notification_start" style="display: none;"></div>
              <div><?php echo $msg; ?></div>
              <div class="system_notification_end" style="display: none;"></div>
            </td>
          </tr>
          <tr>
            <td align="center" style="padding:20px 40px 40px 40px; font-family:Inter, Arial, sans-serif; font-size:14px; line-height:1.5; color:#9C988D;">
              &copy; <?= date('Y') ?> <?= get_settings('system_name'); ?>. All rights reserved.
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>
