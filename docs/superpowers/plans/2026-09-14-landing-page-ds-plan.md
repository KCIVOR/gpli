# Public Landing Page DS Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the live public homepage look like the GPLI sample landing page and the Geese Project design-system HTML, keep every existing home CMS capability, and add the missing blocks with admin wiring that matches today’s toggles + `frontend_settings` pattern.

**Architecture:** Additive. Restyle `home_1` (the default pre-built template) and the matching `components/main` section files so the custom builder gets the same blocks. New marketing JSON + on/off keys live in `frontend_settings`. Header/footer stay the theme chrome (same cart / login / search / newsletter hooks) and are restyled in `gp-public-shell.css`. Do not invent a second page builder.

**Tech Stack:** CodeIgniter 3 views, `frontend_settings` JSON, existing `gp_ds_*` helpers, `--gp-*` tokens, CSS scoped under `.gp-ds`.

**Source of truth (visual):**
- Sample: `C:\Users\Rovick\Downloads\gplilmslandingpreview (1)\gpli-lms-landing-package\index.html`
- DS HTML: `assets/design-system/reference/geeseprojdesignsystem.html`
- Tokens: `assets/design-system/gp-tokens.css`

**Do not commit** unless the user explicitly asks.

---

## Audit (read this before any task)

### What is live today

`Home.php` loads the one `home_pages` row with `status = 1`.

- Permanent (`is_permanent = 1`): `page_name` = first file in `html_file_names` (usually `home_1`). Theme `header.php` + `footer.php` wrap it.
- Custom: `page_name` = `home_builder`. Sections are copies under `application/views/components/builder/{id}-{file}.php`.

`home_1.php` already has these toggles (keep all of them):

| Toggle key | Block |
|---|---|
| `top_course_section` | Top courses (live `get_top_courses()`) |
| `top_category_section` | Top categories (live `get_top_categories()`) |
| `upcoming_course_section` | Upcoming courses |
| `latest_course_section` | Latest courses |
| `top_instructor_section` | Instructors (live users) |
| `motivational_speech_section` | Motivational slides |
| `review_section` | Homepage reviews |
| `faq_section` | Website FAQs (first 5) |
| `blog_visibility_on_the_home_page` | Latest blogs |
| `promotional_section` | Join / become instructor |

Shared settings that already feed the hero: `banner_title`, `banner_sub_title`, banner image, logos. Search form is `home/search` + `name="query"`.

Admin today: Settings → Home page builder. Tab 1 = homes list + canvas. Tab 2 = motivational speech form + those toggles. No fields for eyebrow, stats, media strip, function blurbs, quiz banner, Why tiles, or CTA band.

`.gp-ds` is already on `home_1` / `home_builder` (`design_system_pages.php`). `gp-homepage-builder.css` only token-paints leftover Hyper/LMS class names. It does not match the sample layout.

### Sample vs DS HTML vs live

| Token / pattern | Sample | DS HTML | Live home |
|---|---|---|---|
| Primary / secondary / accent / gold | `#003BA6` `#CD182A` `#00215D` `#FCD01C` | Same | `--gp-*` same values, leftover cyan/pink still in old section CSS |
| Type | Manrope 800 / Inter | Same | Tokens loaded; leftover headings still mixed |
| Buttons | uppercase Manrope 800, 10px radius | `.btn` / `.btn-primary` / `.btn-outline` / `.btn-quiet` | Mix of leftover `btn-primary` and some `gp_ds_button` |
| Section head | red eyebrow + heavy H2 + muted p | `.heading-demo .eyebrow` (secondary, 0.16em, uppercase) | leftover `.title-two` |
| Cards | 14px radius, light border, soft shadow | `.card-tile` | leftover course cards, some DS overrides |
| Hero | centered light hero, gold span, 2 CTAs, search, 4 stats | heading + gold as small accent | leftover `h-1-banner` + 3 icon cards + search |
| Header | sticky, Courses mega, search flyout, cart, Log In, Join Now | navbar underline | leftover sub-header + menubar; Courses hover + cart + login already exist |

**Verdict:** Brand is aligned. Layout is not. The CMS can show the *kinds* of blocks the sample uses. It cannot assemble this exact page until new sections + settings exist.

### Sample blocks vs system

| Sample block | Exists? | This plan |
|---|---|---|
| Sticky header (logo, Courses, search, cart, login, join) | Partial (different chrome) | Restyle existing header. Keep all hrefs / cart ids. |
| Hero (eyebrow, H1 + gold span, sub, 2 CTAs, search, 4 stats) | Partial (title/sub/search/banner only) | Extend settings + restyle `hero_section_1` / `home_1` hero. |
| Feature trio | Partial (3 cards inside old hero) | New section + JSON + toggle. |
| Photo + featured video strip | No | New section + JSON + toggle. |
| Top courses cards | Yes (data) | Restyle cards to sample (`tc-card`). Same queries / wishlist / enrol / cart hooks. |
| Courses by Function | Partial (categories, no blurbs) | New section. Names/counts live. Blurbs in JSON keyed by category id. |
| Category chips | Yes (data, different UI) | Restyle `top_categories_1` to chips. |
| Leadership quiz banner | No | New section. Title/text/button/URL only. **No quiz engine.** |
| Why GPLI tiles + stats | No | New section + JSON + toggle. |
| Top facilitators | Yes (data) | Restyle instructor cards. |
| Dual Join / Facilitator CTA | Yes (`promotional_section`) | Restyle to sample dual cards. Same `sign_up` / become-instructor URLs and gates. |
| Dark CTA band | No | New section + JSON + toggle. |
| Footer 5-col + subscribe | Partial (already restyled once) | Tighten to sample/DS. Keep newsletter `ajaxForm` + legal links. |
| FAQ / blog / reviews / latest / upcoming / motivational | Yes, not in the sample | **Keep.** Place after the sample stack. Restyle heads/cards to DS only. |

### Out of scope

- `home_2`–`home_7` and themed homes (`home_fitness`, etc.).
- Admin builder canvas (`home_page_builder/index.php` JS/CSS).
- AI quiz, new payment/subscription rules, new `gp_ds_*` helpers, new phrase keys.
- Schema changes to `category` / `users`.
- Controllers `Home.php` public routes (except the existing newsletter / search / cart / wishlist they already hit).

---

## Standing constraints (every task)

- Existing toggles, builder files, and frontend settings keep working. Additive keys only.
- Helpers only: `gp_ds_button` (`primary` / `secondary` / `outline` / `quiet`), `gp_ds_badge`, `gp_ds_alert`, `gp_ds_card`, `gp_ds_table`, `gp_ds_page_title`. No raw `<i>` inside `gp_ds_button` labels. White-on-dark CTAs: `primary` / `outline` + extra class `gp-landing-btn-on-dark` (CSS only).
- Do not invent phrase keys. Use an existing complete key or leftover English.
- Type: `letter-spacing: 0` and `word-spacing: 0.12em` on titles/nav/labels. `word-spacing: 0.16em` only on multi-word CTAs.
- CSS under `.gp-ds` using `--gp-*`. Do not copy sample `--primary` names into a third token set.
- Text colors use `--gp-fg` / `--gp-fg-muted` / `--gp-fg-faint` (dark-mode-aware). Never `--gp-ink` / `--gp-text` for headings or body copy — those tokens have no dark-mode override and will go near-invisible on a dark background. No literal hex colors in new CSS; every color is a `--gp-*` token so it follows the existing `data-theme` toggle automatically.
- Gold is a small accent (one H1 span, dark-band eyebrows). Not large fills.
- Keep hooks: `name="query"`, `home/search`, `home/course/{slug}/{id}`, `home/courses?category=`, `home/toggleWishlistItems/{id}/TopCourse`, `#coursesWishlistIconTopCourse{id}`, `checkPropagation`, `#cartItemsCounter`, `#cartItems`, `home/shopping_cart`, `login`, `sign_up`, `sign_up?instructor=yes`, `home/become_an_instructor`, `home/subscribe_to_our_newsletter`, `#newsletter-form`, `ajaxForm resetable`.
- `builder-identity` values unique per section file.
- New `frontend_settings` rows: insert if missing (same idea as `embed_code` in `Crud_model`).
- Stop after each phase for a visual check (Light, Dark via the existing theme toggle, + a narrow viewport). Dark is not optional — this shell already ships a working toggle and every new section must be checked against it, not just Light.

---

## File map

| File | Role |
|---|---|
| `application/helpers/landing_helper.php` | Decode landing JSON with defaults. Autoload it. |
| `application/config/autoload.php` | Add `landing` to helper list. |
| `application/models/Crud_model.php` | `update_landing_page_extras()` + ensure-key helper. |
| `application/controllers/Admin.php` | `frontend_settings/landing_page_extras` → model → redirect to Pre-Built tab. |
| `application/views/backend/admin/home_page_builder.php` | New toggles + extras form on Pre-Built tab. |
| `application/views/components/main/hero_section_1.php` | Sample hero (settings + builder-editable). |
| `application/views/components/main/feature_trio.php` | **New.** |
| `application/views/components/main/media_strip.php` | **New.** |
| `application/views/components/main/top_courses_1.php` | Sample course cards. |
| `application/views/components/main/function_grid.php` | **New.** Parent categories + blurbs. |
| `application/views/components/main/top_categories_1.php` | Sample chips. |
| `application/views/components/main/quiz_banner.php` | **New.** Link-only. |
| `application/views/components/main/why_section.php` | **New.** |
| `application/views/components/main/top_instructors_1.php` | Sample facilitator cards. |
| `application/views/components/main/promotional_section_1.php` | Sample dual CTA. |
| `application/views/components/main/cta_band.php` | **New.** |
| `application/views/frontend/default-new/home_1.php` | Compose the stack via `include` of those files. Keep leftover sections (upcoming, latest, motivational, reviews, FAQ, blog) after, still toggled. |
| `application/views/frontend/default-new/header.php` | Drop leftover sub-header bar. |
| `application/views/frontend/default-new/header_lg_device.php` | Sticky DS header; restyle Courses mega + search flyout + cart + login. |
| `application/views/frontend/default-new/header_sm_device.php` | Mobile drawer aligned to sample. |
| `application/views/frontend/default-new/footer.php` | Sample/DS footer columns. Same subscribe hook. |
| `assets/design-system/gp-landing.css` | **New.** Landing section skin under `.gp-ds`. |
| `assets/design-system/gp-public-shell.css` | Header/footer restyle. Bump cache. |
| `application/views/frontend/default-new/includes_top.php` | Link `gp-landing.css` + bump shell cache. |

**Do not touch:** `Home.php` (routing), `common_scripts.php` DataTables, builder `js.php` / `index.php`, `home_2`–`home_7`, themed homes, payment/auth controllers.

---

## Settings schema (new keys)

All values are strings in `frontend_settings`. JSON keys store JSON. Toggles store `0` or `1`. Seed defaults on first save.

**Toggles (same mechanism as `update_home_page_settings`):**

- `feature_trio_section`
- `media_strip_section`
- `function_grid_section`
- `quiz_banner_section`
- `why_section`
- `cta_band_section`

**JSON key `landing_page_extras`** (one row, one admin form — same idea as `motivational_speech`):

```json
{
  "hero": {
    "eyebrow": "The #1 Learning Platform for SMEs",
    "accent": "Great to World Class",
    "cta1_label": "Get Started",
    "cta1_url": "sign_up",
    "cta2_label": "Explore Courses",
    "cta2_url": "home/courses",
    "stats": [
      {"num": "100+", "lbl": "Expert Courses", "sub": "One subscription, the whole library"},
      {"num": "8", "lbl": "Business Functions", "sub": "HR to operations to leadership"},
      {"num": "2hrs", "lbl": "Avg. Course Length", "sub": "Built for microlearning"},
      {"num": "SME", "lbl": "Focused Content", "sub": "Curated for SME realities"}
    ]
  },
  "trio": [
    {"title": "100+ Online Courses", "text": "Explore a variety of fresh business topics"},
    {"title": "Expert Instruction", "text": "Find the right course, taught by seasoned practitioners"},
    {"title": "Smart Solution", "text": "Learn on your own schedule, at your own pace"}
  ],
  "media": {
    "image_1": "",
    "image_2": "",
    "image_3": "",
    "video_url": "",
    "video_title": "Stop Losing Top Talent: The 24/7 Solution That Actually Works",
    "video_tag": "Featured"
  },
  "function_blurbs": {},
  "quiz": {
    "eyebrow": "Discover Yourself",
    "title": "What's Your Leadership Style?",
    "text": "Take our free quiz to understand your unique leadership approach.",
    "button_label": "Take the Quiz Now",
    "button_url": ""
  },
  "why": {
    "eyebrow": "Why GPLI",
    "title": "Why GP Leadership Institute?",
    "text": "Our courses are based on the best practices of global companies.",
    "tiles": [
      {"title": "Affordable", "text": "Low monthly cost makes world-class training accessible."},
      {"title": "Function Specific", "text": "Courses organized by business function."},
      {"title": "World-Class Content", "text": "Content created by experienced practitioners."}
    ],
    "stats": [
      {"num": "100+", "lbl": "Professional Courses"},
      {"num": "8", "lbl": "Business Functions"},
      {"num": "2hrs", "lbl": "Average Course Length"},
      {"num": "SME", "lbl": "Focused Content"}
    ]
  },
  "cta_band": {
    "title": "Ready to Transform Your Business?",
    "text": "Join SMEs worldwide that have empowered their teams.",
    "cta1_label": "Get Started Free",
    "cta1_url": "sign_up",
    "cta2_label": "Explore Courses",
    "cta2_url": "home/courses",
    "footnote": "Minimum 5 users per subscription • Unlimited access • Professional certificates included"
  }
}
```

`function_blurbs` is `{ "12": "Covers recruitment, diversity, inclusion, and retention." }` keyed by parent `category.id`. Empty blurb → hide the `<p>` or show leftover “View courses”.

`cta*_url` values are path fragments passed through `site_url()`. Allow full `http` URLs for the quiz button only.

Hero **title** and **subtitle** stay `banner_title` / `banner_sub_title`. Banner image stays the existing uploader.

---

### Task 1: Landing helper + settings save

**Files:**
- Create: `application/helpers/landing_helper.php`
- Modify: `application/config/autoload.php` (helpers array)
- Modify: `application/models/Crud_model.php` (append methods)
- Modify: `application/controllers/Admin.php` `frontend_settings()` (one new `$param1` branch)

- [ ] **Step 1: Add the helper**

Create `application/helpers/landing_helper.php`:

```php
<?php
defined('BASEPATH') or exit('No direct script access allowed');

function gp_landing_extras()
{
    $raw = get_frontend_settings('landing_page_extras');
    $data = is_string($raw) && $raw !== '' ? json_decode($raw, true) : [];
    if (! is_array($data)) {
        $data = [];
    }
    $defaults = [
        'hero' => [
            'eyebrow' => 'The #1 Learning Platform for SMEs',
            'accent' => 'Great to World Class',
            'cta1_label' => 'Get Started',
            'cta1_url' => 'sign_up',
            'cta2_label' => 'Explore Courses',
            'cta2_url' => 'home/courses',
            'stats' => [
                ['num' => '100+', 'lbl' => 'Expert Courses', 'sub' => 'One subscription, the whole library'],
                ['num' => '8', 'lbl' => 'Business Functions', 'sub' => 'HR to operations to leadership'],
                ['num' => '2hrs', 'lbl' => 'Avg. Course Length', 'sub' => 'Built for microlearning'],
                ['num' => 'SME', 'lbl' => 'Focused Content', 'sub' => 'Curated for SME realities'],
            ],
        ],
        'trio' => [
            ['title' => '100+ Online Courses', 'text' => 'Explore a variety of fresh business topics'],
            ['title' => 'Expert Instruction', 'text' => 'Find the right course, taught by seasoned practitioners'],
            ['title' => 'Smart Solution', 'text' => 'Learn on your own schedule, at your own pace'],
        ],
        'media' => [
            'image_1' => '', 'image_2' => '', 'image_3' => '',
            'video_url' => '',
            'video_title' => 'Stop Losing Top Talent: The 24/7 Solution That Actually Works',
            'video_tag' => 'Featured',
        ],
        'function_blurbs' => [],
        'quiz' => [
            'eyebrow' => 'Discover Yourself',
            'title' => "What's Your Leadership Style?",
            'text' => 'Take our free quiz to understand your unique leadership approach.',
            'button_label' => 'Take the Quiz Now',
            'button_url' => '',
        ],
        'why' => [
            'eyebrow' => 'Why GPLI',
            'title' => 'Why GP Leadership Institute?',
            'text' => 'Our courses are based on the best practices of global companies.',
            'tiles' => [
                ['title' => 'Affordable', 'text' => 'Low monthly cost makes world-class training accessible.'],
                ['title' => 'Function Specific', 'text' => 'Courses organized by business function.'],
                ['title' => 'World-Class Content', 'text' => 'Content created by experienced practitioners.'],
            ],
            'stats' => [
                ['num' => '100+', 'lbl' => 'Professional Courses'],
                ['num' => '8', 'lbl' => 'Business Functions'],
                ['num' => '2hrs', 'lbl' => 'Average Course Length'],
                ['num' => 'SME', 'lbl' => 'Focused Content'],
            ],
        ],
        'cta_band' => [
            'title' => 'Ready to Transform Your Business?',
            'text' => 'Join SMEs worldwide that have empowered their teams.',
            'cta1_label' => 'Get Started Free',
            'cta1_url' => 'sign_up',
            'cta2_label' => 'Explore Courses',
            'cta2_url' => 'home/courses',
            'footnote' => 'Minimum 5 users per subscription • Unlimited access • Professional certificates included',
        ],
    ];
    return array_replace_recursive($defaults, $data);
}

function gp_landing_url($path)
{
    $path = trim((string) $path);
    if ($path === '') {
        return '#';
    }
    if (preg_match('#^https?://#i', $path)) {
        return $path;
    }
    return site_url($path);
}

function gp_landing_toggle($key)
{
    $value = get_frontend_settings($key);
    if ($value === null || $value === false || $value === '') {
        return true;
    }
    return (int) $value === 1;
}
```

New toggles default **on** when the key is missing so a fresh install still shows the sample stack. After an admin turns one off, the `0` row exists and hides it.

- [ ] **Step 2: Autoload the helper**

In `application/config/autoload.php`, add `'landing'` next to `'design_system'` in `$autoload['helper']`.

- [ ] **Step 3: Model save + ensure keys**

Append to `Crud_model.php` (do not rename existing methods):

```php
public function ensure_frontend_setting($key, $value = '')
{
    $row = $this->db->where('key', $key)->get('frontend_settings');
    if ($row->num_rows() === 0) {
        $this->db->insert('frontend_settings', ['key' => $key, 'value' => $value]);
    }
}

public function update_landing_page_extras()
{
    $current = gp_landing_extras();
    $posted  = $this->input->post('landing');
    if (! is_array($posted)) {
        $posted = [];
    }
    $merged = array_replace_recursive($current, $posted);

    if (! empty($_FILES['landing_media']['name']) && is_array($_FILES['landing_media']['name'])) {
        if (! is_dir('uploads/home-pages')) {
            mkdir('uploads/home-pages', 0777, true);
        }
        foreach (['image_1', 'image_2', 'image_3'] as $slot) {
            if (! empty($_FILES['landing_media']['name'][$slot])) {
                $name = 'uploads/home-pages/' . md5(uniqid((string) mt_rand(), true)) . '.jpg';
                if (move_uploaded_file($_FILES['landing_media']['tmp_name'][$slot], $name)) {
                    $merged['media'][$slot] = $name;
                }
            }
        }
    }

    $this->ensure_frontend_setting('landing_page_extras', '{}');
    $this->db->where('key', 'landing_page_extras')->update('frontend_settings', [
        'value' => json_encode($merged),
    ]);

    foreach (['feature_trio_section', 'media_strip_section', 'function_grid_section', 'quiz_banner_section', 'why_section', 'cta_band_section'] as $toggle) {
        $this->ensure_frontend_setting($toggle, '1');
    }
}
```

`update_home_page_settings($key)` already flips any existing key. After `ensure_frontend_setting`, the new toggle checkboxes in the Pre-Built tab can call the same `admin/frontend_settings/home_page_settings/{key}` URL.

- [ ] **Step 4: Controller branch**

Inside `Admin.php` `frontend_settings()`, after the `motivational_speech` branch, add:

```php
if ($param1 == 'landing_page_extras') {
    $this->crud_model->update_landing_page_extras();
    $this->session->set_flashdata('flash_message', get_phrase('frontend_settings_updated'));
    redirect(site_url('admin/home_page_builder?tab=pre-built-home-settings'), 'refresh');
}
```

- [ ] **Step 5: Verify save without a browser home restyle yet**

As admin, you cannot submit the form until Task 2. Smoke-check: `gp_landing_extras()` returns defaults on a page that loads helpers (no PHP error).

---

### Task 2: Admin Pre-Built tab — toggles + extras form

**Files:**
- Modify: `application/views/backend/admin/home_page_builder.php` (Pre-Built pane only)

- [ ] **Step 1: Add six toggles** under the existing Home page section card, same markup as `faq_section`:

```php
<?php
$gp_landing_toggles = [
    'feature_trio_section' => 'Feature trio',
    'media_strip_section' => 'Media strip',
    'function_grid_section' => 'Courses by function',
    'quiz_banner_section' => 'Quiz banner',
    'why_section' => 'Why section',
    'cta_band_section' => 'CTA band',
];
foreach ($gp_landing_toggles as $toggle_key => $toggle_label):
?>
<div class="form-group row">
    <label class="col-8" for="<?php echo $toggle_key; ?>"><?php echo $toggle_label; ?></label>
    <div class="col-4">
        <input type="checkbox" onchange="actionTo('<?php echo site_url('admin/frontend_settings/home_page_settings/' . $toggle_key); ?>')" id="<?php echo $toggle_key; ?>" data-switch="success" <?php if (gp_landing_toggle($toggle_key)) echo 'checked'; ?>>
        <label for="<?php echo $toggle_key; ?>" data-on-label="On" data-off-label="Off"></label>
    </div>
</div>
<?php endforeach; ?>
```

Call `$this->crud_model->ensure_frontend_setting($toggle_key, '1');` once from the extras save (already in Task 1). First toggle click must not 404 because the key is missing — if the checkbox is used before the first extras save, run ensure in `update_home_page_settings` when `num_rows() === 0`: insert `1` then flip, **or** seed the six keys at the top of `home_page_builder.php`:

```php
<?php
foreach (['feature_trio_section', 'media_strip_section', 'function_grid_section', 'quiz_banner_section', 'why_section', 'cta_band_section'] as $gp_seed_key) {
    $this->crud_model->ensure_frontend_setting($gp_seed_key, '1');
}
?>
```

- [ ] **Step 2: Add a `gp_ds_card` form** `action="<?php echo site_url('admin/frontend_settings/landing_page_extras'); ?>"` `method="post"` `enctype="multipart/form-data"`.

Field names must be `landing[hero][eyebrow]`, `landing[hero][accent]`, `landing[hero][cta1_label]`, `landing[hero][cta1_url]`, `landing[hero][cta2_label]`, `landing[hero][cta2_url]`, `landing[hero][stats][0][num]` / `[lbl]` / `[sub]` (0–3), `landing[trio][0][title]` / `[text]` (0–2), `landing_media[image_1]` file inputs (PHP will see `$_FILES['landing_media']`), `landing[media][video_url]`, `landing[media][video_title]`, `landing[media][video_tag]`, `landing[quiz][...]`, `landing[why][tiles][0][title]`, `landing[why][stats][0][num]`, `landing[cta_band][...]`.

For blurbs, loop parent categories:

```php
<?php foreach ($this->crud_model->get_categories()->result_array() as $gp_cat): ?>
<label><?php echo htmlspecialchars($gp_cat['name']); ?></label>
<textarea class="form-control" name="landing[function_blurbs][<?php echo (int) $gp_cat['id']; ?>]"><?php echo htmlspecialchars(isset($extras['function_blurbs'][$gp_cat['id']]) ? $extras['function_blurbs'][$gp_cat['id']] : ''); ?></textarea>
<?php endforeach; ?>
```

`$extras = gp_landing_extras();` at the top of the form.

Submit with `gp_ds_button` primary, leftover English `Save landing extras` (do not invent a phrase key).

Use `.gp-settings-page` underline fields already used on this screen.

- [ ] **Step 3: Browser-check admin**

Open `http://localhost/academy/admin/home_page_builder?tab=pre-built-home-settings`. Save extras. Confirm the `frontend_settings` row `landing_page_extras` updates. Flip a new toggle; confirm the key becomes `0`/`1`. Existing motivational speech + old toggles still save.

---

### Task 3: `gp-landing.css` + enqueue

**Files:**
- Create: `assets/design-system/gp-landing.css`
- Modify: `application/views/frontend/default-new/includes_top.php`

Port **layout** from the sample (`feat-trio`, `lms-strip`, `tc-card`, `fn-card`, `cat-chips`, `quiz-banner`, `why` tiles, `instr-card`, `dual-cta`, `cta-band`, `page-hero.ph-light`, `hero-stats`, `hero-search`) but rename tokens to `--gp-*` and prefix wrappers `.gp-landing`.

Required mappings:

| Sample | Use instead |
|---|---|
| `--primary` | `var(--gp-primary)` |
| `--secondary` | `var(--gp-secondary)` |
| `--accent` | `var(--gp-accent)` |
| `--gold` / `--gold-light` / `--gold-deep` | `var(--gp-gold)` / `var(--gp-gold-light)` / `var(--gp-gold-deep)` |
| `--ink` (headings) | `var(--gp-fg)` — **not** `--gp-ink`. `--gp-ink` has no dark-mode override in `gp-tokens.css` (stays `#0d0d0c` in both themes) and is only ever used elsewhere for tooltip backgrounds. `--gp-fg` is the token that actually flips per theme and is what `gp-components-core.css` uses for real text. |
| `--text` (body/sub copy) | `var(--gp-fg-muted)` — same reasoning; `--gp-text` is not dark-aware. Use `--gp-fg-faint` only for the lowest-emphasis captions if needed. |
| `--paper` | `var(--gp-paper)` (this one is already dark-aware, keep as planned) |
| `.btn` | existing `gp_ds_button` markup; do not restyle leftover Hyper `.btn-info` |
| Section eyebrow | DS: Manrope 700, uppercase, `letter-spacing: 0.16em`, `color: var(--gp-secondary)` |
| H2 | Manrope 800, `letter-spacing: 0`, `word-spacing: 0.12em` |
| Card | 14px radius, `var(--gp-border)`, `var(--gp-shadow-card)` |
| Dark band | `var(--gp-accent)` / `var(--gp-accent-2)` gradient like DS `.card-dark` |
| `.gp-landing-btn-on-dark` | white fill, accent text; hover invert (sample dark-band rule) |

Do not import the sample’s contact/awards/word-cloud CSS. Do not set `letter-spacing` on titles except the eyebrow.

**Dark mode:** every color in `gp-landing.css` must be a `--gp-*` token, never a literal hex, so it inherits the existing `[data-theme="dark"]` / `prefers-color-scheme: dark` overrides in `gp-tokens.css` — no separate dark block needed in this file. Use only the tokens that actually have dark-mode values: `--gp-fg` / `--gp-fg-muted` / `--gp-fg-faint` for text (not `--gp-ink` / `--gp-text`, which never change), `--gp-bg` / `--gp-surface` / `--gp-surface-sunk` / `--gp-paper` for backgrounds, `--gp-border` / `--gp-border-strong` for hairlines. Watch two spots specifically: inline SVG icons carrying a literal `stroke`/`fill` hex (e.g. the leftover hero search icon `#1E293B`) go invisible against a dark input in dark mode — replace with `stroke="currentColor"`/`fill="currentColor"` and set `color: var(--gp-fg)` on the wrapper; and the navy CTA band / quiz banner (`--gp-accent` fill) must keep `#fff` text via `gp-landing-btn-on-dark` / hardcoded white, not `--gp-fg`, since that surface stays dark-on-dark in both themes.

In `includes_top.php` after `gp-homepage-builder.css`:

```php
<link rel="stylesheet" href="<?php echo base_url('assets/design-system/gp-landing.css'); ?>?v=landing-1">
```

Bump `gp-public-shell.css` when Task 8 changes it.

---

### Task 4: Hero + feature trio + media strip

**Files:**
- Modify: `application/views/components/main/hero_section_1.php` (replace markup, keep search hook)
- Create: `application/views/components/main/feature_trio.php`
- Create: `application/views/components/main/media_strip.php`

- [ ] **Step 1: Hero**

`hero_section_1.php` structure (hooks in comments must stay):

```php
<?php $gp_h = gp_landing_extras()['hero']; ?>
<section class="gp-landing gp-landing-hero">
    <div class="gp-landing-hero-copy">
        <div class="gp-landing-eyebrow builder-editable" builder-identity="1"><?php echo htmlspecialchars($gp_h['eyebrow']); ?></div>
        <h1>
            <?php echo site_phrase(get_frontend_settings('banner_title')); ?>
            <?php if ($gp_h['accent'] !== ''): ?>
                <span class="gp-landing-accent builder-editable" builder-identity="2"><?php echo htmlspecialchars($gp_h['accent']); ?></span>
            <?php endif; ?>
        </h1>
        <p class="builder-editable" builder-identity="3"><?php echo site_phrase(get_frontend_settings('banner_sub_title')); ?></p>
        <div class="gp-landing-hero-actions">
            <?php echo gp_ds_button($gp_h['cta1_label'], ['variant' => 'primary', 'href' => gp_landing_url($gp_h['cta1_url']), 'extra_class' => 'gp-landing-cta-wide'], true); ?>
            <?php echo gp_ds_button($gp_h['cta2_label'], ['variant' => 'outline', 'href' => gp_landing_url($gp_h['cta2_url'])], true); ?>
        </div>
        <form class="gp-landing-search" action="<?php echo site_url('home/search'); ?>" method="get">
            <input class="form-control" type="text" name="query" placeholder="<?php echo get_phrase('What do you want to learn'); ?>">
            <?php echo gp_ds_button(get_phrase('search'), ['variant' => 'primary', 'type' => 'submit'], true); ?>
        </form>
    </div>
    <div class="gp-landing-stats">
        <?php foreach ($gp_h['stats'] as $i => $stat): ?>
            <div class="gp-landing-stat">
                <div class="num builder-editable" builder-identity="<?php echo 10 + $i; ?>"><?php echo htmlspecialchars($stat['num']); ?></div>
                <div class="lbl builder-editable" builder-identity="<?php echo 20 + $i; ?>"><?php echo htmlspecialchars($stat['lbl']); ?></div>
                <div class="sub builder-editable" builder-identity="<?php echo 30 + $i; ?>"><?php echo htmlspecialchars($stat['sub']); ?></div>
            </div>
        <?php endforeach; ?>
    </div>
</section>
```

Optional banner image: if `get_current_banner('banner_image')` exists, show it under the stats as a single wide image (`builder-identity="40"`). Do not keep the leftover three `banner-card-1` cards — those move to feature trio.

- [ ] **Step 2: Feature trio**

```php
<?php if (! gp_landing_toggle('feature_trio_section')) return; ?>
<?php $gp_trio = gp_landing_extras()['trio']; ?>
<section class="gp-landing gp-landing-trio">
    <div class="container">
        <div class="gp-landing-trio-grid">
            <?php foreach ($gp_trio as $i => $item): ?>
                <div class="gp-landing-feat">
                    <h3 class="builder-editable" builder-identity="<?php echo $i + 1; ?>"><?php echo htmlspecialchars($item['title']); ?></h3>
                    <p class="builder-editable" builder-identity="<?php echo $i + 4; ?>"><?php echo htmlspecialchars($item['text']); ?></p>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
```

- [ ] **Step 3: Media strip**

Hide the whole section if toggle is off **or** all three images and the video URL are empty.

Images: `base_url($media['image_n'])` when the path is set. Video tile: if `video_url` is set, wrap the third image (or a placeholder) in `<a href="<?php echo gp_landing_url($media['video_url']); ?>" target="_blank" rel="noopener">`. Keep `builder-identity` 1–5 on images/title/tag.

- [ ] **Step 4: Visual check**

Load a page that includes only these files (after Task 7 compose) or temporarily include them at the top of `home_1.php`. Confirm search still goes to `home/search?query=`.

---

### Task 5: Courses, function grid, category chips

**Files:**
- Modify: `application/views/components/main/top_courses_1.php`
- Create: `application/views/components/main/function_grid.php`
- Modify: `application/views/components/main/top_categories_1.php`

- [ ] **Step 1: Top courses**

Keep `if (get_frontend_settings('top_course_section') == 1)`. Keep `get_top_courses()`, thumbnail helper, level phrase, ratings math, duration, lesson count, price / free, wishlist heart + `actionTo('home/toggleWishlistItems/{id}/TopCourse')`, `checkPropagation`, course URL `home/course/{slug}/{id}`.

Card chrome: sample `tc-card` — thumb, level badge (`gp_ds_badge` for Beginner/Intermediate/Advanced using existing level phrase), stars, title, hours + lessons, price, Enroll = `gp_ds_button` linking to the course URL. Paid: optional cart control must still use the existing add-to-cart JS already on the theme (if `top_courses_1` currently has no cart button, do **not** invent a new cart API; Enroll-only is enough).

Section head: DS eyebrow leftover `Start Learning Today` + `get_phrase('top_courses')` + existing subtitle phrase.

- [ ] **Step 2: Function grid**

```php
<?php if (! gp_landing_toggle('function_grid_section')) return; ?>
<?php
$gp_extras = gp_landing_extras();
$gp_cats = $this->crud_model->get_categories()->result_array();
?>
<section class="gp-landing gp-landing-functions" id="lms-courses">
    <div class="container">
        <div class="gp-landing-head">
            <div class="gp-landing-eyebrow">The Library</div>
            <h2>Courses by Function</h2>
            <p>Function-specific courses carefully curated to match your company requirements.</p>
        </div>
        <div class="gp-landing-fn-grid">
            <?php foreach ($gp_cats as $gp_cat):
                $count = $this->crud_model->get_category_wise_courses($gp_cat['id'])->num_rows();
                $blurb = isset($gp_extras['function_blurbs'][$gp_cat['id']]) ? $gp_extras['function_blurbs'][$gp_cat['id']] : '';
            ?>
                <a class="gp-landing-fn-card" href="<?php echo site_url('home/courses?category=' . slugify($gp_cat['slug'])); ?>">
                    <h3><?php echo htmlspecialchars($gp_cat['name']); ?></h3>
                    <?php if ($blurb !== ''): ?><p><?php echo htmlspecialchars($blurb); ?></p><?php endif; ?>
                    <span><?php echo (int) $count . ' ' . get_phrase('courses'); ?></span>
                </a>
            <?php endforeach; ?>
        </div>
    </div>
</section>
```

If `get_category_wise_courses` is not the parent-category helper in this install, use the same count method `top_categories` already uses (`get_top_categories` / course_number). Do not write a new query if an existing one works. Confirm the method name in `Crud_model.php` before coding.

- [ ] **Step 3: Category chips**

Keep `top_category_section` toggle and `get_top_categories()`. Markup: `.gp-landing-chips` / `.gp-landing-chip` with name + `{n} courses`. Link `home/courses?category={slug}`. Remove random hex icon colors.

---

### Task 6: Quiz, Why, instructors, dual CTA, CTA band

**Files:**
- Create: `application/views/components/main/quiz_banner.php`
- Create: `application/views/components/main/why_section.php`
- Modify: `application/views/components/main/top_instructors_1.php`
- Modify: `application/views/components/main/promotional_section_1.php`
- Create: `application/views/components/main/cta_band.php`

- [ ] **Step 1: Quiz banner**

If toggle off, return. If `button_url` is empty, render the card without a button (do not fake a quiz). `gp_ds_button` outline/primary + `gp-landing-btn-on-dark` if the card is navy. Geese chevrons are CSS `::before` on `.gp-landing-quiz` (no new image asset required).

- [ ] **Step 2: Why section**

Toggle + `landing.why` tiles/stats. Soft blue background `var(--gp-info-soft)`. Eyebrow/title/text builder-editable.

- [ ] **Step 3: Instructors**

Keep `top_instructor_section` and the existing instructor query. Card: avatar, name, leftover role from existing instructor fields only (`title` / headline if the user row already has one). Do not add a “facilitator role” column.

- [ ] **Step 4: Dual CTA**

Keep `promotional_section` toggle and:

- Learner: `site_url('sign_up')` only if `public_signup == 'enable'`
- Instructor: `allow_instructor == 1`, then logged-in `user/become_an_instructor` else `sign_up?instructor=yes`

Sample copy can be leftover English; existing phrases `join_now_to_start_learning` / `become_a_new_instructor` / `get_started` / `join_now` are preferred.

- [ ] **Step 5: CTA band**

Toggle + navy band + two `gp_ds_button` + footnote. URLs through `gp_landing_url`.

---

### Task 7: Compose `home_1.php`

**Files:**
- Modify: `application/views/frontend/default-new/home_1.php` (replace the file)

Order (sample first, then leftover capabilities):

1. `components/main/hero_section_1.php`
2. `feature_trio.php`
3. `media_strip.php`
4. `top_courses_1.php`
5. `function_grid.php`
6. `top_categories_1.php`
7. `quiz_banner.php`
8. `why_section.php`
9. `top_instructors_1.php`
10. Existing leftover blocks still in `home_1` today: upcoming, latest, motivational, reviews, FAQ, blog — **cut/paste those sections unchanged except wrap their headings in `.gp-landing-head` if easy**. Do not delete them.
11. `promotional_section_1.php`
12. `cta_band.php`

Use `include APPPATH . 'views/components/main/{file}.php';`. Delete the duplicated hero/top-courses/categories/instructors/promotional markup from `home_1` so there is one source.

Remove the leftover `<style>` clamp block at the top of `home_1.php` if the new CSS covers it.

Custom builder: new files appear automatically (directory scan). Existing custom homes that already saved old `hero_section_1` copies are **not** auto-migrated; admin re-adds the block if they want the new look. Document that in the closeout.

---

### Task 8: Header + footer restyle

**Files:**
- Modify: `application/views/frontend/default-new/header.php`
- Modify: `application/views/frontend/default-new/header_lg_device.php`
- Modify: `application/views/frontend/default-new/header_sm_device.php`
- Modify: `application/views/frontend/default-new/footer.php`
- Modify: `assets/design-system/gp-public-shell.css`
- Modify: `includes_top.php` cache `gp-public-shell.css?v=footer-ds-12`

- [ ] **Step 1: Header**

Remove the leftover phone/email/social **sub-header** from `header.php` (those values remain in the footer). Keep `<header class="gp-site-header">`.

Restyle `header_lg_device.php` to the sample sticky bar:

- Logo: existing `dark_logo` → `site_url()`
- Courses: existing `get_categories()` loop + `home/courses?category=` + All Courses. Mega panel two columns; show course count if cheap (reuse existing count helper). Keep addon links (bundle, ebook, etc.) after Courses — do not delete them.
- Custom header pages stay.
- Search: flyout `<form action="<?php echo site_url('home/search'); ?>" method="get">` + `name="query"`.
- Cart: keep `#cartItemsCounter`, `#cartItems`, include `cart_items.php`, checkout `home/shopping_cart`.
- Login `login`, Join Now `sign_up` via `gp_ds_button` (only if public signup enabled). Logged-in menu stays.

Mobile: same destinations in `header_sm_device.php`.

- [ ] **Step 2: Footer**

Keep brand / useful links / contact / subscribe / legal. Align typography and 5-column grid to the sample. Subscribe stays:

`class="ajaxForm resetable gp-foot-subscribe"`  
`action="<?php echo site_url('home/subscribe_to_our_newsletter'); ?>"`  
`id="newsletter-form"`

Do not add a “Programs” column unless those URLs already exist as custom pages (they will already appear in useful links).

---

### Task 9: Browser verification

There is no PHPUnit coverage for these views.

- [ ] **Guest, hard-refresh** `http://localhost/academy/`
  - Header: Courses mega, search submit, cart panel, Login, Join Now
  - Hero search submit
  - Top course opens `home/course/...`
  - Function / chip links open `home/courses?category=`
  - Dual CTA / CTA band destinations
  - Quiz button: no URL → no dead button; with URL → opens it
  - Footer newsletter still posts
  - FAQ / blog / reviews still appear when their old toggles are on
- [ ] **Admin** Pre-Built tab: change eyebrow + turn off feature trio + save. Hard-refresh `/`. Confirm copy and hide.
- [ ] **Dark mode:** flip the existing theme toggle to Dark (and separately confirm the `prefers-color-scheme: dark` / `system` path) on `/`. Every new section (hero, feature trio, media strip, function grid, category chips, quiz banner, why tiles, CTA band) must have readable text — no near-black text on a dark background. Specifically check: hero search icon (must not disappear against a dark input), all `builder-editable` headings/paragraphs (must use `--gp-fg`/`--gp-fg-muted`, not `--gp-ink`/`--gp-text`), and the navy CTA band / quiz banner (white text must stay white, not flip to a dark token).
- [ ] **Narrow viewport** (~375px): hero stack, chips wrap, header drawer. Re-check dark mode at this width too.
- [ ] **Custom builder:** Open Builder on a custom home, add `feature_trio` / `cta_band`, Save. Confirm they appear in the library (file scan). Do not restyle the canvas chrome.

If `/` is not `home_1` (a themed permanent home is Active), activate the `home_1` pre-built **or** add the new blocks on a custom home — do not restyle `home_4` in this plan.

---

## Self-review

**Spec coverage**

| Requirement | Task |
|---|---|
| Audit recorded | Top of this file |
| Existing toggles / data stay | Tasks 5–7 leftover includes |
| Missing blocks added | Tasks 4–6 |
| Admin wired like existing | Tasks 1–2 |
| Looks like sample + DS HTML | Tasks 3, 4–8 |
| No quiz engine | Task 6 |
| Header/footer hooks kept | Task 8 |
| No home_2–7 / canvas JS | Out of scope |

**Placeholders:** none.

**Consistency:** `landing_page_extras`, `gp_landing_extras()`, `gp_landing_url()`, `gp_landing_toggle()`, `update_landing_page_extras()`, `Admin.php` param `landing_page_extras`.
