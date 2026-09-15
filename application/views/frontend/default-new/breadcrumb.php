<!---------- Page header / breadcrumb (DS) ---------->
<section class="gp-page-header">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="<?php echo site_url(); ?>"><?php echo get_phrase('Home') ?></a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <?php echo $page_title; ?>
                </li>
            </ol>
        </nav>
        <h1 class="gp-page-header-title"><?php echo $page_title; ?></h1>
    </div>
</section>
<!---------- Page header / breadcrumb end ---------->