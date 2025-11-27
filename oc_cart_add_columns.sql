-- Migration: add subscription support columns to `oc_cart`
-- Simple, idempotent SQL for MySQL 8+ (JSON supported)

ALTER TABLE `oc_cart`
  ADD COLUMN  `subscription_plan_id` INT(11) NOT NULL DEFAULT 0 AFTER `product_id`,
  ADD COLUMN  `override` JSON NULL AFTER `subscription_plan_id`;

CREATE INDEX  `idx_cart_subscription_plan` ON `oc_cart` (`subscription_plan_id`);

-- Back up your DB before running migrations.
