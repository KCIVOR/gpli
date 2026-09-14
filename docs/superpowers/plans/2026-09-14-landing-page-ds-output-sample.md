# Public Landing Page Design System — Sample Output Specification

> **Reference Plan:** [2026-09-14-landing-page-ds-plan.md](file:///c:/xampp/htdocs/academy/docs/superpowers/plans/2026-09-14-landing-page-ds-plan.md)  
> **Interactive Preview HTML:** [landing_page_preview.html](file:///c:/xampp/htdocs/academy/docs/superpowers/plans/landing_page_preview.html)  
> **Target Framework:** CodeIgniter 3 + Geese Project Design System (`.gp-ds` / `--gp-*`)  
> **Status:** Sample Output & Technical Specification Document  

---

## 1. Executive Summary & Design System Foundations

This document provides the complete sample output of the Public Landing Page Design System implementation plan. It details the visual presentation, rendered Markdown mockups, component architecture, CSS tokens, and admin JSON payload according to the strict constraints of the plan.

### 1.1 Color Palette & Token Tokens

| Token | Hex Value | Role & Usage |
|---|---|---|
| `--gp-primary` | `#003BA6` | Primary brand blue; main CTAs, active links, primary badge background |
| `--gp-primary-hover` | `#002D80` | Hover state for primary actions |
| `--gp-secondary` | `#CD182A` | Brand crimson red; section eyebrows, video tag highlights |
| `--gp-accent` | `#00215D` | Deep navy; prominent headings (H1/H2), dark container backgrounds |
| `--gp-accent-2` | `#00163E` | Midnight navy; gradients, dark CTA band base |
| `--gp-gold` | `#FCD01C` | Accent gold; H1 highlighted span, play button, footer brand accent |
| `--gp-gold-light` | `#FFF8D6` | Subtle gold tint for highlights |
| `--gp-gold-deep` | `#D4A700` | Gold hover / border borders |
| `--gp-ink` | `#0F172A` | Slate 900; body text color |
| `--gp-text-muted` | `#64748B` | Slate 500; subtitles, metadata, lesson counts |
| `--gp-paper` | `#FFFFFF` | Pure white; card backgrounds, button text on dark |
| `--gp-bg` | `#F8FAFC` | Light grey background for alternating sections (courses) |
| `--gp-info-soft` | `#F0F5FF` | Soft blue tint for Why Section container |
| `--gp-border` | `#E2E8F0` | Subtle borders on cards, navigation, and separators |

### 1.2 Typography & Spacing Rules

- **Headings (H1, H2, H3, H4)**: `font-family: 'Manrope', sans-serif; font-weight: 800; letter-spacing: 0; word-spacing: 0.12em;`
- **Section Eyebrows**: `font-family: 'Manrope', sans-serif; font-weight: 700; font-size: 0.825rem; color: var(--gp-secondary); text-transform: uppercase; letter-spacing: 0.16em;`
- **Body & Meta**: `font-family: 'Inter', sans-serif; font-weight: 400/500/600; line-height: 1.6;`
- **Action Buttons**: `font-family: 'Manrope', sans-serif; font-weight: 800; font-size: 0.9rem; text-transform: uppercase; border-radius: 10px; padding: 14px 28px; word-spacing: 0.16em;`
- **Cards**: `border-radius: 14px; border: 1px solid var(--gp-border); box-shadow: 0 10px 30px -5px rgba(0, 33, 93, 0.08);`

---

## 2. Rendered Landing Page Output (Visual & Structural Simulation)

Below is the complete section-by-section simulated output of the live landing page when rendered in `home_1.php`.

```
====================================================================================================
[HEADER]  (Sticky Chrome - White Glassmorphism 95% + Blur)
  [LOGO] GPLI ACADEMY    Courses ▾   Functions   Why GPLI   Instructors   |  [🔍] [🛒 2]  [LOG IN]  [JOIN NOW]
====================================================================================================
```

### Section 1: Hero Section (`hero_section_1.php`)

```markdown
<div align="center">

**THE #1 LEARNING PLATFORM FOR SMES**  
*(Uppercase, Manrope 700, Crimson #CD182A, Spacing 0.16em)*

# Empower Your Workforce from <ins style="color:#D4A700;text-decoration:none">Great to World Class</ins>
*(Manrope 800, Deep Navy #00215D with Gold Accent Span)*

Access enterprise-grade business training curated specifically for growing companies and SMEs.  
*(Inter 400, Slate #64748B, Max Width 640px)*

[ GET STARTED ] (Primary Blue #003BA6)       [ EXPLORE COURSES ] (Outline Blue)

---

🔍 [ What do you want to learn today? (e.g. Sales, HR, Leadership)             ]  [ SEARCH ]
*(Full-width encapsulated search bar with direct submission to home/search)*

</div>

| 100+ | 8 | 2hrs | SME |
| :---: | :---: | :---: | :---: |
| **Expert Courses** | **Business Functions** | **Avg. Course Length** | **Focused Content** |
| One subscription, full library | HR to operations to strategy | Built for microlearning | Tailored for SME realities |
```

---

### Section 2: Feature Trio (`feature_trio.php`)

```markdown
| 📚 **100+ Online Courses** | 🎓 **Expert Instruction** | 💡 **Smart Solution** |
| :--- | :--- | :--- |
| Explore a variety of fresh business topics designed to elevate your team's skillset. | Find the right course, taught by seasoned executive practitioners and trainers. | Learn on your own schedule, at your own pace, on any device. |
*(Cards with 14px radius, white background, soft shadow, subtle hover elevation)*
```

---

### Section 3: Media & Video Strip (`media_strip.php`)

```markdown
+----------------------------------------------------+-------------------------+-------------------------+
| [FEATURED KEYNOTE]                                 |                         |                         |
| ▶ (Gold Circular Play Button)                      |                         |                         |
|                                                    |      [PHOTO TILE 1]     |      [PHOTO TILE 2]     |
| Stop Losing Top Talent: The 24/7 Solution That     |    Interactive Team     |   Executive Coaching    |
| Actually Works                                     |        Workshop         |         Session         |
| (Video Overlay with dark gradient & direct link)   |                         |                         |
+----------------------------------------------------+-------------------------+-------------------------+
```

---

### Section 4: Top Featured Courses (`top_courses_1.php`)

```markdown
<div align="center">

**START LEARNING TODAY**  
## Top Featured Courses  
Hand-picked, high-impact modules for managers, team leads, and business owners.

</div>

| Card 1: Executive Leadership | Card 2: Financial Literacy | Card 3: B2B Sales Ops |
| :--- | :--- | :--- |
| ![Thumb](https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=360) | ![Thumb](https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=360) | ![Thumb](https://images.unsplash.com/photo-1552664730-d307ca884978?w=360) |
| `[INTERMEDIATE]` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `[♥]` | `[BEGINNER]` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `[♥]` | `[ADVANCED]` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `[♥]` |
| ★★★★★ (4.9) | ★★★★★ (4.8) | ★★★★★ (5.0) |
| **Executive Leadership & Strategic Talent Management** | **Financial Literacy for Non-Finance Business Owners** | **High-Performance B2B Sales & Revenue Operations** |
| ⏱ 2.5 Hours &nbsp;•&nbsp; 📖 12 Lessons | ⏱ 1.8 Hours &nbsp;•&nbsp; 📖 9 Lessons | ⏱ 3.0 Hours &nbsp;•&nbsp; 📖 15 Lessons |
| **$49.99** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `[ ENROLL ]` | **$39.99** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `[ ENROLL ]` | **$59.99** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `[ ENROLL ]` |
```

---

### Section 5: Courses by Function (`function_grid.php`)

```markdown
<div align="center">

**THE LIBRARY**  
## Courses by Function  
Function-specific courses carefully curated to match your company requirements.

</div>

+-----------------------------------------+-----------------------------------------+
| ### Human Resources                     | ### Sales & Revenue                     |
| Recruitment, talent retention, policy,  | B2B sales strategy, negotiation,        |
| and organizational culture design.      | pipeline, and revenue growth.           |
|                                         |                                         |
| **18 Courses →**                        | **24 Courses →**                        |
+-----------------------------------------+-----------------------------------------+
| ### Executive Leadership                | ### Finance & Accounting                |
| Decision making, change management,     | Cashflow budgeting, financial reports,  |
| crisis navigation, and team coaching.   | valuation, and SME compliance.          |
|                                         |                                         |
| **30 Courses →**                        | **15 Courses →**                        |
+-----------------------------------------+-----------------------------------------+
```

---

### Section 6: Category Chips (`top_categories_1.php`)

```markdown
[ All Categories ]  [ Talent Management (18) ]  [ Digital Transformation (14) ]  [ Agile Operations (22) ]  [ Financial Literacy (15) ]  [ Executive Coaching (12) ]
*(Horizontal flex wrap chips with smooth hover transition and active state)*
```

---

### Section 7: Leadership Quiz Banner (`quiz_banner.php`)

```markdown
+---------------------------------------------------------------------------------------------+
|                                                                                             |
|   DISCOVER YOURSELF                                                                         |
|   ## What's Your Leadership Style?                                                          |
|   Take our free 3-minute quiz to understand your unique leadership approach and get         |
|   personalized course recommendations.                                                      |
|                                                                                             |
|                                                     [ TAKE THE QUIZ NOW → ]                 |
|                                                     *(White on Dark Button)*                |
+---------------------------------------------------------------------------------------------+
*(Navy Blue gradient background --gp-accent to --gp-accent-2 with Geese chevron watermark)*
```

---

### Section 8: Why GPLI Section (`why_section.php`)

```markdown
<div align="center">

**WHY GPLI**  
## Why GP Leadership Institute?  
Our courses are based on the best practices of global companies tailored for SME execution.

</div>

| 💰 **Affordable** | 🎯 **Function Specific** | 🌐 **World-Class Content** |
| :--- | :--- | :--- |
| Low monthly cost makes enterprise-grade training accessible for teams of all sizes. | Courses organized by business function so staff learn exactly what applies to their role. | Created and taught by experienced practitioners who have built real companies. |

<br>

| 100+ | 8 | 2hrs | SME |
| :---: | :---: | :---: | :---: |
| **Professional Courses** | **Business Functions** | **Average Course Length** | **Focused Content** |
*(Soft blue container background var(--gp-info-soft) with subtle borders)*
```

---

### Section 9: Senior Facilitators / Top Instructors (`top_instructors_1.php`)

```markdown
<div align="center">

**WORLD-CLASS MENTORS**  
## Learn from Senior Facilitators  
Seasoned executives and industry leaders ready to share proven strategies.

</div>

| Dr. Elena Rostova | Marcus Vance | Sarah Jenkins | David Chen |
| :---: | :---: | :---: | :---: |
| ![Avatar](https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=160) | ![Avatar](https://images.unsplash.com/photo-1560250097-0b93528c311a?w=160) | ![Avatar](https://images.unsplash.com/photo-1580489944761-15a19d654956?w=160) | ![Avatar](https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=160) |
| **Dr. Elena Rostova** | **Marcus Vance** | **Sarah Jenkins** | **David Chen** |
| Head of Talent & Org Design | Former VP of Sales Growth | Senior Financial Consultant | Agile Operations Specialist |
```

---

### Section 10: Preserved Leftover CMS Sections

As specified in Task 7 of the implementation plan, existing toggled sections remain fully supported and cleanly styled in `.gp-landing-head`:
- **Upcoming Courses** (`upcoming_course_section`)
- **Latest Courses** (`latest_course_section`)
- **Motivational Speech** (`motivational_speech_section`)
- **Client Reviews** (`review_section`)
- **Website FAQ** (`faq_section`)
- **Latest Blogs** (`blog_visibility_on_the_home_page`)

---

### Section 11: Dual Promotional CTA (`promotional_section_1.php`)

```markdown
+--------------------------------------------+--------------------------------------------+
| [ LEARNER CARD - DEEP NAVY #00215D ]       | [ FACILITATOR CARD - CRIMSON #CD182A ]     |
|                                            |                                            |
| ### Join Now to Start Learning             | ### Become a Facilitator                   |
| Empower yourself or your entire team with  | Share your business expertise with         |
| instant access to 100+ business courses.   | thousands of SME leaders worldwide.        |
|                                            |                                            |
| [ GET STARTED NOW ]                        | [ APPLY AS INSTRUCTOR ]                    |
| *(Links to sign_up)*                       | *(Links to sign_up?instructor=yes)*        |
+--------------------------------------------+--------------------------------------------+
```

---

### Section 12: Dark CTA Band (`cta_band.php`)

```markdown
+---------------------------------------------------------------------------------------------+
|                                                                                             |
|                          READY TO TRANSFORM YOUR BUSINESS?                                  |
|            Join SMEs worldwide that have empowered their teams with GPLI.                   |
|                                                                                             |
|                 [ GET STARTED FREE ]            [ EXPLORE COURSES ]                         |
|                 *(White Solid CTA)*             *(White Outline CTA)*                       |
|                                                                                             |
|    Minimum 5 users per subscription • Unlimited access • Professional certificates included|
|                                                                                             |
+---------------------------------------------------------------------------------------------+
*(Gradient Navy background var(--gp-accent) to var(--gp-accent-2) with 0.16em button word-spacing)*
```

---

### Section 13: Footer (`footer.php`)

```markdown
====================================================================================================
GPLI ACADEMY           FUNCTIONS          QUICK LINKS         LEGAL               NEWSLETTER
Empowering businesses  • Human Resources  • All Courses       • Privacy Policy    Get SME insights &
through practical,     • Sales & Growth   • Leadership Quiz   • Terms of Service  course drops:
enterprise education.  • Leadership       • Become Instructor • Refund Policy     [ Enter email ] [JOIN]
                       • Finance & SME    • Pricing Plans     • Support Center
📍 Singapore • Manila • KL
----------------------------------------------------------------------------------------------------
© 2026 GP Leadership Institute. All rights reserved.           Built with GPLI Design System
====================================================================================================
```

---

## 3. Data & Settings Schema Output (`landing_page_extras`)

The following exact JSON structure is stored in the `frontend_settings` table under the key `landing_page_extras`:

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
      {
        "num": "100+",
        "lbl": "Expert Courses",
        "sub": "One subscription, the whole library"
      },
      {
        "num": "8",
        "lbl": "Business Functions",
        "sub": "HR to operations to leadership"
      },
      {
        "num": "2hrs",
        "lbl": "Avg. Course Length",
        "sub": "Built for microlearning"
      },
      {
        "num": "SME",
        "lbl": "Focused Content",
        "sub": "Curated for SME realities"
      }
    ]
  },
  "trio": [
    {
      "title": "100+ Online Courses",
      "text": "Explore a variety of fresh business topics"
    },
    {
      "title": "Expert Instruction",
      "text": "Find the right course, taught by seasoned practitioners"
    },
    {
      "title": "Smart Solution",
      "text": "Learn on your own schedule, at your own pace"
    }
  ],
  "media": {
    "image_1": "",
    "image_2": "",
    "image_3": "",
    "video_url": "",
    "video_title": "Stop Losing Top Talent: The 24/7 Solution That Actually Works",
    "video_tag": "Featured"
  },
  "function_blurbs": {
    "1": "Recruitment, talent retention, organizational policy, and culture design.",
    "2": "B2B sales strategy, negotiation, client management, and revenue growth.",
    "3": "Decision making, change management, crisis navigation, and coaching.",
    "4": "Cashflow budgeting, financial reporting, valuation, and SME compliance."
  },
  "quiz": {
    "eyebrow": "Discover Yourself",
    "title": "What's Your Leadership Style?",
    "text": "Take our free quiz to understand your unique leadership approach.",
    "button_label": "Take the Quiz Now",
    "button_url": "home/quiz"
  },
  "why": {
    "eyebrow": "Why GPLI",
    "title": "Why GP Leadership Institute?",
    "text": "Our courses are based on the best practices of global companies.",
    "tiles": [
      {
        "title": "Affordable",
        "text": "Low monthly cost makes world-class training accessible."
      },
      {
        "title": "Function Specific",
        "text": "Courses organized by business function."
      },
      {
        "title": "World-Class Content",
        "text": "Content created by experienced practitioners."
      }
    ],
    "stats": [
      {
        "num": "100+",
        "lbl": "Professional Courses"
      },
      {
        "num": "8",
        "lbl": "Business Functions"
      },
      {
        "num": "2hrs",
        "lbl": "Average Course Length"
      },
      {
        "num": "SME",
        "lbl": "Focused Content"
      }
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

### 3.1 Toggle Keys in `frontend_settings`

| Key | Default Value | Role |
|---|---|---|
| `feature_trio_section` | `1` | Controls rendering of `feature_trio.php` |
| `media_strip_section` | `1` | Controls rendering of `media_strip.php` |
| `function_grid_section` | `1` | Controls rendering of `function_grid.php` |
| `quiz_banner_section` | `1` | Controls rendering of `quiz_banner.php` |
| `why_section` | `1` | Controls rendering of `why_section.php` |
| `cta_band_section` | `1` | Controls rendering of `cta_band.php` |

---

## 4. Implementation Code Samples (Per File Map)

### 4.1 Helper: `application/helpers/landing_helper.php`

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

---

### 4.2 Hero Component: `application/views/components/main/hero_section_1.php`

```php
<?php $gp_h = gp_landing_extras()['hero']; ?>
<section class="gp-landing gp-landing-hero">
    <div class="container">
        <div class="gp-landing-hero-copy">
            <span class="gp-eyebrow builder-editable" builder-identity="1"><?php echo htmlspecialchars($gp_h['eyebrow']); ?></span>
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
    </div>
</section>
```

---

### 4.3 Feature Trio: `application/views/components/main/feature_trio.php`

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

---

### 4.4 Quiz Banner: `application/views/components/main/quiz_banner.php`

```php
<?php if (! gp_landing_toggle('quiz_banner_section')) return; ?>
<?php $gp_q = gp_landing_extras()['quiz']; ?>
<section class="gp-landing gp-landing-quiz-wrap">
    <div class="container">
        <div class="gp-landing-quiz">
            <div class="gp-landing-quiz-content">
                <span class="gp-eyebrow gp-eyebrow-gold"><?php echo htmlspecialchars($gp_q['eyebrow']); ?></span>
                <h2><?php echo htmlspecialchars($gp_q['title']); ?></h2>
                <p><?php echo htmlspecialchars($gp_q['text']); ?></p>
            </div>
            <?php if (! empty($gp_q['button_url'])): ?>
                <div class="gp-landing-quiz-action">
                    <?php echo gp_ds_button($gp_q['button_label'] . ' →', [
                        'variant' => 'primary',
                        'href' => gp_landing_url($gp_q['button_url']),
                        'extra_class' => 'gp-landing-btn-on-dark'
                    ], true); ?>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>
```

---

### 4.5 Dark CTA Band: `application/views/components/main/cta_band.php`

```php
<?php if (! gp_landing_toggle('cta_band_section')) return; ?>
<?php $gp_c = gp_landing_extras()['cta_band']; ?>
<section class="gp-landing gp-landing-cta-band">
    <div class="container">
        <div class="gp-landing-cta-inner">
            <h2><?php echo htmlspecialchars($gp_c['title']); ?></h2>
            <p><?php echo htmlspecialchars($gp_c['text']); ?></p>
            <div class="gp-landing-cta-actions">
                <?php echo gp_ds_button($gp_c['cta1_label'], [
                    'variant' => 'primary',
                    'href' => gp_landing_url($gp_c['cta1_url']),
                    'extra_class' => 'gp-landing-btn-on-dark'
                ], true); ?>
                <?php echo gp_ds_button($gp_c['cta2_label'], [
                    'variant' => 'outline',
                    'href' => gp_landing_url($gp_c['cta2_url']),
                    'extra_class' => 'gp-landing-btn-on-dark'
                ], true); ?>
            </div>
            <?php if (! empty($gp_c['footnote'])): ?>
                <div class="gp-landing-cta-footnote"><?php echo htmlspecialchars($gp_c['footnote']); ?></div>
            <?php endif; ?>
        </div>
    </div>
</section>
```

---

### 4.6 Page Composition: `application/views/frontend/default-new/home_1.php`

```php
<?php
// Main landing stack (Sample order)
include APPPATH . 'views/components/main/hero_section_1.php';
include APPPATH . 'views/components/main/feature_trio.php';
include APPPATH . 'views/components/main/media_strip.php';
include APPPATH . 'views/components/main/top_courses_1.php';
include APPPATH . 'views/components/main/function_grid.php';
include APPPATH . 'views/components/main/top_categories_1.php';
include APPPATH . 'views/components/main/quiz_banner.php';
include APPPATH . 'views/components/main/why_section.php';
include APPPATH . 'views/components/main/top_instructors_1.php';

// Preserved leftover CMS sections (Kept in order with DS heading wrapper)
if (get_frontend_settings('upcoming_course_section') == 1) {
    include APPPATH . 'views/components/main/upcoming_courses_1.php';
}
if (get_frontend_settings('latest_course_section') == 1) {
    include APPPATH . 'views/components/main/latest_courses_1.php';
}
if (get_frontend_settings('motivational_speech_section') == 1) {
    include APPPATH . 'views/components/main/motivational_speech_1.php';
}
if (get_frontend_settings('review_section') == 1) {
    include APPPATH . 'views/components/main/reviews_1.php';
}
if (get_frontend_settings('faq_section') == 1) {
    include APPPATH . 'views/components/main/faq_section_1.php';
}
if (get_frontend_settings('blog_visibility_on_the_home_page') == 1) {
    include APPPATH . 'views/components/main/latest_blogs_1.php';
}

// Final action closures
include APPPATH . 'views/components/main/promotional_section_1.php';
include APPPATH . 'views/components/main/cta_band.php';
?>
```

---

## 5. Verification Checklist

| Section / Capability | Verification Test | Expected Status |
|---|---|---|
| **Sticky Header** | Scroll viewport down | Header sticks with blur, Courses mega drops, Cart count displays |
| **Hero Search** | Enter "leadership" and click Search | Submits to `home/search?query=leadership` |
| **Top Courses** | Click Heart icon & Click Enroll | Heart triggers `toggleWishlistItems`, Enroll opens course details |
| **Function Grid** | Click category card | Navigates to `home/courses?category={slug}` with category filtered |
| **Quiz Banner** | Test with empty URL and valid URL | Empty: Button hidden. Valid: Opens target URL directly |
| **Why Section** | Inspect background & layout | Light blue background `var(--gp-info-soft)` with 3 tiles + 4 stats |
| **Dual CTA** | Check learner and instructor gates | Respects `public_signup` and `allow_instructor` settings |
| **Admin Toggles** | Toggle off `feature_trio_section` in Admin | Feature trio vanishes on home refresh |
| **Admin JSON Save** | Edit hero eyebrow in Admin Pre-Built tab | Updates `frontend_settings` and reflects on homepage |
| **Mobile (375px)** | Inspect responsive drawer & stacking | Hero stacks vertically, chips wrap, hamburger drawer functions |
