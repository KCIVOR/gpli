<?php
/**
 * GPLI dummy data — 08: assign real, DISTINCT course thumbnails.
 *
 * The GPLI courses were inserted with thumbnail = NULL, which is why they
 * show the theme's generic placeholder image. This script assigns each
 * course its own real photo — no two courses share the same image — pulled
 * from a pool of 92 real, freely-licensed stock photos (Pexels license:
 * free for commercial use, no attribution required) downloaded into
 * assets/frontend/default-new/home/gpli-course-photos/. An earlier version
 * of this script assigned one photo per business function, which looked
 * repetitive once a function had 6+ courses — this version fixes that by
 * assigning per course instead, sorted deterministically by course id so
 * re-running produces the same assignment (not a random reshuffle each time).
 *
 * Why a PHP script and not another .sql file: course thumbnails aren't just
 * a database value — application/models/Crud_model.php::get_course_thumbnail_url()
 * expects an actual .jpg file to exist on disk at an exact path built from
 * the theme name + course id + the course's `last_modified` timestamp. That
 * file has to be copied into place; SQL alone can't do that.
 *
 * HOW TO RUN THIS ON CPANEL — three options, pick whichever you have:
 *
 *   A) SSH (if enabled): php migrations/2026_gpli_data_08_assign_course_thumbnails.php
 *
 *   B) cPanel Cron Job (no SSH needed) — cPanel > Cron Jobs lets you schedule
 *      a command even when the Terminal app is disabled. Add a job with the
 *      command below, set it to run once a few minutes from now (any minute/
 *      hour combination that matches "just once soon"), let it fire, then
 *      DELETE the cron job afterward so it doesn't keep re-running forever:
 *        php /home/YOURUSERNAME/public_html/migrations/2026_gpli_data_08_assign_course_thumbnails.php
 *      (adjust the path to wherever your app actually lives on the server —
 *      check cPanel's File Manager for the exact path, usually shown when
 *      you open this file there).
 *
 *   C) Run it once through your browser (no SSH or Cron needed) — this file
 *      also accepts a one-time secret key as a URL parameter so it's not
 *      wide open to anyone. Change RUN_KEY below to your own random string
 *      first, then visit:
 *        https://yourdomain.com/migrations/2026_gpli_data_08_assign_course_thumbnails.php?key=YOUR_RANDOM_STRING
 *      Delete this file from the server immediately after it runs — leaving
 *      any script that writes to your database reachable by URL is a bad
 *      habit even with a key, and the file has done its job once it's run.
 *
 *   Either way: make sure 2026_gpli_data_01 through _12 have already been
 *   imported first, and that the assets/frontend/default-new/home/gpli-course-photos/
 *   folder (92 images, ~5MB) made it to the server — it's tracked in git
 *   under assets/, so a normal deploy already carries it.
 *
 * Safe to re-run — same courses always get the same photos (deterministic
 * by course id), it only ever overwrites those courses' own thumbnail
 * files, never touches anything else. If you add MORE courses later than
 * the 92-photo pool can uniquely cover, re-running this script will start
 * reusing photos from the start of the pool again — bump the pool by
 * downloading more photos if that happens.
 *
 * Reads real DB credentials from application/config/database.php — no
 * editing needed before running this on a different environment.
 */

// Only relevant for option C (browser access) — CLI (SSH/Cron) runs are
// always allowed since they already require server access to trigger.
define('RUN_KEY', 'change-me-to-a-random-string-before-using-the-browser-option');
if (php_sapi_name() !== 'cli') {
    if (!isset($_GET['key']) || $_GET['key'] !== RUN_KEY || RUN_KEY === 'change-me-to-a-random-string-before-using-the-browser-option') {
        http_response_code(403);
        die("Not authorized. If you're trying to run this via browser, edit RUN_KEY at the top of this file to a real random string first, then visit this URL with ?key=<that string>.\n");
    }
    header('Content-Type: text/plain');
}

$app_root = dirname(__DIR__);
$db_config_file = $app_root . '/application/config/database.php';
if (!file_exists($db_config_file)) {
    die("Could not find application/config/database.php — run this script from inside the project, not a copied-out location.\n");
}

// application/config/database.php guards itself against direct access with
// `defined('BASEPATH') or exit(...)` — define it here so the include works
// standalone, outside CodeIgniter's own bootstrap.
if (!defined('BASEPATH')) {
    define('BASEPATH', true);
}
if (!defined('ENVIRONMENT')) {
    define('ENVIRONMENT', 'production');
}

// The config file defines $db as a local variable when included — capture it.
$db = [];
$active_group = 'default';
$query_builder = true;
include $db_config_file;

if (!isset($db[$active_group])) {
    die("Could not read DB credentials from application/config/database.php.\n");
}
$cfg = $db[$active_group];

$mysqli = new mysqli($cfg['hostname'], $cfg['username'], $cfg['password'], $cfg['database']);
if ($mysqli->connect_error) {
    die('DB connect failed: ' . $mysqli->connect_error . "\n");
}

$theme = 'default-new';
$pool_dir = $app_root . '/assets/frontend/default-new/home/gpli-course-photos/';
$dest_dir = $app_root . '/uploads/thumbnails/course_thumbnails/';
$dest_optimized_dir = $dest_dir . 'optimized/';

if (!is_dir($dest_dir) || !is_dir($dest_optimized_dir)) {
    die("Expected upload directories don't exist:\n  $dest_dir\n  $dest_optimized_dir\nCreate them first (they should already exist from your app's normal install).\n");
}
if (!is_dir($pool_dir)) {
    die("Photo pool directory not found: $pool_dir\n");
}

// Sorted so the assignment is deterministic across runs/environments.
$pool = glob($pool_dir . 'gpli_stock_*.jpg');
sort($pool);
$pool_size = count($pool);
if ($pool_size === 0) {
    die("No photos found in $pool_dir\n");
}

// Every GPLI course lives under one of these 8 top-level category slugs.
$gpli_function_slugs = [
    'hr', 'sales', 'gpli-marketing', 'gpli-operations',
    'customer-support', 'gpli-leadership', 'gpli-management', 'professional-development',
];
$slugs_escaped = array_map(fn($s) => "'" . $mysqli->real_escape_string($s) . "'", $gpli_function_slugs);
$sql = "SELECT c.id, c.last_modified
        FROM course c
        JOIN category cat ON cat.id = c.category_id
        WHERE cat.slug IN (" . implode(',', $slugs_escaped) . ")
        ORDER BY c.id ASC";
$result = $mysqli->query($sql);
if (!$result) {
    die('Query failed: ' . $mysqli->error . "\n");
}

$courses = $result->fetch_all(MYSQLI_ASSOC);
$course_count = count($courses);
if ($course_count > $pool_size) {
    echo "WARNING: $course_count courses but only $pool_size distinct photos available — some repeats are unavoidable until the pool is grown.\n";
}

$count = 0;
foreach ($courses as $i => $row) {
    $src_file = $pool[$i % $pool_size];

    $last_modified = $row['last_modified']; // NULL becomes '' when concatenated, exactly like the PHP that reads it
    $filename = 'course_thumbnail_' . $theme . '_' . $row['id'] . $last_modified . '.jpg';

    copy($src_file, $dest_dir . $filename);
    copy($src_file, $dest_optimized_dir . $filename);
    $count++;
}

echo "Done. Assigned distinct thumbnails to $count courses from a pool of $pool_size photos.\n";
