-- Add subscription management columns to support customer self-service actions

-- Add pause/skip functionality columns
-- Note: Run each ALTER statement separately if any columns already exist
ALTER TABLE `oc_subscription`
  ADD COLUMN `paused_until` DATE NULL COMMENT 'Date until which subscription is paused' AFTER `duration_id`;

ALTER TABLE `oc_subscription`
  ADD COLUMN `skip_next_delivery` TINYINT(1) DEFAULT 0 COMMENT 'Skip the next delivery' AFTER `paused_until`;

ALTER TABLE `oc_subscription`
  ADD COLUMN `last_modified_by` VARCHAR(20) DEFAULT 'system' COMMENT 'Who last modified: customer, admin, or system' AFTER `skip_next_delivery`;

-- Extend existing subscription_history table to track customer management actions
-- Note: Run each ALTER statement separately if any columns already exist
ALTER TABLE `oc_subscription_history`
  ADD COLUMN `action_type` VARCHAR(50) NULL COMMENT 'pause, skip, frequency_change, delivery_date_change, plan_change, cancel, resume' AFTER `subscription_status_id`;

ALTER TABLE `oc_subscription_history`
  ADD COLUMN `old_value` TEXT NULL COMMENT 'Previous value (JSON format for complex data)' AFTER `action_type`;

ALTER TABLE `oc_subscription_history`
  ADD COLUMN `new_value` TEXT NULL COMMENT 'New value (JSON format for complex data)' AFTER `old_value`;

ALTER TABLE `oc_subscription_history`
  ADD COLUMN `modified_by` VARCHAR(20) DEFAULT 'customer' COMMENT 'customer, admin, or system' AFTER `comment`;

-- Add index for action_type for better query performance
CREATE INDEX IF NOT EXISTS `idx_action_type` ON `oc_subscription_history` (`action_type`);

-- Add index for better query performance on paused subscriptions
CREATE INDEX IF NOT EXISTS `idx_paused_until` ON `oc_subscription` (`paused_until`);
CREATE INDEX IF NOT EXISTS `idx_skip_next` ON `oc_subscription` (`skip_next_delivery`);
