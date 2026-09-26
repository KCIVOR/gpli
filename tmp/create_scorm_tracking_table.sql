-- Run this on BOTH local dev (academy_lms) and production (via phpMyAdmin SQL tab)
-- before the SCORM score-capture code is deployed. It creates one new table;
-- nothing existing is touched.
--
-- Purpose: the SCORM course addon currently only displays the package in an
-- iframe — it never talks to the SCORM content's own runtime (no LMSSetValue/
-- LMSCommit handling), so a quiz score authored inside a package (e.g. an
-- Articulate Rise assessment) never reaches this LMS. This table stores that
-- score once the API shim (added separately) starts capturing it, so the
-- certificate can require it to be >= 80 instead of just "lesson checkbox ticked".

CREATE TABLE IF NOT EXISTS `scorm_tracking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `lesson_status` varchar(50) DEFAULT NULL,
  `score_raw` int(11) DEFAULT NULL,
  `lesson_location` varchar(255) DEFAULT NULL,
  `suspend_data` longtext DEFAULT NULL,
  `date_added` varchar(255) DEFAULT NULL,
  `date_updated` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_student` (`course_id`, `student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- If this table was already created by an earlier version of this script (before resume
-- support was added), run this instead to add the two new columns without losing data:
-- ALTER TABLE `scorm_tracking`
--   ADD COLUMN `lesson_location` varchar(255) DEFAULT NULL AFTER `score_raw`,
--   ADD COLUMN `suspend_data` longtext DEFAULT NULL AFTER `lesson_location`;
