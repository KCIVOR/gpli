-- GPLI dummy data — 02: instructor accounts (8, one per business function)
-- Placeholder password for every seeded account: Gpli@2026 (SHA1-hashed below). Change after import if these will ever log in.

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Priya', 'Nathan', 'priya.nathan@gpli.io', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', 'People operations leader with 12 years building HR functions for growing SMEs.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', 'HR Facilitator', '', '', 1, 1, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'priya.nathan@gpli.io');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Marcus', 'Webb', 'marcus.webb@gpli.io', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', 'B2B sales leader who has closed and coached teams through 8-figure pipelines.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', 'Sales Facilitator', '', '', 1, 1, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'marcus.webb@gpli.io');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Elena', 'Voss', 'elena.voss@gpli.io', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', 'Brand and growth marketer who has scaled demand generation for multiple SME brands.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', 'Marketing Facilitator', '', '', 1, 1, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'elena.voss@gpli.io');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Daniel', 'Cho', 'daniel.cho@gpli.io', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', 'Operations executive with a background in lean process design for manufacturing and services SMEs.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', 'Operations Facilitator', '', '', 1, 1, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'daniel.cho@gpli.io');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Grace', 'Alonzo', 'grace.alonzo@gpli.io', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', 'Customer experience lead who built support playbooks for fast-growing service businesses.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', 'Customer Support Facilitator', '', '', 1, 1, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'grace.alonzo@gpli.io');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Richard', 'Caballero', 'richard.caballero@gpli.io', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', 'Founder and leadership coach behind the Geese Project methodology for Filipino and SME leaders.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', 'Leadership Facilitator', '', '', 1, 1, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'richard.caballero@gpli.io');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Tasha', 'Reeves', 'tasha.reeves@gpli.io', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', 'Operations manager turned management trainer, specializing in first-time-manager transitions.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', 'Management Facilitator', '', '', 1, 1, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'tasha.reeves@gpli.io');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `skills`, `social_links`, `biography`, `role_id`, `date_added`, `last_modified`, `wishlist`, `title`, `payment_keys`, `verification_code`, `status`, `is_instructor`, `temp`, `sessions`)
SELECT 'Omar', 'Farsi', 'omar.farsi@gpli.io', 'a02f4b0dc24d38fa116472881c26aa04da5d7d59', '', '', 'Workplace communication trainer and executive coach with a focus on practical, low-jargon skill building.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '', 'Professional Development Facilitator', '', '', 1, 1, '', ''
WHERE NOT EXISTS (SELECT 1 FROM `users` WHERE `email` = 'omar.farsi@gpli.io');

