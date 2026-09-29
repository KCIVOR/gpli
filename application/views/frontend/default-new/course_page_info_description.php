<div class="course-description">
    <h3 class="description-head"><?php echo get_phrase('Course Description') ?></h3>
    <?php echo $course_details['description']; ?>
</div>

<?php
    $outcomes = array_filter((array) json_decode($course_details['outcomes']), function ($item) { return trim((string) $item) !== ''; });
    $requirements = array_filter((array) json_decode($course_details['requirements']), function ($item) { return trim((string) $item) !== ''; });
?>

<?php if (!empty($outcomes)) : ?>
<div class="course-description">
    <h3 class="description-head"><?php echo get_phrase('What will i learn?') ?></h3>
    <ul class="step-down">
        <?php foreach ($outcomes as $outcome) : ?>
            <li><?php echo $outcome; ?></li>
        <?php endforeach; ?>
    </ul>
</div>
<?php endif; ?>

<?php if (!empty($requirements)) : ?>
<div class="course-description requirements">
    <h3 class="description-head"><?php echo get_phrase('Requirements') ?></h3>
    <ul>
        <?php foreach ($requirements as $requirement) : ?>
            <li><?php echo $requirement; ?></li>
        <?php endforeach; ?>
    </ul>
</div>
<?php endif; ?>

<?php $faqs = json_decode($course_details['faqs'], true);
    $counter = 0;
  if(is_array($faqs) && count($faqs) > 0): ?>
    <div class="course-description">
        <h3 class="description-head"><?php echo get_phrase('Frequently asked question') ?></h3>

        <div class="faq-accrodion m-0">
            <?php foreach($faqs as $faq_question => $faq): ?>
                <?php ++$counter; ?>
                <div class="accordion">
                    <div class="accordion-item">
                      <h2 class="accordion-header" id="faq<?php echo $counter; ?>">
                        <button class="faq accordion-button collapsed text-18px mt-20px" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-<?php echo $counter; ?>" aria-expanded="false" aria-controls="panelsStayOpen-<?php echo $counter; ?>">
                            <?php echo $faq_question; ?>
                        </button>
                      </h2>
                      <div id="panelsStayOpen-<?php echo $counter; ?>" class="accordion-collapse collapse" aria-labelledby="faq<?php echo $counter; ?>">
                        <div class="accordion-body pt-0">
                            <?php echo $faq; ?>
                        </div>
                      </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
<?php endif; ?>