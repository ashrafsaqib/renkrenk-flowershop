<?php
namespace Opencart\Catalog\Model\Catalog;
/**
 * Class Subscription Plan
 *
 * Can be called using $this->load->model('catalog/subscription_plan');
 *
 * @package Opencart\Catalog\Model\Catalog
 */
class SubscriptionPlan extends \Opencart\System\Engine\Model {
	/**
	 * Get Subscription Plan
	 *
	 * Get the record of the subscription plan record in the database.
	 *
	 * @param int $subscription_plan_id primary key of the subscription plan record
	 *
	 * @return array<string, mixed> subscription plan record that have subscription plan ID
	 *
	 * @example
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $subscription_plan_info = $this->model_catalog_subscription_plan->getSubscriptionPlan($subscription_plan_id);
	 */
	public function getSubscriptionPlan(int $subscription_plan_id): array {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_plan` `sp` LEFT JOIN `" . DB_PREFIX . "subscription_plan_description` `spd` ON (`sp`.`subscription_plan_id` = `spd`.`subscription_plan_id`) WHERE `sp`.`subscription_plan_id` = '" . (int)$subscription_plan_id . "' AND `spd`.`language_id` = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	}

	/**
	 * Get Subscription Plans
	 *
	 * Get the record of the subscription plan records in the database.
	 *
	 * @param array<string, mixed> $data array of filters
	 *
	 * @return array<int, array<string, mixed>> subscription plan records
	 *
	 * @example
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $results = $this->model_catalog_subscription_plan->getSubscriptionPlans();
	 */
	public function getSubscriptionPlans(array $data = []): array {
		$sql = "SELECT * FROM `" . DB_PREFIX . "subscription_plan` `sp` LEFT JOIN `" . DB_PREFIX . "subscription_plan_description` `spd` ON (`sp`.`subscription_plan_id` = `spd`.`subscription_plan_id`) WHERE `spd`.`language_id` = '" . (int)$this->config->get('config_language_id') . "'";

		if (isset($data['filter_status'])) {
			$sql .= " AND `sp`.`status` = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_name'])) {
			$sql .= " AND `spd`.`name` LIKE '" . $this->db->escape($data['filter_name'] . '%') . "'";
		}

		$sort_data = [
			'spd.name',
			'sp.sort_order'
		];

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY `spd`.`name`";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	/**
	 * Get Total Subscription Plans
	 *
	 * Get the total number of total subscription plan records in the database.
	 *
	 * @return int total number of subscription plan records
	 *
	 * @example
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $subscription_plan_total = $this->model_catalog_subscription_plan->getTotalSubscriptionPlans();
	 */
	public function getTotalSubscriptionPlans(): int {
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM `" . DB_PREFIX . "subscription_plan`");

		return (int)$query->row['total'];
	}

	/**
	 * Get Subscription Plan Images
	 *
	 * Get the subscription plan images from the database.
	 *
	 * @param int $subscription_plan_id primary key of the subscription plan record
	 *
	 * @return array<int, array<string, mixed>> subscription plan image records
	 *
	 * @example
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $subscription_plan_images = $this->model_catalog_subscription_plan->getImages($subscription_plan_id);
	 */
	public function getImages(int $subscription_plan_id): array {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_plan_image` WHERE `subscription_plan_id` = '" . (int)$subscription_plan_id . "' ORDER BY `sort_order` ASC");

		return $query->rows;
	}

	/**
	 * Get Frequencies
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $subscription_plan_frequencies = $this->model_catalog_subscription_plan->getFrequencies($subscription_plan_id);
	 */
	public function getFrequencies(int $subscription_plan_id): array {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_plan_frequency` WHERE `subscription_plan_id` = '" . (int)$subscription_plan_id . "' ORDER BY `subscription_plan_frequency_id` ASC");

		return $query->rows;
	}

	/**
	 * Get Durations
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $subscription_plan_durations = $this->model_catalog_subscription_plan->getDurations($subscription_plan_id);
	 */
	public function getDurations(int $subscription_plan_id): array {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_plan_duration` WHERE `subscription_plan_id` = '" . (int)$subscription_plan_id . "' ORDER BY `subscription_plan_duration_id` ASC");

		return $query->rows;
	}

	/**
	 * Get Gifts
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $subscription_plan_gifts = $this->model_catalog_subscription_plan->getGifts($subscription_plan_id);
	 */
	public function getGifts(int $subscription_plan_id): array {
		$query = $this->db->query("SELECT spg.product_id, pd.name FROM `" . DB_PREFIX . "subscription_plan_gift` spg LEFT JOIN `" . DB_PREFIX . "product_description` pd ON (spg.product_id = pd.product_id) WHERE spg.subscription_plan_id = '" . (int)$subscription_plan_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");

		return $query->rows;
	}

	/**
	 * Get Vases
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $subscription_plan_vases = $this->model_catalog_subscription_plan->getVases($subscription_plan_id);
	 */
	public function getVases(int $subscription_plan_id): array {
		$query = $this->db->query("SELECT spv.product_id, pd.name FROM `" . DB_PREFIX . "subscription_plan_vase` spv LEFT JOIN `" . DB_PREFIX . "product_description` pd ON (spv.product_id = pd.product_id) WHERE spv.subscription_plan_id = '" . (int)$subscription_plan_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");

		return $query->rows;
	}

	/**
	 * Get Related Products
	 *
	 * $this->load->model('catalog/subscription_plan');
	 *
	 * $subscription_plan_related = $this->model_catalog_subscription_plan->getRelatedProducts($subscription_plan_id);
	 */
	public function getRelatedProducts(int $subscription_plan_id): array {
		$query = $this->db->query("SELECT spr.product_id, pd.name FROM `" . DB_PREFIX . "subscription_plan_related` spr LEFT JOIN `" . DB_PREFIX . "product_description` pd ON (spr.product_id = pd.product_id) WHERE spr.subscription_plan_id = '" . (int)$subscription_plan_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");

		return $query->rows;
	}
}
