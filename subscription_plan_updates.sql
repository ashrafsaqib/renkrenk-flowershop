-- SQL Updates for Subscription Plan Enhancement
-- This script adds price field and image support to subscription plans

-- 1. Add price column to subscription_plan table (if not already exists)
ALTER TABLE `oc_subscription_plan` ADD COLUMN `price` DECIMAL(15, 4) NOT NULL DEFAULT 0.0000 AFTER `sort_order`;

-- 2. Create subscription_plan_image table for multiple images
CREATE TABLE IF NOT EXISTS `oc_subscription_plan_image` (
  `subscription_plan_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_plan_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`subscription_plan_image_id`),
  KEY `subscription_plan_id` (`subscription_plan_id`),
  CONSTRAINT `oc_subscription_plan_image_ibfk_1` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Add description column to subscription_plan_description table (if not already exists)
ALTER TABLE `oc_subscription_plan_description` ADD COLUMN `description` LONGTEXT NULL AFTER `name`;

-- Verify the structure (Optional - run these to check if updates were successful)
-- DESCRIBE `oc_subscription_plan`;
-- DESCRIBE `oc_subscription_plan_description`;
-- DESCRIBE `oc_subscription_plan_image`;
