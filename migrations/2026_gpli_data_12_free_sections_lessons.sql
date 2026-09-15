-- GPLI dummy data — 12: sections & lessons for the 16 batch-3 free courses (12 lessons each, 192 total)

-- === Writing Job Descriptions That Attract the Right People ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Writing Job Descriptions That Attract the Right People') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Writing Job Descriptions That Attract the Right People: Introduction & Overview', '00:18:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=sxjgL64czRY', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Writing Job Descriptions That Attract the Right People: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to writing Job Descriptions That Attract the Right People.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to writing Job Descriptions That Attract the Right People.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to writing Job Descriptions That Attract the Right People.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to writing Job Descriptions That Attract the Right People.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to writing Job Descriptions That Attract the Right People.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to writing Job Descriptions That Attract the Right People.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to writing Job Descriptions That Attract the Right People.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to writing Job Descriptions That Attract the Right People.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to writing Job Descriptions That Attract the Right People.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to writing Job Descriptions That Attract the Right People.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to writing Job Descriptions That Attract the Right People.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === HR Fundamentals: A Free Starter Course ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'HR Fundamentals: A Free Starter Course') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'HR Fundamentals: A Free Starter Course: Introduction & Overview', '00:18:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=sxjgL64czRY', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'HR Fundamentals: A Free Starter Course: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to hR Fundamentals: A Free Starter Course.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to hR Fundamentals: A Free Starter Course.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to hR Fundamentals: A Free Starter Course.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to hR Fundamentals: A Free Starter Course.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to hR Fundamentals: A Free Starter Course.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to hR Fundamentals: A Free Starter Course.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to hR Fundamentals: A Free Starter Course.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to hR Fundamentals: A Free Starter Course.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to hR Fundamentals: A Free Starter Course.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to hR Fundamentals: A Free Starter Course.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to hR Fundamentals: A Free Starter Course.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Sales Mindset Basics ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Sales Mindset Basics') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Sales Mindset Basics: Introduction & Overview', '00:21:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=6pY7EjqD3QA', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Sales Mindset Basics: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to sales Mindset Basics.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to sales Mindset Basics.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to sales Mindset Basics.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to sales Mindset Basics.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to sales Mindset Basics.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to sales Mindset Basics.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to sales Mindset Basics.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to sales Mindset Basics.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to sales Mindset Basics.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to sales Mindset Basics.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to sales Mindset Basics.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Introduction to CRM Tools for Small Teams ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Introduction to CRM Tools for Small Teams') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Introduction to CRM Tools for Small Teams: Introduction & Overview', '00:21:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=6pY7EjqD3QA', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Introduction to CRM Tools for Small Teams: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to introduction to CRM Tools for Small Teams.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to introduction to CRM Tools for Small Teams.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to introduction to CRM Tools for Small Teams.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to introduction to CRM Tools for Small Teams.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to introduction to CRM Tools for Small Teams.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to introduction to CRM Tools for Small Teams.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to introduction to CRM Tools for Small Teams.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to introduction to CRM Tools for Small Teams.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to introduction to CRM Tools for Small Teams.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to introduction to CRM Tools for Small Teams.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to introduction to CRM Tools for Small Teams.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Marketing 101 for New Business Owners ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Marketing 101 for New Business Owners') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Marketing 101 for New Business Owners: Introduction & Overview', '00:13:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=yHGRBTZI6w0', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Marketing 101 for New Business Owners: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to marketing 101 for New Business Owners.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to marketing 101 for New Business Owners.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to marketing 101 for New Business Owners.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to marketing 101 for New Business Owners.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to marketing 101 for New Business Owners.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to marketing 101 for New Business Owners.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to marketing 101 for New Business Owners.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to marketing 101 for New Business Owners.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to marketing 101 for New Business Owners.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to marketing 101 for New Business Owners.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to marketing 101 for New Business Owners.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Understanding Your Target Customer ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Understanding Your Target Customer') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Understanding Your Target Customer: Introduction & Overview', '00:13:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=yHGRBTZI6w0', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Understanding Your Target Customer: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to understanding Your Target Customer.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to understanding Your Target Customer.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to understanding Your Target Customer.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to understanding Your Target Customer.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to understanding Your Target Customer.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to understanding Your Target Customer.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to understanding Your Target Customer.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to understanding Your Target Customer.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to understanding Your Target Customer.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to understanding Your Target Customer.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to understanding Your Target Customer.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Introduction to Standard Operating Procedures ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Introduction to Standard Operating Procedures') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Introduction to Standard Operating Procedures: Introduction & Overview', '00:15:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=3zqwlr8sp2Y', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Introduction to Standard Operating Procedures: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to introduction to Standard Operating Procedures.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to introduction to Standard Operating Procedures.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to introduction to Standard Operating Procedures.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to introduction to Standard Operating Procedures.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to introduction to Standard Operating Procedures.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to introduction to Standard Operating Procedures.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to introduction to Standard Operating Procedures.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to introduction to Standard Operating Procedures.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to introduction to Standard Operating Procedures.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to introduction to Standard Operating Procedures.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to introduction to Standard Operating Procedures.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Basics of Inventory Management ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Basics of Inventory Management') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Basics of Inventory Management: Introduction & Overview', '00:15:40', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=3zqwlr8sp2Y', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Basics of Inventory Management: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to basics of Inventory Management.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to basics of Inventory Management.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to basics of Inventory Management.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to basics of Inventory Management.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to basics of Inventory Management.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to basics of Inventory Management.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to basics of Inventory Management.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to basics of Inventory Management.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to basics of Inventory Management.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to basics of Inventory Management.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to basics of Inventory Management.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Customer Support 101 ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Customer Support 101') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Customer Support 101: Introduction & Overview', '00:08:21', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=GH1TXfQSwUQ', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Customer Support 101: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to customer Support 101.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to customer Support 101.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to customer Support 101.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to customer Support 101.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to customer Support 101.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to customer Support 101.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to customer Support 101.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to customer Support 101.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to customer Support 101.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to customer Support 101.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to customer Support 101.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === First Response Best Practices ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'First Response Best Practices') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'First Response Best Practices: Introduction & Overview', '00:08:21', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=GH1TXfQSwUQ', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'First Response Best Practices: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to first Response Best Practices.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to first Response Best Practices.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to first Response Best Practices.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to first Response Best Practices.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to first Response Best Practices.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to first Response Best Practices.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to first Response Best Practices.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to first Response Best Practices.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to first Response Best Practices.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to first Response Best Practices.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to first Response Best Practices.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Leadership Basics: A Free Introduction ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Leadership Basics: A Free Introduction') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Leadership Basics: A Free Introduction: Introduction & Overview', '00:09:20', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=aUYSDEYdmzw', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Leadership Basics: A Free Introduction: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to leadership Basics: A Free Introduction.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to leadership Basics: A Free Introduction.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to leadership Basics: A Free Introduction.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to leadership Basics: A Free Introduction.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to leadership Basics: A Free Introduction.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to leadership Basics: A Free Introduction.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to leadership Basics: A Free Introduction.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to leadership Basics: A Free Introduction.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to leadership Basics: A Free Introduction.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to leadership Basics: A Free Introduction.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to leadership Basics: A Free Introduction.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Self-Awareness for New Leaders ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Self-Awareness for New Leaders') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Self-Awareness for New Leaders: Introduction & Overview', '00:09:20', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=aUYSDEYdmzw', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Self-Awareness for New Leaders: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to self-Awareness for New Leaders.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to self-Awareness for New Leaders.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to self-Awareness for New Leaders.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to self-Awareness for New Leaders.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to self-Awareness for New Leaders.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to self-Awareness for New Leaders.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to self-Awareness for New Leaders.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to self-Awareness for New Leaders.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to self-Awareness for New Leaders.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to self-Awareness for New Leaders.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to self-Awareness for New Leaders.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === New Manager Survival Guide ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'New Manager Survival Guide') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'New Manager Survival Guide: Introduction & Overview', '00:11:55', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=n3kNlFMXslo', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'New Manager Survival Guide: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to new Manager Survival Guide.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to new Manager Survival Guide.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to new Manager Survival Guide.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to new Manager Survival Guide.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to new Manager Survival Guide.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to new Manager Survival Guide.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to new Manager Survival Guide.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to new Manager Survival Guide.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to new Manager Survival Guide.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to new Manager Survival Guide.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to new Manager Survival Guide.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Setting Goals with Your Team ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Setting Goals with Your Team') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Setting Goals with Your Team: Introduction & Overview', '00:11:55', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=n3kNlFMXslo', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Setting Goals with Your Team: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to setting Goals with Your Team.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to setting Goals with Your Team.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to setting Goals with Your Team.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to setting Goals with Your Team.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to setting Goals with Your Team.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to setting Goals with Your Team.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to setting Goals with Your Team.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to setting Goals with Your Team.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to setting Goals with Your Team.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to setting Goals with Your Team.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to setting Goals with Your Team.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Workplace Communication Basics ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Workplace Communication Basics') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Workplace Communication Basics: Introduction & Overview', '00:16:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=HrCbXNRP7eg', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Workplace Communication Basics: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to workplace Communication Basics.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to workplace Communication Basics.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to workplace Communication Basics.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to workplace Communication Basics.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to workplace Communication Basics.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to workplace Communication Basics.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to workplace Communication Basics.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to workplace Communication Basics.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to workplace Communication Basics.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to workplace Communication Basics.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to workplace Communication Basics.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

-- === Introduction to Time Blocking ===
SET @gpli_course_id = (SELECT id FROM (SELECT id FROM `course` WHERE `title` = 'Introduction to Time Blocking') AS tc);
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Foundations & Core Concepts', @gpli_course_id, 0 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Foundations & Core Concepts') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Introduction to Time Blocking: Introduction & Overview', '00:16:00', @gpli_course_id, @gpli_section_id, 'youtube', NULL, 'https://www.youtube.com/watch?v=HrCbXNRP7eg', NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'video', NULL, NULL, NULL, 'Watch this introductory video, then continue to the text lessons in this section.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Introduction to Time Blocking: Introduction & Overview');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Key Terminology and Concepts', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through key Terminology and Concepts as it applies to introduction to Time Blocking.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Key Terminology and Concepts');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Why This Matters for SMEs', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through why This Matters for SMEs as it applies to introduction to Time Blocking.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Why This Matters for SMEs');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Practical Frameworks & Tools', @gpli_course_id, 1 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Practical Frameworks & Tools') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Core Framework Walkthrough', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through core Framework Walkthrough as it applies to introduction to Time Blocking.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Core Framework Walkthrough');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Tools & Templates You Can Use Today', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through tools & Templates You Can Use Today as it applies to introduction to Time Blocking.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Tools & Templates You Can Use Today');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Common Pitfalls to Avoid', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through common Pitfalls to Avoid as it applies to introduction to Time Blocking.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Common Pitfalls to Avoid');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Real-World Application', @gpli_course_id, 2 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Real-World Application') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Case Study: Applying the Framework', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through case Study: Applying the Framework as it applies to introduction to Time Blocking.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Case Study: Applying the Framework');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Adapting the Approach to Your Team', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through adapting the Approach to Your Team as it applies to introduction to Time Blocking.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Adapting the Approach to Your Team');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Measuring Results & Iterating', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through measuring Results & Iterating as it applies to introduction to Time Blocking.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Measuring Results & Iterating');
SET @gpli_section_exists = (SELECT COUNT(*) FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together');
INSERT INTO `section` (`title`, `course_id`, `order`)
SELECT 'Putting It All Together', @gpli_course_id, 3 WHERE @gpli_section_exists = 0 AND @gpli_course_id IS NOT NULL;
SET @gpli_section_id = (SELECT id FROM (SELECT id FROM `section` WHERE `course_id` = @gpli_course_id AND `title` = 'Putting It All Together') AS ts);
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Building Your Action Plan', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through building Your Action Plan as it applies to introduction to Time Blocking.', 1, 0, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Building Your Action Plan');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Q&A and Troubleshooting', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through q&A and Troubleshooting as it applies to introduction to Time Blocking.', 1, 1, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Q&A and Troubleshooting');
INSERT INTO `lesson` (`title`, `duration`, `course_id`, `section_id`, `video_type`, `cloud_video_id`, `video_url`, `audio_url`, `date_added`, `last_modified`, `lesson_type`, `attachment`, `attachment_type`, `caption`, `summary`, `is_free`, `order`, `quiz_attempt`)
SELECT 'Course Wrap-Up & Next Steps', NULL, @gpli_course_id, @gpli_section_id, NULL, NULL, NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'text', NULL, NULL, NULL, 'In this lesson, you will work through course Wrap-Up & Next Steps as it applies to introduction to Time Blocking.', 1, 2, 0
WHERE @gpli_section_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `lesson` WHERE `section_id` = @gpli_section_id AND `title` = 'Course Wrap-Up & Next Steps');

