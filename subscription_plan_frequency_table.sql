-- Create subscription_plan_frequency table to store multiple frequencies per subscription plan

CREATE TABLE IF NOT EXISTS `oc_subscription_plan_frequency` (
`subscription_plan_frequency_id` int(11) NOT NULL AUTO_INCREMENT,
`subscription_plan_id` int(11) NOT NULL,
`frequency` varchar(10) NOT NULL,
`cycle` smallint(6) NOT NULL,
`duration` smallint(6) NOT NULL,
`price` decimal(10,4) NOT NULL DEFAULT '0.0000',
PRIMARY KEY (`subscription_plan_frequency_id`),
KEY `subscription_plan_id` (`subscription_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Add foreign key constraint (optional but recommended)
ALTER TABLE `oc_subscription_plan_frequency`
ADD CONSTRAINT `fk_subscription_plan_frequency_plan`
FOREIGN KEY (`subscription_plan_id`) 
REFERENCES `oc_subscription_plan` (`subscription_plan_id`) 
ON DELETE CASCADE;
