CREATE TABLE IF NOT EXISTS `oc_subscription_plan_vase` (
  `subscription_plan_vase_id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_plan_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`subscription_plan_vase_id`),
  KEY `subscription_plan_id` (`subscription_plan_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `fk_subscription_plan_vase_plan` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_subscription_plan_vase_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
