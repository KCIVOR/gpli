-- GPLI dummy data — 10: sections & lessons for the 16 batch-2 courses (12 lessons each, 192 total)

-- === Onboarding Programs That Actually Work ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Onboarding Programs That Actually Work') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Onboarding Programs That Actually Work: Introduction & Overview', '00:18:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=sxjgL64czRY', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Onboarding Programs That Actually Work: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to onboarding Programs That Actually Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to onboarding Programs That Actually Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to onboarding Programs That Actually Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to onboarding Programs That Actually Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to onboarding Programs That Actually Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to onboarding Programs That Actually Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to onboarding Programs That Actually Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to onboarding Programs That Actually Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to onboarding Programs That Actually Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to onboarding Programs That Actually Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to onboarding Programs That Actually Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === HR Compliance Basics for SME Owners ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'HR Compliance Basics for SME Owners') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'HR Compliance Basics for SME Owners: Introduction & Overview', '00:18:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=sxjgL64czRY', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'HR Compliance Basics for SME Owners: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to hR Compliance Basics for SME Owners.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to hR Compliance Basics for SME Owners.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to hR Compliance Basics for SME Owners.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to hR Compliance Basics for SME Owners.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to hR Compliance Basics for SME Owners.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to hR Compliance Basics for SME Owners.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to hR Compliance Basics for SME Owners.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to hR Compliance Basics for SME Owners.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to hR Compliance Basics for SME Owners.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to hR Compliance Basics for SME Owners.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to hR Compliance Basics for SME Owners.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Building a Sales Pipeline from Zero ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Building a Sales Pipeline from Zero') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building a Sales Pipeline from Zero: Introduction & Overview', '00:21:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=6pY7EjqD3QA', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building a Sales Pipeline from Zero: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to building a Sales Pipeline from Zero.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to building a Sales Pipeline from Zero.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to building a Sales Pipeline from Zero.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to building a Sales Pipeline from Zero.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to building a Sales Pipeline from Zero.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to building a Sales Pipeline from Zero.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to building a Sales Pipeline from Zero.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to building a Sales Pipeline from Zero.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to building a Sales Pipeline from Zero.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to building a Sales Pipeline from Zero.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to building a Sales Pipeline from Zero.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Account Management & Customer Expansion ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Account Management & Customer Expansion') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Account Management & Customer Expansion: Introduction & Overview', '00:21:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=6pY7EjqD3QA', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Account Management & Customer Expansion: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to account Management & Customer Expansion.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to account Management & Customer Expansion.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to account Management & Customer Expansion.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to account Management & Customer Expansion.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to account Management & Customer Expansion.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to account Management & Customer Expansion.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to account Management & Customer Expansion.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to account Management & Customer Expansion.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to account Management & Customer Expansion.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to account Management & Customer Expansion.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to account Management & Customer Expansion.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Email Marketing That Converts ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Email Marketing That Converts') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Email Marketing That Converts: Introduction & Overview', '00:13:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=yHGRBTZI6w0', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Email Marketing That Converts: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to email Marketing That Converts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to email Marketing That Converts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to email Marketing That Converts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to email Marketing That Converts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to email Marketing That Converts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to email Marketing That Converts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to email Marketing That Converts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to email Marketing That Converts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to email Marketing That Converts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to email Marketing That Converts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to email Marketing That Converts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Social Media Marketing for Small Teams ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Social Media Marketing for Small Teams') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Social Media Marketing for Small Teams: Introduction & Overview', '00:13:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=yHGRBTZI6w0', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Social Media Marketing for Small Teams: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to social Media Marketing for Small Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to social Media Marketing for Small Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to social Media Marketing for Small Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to social Media Marketing for Small Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to social Media Marketing for Small Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to social Media Marketing for Small Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to social Media Marketing for Small Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to social Media Marketing for Small Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to social Media Marketing for Small Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to social Media Marketing for Small Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to social Media Marketing for Small Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Operational KPIs Every SME Should Track ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Operational KPIs Every SME Should Track') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Operational KPIs Every SME Should Track: Introduction & Overview', '00:15:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=3zqwlr8sp2Y', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Operational KPIs Every SME Should Track: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to operational KPIs Every SME Should Track.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to operational KPIs Every SME Should Track.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to operational KPIs Every SME Should Track.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to operational KPIs Every SME Should Track.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to operational KPIs Every SME Should Track.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to operational KPIs Every SME Should Track.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to operational KPIs Every SME Should Track.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to operational KPIs Every SME Should Track.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to operational KPIs Every SME Should Track.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to operational KPIs Every SME Should Track.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to operational KPIs Every SME Should Track.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Vendor & Contract Management Basics ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Vendor & Contract Management Basics') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Vendor & Contract Management Basics: Introduction & Overview', '00:15:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=3zqwlr8sp2Y', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Vendor & Contract Management Basics: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to vendor & Contract Management Basics.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to vendor & Contract Management Basics.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to vendor & Contract Management Basics.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to vendor & Contract Management Basics.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to vendor & Contract Management Basics.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to vendor & Contract Management Basics.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to vendor & Contract Management Basics.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to vendor & Contract Management Basics.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to vendor & Contract Management Basics.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to vendor & Contract Management Basics.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to vendor & Contract Management Basics.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Customer Success Fundamentals ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Customer Success Fundamentals') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Customer Success Fundamentals: Introduction & Overview', '00:08:21', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=GH1TXfQSwUQ', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Customer Success Fundamentals: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to customer Success Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to customer Success Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to customer Success Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to customer Success Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to customer Success Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to customer Success Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to customer Success Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to customer Success Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to customer Success Fundamentals.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to customer Success Fundamentals.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to customer Success Fundamentals.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Building a Knowledge Base That Reduces Tickets ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Building a Knowledge Base That Reduces Tickets') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building a Knowledge Base That Reduces Tickets: Introduction & Overview', '00:08:21', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=GH1TXfQSwUQ', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building a Knowledge Base That Reduces Tickets: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to building a Knowledge Base That Reduces Tickets.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to building a Knowledge Base That Reduces Tickets.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to building a Knowledge Base That Reduces Tickets.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to building a Knowledge Base That Reduces Tickets.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to building a Knowledge Base That Reduces Tickets.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to building a Knowledge Base That Reduces Tickets.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to building a Knowledge Base That Reduces Tickets.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to building a Knowledge Base That Reduces Tickets.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to building a Knowledge Base That Reduces Tickets.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to building a Knowledge Base That Reduces Tickets.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to building a Knowledge Base That Reduces Tickets.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Leading Remote & Hybrid Teams ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Leading Remote & Hybrid Teams') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Leading Remote & Hybrid Teams: Introduction & Overview', '00:09:20', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=aUYSDEYdmzw', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Leading Remote & Hybrid Teams: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to leading Remote & Hybrid Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to leading Remote & Hybrid Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to leading Remote & Hybrid Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to leading Remote & Hybrid Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to leading Remote & Hybrid Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to leading Remote & Hybrid Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to leading Remote & Hybrid Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to leading Remote & Hybrid Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to leading Remote & Hybrid Teams.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to leading Remote & Hybrid Teams.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to leading Remote & Hybrid Teams.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Emotional Intelligence for Leaders ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Emotional Intelligence for Leaders') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Emotional Intelligence for Leaders: Introduction & Overview', '00:09:20', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=aUYSDEYdmzw', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Emotional Intelligence for Leaders: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to emotional Intelligence for Leaders.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to emotional Intelligence for Leaders.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to emotional Intelligence for Leaders.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to emotional Intelligence for Leaders.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to emotional Intelligence for Leaders.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to emotional Intelligence for Leaders.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to emotional Intelligence for Leaders.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to emotional Intelligence for Leaders.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to emotional Intelligence for Leaders.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to emotional Intelligence for Leaders.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to emotional Intelligence for Leaders.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Running Meetings That Don't Waste Time ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Running Meetings That Don\'t Waste Time') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Running Meetings That Don\'t Waste Time: Introduction & Overview', '00:11:55', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=n3kNlFMXslo', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Running Meetings That Don\'t Waste Time: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to running Meetings That Don\'t Waste Time.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to running Meetings That Don\'t Waste Time.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to running Meetings That Don\'t Waste Time.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to running Meetings That Don\'t Waste Time.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to running Meetings That Don\'t Waste Time.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to running Meetings That Don\'t Waste Time.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to running Meetings That Don\'t Waste Time.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to running Meetings That Don\'t Waste Time.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to running Meetings That Don\'t Waste Time.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to running Meetings That Don\'t Waste Time.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to running Meetings That Don\'t Waste Time.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Conducting Effective Performance Reviews ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Conducting Effective Performance Reviews') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Conducting Effective Performance Reviews: Introduction & Overview', '00:11:55', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=n3kNlFMXslo', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Conducting Effective Performance Reviews: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to conducting Effective Performance Reviews.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to conducting Effective Performance Reviews.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to conducting Effective Performance Reviews.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to conducting Effective Performance Reviews.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to conducting Effective Performance Reviews.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to conducting Effective Performance Reviews.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to conducting Effective Performance Reviews.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to conducting Effective Performance Reviews.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to conducting Effective Performance Reviews.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to conducting Effective Performance Reviews.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to conducting Effective Performance Reviews.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Critical Thinking & Problem Solving at Work ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Critical Thinking & Problem Solving at Work') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Critical Thinking & Problem Solving at Work: Introduction & Overview', '00:16:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=HrCbXNRP7eg', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Critical Thinking & Problem Solving at Work: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to critical Thinking & Problem Solving at Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to critical Thinking & Problem Solving at Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to critical Thinking & Problem Solving at Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to critical Thinking & Problem Solving at Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to critical Thinking & Problem Solving at Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to critical Thinking & Problem Solving at Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to critical Thinking & Problem Solving at Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to critical Thinking & Problem Solving at Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to critical Thinking & Problem Solving at Work.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to critical Thinking & Problem Solving at Work.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to critical Thinking & Problem Solving at Work.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Networking Skills for Introverts ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Networking Skills for Introverts') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Networking Skills for Introverts: Introduction & Overview', '00:16:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=HrCbXNRP7eg', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Networking Skills for Introverts: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to networking Skills for Introverts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to networking Skills for Introverts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to networking Skills for Introverts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to networking Skills for Introverts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to networking Skills for Introverts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to networking Skills for Introverts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to networking Skills for Introverts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to networking Skills for Introverts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to networking Skills for Introverts.', 0, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to networking Skills for Introverts.', 0, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to networking Skills for Introverts.', 0, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

