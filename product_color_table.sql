CREATE TABLE IF NOT EXISTS `oc_product_to_color` (
  `product_id` int(11) NOT NULL,
  `color_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`color_id`),
  KEY `color_id` (`color_id`),
  CONSTRAINT `oc_product_to_color_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `oc_product_to_color_ibfk_2` FOREIGN KEY (`color_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
