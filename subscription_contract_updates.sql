    -- Add subscription metadata columns to subscription table
    ALTER TABLE `oc_subscription`
    ADD COLUMN `subscription_plan_frequency_id` INT(11) DEFAULT 0 AFTER `subscription_plan_id`,
    ADD COLUMN `delivery_date` DATE NULL AFTER `subscription_plan_frequency_id`,
    ADD COLUMN `is_gift` TINYINT(1) DEFAULT 0 AFTER `delivery_date`,
    ADD COLUMN `gift_id` INT(11) DEFAULT 0 AFTER `is_gift`,
    ADD COLUMN `vase_id` INT(11) DEFAULT 0 AFTER `gift_id`,
    ADD COLUMN `duration_id` INT(11) DEFAULT 0 AFTER `vase_id`;

    -- oc_subscription_order table already exists with all required columns
    -- No additional columns needed for subscription order tracking
