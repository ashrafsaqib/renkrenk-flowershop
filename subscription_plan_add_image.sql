-- Add image column to subscription_plan table
ALTER TABLE `oc_subscription_plan` ADD COLUMN `image` VARCHAR(255) NOT NULL DEFAULT '' AFTER `sort_order`;
