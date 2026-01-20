-- Add color_swatch_id column to oc_product table
-- This allows directly saving a color swatch to a product

ALTER TABLE `oc_product` 
ADD COLUMN `color_swatch_id` int(11) DEFAULT NULL AFTER `manufacturer_id`;

-- Add index for better query performance
ALTER TABLE `oc_product` 
ADD KEY `color_swatch_id` (`color_swatch_id`);

-- Add foreign key constraint (optional, uncomment if you want cascading deletes)
-- ALTER TABLE `oc_product` 
-- ADD CONSTRAINT `oc_product_ibfk_color_swatch` 
-- FOREIGN KEY (`color_swatch_id`) REFERENCES `oc_color_swatch` (`color_swatch_id`) ON DELETE SET NULL;
