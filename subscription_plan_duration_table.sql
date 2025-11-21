CREATE TABLE IF NOT EXISTS `oc_subscription_plan_duration` (
  `subscription_plan_duration_id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_plan_id` int(11) NOT NULL,
  `duration` int(11) NOT NULL COMMENT 'Duration in months',
  `label` varchar(255) NOT NULL,
  `price` decimal(15,4) NOT NULL,
  PRIMARY KEY (`subscription_plan_duration_id`),
  KEY `subscription_plan_id` (`subscription_plan_id`),
  CONSTRAINT `fk_subscription_plan_duration` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
