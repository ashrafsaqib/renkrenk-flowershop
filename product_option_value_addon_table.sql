-- Table structure for product option value addons
CREATE TABLE IF NOT EXISTS `oc_product_option_value_addon` (
  `product_option_value_addon_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `product_option_id` int(11) NOT NULL,
  `product_option_value_id` int(11) NOT NULL,
  `addon_product_id` int(11) NOT NULL,
  PRIMARY KEY (`product_option_value_addon_id`),
  KEY `product_id` (`product_id`),
  KEY `product_option_id` (`product_option_id`),
  KEY `product_option_value_id` (`product_option_value_id`),
  KEY `addon_product_id` (`addon_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
