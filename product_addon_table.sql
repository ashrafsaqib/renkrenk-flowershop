-- Create product_addon table to link products with addon products
-- Similar to product_vase table structure

CREATE TABLE IF NOT EXISTS `oc_product_to_addon` (
  `product_id` int(11) NOT NULL,
  `addon_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`addon_id`),
  KEY `addon_id` (`addon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Add foreign key constraints
ALTER TABLE `oc_product_to_addon`
  ADD CONSTRAINT `fk_product_to_addon_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_product_to_addon_addon` FOREIGN KEY (`addon_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;

-- Note: The addon_id references oc_product table as addons are also products
-- This allows flexibility to link any product as an addon option

-- Example usage after table creation:
-- INSERT INTO oc_product_to_addon (product_id, addon_id) VALUES (123, 456);
-- This would link product 123 with addon product 456
