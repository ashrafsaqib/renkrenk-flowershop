-- SQL for Product Location Feature
-- This script creates tables to store product availability by country and zone

-- 1. Create product_to_country table to store which countries a product is available in
CREATE TABLE IF NOT EXISTS `oc_product_to_country` (
  `product_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`, `country_id`),
  KEY `product_id` (`product_id`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Create product_to_zone table to store which zones a product is available in
CREATE TABLE IF NOT EXISTS `oc_product_to_zone` (
  `product_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`, `country_id`, `zone_id`),
  KEY `product_id` (`product_id`),
  KEY `country_id` (`country_id`),
  KEY `zone_id` (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Verify the structure (Optional - run these to check if creation was successful)
-- DESCRIBE `oc_product_to_country`;
-- DESCRIBE `oc_product_to_zone`;
