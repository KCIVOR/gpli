# Geese Project — Course Setup Reference

Source documents:
- "The Geese Project 8-Week Leadership Accelerator — Course Curriculum Overview" (image, re-verified twice against the raw table)
- "The 12-week Leadership Challenge Overview - Revised April 16 2026.docx" (extracted programmatically from the file's own XML)
- SCORM zip folder: `Copy of Personal_Development_SCORM1-2_4` (23 files; verified via `unzip -l` and each package's own `imsmanifest.xml`)

## The 12 courses (8-Week Accelerator)

Course name is the "Course (verbatim)" column from the curriculum table — the source of truth for course titles per user decision.

| # | Course name | Category | Subcategory | SCORM file available? |
|---|---|---|---|---|
| 1 | Business Ethics | Foundation | Integrity | No |
| 2 | Goal Setting | Execution & Standards | Work Ethic | Yes |
| 3 | Taking Initiative | Execution & Standards | Excellence | Yes |
| 4 | Interpersonal Skills | People Skills | Relationship | No |
| 5 | Communication Strategies | People Skills | Communications | No |
| 6 | Improving Mindfulness | Adaptability | Resilience | Yes |
| 7 | Creative Problem Solving | Adaptability | Resourcefulness | No |
| 8 | Critical Thinking | Thinking & Innovation | Critical Thinking | Yes |
| 9 | Developing Creativity | Thinking & Innovation | Innovation | No |
| 10 | Emotional Intelligence | Emotional Mastery | Discipline | Yes |
| 11 | Conflict Resolution | Emotional Mastery | Conflict Management | No |
| 12 | Leadership and Influence | Leadership | Leadership | No |

Category/Subcategory columns are the THEME/TRAIT structure from the curriculum table, interpreted as parent/child categories (this interpretation was confirmed with the user, not stated verbatim in the source document itself).

## The 5 ready-to-upload courses — verified fields only

For each: name is confirmed from **two independent sources** (curriculum table + the SCORM package's own `imsmanifest.xml` title). Short description and description are reported as **not available** — verified by inspecting each package's `metadata.xml`, which is an identical, unfilled boilerplate template (title field empty, description field contains the literal placeholder text `Description`) across all 5 packages. Nothing here is invented to fill that gap.

### 1. Goal Setting
- **File:** `Goal_Setting_and_Getting_Things_Done_SCORM1.2_7412.zip`
- **Manifest title (verbatim):** "Goal Setting and Getting Things Done"
- **Category → Subcategory:** Execution & Standards → Work Ethic
- **Short description:** Not available in source materials
- **Description:** Not available in source materials

### 2. Taking Initiative
- **File:** `Taking_Initiative_SCORM1.2_2581.zip`
- **Manifest title (verbatim):** "Taking Initiative"
- **Category → Subcategory:** Execution & Standards → Excellence
- **Short description:** Not available in source materials
- **Description:** Not available in source materials

### 3. Improving Mindfulness
- **File:** `Improving_Mindfulness_SCORM1.2_4102.zip`
- **Manifest title (verbatim):** "Improving Mindfulness"
- **Category → Subcategory:** Adaptability → Resilience
- **Short description:** Not available in source materials
- **Description:** Not available in source materials

### 4. Critical Thinking
- **File:** `Critical_Thinking_SCORM1.2_4863.zip`
- **Manifest title (verbatim):** "Critical Thinking"
- **Category → Subcategory:** Thinking & Innovation → Critical Thinking
- **Short description:** Not available in source materials
- **Description:** Not available in source materials

### 5. Emotional Intelligence
- **File:** `Developing_Emotional_Intelligence_SCORM1.2_6948.zip`
- **Manifest title (verbatim):** "Developing Emotional Intelligence" — note: this differs from the curriculum table's "Emotional Intelligence." Not resolved; flagged for the user to pick one.
- **Category → Subcategory:** Emotional Mastery → Discipline
- **Short description:** Not available in source materials
- **Description:** Not available in source materials

## Open items
- 7 of the 12 courses have no matching SCORM file in the provided folder (see table above).
- No short/long description exists anywhere in source materials for any of the 5 available courses — these will need to be written from scratch (by you, or by me if you want me to draft copy, clearly marked as newly authored rather than sourced).
- "Emotional Intelligence" vs. "Developing Emotional Intelligence" naming conflict not yet resolved.
- The 12-Week Challenge document (separate from this table) reuses 4 of these same course names but was not cross-merged into this file — see prior conversation turn for that comparison.
