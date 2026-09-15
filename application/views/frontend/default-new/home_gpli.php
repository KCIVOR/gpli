<?php include 'home_gpli_assets.php'; ?>
<?php
/**
 * GP Leadership Institute — homepage.
 * Marketing copy/layout hardcoded from the client-provided landing page
 * design (gpli-lms-landing-package/index.html); Top Courses, Categories,
 * Top Facilitators, and testimonials pull real data the same way
 * home_elegant.php does — never the sample file's own placeholder figures.
 */
$gpli_total_courses    = $this->db->where('status', 'active')->get('course')->num_rows();
$gpli_total_categories = $this->db->get('category')->num_rows();
$gpli_total_students   = $this->db->where('is_instructor', 0)->get('users')->num_rows();

// Admin-edited copy/media (Home Page Builder → hero/trio/media/quiz/why/CTA
// fields). Falls back to the same default English copy this page always
// had when nothing has been saved yet.
$extras = gp_landing_extras();

// Admin-uploaded section backgrounds (Home Page Builder screen) — optional;
// each falls back to its default look when nothing has been uploaded. The
// photo URL is set inline per section (dynamic, from the DB); the
// light/dark-aware tint overlay on top lives in gp-landing-lms.css as
// `.has-bg-photo::before`, using --gp-* tokens so it flips with theme — an
// inline style here couldn't do that. Only these 3 sections got this (hero,
// quiz banner, closing CTA band) — the course/category/facilitator grids
// don't suit a background photo the way a promotional block does.
function gpli_bg_photo_attrs($setting_key)
{
    $bg = get_frontend_settings($setting_key);
    if (!$bg) {
        return ['class' => '', 'style' => ''];
    }
    return [
        'class' => ' has-bg-photo',
        'style' => ' style="background-image:url(' . base_url('uploads/system/' . $bg) . ');background-size:cover;background-position:center;"',
    ];
}
$gpli_hero_bg = gpli_bg_photo_attrs('gpli_hero_background');
$gpli_quiz_bg = gpli_bg_photo_attrs('gpli_quiz_background');
$gpli_cta_bg  = gpli_bg_photo_attrs('gpli_cta_background');

// Colors the last $tail_words of an *existing* get_phrase() string, leaving
// the rest of the heading in its normal default (black/dark) color — most
// of the heading stays plain, only the called-out word(s) pick up a single
// brand accent color. Splits the already-translated string itself rather
// than calling get_phrase() again on a sub-phrase — a new sub-phrase has
// never been seen before, so get_phrase() would insert it lowercased
// ("Gp leadership institute") instead of keeping the casing already stored
// for the real, existing phrase key.
function gpli_two_tone_heading($phrase, $tail_words = 1, $tone = 'blue')
{
    $words = explode(' ', $phrase);
    $tail  = implode(' ', array_splice($words, -$tail_words));
    $head  = implode(' ', $words);
    return trim(htmlspecialchars($head) . ' <span class="gp-two-tone-' . $tone . '">' . htmlspecialchars($tail) . '</span>');
}
?>

<div class="gpli-home">

  <!-- HERO -->
  <section class="page-hero ph-light<?php echo $gpli_hero_bg['class']; ?>"<?php echo $gpli_hero_bg['style']; ?>>
    <div class="ph-grid">
      <div class="ph-copy">
        <div class="eyebrow"><?php echo htmlspecialchars($extras['hero']['eyebrow']); ?></div>
        <?php
          // Admin's "Gold accent word(s)" field, split into the last 2 words
          // (tail, red) vs everything before them (head, blue) — same two-tone
          // treatment as before, now driven by the saved value instead of a
          // fixed phrase.
          $gpli_hero_accent_words = explode(' ', $extras['hero']['accent']);
          $gpli_hero_accent_tail  = implode(' ', array_splice($gpli_hero_accent_words, -2));
          $gpli_hero_accent_head  = implode(' ', $gpli_hero_accent_words);
        ?>
        <h1><?php echo get_phrase('Transform Your Team from'); ?> <span class="gp-two-tone-blue"><?php echo htmlspecialchars($gpli_hero_accent_head); ?></span> <span class="gp-two-tone-red"><?php echo htmlspecialchars($gpli_hero_accent_tail); ?></span></h1>
        <p class="ph-sub"><?php echo site_phrase(get_frontend_settings('banner_sub_title')); ?></p>
        <div class="ph-actions">
          <a class="btn btn-primary" href="<?php echo gp_landing_url($extras['hero']['cta1_url']); ?>"><?php echo htmlspecialchars($extras['hero']['cta1_label']); ?></a>
          <a class="btn btn-outline-blue" href="<?php echo gp_landing_url($extras['hero']['cta2_url']); ?>"><?php echo htmlspecialchars($extras['hero']['cta2_label']); ?></a>
        </div>
        <form class="hero-search" action="<?php echo site_url('home/courses'); ?>" method="get">
          <input type="text" name="search" placeholder="<?php echo get_phrase('What do you want to learn?'); ?>" aria-label="<?php echo get_phrase('Search courses'); ?>">
          <button class="btn btn-primary" type="submit"><?php echo get_phrase('Search'); ?></button>
        </form>
      </div>
      <?php
        // Numbers 1-3 always show the real, live counts (courses/categories/
        // students) rather than the admin's saved "num" — those are kept
        // accurate automatically instead of needing a manual update every
        // time a course is added. Only the labels/sub-text are admin-edited.
        // Stat 4 ("SME") has no live count, so it's fully admin-controlled.
        $gpli_hero_stats = $extras['hero']['stats'];
      ?>
      <div class="hero-stats">
        <div class="stat">
          <div class="num"><?php echo $gpli_total_courses; ?>+</div>
          <div class="lbl"><?php echo htmlspecialchars($gpli_hero_stats[0]['lbl'] ?? 'Expert Courses'); ?></div>
          <div class="sub"><?php echo htmlspecialchars($gpli_hero_stats[0]['sub'] ?? ''); ?></div>
        </div>
        <div class="stat">
          <div class="num"><?php echo $gpli_total_categories; ?></div>
          <div class="lbl"><?php echo htmlspecialchars($gpli_hero_stats[1]['lbl'] ?? 'Business Functions'); ?></div>
          <div class="sub"><?php echo htmlspecialchars($gpli_hero_stats[1]['sub'] ?? ''); ?></div>
        </div>
        <div class="stat">
          <div class="num"><?php echo $gpli_total_students; ?>+</div>
          <div class="lbl"><?php echo htmlspecialchars($gpli_hero_stats[2]['lbl'] ?? 'Learners'); ?></div>
          <div class="sub"><?php echo htmlspecialchars($gpli_hero_stats[2]['sub'] ?? ''); ?></div>
        </div>
        <div class="stat">
          <div class="num"><?php echo htmlspecialchars($gpli_hero_stats[3]['num'] ?? 'SME'); ?></div>
          <div class="lbl"><?php echo htmlspecialchars($gpli_hero_stats[3]['lbl'] ?? 'Focused Content'); ?></div>
          <div class="sub"><?php echo htmlspecialchars($gpli_hero_stats[3]['sub'] ?? ''); ?></div>
        </div>
      </div>
    </div>
  </section>

  <!-- FEATURE TRIO -->
  <?php
    // Icons stay fixed per position (not admin-editable); title/text pull
    // from the admin's "Feature trio" fields.
    $gpli_trio_icons = [
      '<path stroke-linecap="round" stroke-linejoin="round" d="M4 19.5A2.5 2.5 0 016.5 17H20M4 19.5A2.5 2.5 0 006.5 22H20V2H6.5A2.5 2.5 0 004 4.5v15z"/>',
      '<path stroke-linecap="round" stroke-linejoin="round" d="M12 14a4 4 0 100-8 4 4 0 000 8zM4 21a8 8 0 0116 0"/>',
      '<path stroke-linecap="round" stroke-linejoin="round" d="M13 2 3 14h7l-1 8 10-12h-7l1-8z"/>',
    ];
  ?>
  <section class="section-pad gp-landing" style="padding:56px 0;">
    <div class="container">
      <div class="feat-trio">
        <?php foreach ($extras['trio'] as $gpli_trio_i => $gpli_trio_item): ?>
        <div class="feat">
          <div class="feat-icon"><svg viewBox="0 0 24 24"><?php echo $gpli_trio_icons[$gpli_trio_i] ?? $gpli_trio_icons[0]; ?></svg></div>
          <h3><?php echo htmlspecialchars($gpli_trio_item['title']); ?></h3>
          <p><?php echo htmlspecialchars($gpli_trio_item['text']); ?></p>
        </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>

  <!-- PHOTO / VIDEO STRIP -->
  <?php
    // Each image slot falls back to the original default photo when nothing
    // has been uploaded from Home Page Builder yet — same pattern as the
    // hero/quiz/CTA background photos above.
    $gpli_media = $extras['media'];
    $gpli_media_image_1 = $gpli_media['image_1'] !== '' ? base_url($gpli_media['image_1']) : base_url('assets/frontend/default-new/home/gpli-landing/team-highfive.jpg');
    $gpli_media_image_2 = $gpli_media['image_2'] !== '' ? base_url($gpli_media['image_2']) : base_url('assets/frontend/default-new/home/gpli-landing/learner-portrait.jpg');
    $gpli_media_image_3 = $gpli_media['image_3'] !== '' ? base_url($gpli_media['image_3']) : base_url('assets/frontend/default-new/home/gpli-landing/featured-video-thumb.jpg');
    $gpli_media_video_url = gp_landing_url($gpli_media['video_url']);
  ?>
  <section class="section-pad gp-landing" style="padding-top:64px;">
    <div class="container">
      <div class="lms-strip">
        <div class="strip-media">
          <img src="<?php echo $gpli_media_image_1; ?>" alt="<?php echo get_phrase('Team collaborating in the office'); ?>">
        </div>
        <div class="strip-media">
          <img src="<?php echo $gpli_media_image_2; ?>" alt="<?php echo get_phrase('Professional portrait of a learner'); ?>">
        </div>
        <div>
          <?php if ($gpli_media['video_url'] !== ''): ?><a href="<?php echo $gpli_media_video_url; ?>" target="_blank" rel="noopener"><?php endif; ?>
          <div class="strip-media featured-video">
            <img src="<?php echo $gpli_media_image_3; ?>" alt="<?php echo get_phrase('Featured video thumbnail'); ?>">
            <span class="video-tag"><?php echo htmlspecialchars($gpli_media['video_tag']); ?></span>
            <div class="play"><span><svg viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg></span></div>
          </div>
          <?php if ($gpli_media['video_url'] !== ''): ?></a><?php endif; ?>
          <div class="video-caption">
            <h4><?php echo htmlspecialchars($gpli_media['video_title']); ?></h4>
            <span class="pace"><?php echo get_phrase('Self-paced'); ?></span>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- TOP COURSES (real data) -->
  <?php if (get_frontend_settings('top_course_section') == 1): ?>
  <?php $top_courses = $this->crud_model->get_top_courses()->result_array(); ?>
  <?php if (!empty($top_courses)): ?>
  <section class="section-pad bg-muted gp-landing">
    <div class="container">
      <div class="section-head">
        <div class="section-eyebrow"><?php echo get_phrase('Start Learning Today'); ?></div>
        <h2><?php echo gpli_two_tone_heading(get_phrase('Top Courses'), 1, 'blue'); ?></h2>
        <p><?php echo get_phrase('The most popular courses among GPLI learners worldwide.'); ?></p>
      </div>
      <div class="g3">
        <?php foreach ($top_courses as $key => $top_course): ?>
        <?php if ($key == 6) break; ?>
        <?php
          $lessons           = $this->crud_model->get_lessons('course', $top_course['id']);
          $course_duration   = $this->crud_model->get_total_duration_of_lesson_by_course_id($top_course['id']);
          $total_rating      = $this->crud_model->get_ratings('course', $top_course['id'], true)->row()->rating;
          $number_of_ratings = $this->crud_model->get_ratings('course', $top_course['id'])->num_rows();
          $average_rating    = $number_of_ratings > 0 ? ceil($total_rating / $number_of_ratings) : 0;
        ?>
        <div class="tc-card">
          <a href="<?php echo site_url('home/course/' . rawurlencode(slugify($top_course['title'])) . '/' . $top_course['id']); ?>">
            <div class="tc-thumb">
              <img src="<?php echo $this->crud_model->get_course_thumbnail_url($top_course['id']); ?>" alt="<?php echo $top_course['title']; ?>">
              <span class="tc-level"><?php echo ucfirst($top_course['course_type'] ?? get_phrase('Course')); ?></span>
            </div>
          </a>
          <div class="tc-body">
            <div class="tc-rating">
              <span class="stars"><?php echo str_repeat('★', $average_rating) . str_repeat('☆', 5 - $average_rating); ?></span>
              (<?php echo $number_of_ratings; ?> <?php echo get_phrase('Reviews'); ?>)
            </div>
            <a href="<?php echo site_url('home/course/' . rawurlencode(slugify($top_course['title'])) . '/' . $top_course['id']); ?>">
              <h3><?php echo $top_course['title']; ?></h3>
            </a>
            <div class="tc-meta">
              <span><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path stroke-linecap="round" d="M12 7v5l3 3"/></svg><?php echo $course_duration; ?></span>
              <span><svg viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 19.5A2.5 2.5 0 016.5 17H20M4 19.5A2.5 2.5 0 006.5 22H20V2H6.5A2.5 2.5 0 004 4.5v15z"/></svg><?php echo $lessons->num_rows(); ?> <?php echo get_phrase('Lessons'); ?></span>
            </div>
            <div class="tc-foot">
              <?php if ($top_course['is_free_course'] == 1): ?>
              <span class="tc-price free"><?php echo get_phrase('Free'); ?></span>
              <?php elseif ($top_course['discount_flag'] == 1): ?>
              <span class="tc-price"><?php echo currency($top_course['discounted_price']); ?></span>
              <?php else: ?>
              <span class="tc-price"><?php echo currency($top_course['price']); ?></span>
              <?php endif; ?>
              <div class="tc-actions">
                <a class="btn btn-primary" style="padding:10px 18px;" href="<?php echo site_url('home/course/' . rawurlencode(slugify($top_course['title'])) . '/' . $top_course['id']); ?>"><?php echo get_phrase('Enroll Now'); ?></a>
              </div>
            </div>
          </div>
        </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>
  <?php endif; ?>
  <?php endif; ?>

  <!-- CATEGORIES (real data) -->
  <?php if (get_frontend_settings('top_category_section') == 1): ?>
  <?php $top_categories = $this->crud_model->get_top_categories(8, 'sub_category_id'); ?>
  <?php if (!empty($top_categories)): ?>
  <section class="section-pad gp-landing">
    <div class="container">
      <div class="section-head">
        <div class="section-eyebrow"><?php echo get_phrase('Browse By Topic'); ?></div>
        <h2><?php echo gpli_two_tone_heading(get_phrase('Top Categories'), 1, 'red'); ?></h2>
        <p><?php echo get_phrase('Jump straight to the topics GPLI learners search for most.'); ?></p>
      </div>
      <div class="cat-chips">
        <?php foreach ($top_categories as $top_category): ?>
        <?php $category_details = $this->crud_model->get_category_details_by_id($top_category['sub_category_id'])->row_array(); ?>
        <?php if (empty($category_details)) continue; ?>
        <a class="cat-chip" href="<?php echo site_url('home/courses?category=' . $category_details['slug']); ?>">
          <div class="ci"><svg viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 19.5A2.5 2.5 0 016.5 17H20M4 19.5A2.5 2.5 0 006.5 22H20V2H6.5A2.5 2.5 0 004 4.5v15z"/></svg></div>
          <div class="ct">
            <h4><?php echo $category_details['name']; ?></h4>
            <span><?php echo $top_category['course_number']; ?> <?php echo get_phrase('courses'); ?></span>
          </div>
        </a>
        <?php endforeach; ?>
      </div>
    </div>
  </section>
  <?php endif; ?>
  <?php endif; ?>

  <!-- LEADERSHIP QUIZ -->
  <section class="section-pad bg-muted gp-landing">
    <div class="container">
      <div class="quiz-banner<?php echo $gpli_quiz_bg['class']; ?>"<?php echo $gpli_quiz_bg['style']; ?>>
        <div class="ph-flock" aria-hidden="true">
          <div class="ph-chevron" style="top:16%;left:78%;transform:scale(1.1);"></div>
          <div class="ph-chevron" style="top:70%;left:60%;transform:scale(.8);"></div>
        </div>
        <div>
          <div class="eyebrow"><?php echo htmlspecialchars($extras['quiz']['eyebrow']); ?></div>
          <h2><?php echo gpli_two_tone_heading($extras['quiz']['title'], 2, 'red'); ?></h2>
          <p><?php echo htmlspecialchars($extras['quiz']['text']); ?></p>
          <a class="btn btn-white" href="<?php echo gp_landing_url($extras['quiz']['button_url'] !== '' ? $extras['quiz']['button_url'] : 'home/courses'); ?>"><?php echo htmlspecialchars($extras['quiz']['button_label']); ?> →</a>
        </div>
        <div class="quiz-badge">
          <div class="ql1">GP LEADERSHIP</div>
          <div class="ql2">INSTITUTE</div>
          <div class="ql3"><?php echo get_phrase('Founded 2020'); ?> &bull; Canada</div>
        </div>
      </div>
    </div>
  </section>

  <!-- WHY GPLI -->
  <section class="section-pad bg-blue-soft gp-landing">
    <div class="container">
      <div class="section-head">
        <div class="section-eyebrow"><?php echo htmlspecialchars($extras['why']['eyebrow']); ?></div>
        <h2><?php echo gpli_two_tone_heading($extras['why']['title'], 3, 'red'); ?></h2>
        <p><?php echo htmlspecialchars($extras['why']['text']); ?></p>
      </div>
      <div class="g3">
        <?php foreach ($extras['why']['tiles'] as $gpli_why_tile): ?>
        <div class="tile">
          <h3><?php echo htmlspecialchars($gpli_why_tile['title']); ?></h3>
          <p><?php echo htmlspecialchars($gpli_why_tile['text']); ?></p>
        </div>
        <?php endforeach; ?>
      </div>
      <?php $gpli_why_stats = $extras['why']['stats']; ?>
      <div class="why-stats">
        <div class="stat">
          <div class="num"><?php echo $gpli_total_courses; ?>+</div>
          <div class="lbl"><?php echo htmlspecialchars($gpli_why_stats[0]['lbl'] ?? 'Professional Courses'); ?></div>
        </div>
        <div class="stat">
          <div class="num"><?php echo $gpli_total_categories; ?></div>
          <div class="lbl"><?php echo htmlspecialchars($gpli_why_stats[1]['lbl'] ?? 'Business Functions'); ?></div>
        </div>
        <div class="stat">
          <div class="num"><?php echo $gpli_total_students; ?>+</div>
          <div class="lbl"><?php echo htmlspecialchars($gpli_why_stats[2]['lbl'] ?? 'Learners'); ?></div>
        </div>
        <div class="stat">
          <div class="num"><?php echo htmlspecialchars($gpli_why_stats[3]['num'] ?? 'SME'); ?></div>
          <div class="lbl"><?php echo htmlspecialchars($gpli_why_stats[3]['lbl'] ?? 'Focused Content'); ?></div>
        </div>
      </div>
    </div>
  </section>

  <!-- TOP FACILITATORS (real instructors) -->
  <?php $instructors = $this->user_model->get_instructor_list()->result_array(); ?>
  <?php if (!empty($instructors)): ?>
  <section class="section-pad gp-landing">
    <div class="container">
      <div class="section-head">
        <div class="section-eyebrow"><?php echo get_phrase('Learn From The Best'); ?></div>
        <h2><?php echo gpli_two_tone_heading(get_phrase('Top Facilitators'), 1, 'blue'); ?></h2>
        <p><?php echo get_phrase("They efficiently serve GPLI's learners with practices proven at global companies."); ?></p>
      </div>
      <div class="instr-grid">
        <?php foreach ($instructors as $key => $instructor): ?>
        <?php if ($key == 4) break; ?>
        <div class="instr-card">
          <div class="instr-avatar"><img src="<?php echo $this->user_model->get_user_image_url($instructor['id']); ?>" alt="<?php echo $instructor['first_name'] . ' ' . $instructor['last_name']; ?>"></div>
          <h3><?php echo $instructor['first_name'] . ' ' . $instructor['last_name']; ?></h3>
          <div class="role"><?php echo get_phrase('Facilitator'); ?></div>
        </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>
  <?php endif; ?>

  <!-- DUAL CTA -->
  <section class="section-pad bg-muted gp-landing">
    <div class="container">
      <div class="dual-cta">
        <div class="dual-card learner">
          <h3><?php echo get_phrase('Join Now to Start Learning'); ?></h3>
          <p><?php echo get_phrase('Learn from our quality facilitators — unlimited access to 100+ SME-focused courses.'); ?></p>
          <a class="btn btn-white" href="<?php echo site_url('sign_up'); ?>"><?php echo get_phrase('Get Started'); ?></a>
        </div>
        <div class="dual-card facilitator">
          <h3><?php echo get_phrase('Become a GPLI Facilitator'); ?></h3>
          <p><?php echo get_phrase('Teach SME teams worldwide and share your practice with a growing community of learners.'); ?></p>
          <a class="btn btn-white" href="<?php echo site_url('home/become_an_instructor'); ?>"><?php echo get_phrase('Apply Now'); ?></a>
        </div>
      </div>
    </div>
  </section>

  <!-- TESTIMONIALS (real reviews) -->
  <?php if (get_frontend_settings('review_section') == 1): ?>
  <?php $reviews = $this->db->where('ratable_type', null)->where('ratable_id', null)->get('rating')->result(); ?>
  <?php if (!empty($reviews)): ?>
  <section class="section-pad bg-muted gp-landing">
    <div class="container">
      <div class="section-head">
        <h2><?php echo gpli_two_tone_heading(get_phrase('What the people Thinks About Us'), 2, 'red'); ?></h2>
        <p><?php echo get_phrase('It highlights feedback and testimonials from users, reflecting their experiences and satisfaction.'); ?></p>
      </div>
      <div class="testi-grid">
        <?php foreach ($reviews as $key => $review): ?>
        <?php if ($key == 6) break; ?>
        <?php $user_data = $this->db->get_where('users', ['id' => $review->user_id])->row_array(); ?>
        <?php if (empty($user_data)) continue; ?>
        <div class="testi">
          <div class="stars"><?php echo str_repeat('★', (int) $review->rating) . str_repeat('☆', 5 - (int) $review->rating); ?></div>
          <p>&ldquo;<?php echo $review->review; ?>&rdquo;</p>
          <div class="who">
            <img src="<?php echo $this->user_model->get_user_image_url($user_data['id']); ?>" alt="<?php echo $user_data['first_name']; ?>">
            <?php echo $user_data['first_name'] . ' ' . $user_data['last_name']; ?>
          </div>
        </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>
  <?php endif; ?>
  <?php endif; ?>

  <!-- CTA BAND -->
  <section class="cta-band gpli-bg-primary gp-landing<?php echo $gpli_cta_bg['class']; ?>"<?php echo $gpli_cta_bg['style']; ?>>
    <div class="ph-flock" aria-hidden="true">
      <div class="ph-chevron" style="top:14%;left:9%;transform:scale(.9);"></div>
      <div class="ph-chevron" style="top:62%;left:78%;transform:scale(1.45);"></div>
      <div class="ph-chevron" style="top:78%;left:26%;transform:scale(.75);"></div>
    </div>
    <div class="container">
      <h2><?php echo htmlspecialchars($extras['cta_band']['title']); ?></h2>
      <p><?php echo htmlspecialchars($extras['cta_band']['text']); ?></p>
      <div class="cta-actions">
        <a class="btn btn-primary" href="<?php echo gp_landing_url($extras['cta_band']['cta1_url']); ?>"><?php echo htmlspecialchars($extras['cta_band']['cta1_label']); ?></a>
        <a class="btn btn-white" href="<?php echo gp_landing_url($extras['cta_band']['cta2_url']); ?>"><?php echo htmlspecialchars($extras['cta_band']['cta2_label']); ?></a>
      </div>
      <p style="margin-top:22px;font-size:13px;color:rgba(255,255,255,.75);"><?php echo htmlspecialchars($extras['cta_band']['footnote']); ?></p>
    </div>
  </section>

</div>
