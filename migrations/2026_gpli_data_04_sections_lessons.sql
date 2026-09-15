-- GPLI dummy data — 04: sections & lessons (4 sections x 3 lessons = 12 lessons per course, 384 total)
-- Lesson 1 of every course carries a real, verified public YouTube video; the other 11 are text lessons
-- (matches the exact convention already used by this app's own course #1 seed data).

-- === Modern Recruitment Strategies for SMEs ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Modern Recruitment Strategies for SMEs') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Modern Recruitment Strategies for SMEs: Introduction & Overview', '00:18:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=sxjgL64czRY', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Modern Recruitment Strategies for SMEs: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to modern Recruitment Strategies for SMEs.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to modern Recruitment Strategies for SMEs.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to modern Recruitment Strategies for SMEs.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to modern Recruitment Strategies for SMEs.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to modern Recruitment Strategies for SMEs.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to modern Recruitment Strategies for SMEs.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to modern Recruitment Strategies for SMEs.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to modern Recruitment Strategies for SMEs.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to modern Recruitment Strategies for SMEs.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to modern Recruitment Strategies for SMEs.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to modern Recruitment Strategies for SMEs.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Building an Employer Brand That Attracts Talent ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Building an Employer Brand That Attracts Talent') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building an Employer Brand That Attracts Talent: Introduction & Overview', '00:18:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=sxjgL64czRY', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building an Employer Brand That Attracts Talent: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to building an Employer Brand That Attracts Talent.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to building an Employer Brand That Attracts Talent.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to building an Employer Brand That Attracts Talent.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to building an Employer Brand That Attracts Talent.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to building an Employer Brand That Attracts Talent.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to building an Employer Brand That Attracts Talent.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to building an Employer Brand That Attracts Talent.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to building an Employer Brand That Attracts Talent.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to building an Employer Brand That Attracts Talent.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to building an Employer Brand That Attracts Talent.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to building an Employer Brand That Attracts Talent.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Diversity & Inclusion in the Workplace ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Diversity & Inclusion in the Workplace') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Diversity & Inclusion in the Workplace: Introduction & Overview', '00:18:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=sxjgL64czRY', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Diversity & Inclusion in the Workplace: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to diversity & Inclusion in the Workplace.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to diversity & Inclusion in the Workplace.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to diversity & Inclusion in the Workplace.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to diversity & Inclusion in the Workplace.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to diversity & Inclusion in the Workplace.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to diversity & Inclusion in the Workplace.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to diversity & Inclusion in the Workplace.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to diversity & Inclusion in the Workplace.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to diversity & Inclusion in the Workplace.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to diversity & Inclusion in the Workplace.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to diversity & Inclusion in the Workplace.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Employee Retention Strategies That Work ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Employee Retention Strategies That Work') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Employee Retention Strategies That Work: Introduction & Overview', '00:18:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=sxjgL64czRY', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Employee Retention Strategies That Work: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to employee Retention Strategies That Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to employee Retention Strategies That Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to employee Retention Strategies That Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to employee Retention Strategies That Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to employee Retention Strategies That Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to employee Retention Strategies That Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to employee Retention Strategies That Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to employee Retention Strategies That Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to employee Retention Strategies That Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to employee Retention Strategies That Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to employee Retention Strategies That Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Prospecting Fundamentals: Finding Your Next Customer ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Prospecting Fundamentals: Finding Your Next Customer') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Prospecting Fundamentals: Finding Your Next Customer: Introduction & Overview', '00:21:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=6pY7EjqD3QA', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Prospecting Fundamentals: Finding Your Next Customer: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to prospecting Fundamentals: Finding Your Next Customer.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Cold Outreach That Actually Converts ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Cold Outreach That Actually Converts') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Cold Outreach That Actually Converts: Introduction & Overview', '00:21:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=6pY7EjqD3QA', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Cold Outreach That Actually Converts: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to cold Outreach That Actually Converts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to cold Outreach That Actually Converts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to cold Outreach That Actually Converts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to cold Outreach That Actually Converts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to cold Outreach That Actually Converts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to cold Outreach That Actually Converts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to cold Outreach That Actually Converts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to cold Outreach That Actually Converts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to cold Outreach That Actually Converts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to cold Outreach That Actually Converts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to cold Outreach That Actually Converts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Negotiation Tactics for Sales Professionals ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Negotiation Tactics for Sales Professionals') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Negotiation Tactics for Sales Professionals: Introduction & Overview', '00:21:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=6pY7EjqD3QA', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Negotiation Tactics for Sales Professionals: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to negotiation Tactics for Sales Professionals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to negotiation Tactics for Sales Professionals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to negotiation Tactics for Sales Professionals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to negotiation Tactics for Sales Professionals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to negotiation Tactics for Sales Professionals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to negotiation Tactics for Sales Professionals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to negotiation Tactics for Sales Professionals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to negotiation Tactics for Sales Professionals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to negotiation Tactics for Sales Professionals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to negotiation Tactics for Sales Professionals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to negotiation Tactics for Sales Professionals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Closing Techniques for High-Value Deals ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Closing Techniques for High-Value Deals') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Closing Techniques for High-Value Deals: Introduction & Overview', '00:21:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=6pY7EjqD3QA', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Closing Techniques for High-Value Deals: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to closing Techniques for High-Value Deals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to closing Techniques for High-Value Deals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to closing Techniques for High-Value Deals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to closing Techniques for High-Value Deals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to closing Techniques for High-Value Deals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to closing Techniques for High-Value Deals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to closing Techniques for High-Value Deals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to closing Techniques for High-Value Deals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to closing Techniques for High-Value Deals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to closing Techniques for High-Value Deals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to closing Techniques for High-Value Deals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Digital Marketing Strategy for Small Business ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Digital Marketing Strategy for Small Business') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Digital Marketing Strategy for Small Business: Introduction & Overview', '00:13:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=yHGRBTZI6w0', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Digital Marketing Strategy for Small Business: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to digital Marketing Strategy for Small Business.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to digital Marketing Strategy for Small Business.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to digital Marketing Strategy for Small Business.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to digital Marketing Strategy for Small Business.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to digital Marketing Strategy for Small Business.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to digital Marketing Strategy for Small Business.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to digital Marketing Strategy for Small Business.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to digital Marketing Strategy for Small Business.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to digital Marketing Strategy for Small Business.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to digital Marketing Strategy for Small Business.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to digital Marketing Strategy for Small Business.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === SEO Fundamentals for Growing Brands ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'SEO Fundamentals for Growing Brands') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'SEO Fundamentals for Growing Brands: Introduction & Overview', '00:13:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=yHGRBTZI6w0', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'SEO Fundamentals for Growing Brands: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to sEO Fundamentals for Growing Brands.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to sEO Fundamentals for Growing Brands.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to sEO Fundamentals for Growing Brands.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to sEO Fundamentals for Growing Brands.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to sEO Fundamentals for Growing Brands.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to sEO Fundamentals for Growing Brands.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to sEO Fundamentals for Growing Brands.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to sEO Fundamentals for Growing Brands.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to sEO Fundamentals for Growing Brands.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to sEO Fundamentals for Growing Brands.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to sEO Fundamentals for Growing Brands.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Building a Brand Identity from Scratch ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Building a Brand Identity from Scratch') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building a Brand Identity from Scratch: Introduction & Overview', '00:13:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=yHGRBTZI6w0', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building a Brand Identity from Scratch: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to building a Brand Identity from Scratch.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to building a Brand Identity from Scratch.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to building a Brand Identity from Scratch.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to building a Brand Identity from Scratch.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to building a Brand Identity from Scratch.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to building a Brand Identity from Scratch.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to building a Brand Identity from Scratch.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to building a Brand Identity from Scratch.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to building a Brand Identity from Scratch.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to building a Brand Identity from Scratch.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to building a Brand Identity from Scratch.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Content Marketing That Drives Engagement ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Content Marketing That Drives Engagement') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Content Marketing That Drives Engagement: Introduction & Overview', '00:13:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=yHGRBTZI6w0', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Content Marketing That Drives Engagement: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to content Marketing That Drives Engagement.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to content Marketing That Drives Engagement.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to content Marketing That Drives Engagement.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to content Marketing That Drives Engagement.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to content Marketing That Drives Engagement.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to content Marketing That Drives Engagement.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to content Marketing That Drives Engagement.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to content Marketing That Drives Engagement.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to content Marketing That Drives Engagement.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to content Marketing That Drives Engagement.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to content Marketing That Drives Engagement.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Project Management Fundamentals ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Project Management Fundamentals') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Project Management Fundamentals: Introduction & Overview', '00:15:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=3zqwlr8sp2Y', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Project Management Fundamentals: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to project Management Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to project Management Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to project Management Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to project Management Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to project Management Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to project Management Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to project Management Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to project Management Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to project Management Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to project Management Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to project Management Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Agile & Scrum for Non-Software Teams ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Agile & Scrum for Non-Software Teams') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Agile & Scrum for Non-Software Teams: Introduction & Overview', '00:15:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=3zqwlr8sp2Y', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Agile & Scrum for Non-Software Teams: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to agile & Scrum for Non-Software Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to agile & Scrum for Non-Software Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to agile & Scrum for Non-Software Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to agile & Scrum for Non-Software Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to agile & Scrum for Non-Software Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to agile & Scrum for Non-Software Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to agile & Scrum for Non-Software Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to agile & Scrum for Non-Software Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to agile & Scrum for Non-Software Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to agile & Scrum for Non-Software Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to agile & Scrum for Non-Software Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Lean Process Improvement for SMEs ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Lean Process Improvement for SMEs') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Lean Process Improvement for SMEs: Introduction & Overview', '00:15:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=3zqwlr8sp2Y', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Lean Process Improvement for SMEs: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to lean Process Improvement for SMEs.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to lean Process Improvement for SMEs.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to lean Process Improvement for SMEs.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to lean Process Improvement for SMEs.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to lean Process Improvement for SMEs.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to lean Process Improvement for SMEs.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to lean Process Improvement for SMEs.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to lean Process Improvement for SMEs.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to lean Process Improvement for SMEs.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to lean Process Improvement for SMEs.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to lean Process Improvement for SMEs.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Supply Chain Basics for Operations Managers ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Supply Chain Basics for Operations Managers') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Supply Chain Basics for Operations Managers: Introduction & Overview', '00:15:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=3zqwlr8sp2Y', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Supply Chain Basics for Operations Managers: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to supply Chain Basics for Operations Managers.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to supply Chain Basics for Operations Managers.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to supply Chain Basics for Operations Managers.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to supply Chain Basics for Operations Managers.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to supply Chain Basics for Operations Managers.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to supply Chain Basics for Operations Managers.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to supply Chain Basics for Operations Managers.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to supply Chain Basics for Operations Managers.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to supply Chain Basics for Operations Managers.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to supply Chain Basics for Operations Managers.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to supply Chain Basics for Operations Managers.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Customer Service Excellence Fundamentals ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Customer Service Excellence Fundamentals') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Customer Service Excellence Fundamentals: Introduction & Overview', '00:08:21', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=GH1TXfQSwUQ', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Customer Service Excellence Fundamentals: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to customer Service Excellence Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to customer Service Excellence Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to customer Service Excellence Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to customer Service Excellence Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to customer Service Excellence Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to customer Service Excellence Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to customer Service Excellence Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to customer Service Excellence Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to customer Service Excellence Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to customer Service Excellence Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to customer Service Excellence Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Handling Difficult Customers with Confidence ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Handling Difficult Customers with Confidence') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Handling Difficult Customers with Confidence: Introduction & Overview', '00:08:21', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=GH1TXfQSwUQ', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Handling Difficult Customers with Confidence: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to handling Difficult Customers with Confidence.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to handling Difficult Customers with Confidence.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to handling Difficult Customers with Confidence.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to handling Difficult Customers with Confidence.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to handling Difficult Customers with Confidence.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to handling Difficult Customers with Confidence.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to handling Difficult Customers with Confidence.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to handling Difficult Customers with Confidence.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to handling Difficult Customers with Confidence.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to handling Difficult Customers with Confidence.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to handling Difficult Customers with Confidence.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Communication Skills for Support Teams ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Communication Skills for Support Teams') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Communication Skills for Support Teams: Introduction & Overview', '00:08:21', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=GH1TXfQSwUQ', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Communication Skills for Support Teams: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to communication Skills for Support Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to communication Skills for Support Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to communication Skills for Support Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to communication Skills for Support Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to communication Skills for Support Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to communication Skills for Support Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to communication Skills for Support Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to communication Skills for Support Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to communication Skills for Support Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to communication Skills for Support Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to communication Skills for Support Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Writing Effective Support Responses ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Writing Effective Support Responses') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Writing Effective Support Responses: Introduction & Overview', '00:08:21', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=GH1TXfQSwUQ', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Writing Effective Support Responses: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to writing Effective Support Responses.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to writing Effective Support Responses.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to writing Effective Support Responses.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to writing Effective Support Responses.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to writing Effective Support Responses.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to writing Effective Support Responses.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to writing Effective Support Responses.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to writing Effective Support Responses.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to writing Effective Support Responses.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to writing Effective Support Responses.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to writing Effective Support Responses.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Executive Leadership Essentials ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Executive Leadership Essentials') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Executive Leadership Essentials: Introduction & Overview', '00:09:20', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=aUYSDEYdmzw', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Executive Leadership Essentials: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to executive Leadership Essentials.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to executive Leadership Essentials.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to executive Leadership Essentials.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to executive Leadership Essentials.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to executive Leadership Essentials.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to executive Leadership Essentials.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to executive Leadership Essentials.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to executive Leadership Essentials.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to executive Leadership Essentials.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to executive Leadership Essentials.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to executive Leadership Essentials.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Strategic Decision-Making for Leaders ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Strategic Decision-Making for Leaders') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Strategic Decision-Making for Leaders: Introduction & Overview', '00:09:20', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=aUYSDEYdmzw', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Strategic Decision-Making for Leaders: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to strategic Decision-Making for Leaders.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to strategic Decision-Making for Leaders.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to strategic Decision-Making for Leaders.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to strategic Decision-Making for Leaders.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to strategic Decision-Making for Leaders.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to strategic Decision-Making for Leaders.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to strategic Decision-Making for Leaders.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to strategic Decision-Making for Leaders.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to strategic Decision-Making for Leaders.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to strategic Decision-Making for Leaders.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to strategic Decision-Making for Leaders.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Leading Organizational Change ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Leading Organizational Change') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Leading Organizational Change: Introduction & Overview', '00:09:20', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=aUYSDEYdmzw', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Leading Organizational Change: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to leading Organizational Change.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to leading Organizational Change.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to leading Organizational Change.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to leading Organizational Change.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to leading Organizational Change.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to leading Organizational Change.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to leading Organizational Change.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to leading Organizational Change.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to leading Organizational Change.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to leading Organizational Change.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to leading Organizational Change.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Building a Culture of Accountability ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Building a Culture of Accountability') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building a Culture of Accountability: Introduction & Overview', '00:09:20', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=aUYSDEYdmzw', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building a Culture of Accountability: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to building a Culture of Accountability.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to building a Culture of Accountability.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to building a Culture of Accountability.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to building a Culture of Accountability.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to building a Culture of Accountability.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to building a Culture of Accountability.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to building a Culture of Accountability.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to building a Culture of Accountability.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to building a Culture of Accountability.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to building a Culture of Accountability.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to building a Culture of Accountability.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Time Management for New Managers ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Time Management for New Managers') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Time Management for New Managers: Introduction & Overview', '00:11:55', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=n3kNlFMXslo', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Time Management for New Managers: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to time Management for New Managers.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to time Management for New Managers.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to time Management for New Managers.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to time Management for New Managers.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to time Management for New Managers.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to time Management for New Managers.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to time Management for New Managers.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to time Management for New Managers.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to time Management for New Managers.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to time Management for New Managers.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to time Management for New Managers.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === The Art of Delegation ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'The Art of Delegation') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'The Art of Delegation: Introduction & Overview', '00:11:55', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=n3kNlFMXslo', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'The Art of Delegation: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to the Art of Delegation.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to the Art of Delegation.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to the Art of Delegation.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to the Art of Delegation.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to the Art of Delegation.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to the Art of Delegation.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to the Art of Delegation.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to the Art of Delegation.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to the Art of Delegation.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to the Art of Delegation.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to the Art of Delegation.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Managing High-Performing Teams ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Managing High-Performing Teams') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Managing High-Performing Teams: Introduction & Overview', '00:11:55', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=n3kNlFMXslo', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Managing High-Performing Teams: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to managing High-Performing Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to managing High-Performing Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to managing High-Performing Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to managing High-Performing Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to managing High-Performing Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to managing High-Performing Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to managing High-Performing Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to managing High-Performing Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to managing High-Performing Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to managing High-Performing Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to managing High-Performing Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Giving Feedback That Drives Growth ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Giving Feedback That Drives Growth') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Giving Feedback That Drives Growth: Introduction & Overview', '00:11:55', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=n3kNlFMXslo', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Giving Feedback That Drives Growth: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to giving Feedback That Drives Growth.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to giving Feedback That Drives Growth.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to giving Feedback That Drives Growth.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to giving Feedback That Drives Growth.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to giving Feedback That Drives Growth.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to giving Feedback That Drives Growth.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to giving Feedback That Drives Growth.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to giving Feedback That Drives Growth.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to giving Feedback That Drives Growth.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to giving Feedback That Drives Growth.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to giving Feedback That Drives Growth.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Assertive Communication in the Workplace ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Assertive Communication in the Workplace') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Assertive Communication in the Workplace: Introduction & Overview', '00:16:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=HrCbXNRP7eg', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Assertive Communication in the Workplace: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to assertive Communication in the Workplace.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to assertive Communication in the Workplace.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to assertive Communication in the Workplace.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to assertive Communication in the Workplace.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to assertive Communication in the Workplace.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to assertive Communication in the Workplace.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to assertive Communication in the Workplace.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to assertive Communication in the Workplace.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to assertive Communication in the Workplace.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to assertive Communication in the Workplace.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to assertive Communication in the Workplace.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Public Speaking for Professionals ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Public Speaking for Professionals') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Public Speaking for Professionals: Introduction & Overview', '00:16:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=HrCbXNRP7eg', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Public Speaking for Professionals: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to public Speaking for Professionals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to public Speaking for Professionals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to public Speaking for Professionals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to public Speaking for Professionals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to public Speaking for Professionals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to public Speaking for Professionals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to public Speaking for Professionals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to public Speaking for Professionals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to public Speaking for Professionals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to public Speaking for Professionals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to public Speaking for Professionals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Mindfulness for Workplace Wellbeing ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Mindfulness for Workplace Wellbeing') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Mindfulness for Workplace Wellbeing: Introduction & Overview', '00:16:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=HrCbXNRP7eg', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Mindfulness for Workplace Wellbeing: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to mindfulness for Workplace Wellbeing.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to mindfulness for Workplace Wellbeing.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to mindfulness for Workplace Wellbeing.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to mindfulness for Workplace Wellbeing.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to mindfulness for Workplace Wellbeing.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to mindfulness for Workplace Wellbeing.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to mindfulness for Workplace Wellbeing.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to mindfulness for Workplace Wellbeing.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to mindfulness for Workplace Wellbeing.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to mindfulness for Workplace Wellbeing.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to mindfulness for Workplace Wellbeing.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Managing Stress & Avoiding Burnout ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Managing Stress & Avoiding Burnout') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Managing Stress & Avoiding Burnout: Introduction & Overview', '00:16:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=HrCbXNRP7eg', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Managing Stress & Avoiding Burnout: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to managing Stress & Avoiding Burnout.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to managing Stress & Avoiding Burnout.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to managing Stress & Avoiding Burnout.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to managing Stress & Avoiding Burnout.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to managing Stress & Avoiding Burnout.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to managing Stress & Avoiding Burnout.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to managing Stress & Avoiding Burnout.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to managing Stress & Avoiding Burnout.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to managing Stress & Avoiding Burnout.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to managing Stress & Avoiding Burnout.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to managing Stress & Avoiding Burnout.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

