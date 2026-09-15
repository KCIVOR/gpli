-- GPLI dummy data — 07: student accounts + testimonials
-- Adds 15 non-instructor accounts and 15 site-wide testimonials (ratable_type/id = NULL,
-- exactly what home_gpli.php's "What the people Thinks About Us" section already queries).
-- Same placeholder password convention as file 02: Gpli@2026 (SHA1-hashed).

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Amara', 'Okafor', 'amara.okafor@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'amara.okafor@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Liam', 'Chen', 'liam.chen@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'liam.chen@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Sofia', 'Reyes', 'sofia.reyes@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'sofia.reyes@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Noah', 'Patel', 'noah.patel@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'noah.patel@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Isabella', 'Kim', 'isabella.kim@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'isabella.kim@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Ethan', 'Mercado', 'ethan.mercado@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'ethan.mercado@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Mia', 'Johansson', 'mia.johansson@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'mia.johansson@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Lucas', 'Santos', 'lucas.santos@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'lucas.santos@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Ava', 'Nakamura', 'ava.nakamura@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'ava.nakamura@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Oliver', 'Grant', 'oliver.grant@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'oliver.grant@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Chloe', 'Delacroix', 'chloe.delacroix@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'chloe.delacroix@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Mateo', 'Silva', 'mateo.silva@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'mateo.silva@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Zara', 'Hassan', 'zara.hassan@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'zara.hassan@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Benjamin', 'Osei', 'benjamin.osei@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'benjamin.osei@example-student.com');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Ines', 'Moreau', 'ines.moreau@example-student.com', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', '', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', '', '', '', 1, 0, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'ines.moreau@example-student.com');


INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 4, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'amara.okafor@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'The courses are short enough to finish during lunch breaks but detailed enough to actually change how our team works.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'The courses are short enough to finish during lunch breaks but detailed enough to actually change how our team works.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'liam.chen@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'My whole team went through the Leadership track together — it gave us a shared vocabulary we didn\'t have before.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'My whole team went through the Leadership track together — it gave us a shared vocabulary we didn\'t have before.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'sofia.reyes@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'I was skeptical about an online course changing how we hire, but the recruitment course paid for itself in one hire.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'I was skeptical about an online course changing how we hire, but the recruitment course paid for itself in one hire.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'noah.patel@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Straightforward, practical, no fluff. Exactly what a small business owner needs.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Straightforward, practical, no fluff. Exactly what a small business owner needs.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'isabella.kim@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'The delegation course alone saved me hours a week. Wish I had found this two years ago.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'The delegation course alone saved me hours a week. Wish I had found this two years ago.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 4, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'ethan.mercado@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Good mix of video and reading — I could go through lessons even with a spotty connection at the office.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Good mix of video and reading — I could go through lessons even with a spotty connection at the office.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'mia.johansson@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Our support team completion rate went up noticeably after we assigned the customer service courses.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Our support team completion rate went up noticeably after we assigned the customer service courses.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'lucas.santos@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Clear, well-structured, and the facilitators clearly know what SME teams actually deal with.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Clear, well-structured, and the facilitators clearly know what SME teams actually deal with.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'ava.nakamura@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'The negotiation course gave my sales team concrete scripts, not just theory.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'The negotiation course gave my sales team concrete scripts, not just theory.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'oliver.grant@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Certificates were a nice touch for our internal training records.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Certificates were a nice touch for our internal training records.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 4, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'chloe.delacroix@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Content feels current and grounded in real business scenarios, not generic corporate training filler.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Content feels current and grounded in real business scenarios, not generic corporate training filler.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'mateo.silva@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Easy to assign courses across the team and track who finished what.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Easy to assign courses across the team and track who finished what.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'zara.hassan@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'The change management course helped us get through a rocky reorg with a lot less friction.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'The change management course helped us get through a rocky reorg with a lot less friction.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'benjamin.osei@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Bite-sized lessons made it realistic to actually finish courses instead of abandoning them halfway.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Bite-sized lessons made it realistic to actually finish courses instead of abandoning them halfway.');

INSERT INTO `rating` (`rating`, `user_id`, `ratable_id`, `ratable_type`, `date_added`, `last_modified`, `review`)
SELECT 5, (SELECT id FROM (SELECT id FROM `users` WHERE `email` = 'ines.moreau@example-student.com') AS tu), NULL, NULL, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'Good value for a small team — the per-seat pricing made sense for us at 6 people.'
WHERE NOT EXISTS (SELECT 1 FROM `rating` WHERE `ratable_type` IS NULL AND `ratable_id` IS NULL AND `review` = 'Good value for a small team — the per-seat pricing made sense for us at 6 people.');

