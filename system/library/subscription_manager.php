<?php
namespace Opencart\System\Library;
/**
 * Class SubscriptionManager
 *
 * Common subscription management functionality shared between admin and catalog
 *
 * @package Opencart\System\Library
 */
class SubscriptionManager {
	private $registry;
	
	public function __construct($registry) {
		$this->registry = $registry;
	}
	
	/**
	 * Magic getter to access registry objects
	 */
	public function __get($key) {
		return $this->registry->get($key);
	}
	
	/**
	 * Pause Subscription
	 */
	public function pauseSubscription(int $subscription_id, string $paused_until, string $comment = '', string $modified_by = 'customer'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		// Update subscription
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`paused_until` = '" . $this->db->escape($paused_until) . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		// Log the action
		$this->addSubscriptionHistory($subscription_id, 'pause', null, $paused_until, $comment, $modified_by);
		
		return true;
	}
	
	/**
	 * Resume Subscription
	 */
	public function resumeSubscription(int $subscription_id, string $comment = '', string $modified_by = 'customer'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		$old_value = $subscription['paused_until'];
		
		// Update subscription
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`paused_until` = NULL,
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		// Log the action
		$this->addSubscriptionHistory($subscription_id, 'resume', $old_value, null, $comment, $modified_by);
		
		return true;
	}
	
	/**
	 * Skip Next Delivery
	 */
	public function skipNextDelivery(int $subscription_id, int $skip_count = 1, string $comment = '', string $modified_by = 'customer'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		// Validate skip count
		if ($skip_count < 1) {
			$skip_count = 1;
		}
		
		// Store the current next delivery date for logging
		$skipped_date = $subscription['date_next'];
		
		// Calculate the new next delivery date (skip multiple cycles)
		$current_date = new \DateTime($subscription['date_next']);
		
		// Calculate total cycles to skip
		$cycles_to_skip = (int)$subscription['cycle'] * $skip_count;
		
		switch ($subscription['frequency']) {
			case 'day':
				$current_date->modify('+' . $cycles_to_skip . ' day');
				break;
			case 'week':
				$current_date->modify('+' . $cycles_to_skip . ' week');
				break;
			case 'month':
				$current_date->modify('+' . $cycles_to_skip . ' month');
				break;
			case 'year':
				$current_date->modify('+' . $cycles_to_skip . ' year');
				break;
		}
		
		$new_date_next = $current_date->format('Y-m-d');
		
		// Update subscription with new date
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`date_next` = '" . $this->db->escape($new_date_next) . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		// Log the action with the skipped date and count
		$log_comment = $comment;
		if ($skip_count > 1) {
			$log_comment = 'Skipped ' . $skip_count . ' deliveries. ' . ($comment ? $comment : '');
		}
		$this->addSubscriptionHistory($subscription_id, 'skip', null, $skipped_date, $log_comment, $modified_by);
		
		return true;
	}
	
	/**
	 * Change Subscription Frequency
	 */
	public function changeFrequency(int $subscription_id, int $subscription_plan_frequency_id, string $frequency, int $cycle, string $comment = '', string $modified_by = 'customer'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		$old_value = json_encode([
			'frequency_id' => $subscription['subscription_plan_frequency_id'],
			'frequency' => $subscription['frequency'],
			'cycle' => $subscription['cycle']
		]);
		
		$new_value = json_encode([
			'frequency_id' => $subscription_plan_frequency_id,
			'frequency' => $frequency,
			'cycle' => $cycle
		]);
		
		// Calculate new date_next based on new frequency
		$date_next = date('Y-m-d', strtotime('+' . $cycle . ' ' . $frequency));
		
		// Update subscription
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`subscription_plan_frequency_id` = '" . (int)$subscription_plan_frequency_id . "',
			`frequency` = '" . $this->db->escape($frequency) . "',
			`cycle` = '" . (int)$cycle . "',
			`date_next` = '" . $this->db->escape($date_next) . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		// Log the action
		$this->addSubscriptionHistory($subscription_id, 'frequency_change', $old_value, $new_value, $comment, $modified_by);
		
		return true;
	}
	
	/**
	 * Change Delivery Date
	 */
	public function changeDeliveryDate(int $subscription_id, string $delivery_date, string $comment = '', string $modified_by = 'customer'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		$old_value = $subscription['date_next'];
		
		// Update subscription
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`date_next` = '" . $this->db->escape($delivery_date) . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		// Log the action
		$this->addSubscriptionHistory($subscription_id, 'delivery_date_change', $old_value, $delivery_date, $comment, $modified_by);
		
		return true;
	}
	
	/**
	 * Change Subscription Plan
	 */
	public function changeSubscriptionPlan(int $subscription_id, int $subscription_plan_id, float $price, string $comment = '', string $modified_by = 'customer'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		$old_value = json_encode([
			'plan_id' => $subscription['subscription_plan_id'],
			'price' => $subscription['price']
		]);
		
		$new_value = json_encode([
			'plan_id' => $subscription_plan_id,
			'price' => $price
		]);
		
		// Update subscription
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`subscription_plan_id` = '" . (int)$subscription_plan_id . "',
			`price` = '" . (float)$price . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		// Log the action
		$this->addSubscriptionHistory($subscription_id, 'plan_change', $old_value, $new_value, $comment, $modified_by);
		
		return true;
	}
	
	/**
	 * Change Delivery Address
	 */
	public function changeDeliveryAddress(int $subscription_id, int $address_id, string $comment = '', string $modified_by = 'customer'): bool {
		// Get current address
		$query = $this->db->query("SELECT shipping_address_id FROM `" . DB_PREFIX . "subscription` WHERE subscription_id = '" . (int)$subscription_id . "'");
		
		if (!$query->num_rows) {
			return false;
		}

		$old_address_id = $query->row['shipping_address_id'];

		// Update subscription with new address
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`shipping_address_id` = '" . (int)$address_id . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");

		// Log the change
		$log_comment = 'Delivery address changed from address ID #' . $old_address_id . ' to #' . $address_id;
		if ($comment) {
			$log_comment .= '. Note: ' . $comment;
		}

		$this->addSubscriptionHistory(
			$subscription_id,
			'address_change',
			(string)$old_address_id,
			(string)$address_id,
			$log_comment,
			$modified_by
		);

		return true;
	}
	
	/**
	 * Get Subscription
	 */
	private function getSubscription(int $subscription_id): array {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription` WHERE `subscription_id` = '" . (int)$subscription_id . "'");

		if ($query->num_rows) {
			return [
				'payment_method'  => $query->row['payment_method'] ? json_decode($query->row['payment_method'], true) : [],
				'shipping_method' => $query->row['shipping_method'] ? json_decode($query->row['shipping_method'], true) : []
			] + $query->row;
		}

		return [];
	}
	
	/**
	 * Add Subscription History
	 */
	private function addSubscriptionHistory(int $subscription_id, string $action_type, ?string $old_value, ?string $new_value, string $comment = '', string $modified_by = 'customer'): int {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "subscription_history` SET 
			`subscription_id` = '" . (int)$subscription_id . "',
			`subscription_status_id` = 0,
			`action_type` = '" . $this->db->escape($action_type) . "',
			`old_value` = " . ($old_value !== null ? "'" . $this->db->escape($old_value) . "'" : "NULL") . ",
			`new_value` = " . ($new_value !== null ? "'" . $this->db->escape($new_value) . "'" : "NULL") . ",
			`notify` = 0,
			`comment` = '" . $this->db->escape($comment) . "',
			`modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_added` = NOW()");
		
		return $this->db->getLastId();
	}
}
