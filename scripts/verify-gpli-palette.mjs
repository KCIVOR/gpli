import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { execFileSync } from 'node:child_process';

const read = (path) => readFileSync(resolve(path), 'utf8');
const tokens = read('assets/design-system/gp-tokens.css');
const base = read('assets/design-system/gp-base.css');
const core = read('assets/design-system/gp-components-core.css');
const auth = read('assets/design-system/gp-auth.css');
const landing = read('assets/design-system/gp-landing.css');
const courses = read('assets/design-system/gp-courses.css');
const courseDetail = read('assets/design-system/gp-course-detail.css');
const cart = read('assets/design-system/gp-cart.css');
const student = read('assets/design-system/gp-student.css');
const adminShell = read('assets/design-system/gp-admin-shell.css');
const dashboard = read('assets/design-system/gp-dashboard.css');
const payment = read('assets/design-system/gp-payment.css');
const landingLms = read('assets/design-system/gp-landing-lms.css');
const faq = read('assets/design-system/gp-faq.css');
const publicShell = read('assets/design-system/gp-public-shell.css');
const player = read('assets/playing-page/css/style.css');
const pdfCanvas = read('application/views/lessons/pdf_canvas.php');
const lessonIndex = read('application/views/lessons/index.php');
const plyrConfig = read('application/views/lessons/plyr_config.php');
const progressBar = read('assets/playing-page/css/jQuery-plugin-progressbar.css');
const playIcon = read('assets/playing-page/img/play.svg');
const thumbIcon = read('assets/playing-page/img/thumb.svg');
const replyIcon = read('assets/playing-page/img/reply.svg');
const boot = read('assets/design-system/gp-theme-boot.js');
const toggle = read('assets/design-system/gp-theme-toggle.js');

const expectations = [
  [tokens, '--gp-action: #2563EB;', 'light primary action token'],
  [tokens, '--gp-action-hover: #1D4ED8;', 'light action hover token'],
  [tokens, '--gp-on-action: #FFFFFF;', 'action foreground token'],
  [tokens, '--gp-link: #2563EB;', 'light link token'],
  [tokens, '--gp-heading: #1B2A4A;', 'light heading token'],
  [tokens, '--gp-field-border: #E5E7EB;', 'light field-border token'],
  [tokens, '--gp-placeholder: rgb(29 33 37 / 75%);', 'light placeholder token'],
  [tokens, '--gp-bg: #F8FAFC;', 'light page background'],
  [tokens, '--gp-fg: #1F2937;', 'light foreground'],
  [tokens, '--gp-fg-muted: #6B7280;', 'light muted foreground'],
  [base, 'color: var(--gp-heading);', 'shared heading role mapping'],
  [base, /\.gp-ds h1,[\s\S]*?\.gp-ds h6 \{[\s\S]*?color: var\(--gp-heading\);/, 'shared h1-h6 heading role mapping'],
  [base, 'color: var(--gp-link);', 'shared link role mapping'],
  [core, 'background: var(--gp-action);', 'primary action mapping'],
  [core, 'background: var(--gp-action-hover);', 'primary action hover mapping'],
  [core, 'border-color: var(--gp-field-border);', 'shared field border mapping'],
  [core, '.gp-ds .form-control,', 'Bootstrap field role mapping'],
  [core, 'color: var(--gp-placeholder);', 'shared placeholder role mapping'],
  [auth, 'border-bottom: 1px solid var(--gp-field-border);', 'auth field-border role mapping'],
  [auth, 'border-bottom-color: var(--gp-focus-ring);', 'auth focus role mapping'],
  [auth, /\.gp-ds \.gp-auth-form input:focus-visible,[\s\S]*?outline: 2px solid var\(--gp-focus-ring\);/, 'auth keyboard focus indicator'],
  [auth, 'color: var(--gp-link);', 'auth link role mapping'],
  [landing, /\.gp-ds \.gp-landing-hero h1 \{[\s\S]*?color: var\(--gp-heading\);/, 'landing hero heading role mapping'],
  [landingLms, /\.gp-ds \.gpli-home \.ph-grid h1 \{[\s\S]*?color: var\(--gp-heading\);/, 'GPLI homepage hero heading role mapping'],
  [landingLms, /\.gp-ds \.gpli-home \.btn-primary:hover \{[\s\S]*?background: var\(--gp-action-hover\);[\s\S]*?border-color: var\(--gp-action-hover\);/, 'GPLI homepage primary hover mapping'],
  [landingLms, /\.gp-ds \.gpli-home \.btn-outline-blue:hover \{[\s\S]*?background: var\(--gp-action-hover\);[\s\S]*?border-color: var\(--gp-action-hover\);/, 'GPLI homepage outline hover mapping'],
  [faq, /\.gp-ds \.gp-faq-page-intro h2 \{[\s\S]*?color: var\(--gp-heading\);/, 'FAQ page heading role mapping'],
  [publicShell, /\.gp-ds \.gp-page-header-title \{[\s\S]*?color: var\(--gp-heading\);/, 'public page-header heading role mapping'],
  [auth, /\.gp-ds \.gp-auth-form h1 \{[\s\S]*?color: var\(--gp-heading\);/, 'auth form heading role mapping'],
  [courses, /\.gp-ds \.gp-catalog-head h1 \{[\s\S]*?color: var\(--gp-heading\);/, 'catalog heading role mapping'],
  [courseDetail, /\.gp-ds \.gp-course-hero h1 \{[\s\S]*?color: var\(--gp-heading\);/, 'course-detail heading role mapping'],
  [cart, /\.gp-ds \.gp-cart-head h1 \{[\s\S]*?color: var\(--gp-heading\);/, 'cart heading role mapping'],
  [student, /\.gp-ds \.gp-student-page \.header-title,[\s\S]*?\.gp-ds \.gp-student-page h5 \{/, 'student shared heading role selector'],
  [student, 'color: var(--gp-heading) !important;', 'student shared heading role mapping'],
  [adminShell, '.gp-ds .content-page .header-title,', 'admin and instructor shared heading selector'],
  [adminShell, 'color: var(--gp-heading) !important;', 'admin and instructor shared heading mapping'],
  [dashboard, 'color: var(--gp-link);', 'instructor dashboard link role mapping'],
  [payment, /\.gp-ds \.gp-payment-head h1 \{[\s\S]*?color: var\(--gp-heading\);/, 'payment heading role mapping'],
  [payment, 'background: var(--gp-action) !important;', 'payment action role mapping'],
  [payment, 'background: var(--gp-action-hover) !important;', 'payment hover role mapping'],
  [player, '.gp-ds .course-playing h1,', 'lesson and mobile heading role selector'],
  [player, 'color: var(--gp-heading);', 'lesson and mobile heading role mapping'],
  [pdfCanvas, 'background-color: var(--gp-action);', 'lesson PDF action role mapping'],
  [lessonIndex, 'color: #6B7280;', 'lesson sidebar muted text mapping'],
  [lessonIndex, 'background-color: #E5E7EB;', 'lesson sidebar muted icon surface mapping'],
  [lessonIndex, 'color: #2563EB;', 'lesson sidebar active icon action mapping'],
  [lessonIndex, 'accent-color: #E5E7EB;', 'lesson checkbox border mapping'],
  [pdfCanvas, 'background-color: #2563EB;', 'lesson PDF navigation action mapping'],
  [plyrConfig, 'stroke: #E5E7EB;', 'player progress border mapping'],
  [plyrConfig, 'stroke: #2563EB;', 'player progress action mapping'],
  [progressBar, 'body { background-color:#FFFFFF;}', 'legacy progress body surface mapping'],
  [progressBar, 'background-color: #E5E7EB;', 'legacy progress track border mapping'],
  [progressBar, 'background-color: #2563EB;', 'legacy progress action mapping'],
  [playIcon, 'fill="#2563EB"', 'play icon action mapping'],
  [thumbIcon, 'fill="#2563EB"', 'thumb icon action mapping'],
  [replyIcon, 'fill="#2563EB"', 'reply icon action mapping'],
  [boot, "'#F8FAFC'", 'first-paint light background'],
  [toggle, "'#F8FAFC'", 'theme-toggle light background'],
];

const missing = expectations.filter(([source, expected]) => typeof expected === 'string' ? !source.includes(expected) : !expected.test(source));
let staleCacheRefs = [];
try {
  staleCacheRefs = execFileSync('rg', ['-l', 'color-bridge-1|no-system-1|btn-variants-1', 'application/views'], { encoding: 'utf8' })
    .trim()
    .split(/\r?\n/)
    .filter(Boolean);
} catch (error) {
  if (error.status !== 1) throw error;
}
if (staleCacheRefs.length) missing.push([null, staleCacheRefs.join(', '), 'stale shared-palette cache references']);
if (missing.length) {
  console.error('Missing GPLI palette contract:');
  for (const [, expected, label] of missing) console.error(`- ${label}: ${expected}`);
  process.exit(1);
}

console.log(`GPLI palette contract passed (${expectations.length} assertions).`);
