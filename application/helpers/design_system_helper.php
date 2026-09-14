<?php
defined('BASEPATH') or exit('No direct script access allowed');

/**
 * Phase R8 — new-work mandate (in force 12 Sep 2026 for NEW markup only).
 *
 * From this date, NEW view markup for buttons, badges, alerts, page titles,
 * simple cards, and static tables should call gp_ds_*.
 * Existing pages are not rewritten just to comply.
 * Do not apply this to payment SDK markup, Dropzone, Summernote, or DataTables action HTML.
 *
 * See DESIGN_SYSTEM_REUSABLE_COMPONENTS_PLAN.md Phase R8.
 */

/**
 * True on every shared-shell page unless listed in gp_ds_exclude_pages.
 * Plan rollback for a single page: add its page_name to that exclude list.
 */
function gp_ds_is_active($page_name = '')
{
    $CI = &get_instance();
    $CI->config->load('design_system_pages');
    $exclude = $CI->config->item('gp_ds_exclude_pages');
    if (! is_array($exclude)) {
        $exclude = [];
    }
    return $page_name === '' || ! in_array($page_name, $exclude, true);
}

/**
 * Load a design-system CI partial.
 *
 * @param string $partial  File under views/components/design-system/ (no .php)
 * @param array  $data
 * @param bool   $return
 * @return void|string
 */
function gp_ds_partial($partial, $data = [], $return = false)
{
    $CI = &get_instance();
    return $CI->load->view('components/design-system/' . $partial, $data, $return);
}

function gp_ds_card($data = [], $return = false)
{
    if (! is_array($data)) {
        $data = [];
    }
    // CI persists view vars. An omitted title would reuse the last
    // gp_ds_page_title() $title (e.g. "My Courses" on every course card).
    if (! array_key_exists('title', $data)) {
        $data['title'] = '';
    }
    return gp_ds_partial('card', $data, $return);
}

/**
 * Design-system §14 table.
 * $data keys: headers, rows, extra_class, empty,
 *   table_id, body_html (raw <tr>…), allow_empty (skip empty-state for DataTables), attrs
 *   responsive (wrap in .table-responsive; default off when table_id is set)
 *
 * Keys are remapped so leftover CI view vars (e.g. button $attrs) cannot leak onto the <table>.
 */
function gp_ds_table($data = [], $return = false)
{
    if (! is_array($data)) {
        $data = [];
    }

    $table_id = isset($data['table_id']) ? $data['table_id'] : '';

    return gp_ds_partial('table', [
        'headers'      => (isset($data['headers']) && is_array($data['headers'])) ? $data['headers'] : [],
        'rows'         => (isset($data['rows']) && is_array($data['rows'])) ? $data['rows'] : [],
        'extra_class'  => isset($data['extra_class']) ? $data['extra_class'] : '',
        'empty'        => isset($data['empty']) ? $data['empty'] : null,
        'table_id'     => $table_id,
        'body_html'    => isset($data['body_html']) ? $data['body_html'] : '',
        'allow_empty'  => ! empty($data['allow_empty']),
        'table_attrs'  => (isset($data['attrs']) && is_array($data['attrs'])) ? $data['attrs'] : [],
        'responsive'   => array_key_exists('responsive', $data) ? ! empty($data['responsive']) : ($table_id === ''),
    ], $return);
}

function gp_ds_page_title($title, $actions = '', $return = false)
{
    return gp_ds_partial('page_title_card', [
        'title'   => $title,
        'actions' => $actions,
    ], $return);
}

/**
 * variant: primary | secondary | outline | quiet  (hard-rule §05 only)
 * $options keys allowed: href, tag (a|button), type, extra_class, attrs (assoc array, each value html_escape'd)
 * Do not add onclick helper functions. Callers pass JS hooks via attrs if needed.
 */
function gp_ds_button($label, $options = [], $return = false)
{
    if (! is_array($options)) {
        $options = [];
    }

    $allowed = ['primary', 'secondary', 'outline', 'quiet'];
    $variant = isset($options['variant']) ? $options['variant'] : 'primary';
    if (! in_array($variant, $allowed, true)) {
        $variant = 'primary';
    }

    $href = isset($options['href']) ? $options['href'] : '';
    $tag  = isset($options['tag']) ? $options['tag'] : '';
    if ($tag !== 'a' && $tag !== 'button') {
        $tag = ($href !== '') ? 'a' : 'button';
    }

    $type        = isset($options['type']) ? $options['type'] : 'button';
    $extra_class = isset($options['extra_class']) ? $options['extra_class'] : '';
    $attrs       = (isset($options['attrs']) && is_array($options['attrs'])) ? $options['attrs'] : [];

    return gp_ds_partial('button', [
        'label'       => $label,
        'variant'     => $variant,
        'href'        => $href,
        'tag'         => $tag,
        'type'        => $type,
        'extra_class' => $extra_class,
        'attrs'       => $attrs,
    ], $return);
}

/** tone: primary | secondary | success | warning | danger | neutral */
function gp_ds_badge($label, $tone = 'neutral', $return = false)
{
    $allowed = ['primary', 'secondary', 'success', 'warning', 'danger', 'neutral'];
    if (! in_array($tone, $allowed, true)) {
        $tone = 'neutral';
    }

    return gp_ds_partial('badge', [
        'label' => $label,
        'tone'  => $tone,
    ], $return);
}

/** tone: success | warning | danger | info */
function gp_ds_alert($title, $body = '', $tone = 'info', $return = false)
{
    $allowed = ['success', 'warning', 'danger', 'info'];
    if (! in_array($tone, $allowed, true)) {
        $tone = 'info';
    }

    return gp_ds_partial('alert', [
        'title' => $title,
        'body'  => $body,
        'tone'  => $tone,
    ], $return);
}
