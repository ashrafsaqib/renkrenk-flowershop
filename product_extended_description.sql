-- Add extended description fields to product_description table
-- short_description: Plain text for bullet points
-- size: HTML description for size information
-- care: HTML description for care instructions
-- delivery: HTML description for delivery information

ALTER TABLE `oc_product_description` 
ADD COLUMN `short_description` TEXT NULL AFTER `description`,
ADD COLUMN `size` TEXT NULL AFTER `short_description`,
ADD COLUMN `care` TEXT NULL AFTER `size`,
ADD COLUMN `delivery` TEXT NULL AFTER `care`;
