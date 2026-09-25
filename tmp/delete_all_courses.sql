-- Run this against the `academy_lms` database (NOT `gpli` — that db is unrelated/empty).
-- In phpMyAdmin: select `academy_lms` in the left sidebar first, then run this on the SQL tab.
-- Removes ALL courses, ALL categories, and every row that references them.

START TRANSACTION;

-- Quiz answers/questions attached to quiz-type lessons of any course
DELETE qr FROM quiz_results qr
INNER JOIN lesson l ON l.id = qr.quiz_id
WHERE l.course_id IS NOT NULL;

DELETE q FROM question q
INNER JOIN lesson l ON l.id = q.quiz_id
WHERE l.course_id IS NOT NULL;

-- Files attached to lessons of any course
DELETE rf FROM resource_files rf
INNER JOIN lesson l ON l.id = rf.lesson_id
WHERE l.course_id IS NOT NULL;

-- Course content
DELETE FROM lesson WHERE course_id IS NOT NULL;
DELETE FROM section WHERE course_id IS NOT NULL;

-- Enrollment / progress / activity tied to courses
DELETE FROM enrol WHERE course_id IS NOT NULL;
DELETE FROM watch_histories WHERE course_id IS NOT NULL;
DELETE FROM watched_duration WHERE watched_course_id IS NOT NULL;

-- Reviews, live-class, announcements, custom fields
DELETE FROM rating WHERE ratable_type = 'course';
DELETE FROM bbb_meetings WHERE course_id IS NOT NULL;
DELETE FROM announcement_courses WHERE course_id IS NOT NULL;
DELETE FROM custom_fields WHERE course_id IS NOT NULL;

-- The courses themselves
DELETE FROM course;

-- All categories (courses reference category_id, so drop these after courses are gone)
DELETE FROM category;

COMMIT;
