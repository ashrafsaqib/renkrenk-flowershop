-- Migration to add color_swatch_id column to existing product_to_color table
-- Run this if you already have the product_to_color table without the color_swatch_id column

-- Add the color_swatch_id column
ALTER TABLE `oc_product_to_color` 
ADD COLUMN `color_swatch_id` int(11) NOT NULL DEFAULT 0 AFTER `color_id`;

-- Add index for performance
ALTER TABLE `oc_product_to_color` 
ADD KEY `color_swatch_id` (`color_swatch_id`);

-- Add foreign key constraint (optional - uncomment if you want strict referential integrity)
-- ALTER TABLE `oc_product_to_color` 
-- ADD CONSTRAINT `oc_product_to_color_ibfk_3` 
-- FOREIGN KEY (`color_swatch_id`) REFERENCES `oc_color_swatch` (`color_swatch_id`) ON DELETE CASCADE;
