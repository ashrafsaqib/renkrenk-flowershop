-- Add subscription metadata columns to order_subscription (idempotent where supported)
ALTER TABLE `oc_order_subscription`
  ADD COLUMN  `subscription_plan_frequency_id` INT(11) DEFAULT 0 AFTER `subscription_plan_id`,
  ADD COLUMN  `delivery_date` DATETIME NULL AFTER `subscription_plan_frequency_id`,
  ADD COLUMN  `is_gift` TINYINT(1) DEFAULT 0 AFTER `delivery_date`,
  ADD COLUMN `gift_id` INT(11) DEFAULT 0 AFTER `is_gift`,
  ADD COLUMN   `vase_id` INT(11) DEFAULT 0 AFTER `gift_id`;
