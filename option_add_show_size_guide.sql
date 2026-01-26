-- Add show_size_guide flag to option table
ALTER TABLE `oc_option`
ADD COLUMN `show_size_guide` TINYINT(1) NOT NULL DEFAULT 0 AFTER `validation`;
