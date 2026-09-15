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
            'video_url_1' => '', 'video_title_1' => '', 'video_tag_1' => 'Featured',
            'video_url_2' => '', 'video_title_2' => '', 'video_tag_2' => 'Featured',
            'video_url_3' => '', 'video_title_3' => 'Stop Losing Top Talent: The 24/7 Solution That Actually Works', 'video_tag_3' => 'Featured',
        ],
        'function_blurbs' => [],
        'section_bg' => [
            'trio' => '', 'functions' => '', 'categories' => '', 'quiz' => '',
            'why' => '', 'instructors' => '', 'dual' => '', 'cta_band' => '',
        ],
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
    $merged = array_replace_recursive($defaults, $data);

    // Migrate the old single-video fields (before the media strip supported
    // 3 videos) into slot 3, so a site that already saved a video keeps
    // showing it under the new per-slot structure without re-entering it.
    if ($merged['media']['video_url_3'] === '' && isset($data['media']['video_url']) && $data['media']['video_url'] !== '') {
        $merged['media']['video_url_3']   = $data['media']['video_url'];
        $merged['media']['video_title_3'] = $data['media']['video_title'] ?? $merged['media']['video_title_3'];
        $merged['media']['video_tag_3']   = $data['media']['video_tag'] ?? $merged['media']['video_tag_3'];
    }

    return $merged;
}

function gp_landing_section_bg_url($key)
{
    $extras = gp_landing_extras();
    $path = isset($extras['section_bg'][$key]) ? $extras['section_bg'][$key] : '';
    return $path !== '' ? base_url($path) : '';
}

function gp_landing_bg_attrs($key)
{
    $url = gp_landing_section_bg_url($key);
    if ($url === '') {
        return ['class' => '', 'style' => ''];
    }
    return [
        'class' => ' gp-landing-has-bg',
        'style' => ' style="background-image:url(\'' . htmlspecialchars($url, ENT_QUOTES) . '\')"',
    ];
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
