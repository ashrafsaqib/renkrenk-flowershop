-- Create product_vase table to link products with vase products
-- Similar to product_related table structure

CREATE TABLE IF NOT EXISTS `oc_product_to_vase` (
  `product_id` int(11) NOT NULL,
  `vase_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`vase_id`),
  KEY `vase_id` (`vase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Add foreign key constraints
ALTER TABLE `oc_product_to_vase`
  ADD CONSTRAINT `fk_product_to_vase_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_product_to_vase_vase` FOREIGN KEY (`vase_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;

-- Note: The vase_id references oc_product table as vases are also products
-- This allows flexibility to link any product as a vase option

-- Example usage after table creation:
-- INSERT INTO oc_product_to_vase (product_id, vase_id) VALUES (123, 456);
-- This would link product 123 with vase product 456
