-- GPLI dummy data — 01: categories (8 parents + 16 sub-categories = 24)
-- Idempotent: skips any row whose slug already exists.

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'HR', 'HR', 0, 'hr', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-users'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'hr');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'RECRUI', 'Recruitment & Talent Acquisition', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'hr') AS t), 'recruitment-talent-acquisition', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-users'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'recruitment-talent-acquisition');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'DIVERS', 'Diversity, Inclusion & Retention', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'hr') AS t), 'diversity-inclusion-retention', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-users'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'diversity-inclusion-retention');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'SALES', 'Sales', 0, 'sales', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-chart-line'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'sales');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'PROSPE', 'Prospecting & Lead Generation', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'sales') AS t), 'prospecting-lead-generation', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-chart-line'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'prospecting-lead-generation');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'CLOSIN', 'Closing & Negotiation', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'sales') AS t), 'closing-negotiation', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-chart-line'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'closing-negotiation');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'GPLI-M', 'Marketing', 0, 'gpli-marketing', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-bullhorn'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'gpli-marketing');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'GPLI-D', 'Digital Marketing Strategy', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'gpli-marketing') AS t), 'gpli-digital-marketing-strategy', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-bullhorn'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'gpli-digital-marketing-strategy');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'BRAND-', 'Brand & Communications', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'gpli-marketing') AS t), 'brand-communications', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-bullhorn'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'brand-communications');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'GPLI-O', 'Operations', 0, 'gpli-operations', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-diagram-project'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'gpli-operations');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'GPLI-P', 'Project Management', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'gpli-operations') AS t), 'gpli-project-management', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-diagram-project'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'gpli-project-management');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'PROCES', 'Process Improvement', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'gpli-operations') AS t), 'process-improvement', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-diagram-project'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'process-improvement');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'CUSTOM', 'Customer Support', 0, 'customer-support', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-headset'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'customer-support');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'SERVIC', 'Service Excellence', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'customer-support') AS t), 'service-excellence', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-headset'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'service-excellence');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'GPLI-C', 'Communication Skills', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'customer-support') AS t), 'gpli-communication-skills', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-headset'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'gpli-communication-skills');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'GPLI-L', 'Leadership', 0, 'gpli-leadership', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-compass'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'gpli-leadership');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'GPLI-E', 'Executive Leadership', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'gpli-leadership') AS t), 'gpli-executive-leadership', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-compass'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'gpli-executive-leadership');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'CHANGE', 'Change Management', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'gpli-leadership') AS t), 'change-management', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-compass'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'change-management');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'GPLI-M', 'Management', 0, 'gpli-management', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-list-check'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'gpli-management');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'TIME-M', 'Time Management & Delegation', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'gpli-management') AS t), 'time-management-delegation', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-list-check'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'time-management-delegation');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'PEOPLE', 'People Management', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'gpli-management') AS t), 'people-management', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-list-check'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'people-management');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'PROFES', 'Professional Development', 0, 'professional-development', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-seedling'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'professional-development');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'COMMUN', 'Communication & Assertiveness', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'professional-development') AS t), 'communication-assertiveness', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-seedling'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'communication-assertiveness');

INSERT INTO `category` (`code`, `name`, `parent`, `slug`, `date_added`, `last_modified`, `font_awesome_class`)
SELECT 'MINDFU', 'Mindfulness & Wellbeing', (SELECT id FROM (SELECT id FROM `category` WHERE `slug` = 'professional-development') AS t), 'mindfulness-wellbeing', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'fa fa-seedling'
WHERE NOT EXISTS (SELECT 1 FROM `category` WHERE `slug` = 'mindfulness-wellbeing');

