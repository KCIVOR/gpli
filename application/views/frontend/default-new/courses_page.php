<?php
    $selected_category = isset($_GET['category']) ? $_GET['category'] : 'all';
    $selected_price    = isset($_GET['price']) ? $_GET['price'] : 'all';
    $selected_level    = isset($_GET['level']) ? $_GET['level'] : 'all';
    $selected_language = isset($_GET['language']) ? $_GET['language'] : 'all';
    $selected_rating   = isset($_GET['rating']) ? $_GET['rating'] : 'all';
    $selected_sorting  = isset($_GET['sort_by']) ? $_GET['sort_by'] : 'all';
?>

<div class="gp-catalog-page">
<?php include "breadcrumb.php"; ?>

<section class="gp-catalog">
    <div class="container">
        <header class="gp-catalog-head">
            <div class="eyebrow"><?php echo get_phrase('Catalog'); ?></div>
            <div class="gp-catalog-head-row">
                <h1><?php echo $page_title; ?></h1>
                <p class="gp-catalog-count"><?php echo site_phrase('showing').' '.count($courses).' '.site_phrase('of').' '.$total_result.' '.site_phrase('results'); ?></p>
            </div>
        </header>

        <div class="gp-catalog-layout">
            <aside class="gp-catalog-aside">
                <?php include "courses_page_sidebar.php"; ?>
            </aside>
            <div class="gp-catalog-main">
                <?php include 'courses_page_' . $layout . '_layout.php'; ?>

                <?php if(count($courses) == 0): ?>
                    <div class="not-found gp-catalog-empty">
                        <div class="gp-catalog-empty-icon" aria-hidden="true">＋</div>
                        <h5><?php echo get_phrase('Course Not Found'); ?></h5>
                        <p><?php echo get_phrase('Sorry, try using more similar words in your search.') ?></p>
                        <a class="btn btn-primary" href="<?php echo site_url('home/courses'); ?>"><?php echo get_phrase('Reset'); ?></a>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</section>
</div>


<script type="text/javascript">
    function filterCourse(){
        //sorting value added to the filter form
        var sort_by = $('#sorting_select_input').val();
        $('#sorting_hidden_input').val(sort_by);

        $('#course_filter_form').submit();
    }
</script>
