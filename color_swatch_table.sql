-- Color Swatches Table
-- Note: Either color_code OR image must be provided. Image takes precedence on frontend if both are set.
CREATE TABLE IF NOT EXISTS `oc_color_swatch` (
  `color_swatch_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `color_code` varchar(7) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`color_swatch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
