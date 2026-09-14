<?php
gp_ds_page_title(
    $page_title,
    gp_ds_button(get_phrase('view_sitemap_xml'), [
        'variant' => 'outline',
        'href' => base_url('sitemap.xml'),
        'attrs' => ['target' => '_blank'],
    ], true)
);
?>
<div class="gp-settings-page">
<div class="row">
    <div class="col-xl-6">
        <?php
        ob_start();
        if (!empty($sitemap['value'])) {
            $routes = json_decode($sitemap['value'], true);

            if (is_array($routes)) {
                echo '<div class="list-group">';
                $key = 0;
                foreach ($routes as $url) {
                    $full = base_url(htmlspecialchars($url));
                    echo '<a class="list-group-item" href="' . $full . '" target="_blank"><span>' . (++$key) . '. ' . $full . '</span></a>';
                }
                echo '</div>';
            } else {
                echo '<div class="empty-state"><div class="icon"><i class="mdi mdi-map-marker-off-outline"></i></div><h4>Invalid JSON data.</h4></div>';
            }
        } else {
            echo '<div class="empty-state"><div class="icon"><i class="mdi mdi-map-marker-off-outline"></i></div><h4>No data available in sitemap.</h4></div>';
        }
        gp_ds_card([
            'title' => get_phrase('Static routes'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
    <div class="col-xl-6">
        <?php
        ob_start();
        $key = 0;
        echo '<div class="list-group">';

        foreach ($courses as $url) {
            echo '<a class="list-group-item" href="' . htmlspecialchars($url) . '" target="_blank"><span>' . (++$key) . '. ' . htmlspecialchars($url) . '</span></a>';
        }

        foreach ($categories as $url) {
            echo '<a class="list-group-item" href="' . htmlspecialchars($url) . '" target="_blank"><span>' . (++$key) . '. ' . htmlspecialchars($url) . '</span></a>';
        }

        foreach ($blogs as $url) {
            echo '<a class="list-group-item" href="' . htmlspecialchars($url) . '" target="_blank"><span>' . (++$key) . '. ' . htmlspecialchars($url) . '</span></a>';
        }

        foreach ($blog_categories as $url) {
            echo '<a class="list-group-item" href="' . htmlspecialchars($url) . '" target="_blank"><span>' . (++$key) . '. ' . htmlspecialchars($url) . '</span></a>';
        }

        if (addon_status('ebook')) :
            $ebooks = $this->db->get('ebook', array('is_active', 1))->result_array();
            $ebook_url_array = array();

            foreach ($ebooks as $ebook) {
                $slug = slugify($ebook['title']);
                $ebook_id = $ebook['ebook_id'];
                $url = base_url("ebook/ebook_details/$slug/$ebook_id");
                $ebook_url_array[] = $url;
            }

            foreach ($ebook_url_array as $url) {
                echo '<a class="list-group-item" href="' . htmlspecialchars($url) . '" target="_blank"><span>' . (++$key) . '. ' . htmlspecialchars($url) . '</span></a>';
            }
        endif;
        if (addon_status('course_bundle')) :
            $course_bundles = $this->db->get('course_bundle', array('status', 1))->result_array();
            $course_bundle_url_array = array();

            foreach ($course_bundles as $bundle) {
                $slug = slugify($bundle['title']);
                $bundle_id = $bundle['id'];
                $url = base_url("bundle_details/$bundle_id/$slug");
                $course_bundle_url_array[] = $url;
            }

            foreach ($course_bundle_url_array as $url) {
                echo '<a class="list-group-item" href="' . htmlspecialchars($url) . '" target="_blank"><span>' . (++$key) . '. ' . htmlspecialchars($url) . '</span></a>';
            }
        endif;
        if (addon_status('bootcamp')) :
            $bootcamps = $this->db->get('bootcamp')->result_array();
            $bootcamp_url_array = array();

            foreach ($bootcamps as $bootcamp) {
                $bootcamp_id = $bootcamp['id'];
                $url = base_url("addons/bootcamp/details/$bootcamp_id");
                $bootcamp_url_array[] = $url;
            }

            foreach ($bootcamp_url_array as $url) {
                echo '<a class="list-group-item" href="' . htmlspecialchars($url) . '" target="_blank"><span>' . (++$key) . '. ' . htmlspecialchars($url) . '</span></a>';
            }
        endif;
        echo '</div>';
        gp_ds_card([
            'title' => get_phrase('Dynamic routes'),
            'body' => ob_get_clean(),
            'extra_class' => 'gp-dash-panel',
        ]);
        ?>
    </div>
</div>
</div>
