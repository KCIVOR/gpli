# Instructor Sales / Payout Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restyle instructor `/user/sales_report`, `/user/payout_report`, and `/user/payout_settings` so every leftover Hyper control uses the existing Geese Project design system — no new look, no new helpers.

**Architecture:** UI-only, in place. Reuse wrappers already loaded on the instructor backend: `.gp-report-page` + `gp-admin-report.css` for sales, `.gp-dash-stats` + `.gp-users-page` for payout, `.gp-settings-page` + `gp-admin-settings.css` for payout settings. Keep every form `action` / `name` / `id`, DataTables id, daterangepicker hook, and modal hook. Do not edit `User.php`, models, or `common_scripts.php`.

**Tech Stack:** CodeIgniter 3 PHP views, existing `gp_ds_*` helpers (`page_title`, `button`, `card`, `badge`, `alert`, `table`), `--gp-*` tokens, Chart-free DataTables + leftover daterangepicker restyled with tokens.

**Source of truth:** `assets/design-system/reference/geeseprojdesignsystem.html`, `assets/design-system/gp-tokens.css`, `legacy-ui-redesign.md`.

**Do not commit** unless the user explicitly asks.

---

## Standing constraints (every task)

- Helpers only: `gp_ds_button` (`primary` / `secondary` / `outline` / `quiet`), `gp_ds_badge`, `gp_ds_alert`, `gp_ds_card`, `gp_ds_table`, `gp_ds_page_title`. `gp_ds_button` html_escapes labels — no raw `<i>` in the label.
- Compose mashed labels with spaces or an existing complete key. Do not invent phrase keys.
- CSS scoped under `.gp-ds`. Do not invent a third instructor-report stylesheet.
- Confirm dialogs stay `confirm_modal()` / `#alert-modal` / `#update_link`.
- Admin chrome buttons stay compact (existing wrapper CSS already does this).
- Stop after each page for a visual check before starting the next page.

## File map

| File | Role |
|---|---|
| `application/views/backend/user/sales_report.php` | Live `/user/sales_report` (`page_name` = `sales_report`) |
| `application/views/backend/user/payout_report.php` | Live `/user/payout_report` (`page_name` = `payout_report`) |
| `application/views/backend/user/request_withdrawal.php` | Ajax modal opened from payout report |
| `application/views/backend/user/payment_settings.php` | Live `/user/payout_settings` (`page_name` = `payment_settings`) |
| `assets/design-system/gp-admin-report.css` | Date toolbar + DataTables skin for `.gp-report-page` |
| `assets/design-system/gp-admin-users.css` | Table / button / badge skin for `.gp-users-page` |
| `assets/design-system/gp-admin-settings.css` | Form / alert skin for `.gp-settings-page` |
| `application/views/backend/includes_top.php` | Cache query strings only if those CSS files change |

**Do not touch:** `application/controllers/User.php`, `application/views/backend/common_scripts.php`, `application/views/backend/user/invoice.php`, addons, blog, course add/edit.

**Reference implementations (copy structure, not admin URLs):**
- Sales toolbar + card: `application/views/backend/admin/admin_revenue.php`
- Payout table + users wrapper: `application/views/backend/admin/instructor_payout.php`
- Settings form + warning: `application/views/backend/admin/payment_settings.php` (wrapper only; keep instructor gateway loop)

There is no PHPUnit / Jest coverage for these views. Verification is a logged-in instructor browser pass (hard-refresh) after each task.

---

### Task 1: Sales report — date toolbar + list

**Files:**
- Modify: `application/views/backend/user/sales_report.php` (replace entire file)
- Modify: `assets/design-system/gp-admin-report.css` (header comment + table id note only)
- Modify: `application/views/backend/includes_top.php` (bump `gp-admin-report.css` cache if the CSS file changes)

**Hooks that must remain exactly:**
- `action="<?php echo site_url('user/sales_report/filter_by_date_range') ?>"` `method="get"`
- `#reportrange` with `data-toggle="date-picker-range"` `data-target-display="#selectedValue"` `data-cancel-class="btn-light"`
- `#selectedValue`, `#date_range` `name="date_range"`
- `#submit-button` `onclick="update_date_range();"`
- `#sales-report-datatable` (not `#basic-datatable`)
- `initDataTable(["#sales-report-datatable"], 50);`
- `function update_date_range()` copying `#selectedValue` HTML into `#date_range`
- Course link `home/course/{slug}/{id}` `target="_blank"`
- Columns: course name (title + enrolled user + enrolment date + optional coupon) and instructor revenue (plus total amount)

- [ ] **Step 1: Confirm leftover controls on the live page**

Open `http://localhost/academy/user/sales_report` as an instructor. Confirm leftover `btn-info` Filter, leftover Hyper date chrome, leftover green coupon pill, leftover circular/Hyper pager. If the URL redirects to login, stay logged in as instructor.

- [ ] **Step 2: Replace `sales_report.php` with the DS layout**

Overwrite `application/views/backend/user/sales_report.php` with:

```php
<?php gp_ds_page_title(get_phrase('Sales') . ' ' . get_phrase('report')); ?>

<div class="gp-report-page">
    <?php
    ob_start();
    ?>
    <form class="gp-report-toolbar-form" action="<?php echo site_url('user/sales_report/filter_by_date_range'); ?>" method="get">
        <div class="gp-report-date-field">
            <div class="form-group">
                <div id="reportrange" class="form-control" data-toggle="date-picker-range" data-target-display="#selectedValue" data-cancel-class="btn-light">
                    <i class="mdi mdi-calendar"></i>&nbsp;
                    <span id="selectedValue"><?php echo date("F d, Y", $timestamp_start) . " - " . date("F d, Y", $timestamp_end); ?></span> <i class="mdi mdi-menu-down"></i>
                </div>
                <input id="date_range" type="hidden" name="date_range" value="<?php echo date("d F, Y", $timestamp_start) . " - " . date("d F, Y", $timestamp_end); ?>">
            </div>
        </div>
        <?php echo gp_ds_button(get_phrase('filter'), [
            'variant' => 'primary',
            'type'    => 'submit',
            'attrs'   => [
                'id'      => 'submit-button',
                'onclick' => 'update_date_range();',
            ],
        ], true); ?>
    </form>
    <?php
    gp_ds_card([
        'title'       => '',
        'body'        => ob_get_clean(),
        'extra_class' => 'gp-dash-panel gp-report-toolbar',
    ]);
    ?>

    <?php
    ob_start();
    ?>
    <div class="table-responsive-sm">
        <table id="sales-report-datatable" class="table table-striped table-centered mb-0">
            <thead>
                <tr>
                    <th><?php echo get_phrase('course_name'); ?></th>
                    <th><?php echo get_phrase('instructor_revenue'); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($payment_history as $payment) :
                    $course_data = $this->db->get_where('course', array('id' => $payment['course_id']))->row_array();
                    $user_data = $this->db->get_where('users', array('id' => $payment['user_id']))->row_array(); ?>
                    <tr class="gradeU">
                        <td>
                            <strong><a href="<?php echo site_url('home/course/' . rawurlencode(slugify($course_data['title'])) . '/' . $course_data['id']); ?>" target="_blank"><?php echo $course_data['title']; ?></a></strong><br>
                            <small class="text-muted">
                                <strong><?php echo get_phrase('enrolled_user'); ?></strong>: <?php echo $user_data['first_name'] . ' ' . $user_data['last_name']; ?>
                            </small><br>
                            <small class="text-muted"><strong><?php echo get_phrase('enrolment_date') . '</strong>: ' . date('D, d-M-Y h:i:s', $payment['date_added']); ?></small>
                            <?php if ($payment['coupon']) : ?>
                                <small class="d-block">
                                    <span class="text-muted"><?php echo get_phrase('coupon_applied'); ?> :</span>
                                    <?php echo gp_ds_badge($payment['coupon'], 'success', true); ?>
                                </small>
                            <?php endif; ?>
                        </td>
                        <td>
                            <?php echo currency($payment['instructor_revenue']); ?><br>
                            <small class="text-muted"><strong><?php echo get_phrase('total_amount') . '</strong>: ' . currency($payment['amount']); ?></small>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <?php
    gp_ds_card([
        'title'       => get_phrase('Sales') . ' ' . get_phrase('report'),
        'body'        => ob_get_clean(),
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>

<script type="text/javascript">
    function update_date_range() {
        var x = $("#selectedValue").html();
        $("#date_range").val(x);
    }

    $(document).ready(function() {
        initDataTable(["#sales-report-datatable"], 50);
    });
</script>
```

- [ ] **Step 3: Mark sales_report in report CSS**

In `assets/design-system/gp-admin-report.css`, change the in-scope list to:

```css
 * In-scope page_name values:
 *   admin_revenue, instructor_revenue, purchase_history, invoice,
 *   sales_report (instructor /user/sales_report)
```

And add `#sales-report-datatable` to the hooks comment:

```css
 *   #basic-datatable, #sales-report-datatable, tr.gradeU
```

If any selector currently targets only `#basic-datatable` for table chrome, duplicate it for `#sales-report-datatable`. Existing `.gp-report-page table` rules already cover both — do not invent new colors.

- [ ] **Step 4: Bump CSS cache only if Step 3 changed CSS rules**

In `application/views/backend/includes_top.php`, if `gp-admin-report.css` gained new selectors, bump `?v=report-3` to `?v=report-4`. Comment-only edits do not require a bump.

- [ ] **Step 5: Visual check — stop here**

Hard-refresh `/user/sales_report` (Ctrl+F5). Check Light and Dark.

Must pass:
- Title reads as words with spaces (not `Salesreport`)
- Filter is a compact DS primary button (not leftover cyan `btn-info`)
- Date field uses `--gp-*` surface/border; opening the leftover daterangepicker menu is restyled (not leftover Hyper white/cyan)
- Filter still posts `date_range` and reloads the table
- Table search / pager use DS pagination (not leftover circular Hyper pager)
- Coupon (if any row has one) is `gp_ds_badge`, not leftover green Hyper
- Course title still opens the public course in a new tab

Do not start Task 2 until this check passes.

---

### Task 2: Payout report — stats + list + request button

**Files:**
- Modify: `application/views/backend/user/payout_report.php` (replace entire file)
- Modify: `assets/design-system/gp-admin-users.css` (header + small delete-on-stat rule)
- Modify: `application/views/backend/includes_top.php` (bump `gp-admin-users.css` if CSS rules change)

**Hooks that must remain exactly:**
- `showAjaxModal(site_url('modal/popup/request_withdrawal'), get_phrase('request_a_new_withdrawal'))`
- `confirm_modal(site_url('user/withdrawal/delete'))` only when `$requested_withdrawal_amount > 0`
- `#basic-datatable`
- Amount display: `$total_pending_amount > 0 ? currency(...) : currency_code_and_symbol().''.$total_pending_amount` (same for requested when zero)
- Table columns: `#`, payout amount (+ requested_at badge when `!$payout['status']`), payment type or pending badge, date processed when `$payout['status'] && !empty($payout['last_modified'])`

Remove leftover Hyper `bg-danger` / `bg-success` / `bg-info` widgets and leftover `btn-danger` / `btn-outline-primary btn-rounded`.

- [ ] **Step 1: Confirm leftover controls on the live page**

Open `http://localhost/academy/user/payout_report`. Confirm leftover red/green/cyan money cards, leftover rounded Add pill, leftover table pager, leftover pink delete on requested amount.

- [ ] **Step 2: Replace `payout_report.php`**

Overwrite `application/views/backend/user/payout_report.php` with:

```php
<?php
gp_ds_page_title(
    get_phrase('Payout') . ' ' . get_phrase('report'),
    gp_ds_button(get_phrase('request_a_new_withdrawal'), [
        'href'    => 'javascript:void(0)',
        'variant' => 'outline',
        'attrs'   => [
            'onclick' => "showAjaxModal('" . site_url('modal/popup/request_withdrawal') . "', '" . get_phrase('request_a_new_withdrawal') . "')",
        ],
    ], true)
);
?>

<div class="gp-users-page">
    <div class="gp-dash-stats">
        <div class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="mdi mdi-currency-usd"></i></span>
            <span class="gp-dash-stat-value"><?php echo $total_pending_amount > 0 ? currency($total_pending_amount) : currency_code_and_symbol() . '' . $total_pending_amount; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Pending') . ' ' . get_phrase('amount'); ?></span>
        </div>
        <div class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="mdi mdi-currency-usd"></i></span>
            <span class="gp-dash-stat-value"><?php echo $total_payout_amount > 0 ? currency($total_payout_amount) : currency_code_and_symbol() . '' . $total_payout_amount; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('total_payout_amount'); ?></span>
        </div>
        <div class="gp-dash-stat">
            <span class="gp-dash-stat-icon"><i class="mdi mdi-currency-usd"></i></span>
            <span class="gp-dash-stat-value"><?php echo $requested_withdrawal_amount > 0 ? currency($requested_withdrawal_amount) : currency_code_and_symbol() . '' . $requested_withdrawal_amount; ?></span>
            <span class="gp-dash-stat-label"><?php echo get_phrase('Requested') . ' ' . get_phrase('withdrawal'); ?></span>
            <?php if ($requested_withdrawal_amount > 0): ?>
                <?php echo gp_ds_button(get_phrase('delete_requested_withdrawal'), [
                    'href'    => 'javascript:void(0)',
                    'variant' => 'outline',
                    'extra_class' => 'gp-payout-stat-action',
                    'attrs'   => [
                        'onclick' => "confirm_modal('" . site_url('user/withdrawal/delete') . "');",
                    ],
                ], true); ?>
            <?php endif; ?>
        </div>
    </div>

    <?php
    ob_start();
    foreach ($payouts->result_array() as $key => $payout):
    ?>
        <tr class="gradeU">
            <td><?php echo ++$key; ?></td>
            <td>
                <?php echo currency($payout['amount']); ?>
                <?php if (!$payout['status']): ?>
                    <br><small><?php echo '<strong>' . get_phrase('requested_at') . '</strong>: ' . date('D, d M Y', $payout['date_added']); ?></small>
                <?php endif; ?>
            </td>
            <td>
                <?php if ($payout['status']): ?>
                    <?php echo ucfirst($payout['payment_type']); ?>
                <?php else: ?>
                    <?php gp_ds_badge(get_phrase('pending'), 'warning'); ?>
                <?php endif; ?>
            </td>
            <td>
                <?php if ($payout['status'] && !empty($payout['last_modified'])): ?>
                    <?php echo date('D, d M Y', $payout['last_modified']); ?>
                <?php endif; ?>
            </td>
        </tr>
    <?php
    endforeach;
    $payout_table = gp_ds_table([
        'table_id'    => 'basic-datatable',
        'extra_class' => 'mb-0',
        'headers'     => [
            '#',
            get_phrase('payout_amount'),
            get_phrase('payment_type'),
            get_phrase('date_processed'),
        ],
        'body_html'   => ob_get_clean(),
        'allow_empty' => true,
    ], true);
    gp_ds_card([
        'title'       => get_phrase('Payout') . ' ' . get_phrase('report'),
        'body'        => $payout_table,
        'extra_class' => 'gp-dash-panel',
    ]);
    ?>
</div>
```

Remove the leftover unused `update_date_range` script from this file (payout report has no date picker). Do not add a new date filter. Capture `gp_ds_table(..., true)` into `$payout_table`, then pass that string into `gp_ds_card`.

- [ ] **Step 3: Scope payout CSS under `.gp-users-page`**

In `assets/design-system/gp-admin-users.css` header, add:

```css
 *   payout_report (instructor /user/payout_report)
```

Add this rule (tokens only) so the delete control sits under the requested amount:

```css
.gp-ds .gp-users-page .gp-payout-stat-action {
  margin-top: 8px;
  width: auto !important;
  min-width: 0;
  align-self: flex-start;
}
```

`.gp-dash-stats` is already 4 columns in `gp-dashboard.css`. Three tiles will leave an empty fourth slot on wide screens. Add this scoped override (do not change the global dashboard grid):

```css
.gp-ds .gp-users-page .gp-dash-stats {
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

@media (max-width: 1199.98px) {
  .gp-ds .gp-users-page .gp-dash-stats {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 575.98px) {
  .gp-ds .gp-users-page .gp-dash-stats {
    grid-template-columns: 1fr;
  }
}
```

- [ ] **Step 4: Bump users CSS cache**

In `application/views/backend/includes_top.php`, change `gp-admin-users.css?v=users-4` to `?v=users-5`.

- [ ] **Step 5: Visual check — report chrome only**

Hard-refresh `/user/payout_report`. Check Light and Dark.

Must pass:
- Three DS stat tiles (not leftover red/green/cyan)
- Request button is compact outline in the title row; click still opens the ajax modal
- Delete requested withdrawal (if amount > 0) is compact outline, still calls `confirm_modal('.../user/withdrawal/delete')`
- `#basic-datatable` search / pager are DS (not leftover circular)
- Pending rows still show the warning badge

Do not start Task 3 until this check passes. Modal look is Task 3.

---

### Task 3: Request withdrawal modal

**Files:**
- Modify: `application/views/backend/user/request_withdrawal.php` (replace entire file)

**Hooks that must remain exactly:**
- Existing PHP: `$total_pending_amount` queries including `addon_status('ebook')` and `addon_status('tutor_booking')` sums — copy the current PHP at the top of the file unchanged
- Branch 1: `$requested_withdrawals->num_rows() > 0` alert
- Branch 2: `$total_pending_amount == 0` alert
- Branch 3: `form.required-form` `action="<?php echo site_url('user/withdrawal/request'); ?>"` `method="post"` `enctype="multipart/form-data"`
- Hidden `name="id"` = session user id
- `name="withdrawal_amount"` `id="withdrawal_amount"` `type="number"` `min="0"` `max="<?php echo $total_pending_amount; ?>"` `required`
- Submit is `type="button"` `onclick="checkRequiredFields()"` — not a native submit

- [ ] **Step 1: Replace modal markup only**

Keep the PHP block that computes `$total_pending_amount` and `$requested_withdrawals` exactly as it is today (ebook + tutor_booking addons). Replace only the three branches below that PHP with:

```php
<div class="gp-users-page gp-users-modal">
<?php if ($requested_withdrawals->num_rows() > 0): ?>
    <?php gp_ds_alert(get_phrase('oops') . '!', get_phrase('you_already_requested_a_withdrawal') . ' ' . get_phrase('if_you_want_to_make_another') . ', ' . get_phrase('you_have_to_delete_the_requested_one_first'), 'danger'); ?>
<?php elseif ($total_pending_amount == 0): ?>
    <?php gp_ds_alert(get_phrase('oops') . '!', get_phrase('you_got_nothing_to_withdraw'), 'danger'); ?>
<?php else: ?>
    <form class="required-form" action="<?php echo site_url('user/withdrawal/request'); ?>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<?php echo $this->session->userdata('user_id'); ?>">
        <div class="form-group">
            <label for="withdrawal_amount"><?php echo get_phrase('withdrawal_amount'); ?></label>
            <input type="number" class="form-control" name="withdrawal_amount" id="withdrawal_amount" aria-describedby="withdrawal_amount-help" placeholder="<?php echo get_phrase('withdrawal_amount_has_to_be_less_than_or_equal_to') . ' ' . $total_pending_amount; ?>" min="0" max="<?php echo $total_pending_amount; ?>" required>
            <small id="withdrawal_amount-help" class="form-text text-muted"><?php echo get_phrase('withdrawal_amount_has_to_be_less_than_or_equal_to') . ' ' . $total_pending_amount; ?></small>
        </div>
        <?php
        gp_ds_button(get_phrase('request'), [
            'variant' => 'primary',
            'type'    => 'button',
            'attrs'   => [
                'onclick' => 'checkRequiredFields()',
            ],
        ]);
        ?>
    </form>
<?php endif; ?>
</div>
```

`gp_ds_alert` html_escapes the body. That is acceptable for these phrase-only strings.

- [ ] **Step 2: Visual check — modal**

On `/user/payout_report`, click Request a new withdrawal.

Must pass:
- Modal chrome is DS (header / body / footer from `gp-modal.css`), not leftover Hyper
- Alert branches use DS alert (dot + tokens), not leftover `alert-danger` Hyper
- When the form shows: field still named `withdrawal_amount`, Request still runs `checkRequiredFields()`
- Cancel / close still works

Do not start Task 4 until this check passes.

---

### Task 4: Payout settings

**Files:**
- Modify: `application/views/backend/user/payment_settings.php` (replace entire file)
- Modify: `assets/design-system/gp-admin-settings.css` (header comment only unless a field leaks leftover Hyper)
- Modify: `application/views/backend/includes_top.php` (bump `gp-admin-settings.css` only if rules change)

**Hooks that must remain exactly:**
- `action="<?php echo site_url('user/payout_settings/paypal_settings'); ?>"` `method="post"` `enctype="multipart/form-data"`
- `name="gateways[<?php echo $payment_gateway['identifier']; ?>][<?php echo $index; ?>]"`
- `id="<?php echo $payment_gateway['identifier'].$index; ?>"`
- Hidden gateways: `d-none` when `$payment_gateway['status'] != 1 || !addon_status($payment_gateway['identifier']) && $payment_gateway['is_addon'] == 1`
- Existing `$user_data` / `$payment_keys` / `$paypal_keys` / `$stripe_keys` / `$razorpay_keys` assignments at the top (leave them; do not “clean up”)

Do not invent phrase keys for the two English warning sentences. Keep that copy as-is inside `gp_ds_alert` body, or keep it as raw paragraphs under a `gp_ds_alert` title. Prefer title `get_phrase('be_careful') . '!'` and keep the two English sentences as the alert body (they will be html_escaped — they are plain text today).

- [ ] **Step 1: Confirm leftover controls**

Open `http://localhost/academy/user/payout_settings`. Confirm leftover boxed form, leftover Save, leftover yellow warning card.

- [ ] **Step 2: Replace `payment_settings.php`**

Overwrite with:

```php
<?php
$user_data    = $this->user_model->get_user($this->session->userdata('user_id'))->row_array();
$payment_keys = json_decode($user_data['payment_keys'], true);
$paypal_keys  = $payment_keys['paypal'];
$stripe_keys  = $payment_keys['stripe'];
$razorpay_keys = $payment_keys['razorpay'];
?>
<?php gp_ds_page_title(get_phrase('setup_payment_informations')); ?>

<div class="gp-settings-page">
    <div class="row">
        <div class="col-md-8">
            <?php
            ob_start();
            ?>
            <form action="<?php echo site_url('user/payout_settings/paypal_settings'); ?>" method="post" enctype="multipart/form-data">
                <?php
                $payment_gateways = $this->db->get('payment_gateways')->result_array();
                foreach ($payment_gateways as $key => $payment_gateway):
                    $keys = json_decode($payment_gateway['keys'], true);
                    $user_keys = json_decode($user_data['payment_keys'], true);
                    ?>
                    <div class="<?php if ($payment_gateway['status'] != 1 || !addon_status($payment_gateway['identifier']) && $payment_gateway['is_addon'] == 1) echo 'd-none'; ?>">
                        <h4><?php echo get_phrase($payment_gateway['title']); ?></h4>
                        <?php foreach ($keys as $index => $value):
                            if (array_key_exists($payment_gateway['identifier'], $user_keys)) {
                                if (array_key_exists($index, $user_keys[$payment_gateway['identifier']])) {
                                    $value = $user_keys[$payment_gateway['identifier']][$index];
                                } else {
                                    $value = '';
                                }
                            } else {
                                $value = '';
                            }
                            ?>
                            <div class="form-group row mb-3">
                                <label class="col-md-3 col-form-label" for="<?php echo $payment_gateway['identifier'] . $index; ?>"><?php echo get_phrase($index); ?></label>
                                <div class="col-md-9">
                                    <input type="text" id="<?php echo $payment_gateway['identifier'] . $index; ?>" name="gateways[<?php echo $payment_gateway['identifier']; ?>][<?php echo $index; ?>]" value="<?php echo $value; ?>" class="form-control">
                                    <small class="text-muted"><?php echo get_phrase('required_for_instructor'); ?></small>
                                </div>
                            </div>
                        <?php endforeach; ?>
                        <hr>
                    </div>
                <?php endforeach; ?>
                <?php
                gp_ds_button(get_phrase('save_changes'), [
                    'variant' => 'primary',
                    'type'    => 'submit',
                ]);
                ?>
            </form>
            <?php
            gp_ds_card([
                'title'       => get_phrase('setup_your_payment_settings'),
                'body'        => ob_get_clean(),
                'extra_class' => 'gp-dash-panel',
            ]);
            ?>
        </div>
        <div class="col-md-4">
            <?php gp_ds_alert(get_phrase('be_careful') . '!', 'Just configure the payment gateway you want to use, leave the rest blank. Also, make sure that you have configured your payment settings correctly', 'warning'); ?>
        </div>
    </div>
</div>
```

- [ ] **Step 3: Mark payment_settings in settings CSS**

In `assets/design-system/gp-admin-settings.css` in-scope list, ensure instructor is named:

```css
 *   payment_settings (admin + instructor /user/payout_settings)
```

Do not add new tokens. Existing `.gp-settings-page` form-control / label / button rules already apply.

- [ ] **Step 4: Visual check — settings**

Hard-refresh `/user/payout_settings`. Check Light and Dark.

Must pass:
- Title and section heads have readable word spacing
- Inputs use `--gp-*` (not leftover lavender/white Hyper)
- Save is compact DS primary
- Warning is DS alert
- Disabled/addon gateways stay `d-none`
- Saving still posts `gateways[...][...]` to `user/payout_settings/paypal_settings` and returns with the flash message

---

### Task 5: Cross-page regression

- [ ] **Step 1: Re-open the three URLs after all restyles**

1. `/user/sales_report` — filter a date range, open a course link, confirm pager
2. `/user/payout_report` — open request modal, cancel it; if a requested amount exists, confirm the delete confirm modal still uses the DS confirm (do not actually delete unless you intend to)
3. `/user/payout_settings` — change nothing required; confirm Save still works
4. `/user/dashboard` and `/user/courses` — confirm they still look as previously restyled (shared CSS bumps)

- [ ] **Step 2: Leftover-skin audit (live page, not just PHP)**

On each of the three pages, reject the phase if any of these remain: leftover `btn-info` / `btn-danger` / `btn-rounded`, leftover circular pager, leftover Hyper date-range menu, leftover hex `#727cf5` / `#39afd1` / `#0acf97` / `#08c`.

---

## Self-review

1. **Spec coverage:** Sales toolbar + table → Task 1. Payout stats + table + request button → Task 2. Withdrawal modal → Task 3. Settings form + warning → Task 4. Regression → Task 5.
2. **Placeholders:** None. Each replace block is full file content. Payout card wrap warning is explicit (`$payout_table` then `gp_ds_card`).
3. **Type consistency:** Hooks named the same in every task (`#reportrange`, `#sales-report-datatable`, `#basic-datatable`, `gateways[{identifier}][{index}]`, `checkRequiredFields`).
4. **TDD:** No view unit tests exist; browser checks are the verification steps.
5. **Commits:** Not part of this plan unless the user asks.
