-- GPLI Homepage migration
--
-- What this does: registers the new "GP Leadership Institute" homepage
-- (application/views/frontend/default-new/home_gpli.php) in the home_pages
-- table and makes it the active homepage. Nothing here stores page copy —
-- home_gpli.php's marketing text is hardcoded in that file (matches how
-- every other homepage template in this app already works); the DYNAMIC
-- parts of the page (Top Courses, Categories, Top Facilitators, "What the
-- people Thinks About Us") read live from the course/category/users/rating
-- tables that already exist, so there is nothing to seed for those either.
--
-- How to run this on cPanel: phpMyAdmin -> select your database -> Import
-- -> choose this file -> Go. Same way uploads/install.sql was originally
-- imported. Safe to re-run: the INSERT is guarded so it won't duplicate the
-- row if it already exists.

INSERT INTO `home_pages`
  (`title`, `description`, `identifier`, `is_permanent`, `status`, `thumbnail`, `html_file_names`, `created_at`, `updated_at`)
SELECT
  'GP Leadership Institute', 'GPLI custom homepage for SME leadership training', 'gpli', 1, 0,
  'assets/frontend/default-new/home/gpli-landing/team-highfive.jpg', '["home_gpli"]', NOW(), NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM `home_pages` WHERE `identifier` = 'gpli'
);

-- Deactivate every other homepage and activate the GPLI one.
UPDATE `home_pages` SET `status` = 0;
UPDATE `home_pages` SET `status` = 1 WHERE `identifier` = 'gpli';
