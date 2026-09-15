-- GPLI dummy data — 06: expand site-wide FAQs (frontend_settings.website_faqs)
-- Appends 7 new Q&A pairs to whatever already exists in that setting, rather than overwriting it.

SET @gpli_existing_faqs = (SELECT `value` FROM `frontend_settings` WHERE `key` = 'website_faqs' LIMIT 1);
SET @gpli_new_faqs_json = '[{"question":"How many team members can use one GPLI subscription?","answer":"Subscriptions start at a minimum of 5 seats per team; you can add more seats at any time from your account settings."},{"question":"Can I access courses on my phone?","answer":"Yes, all GPLI courses are fully accessible on mobile browsers and our mobile app."},{"question":"Do certificates expire?","answer":"No, certificates issued on course completion do not expire and can be downloaded at any time from your dashboard."},{"question":"Can I switch which courses my team is assigned?","answer":"Yes, team admins can reassign courses to any team member at any time at no extra cost."},{"question":"Is there a free trial?","answer":"Selected courses in our catalog are free to try before you subscribe for full access."},{"question":"Who creates the course content?","answer":"Courses are built by GPLI facilitators, each an experienced practitioner in their business function."},{"question":"Can I cancel my subscription anytime?","answer":"Yes, subscriptions can be cancelled at any time from your account billing page with no cancellation fee."}]';
SET @gpli_merged_faqs = CASE
  WHEN @gpli_existing_faqs IS NULL OR @gpli_existing_faqs = '' OR @gpli_existing_faqs = '[]' THEN @gpli_new_faqs_json
  ELSE CONCAT(LEFT(@gpli_existing_faqs, CHAR_LENGTH(@gpli_existing_faqs) - 1), ',', SUBSTRING(@gpli_new_faqs_json, 2))
END;
UPDATE `frontend_settings` SET `value` = @gpli_merged_faqs WHERE `key` = 'website_faqs' AND @gpli_existing_faqs NOT LIKE '%How many team members can use one GPLI subscription%';
