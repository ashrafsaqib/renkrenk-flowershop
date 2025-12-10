<?php
namespace Opencart\Admin\Model\Sale;
/**
 * Class Subscription
 *
 * Can be loaded using $this->load->model('sale/subscription');
 *
 * @package Opencart\Admin\Model\Sale
 */
class Subscription extends \Opencart\System\Engine\Model {
	/**
	 * Delete Subscription
	 *
	 * Delete subscription record in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->deleteSubscription($subscription_id);
	 */
	public function deleteSubscription(int $subscription_id): void {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "subscription` WHERE `subscription_id` = '" . (int)$subscription_id . "'");

		$this->deleteProducts($subscription_id);
		$this->deleteHistories($subscription_id);
		$this->deleteLogs($subscription_id);
	}

	/**
	 * Edit Remaining
	 *
	 * Edit subscription remaining record in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 * @param int $remaining
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->editRemaining($subscription_id, $remaining);
	 */
	public function editRemaining(int $subscription_id, int $remaining): void {
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET `remaining` = '" . (int)$remaining . "' WHERE `subscription_id` = '" . (int)$subscription_id . "'");
	}

	/**
	 * Edit Date Next
	 *
	 * Edit date next by subscription record in the database.
	 *
	 * @param int    $subscription_id primary key of the subscription record
	 * @param string $date_next
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->editDateNext($subscription_id, $date_next);
	 */
	public function editDateNext(int $subscription_id, string $date_next): void {
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET `date_next` = '" . $this->db->escape($date_next) . "' WHERE `subscription_id` = '" . (int)$subscription_id . "'");
	}

	/**
	 * Delete Subscription By Customer Payment ID
	 *
	 * Delete subscription by customer payment record in the database.
	 *
	 * @param int $customer_payment_id primary key of the customer payment record
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->deleteSubscriptionByCustomerPaymentId($customer_payment_id);
	 */
	public function deleteSubscriptionByCustomerPaymentId(int $customer_payment_id): void {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "subscription` WHERE `customer_payment_id` = '" . (int)$customer_payment_id . "'");
	}

	/**
	 * Get Subscription
	 *
	 * Get the record of the subscription record in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return array<string, mixed> subscription record that has subscription ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $subscription_info = $this->model_sale_subscription->getSubscription($subscription_id);
	 */
	public function getSubscription(int $subscription_id): array {
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
	 * Get Subscription By Order Product ID
	 *
	 * Get the record of the subscriptions by order product records in the database.
	 *
	 * @param int $order_id         primary key of the order record
	 * @param int $order_product_id primary key of the order product record
	 *
	 * @return array<string, mixed> subscription record that has order ID, order product ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $subscription_info = $this->model_sale_subscription->getSubscriptionByOrderProductId($order_id, $order_product_id);
	 */
	public function getSubscriptionByOrderProductId(int $order_id, int $order_product_id): array {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_product` `sp` LEFT JOIN `" . DB_PREFIX . "subscription` `s` ON (`sp`.`subscription_id` = `s`.`subscription_id`) WHERE `sp`.`order_id` = '" . (int)$order_id . "' AND `sp`.`order_product_id` = '" . (int)$order_product_id . "'");

		if ($query->num_rows) {
			return [
				'payment_method'  => $query->row['payment_method'] ? json_decode($query->row['payment_method'], true) : [],
				'shipping_method' => $query->row['shipping_method'] ? json_decode($query->row['shipping_method'], true) : []
			] + $query->row;
		}

		return [];
	}

	/**
	 * Get Subscriptions
	 *
	 * Get the record of the subscription records in the database.
	 *
	 * @param array<string, mixed> $data array of filters
	 *
	 * @return array<int, array<string, mixed>> subscription records
	 *
	 * @example
	 *
	 * $filter_data = [
	 *     'filter_subscription_id'        => 1,
	 *     'filter_order_id'               => 1,
	 *     'filter_customer'               => 'John Doe',
	 *     'filter_subscription_status_id' => 1,
	 *     'filter_date_from'              => '2021-01-01',
	 *     'filter_date_to'                => '2021-01-31',
	 *     'order'                         => 's.subscription_id',
	 *     'sort'                          => 'DESC',
	 *     'start'                         => 0,
	 *     'limit'                         => 10
	 * ];
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $results = $this->model_sale_subscription->getSubscriptions($filter_data);
	 */
	public function getSubscriptions(array $data): array {
		$sql = "SELECT `s`.`subscription_id`, `s`.*, CONCAT(`c`.`firstname`, ' ', `c`.`lastname`) AS `customer`, (SELECT `ss`.`name` FROM `" . DB_PREFIX . "subscription_status` `ss` WHERE `ss`.`subscription_status_id` = `s`.`subscription_status_id` AND `ss`.`language_id` = '" . (int)$this->config->get('config_language_id') . "') AS `subscription_status` FROM `" . DB_PREFIX . "subscription` `s` LEFT JOIN `" . DB_PREFIX . "customer` `c` ON (`s`.`customer_id` = `c`.`customer_id`)";

		$implode = [];

		if (!empty($data['filter_subscription_id'])) {
			$implode[] = "`s`.`subscription_id` = '" . (int)$data['filter_subscription_id'] . "'";
		}

		if (!empty($data['filter_order_id'])) {
			$implode[] = "`s`.`order_id` = '" . (int)$data['filter_order_id'] . "'";
		}

		if (!empty($data['filter_order_product_id'])) {
			$implode[] = "`s`.`order_product_id` = '" . (int)$data['filter_order_product_id'] . "'";
		}

		if (!empty($data['filter_customer_payment_id'])) {
			$implode[] = "`s`.`customer_payment_id` = " . (int)$data['filter_customer_payment_id'];
		}

		if (!empty($data['filter_customer_id'])) {
			$implode[] = "`s`.`customer_id` = " . (int)$data['filter_customer_id'];
		}

		if (!empty($data['filter_customer'])) {
			$implode[] = "LCASE(CONCAT(`o`.`firstname`, ' ', `o`.`lastname`)) LIKE '" . $this->db->escape(oc_strtolower($data['filter_customer']) . '%') . "'";
		}

		if (!empty($data['filter_date_next'])) {
			$implode[] = "DATE(`s`.`date_next`) = DATE('" . $this->db->escape((string)$data['filter_date_next']) . "')";
		}

		if (!empty($data['filter_subscription_status_id'])) {
			$implode[] = "`s`.`subscription_status_id` = '" . (int)$data['filter_subscription_status_id'] . "'";
		}

		if (!empty($data['filter_date_from'])) {
			$implode[] = "DATE(`s`.`date_added`) >= DATE('" . $this->db->escape((string)$data['filter_date_from']) . "')";
		}

		if (!empty($data['filter_date_to'])) {
			$implode[] = "DATE(`s`.`date_added`) <= DATE('" . $this->db->escape((string)$data['filter_date_to']) . "')";
		}

		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}

		$sort_data = [
			's.subscription_id',
			's.order_id',
			's.reference',
			'customer',
			's.subscription_status',
			's.date_added'
		];

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY `s`.`subscription_id`";
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
	 * Get Total Subscriptions
	 *
	 * Get the total number of total subscription records in the database.
	 *
	 * @param array<string, mixed> $data array of filters
	 *
	 * @return int total number of subscription records
	 *
	 * @example
	 *
	 * $filter_data = [
	 *     'filter_subscription_id'        => 1,
	 *     'filter_order_id'               => 1,
	 *     'filter_customer'               => 'John Doe',
	 *     'filter_subscription_status_id' => 1,
	 *     'filter_date_from'              => '2021-01-01',
	 *     'filter_date_to'                => '2021-01-31',
	 *     'order'                         => 's.subscription_id',
	 *     'sort'                          => 'DESC',
	 *     'start'                         => 0,
	 *     'limit'                         => 10
	 * ];
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $subscription_total = $this->model_sale_subscription->getTotalSubscriptions($filter_data);
	 */
	public function getTotalSubscriptions(array $data = []): int {
		$sql = "SELECT COUNT(*) AS `total` FROM `" . DB_PREFIX . "subscription` `s` LEFT JOIN `" . DB_PREFIX . "order` `o` ON (`s`.`order_id` = `o`.`order_id`)";

		$implode = [];

		if (!empty($data['filter_subscription_id'])) {
			$implode[] = "`s`.`subscription_id` = '" . (int)$data['filter_subscription_id'] . "'";
		}

		if (!empty($data['filter_order_id'])) {
			$implode[] = "`s`.`order_id` = '" . (int)$data['filter_order_id'] . "'";
		}

		if (!empty($data['filter_customer_id'])) {
			$implode[] = "`s`.`customer_id` = " . (int)$data['filter_customer_id'];
		}

		if (!empty($data['filter_customer'])) {
			$implode[] = "LCASE(CONCAT(`o`.`firstname`, ' ', `o`.`lastname`)) LIKE '" . $this->db->escape(oc_strtolower($data['filter_customer']) . '%') . "'";
		}

		if (!empty($data['filter_subscription_status_id'])) {
			$implode[] = "`s`.`subscription_status_id` = '" . (int)$data['filter_subscription_status_id'] . "'";
		}

		if (!empty($data['filter_date_from'])) {
			$implode[] = "DATE(`s`.`date_added`) >= DATE('" . $this->db->escape((string)$data['filter_date_from']) . "')";
		}

		if (!empty($data['filter_date_to'])) {
			$implode[] = "DATE(`s`.`date_added`) <= DATE('" . $this->db->escape((string)$data['filter_date_to']) . "')";
		}

		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}

		$query = $this->db->query($sql);

		return (int)$query->row['total'];
	}

	/**
	 * Get Total Subscriptions By Store ID
	 *
	 * Get the total number of total subscriptions by store status records in the database.
	 *
	 * @param int $store_id primary key of the store record
	 *
	 * @return int total number of subscription records that have store ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $subscription_total = $this->model_sale_subscription->getTotalSubscriptionsByStoreId($store_id);
	 */
	public function getTotalSubscriptionsByStoreId(int $store_id): int {
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM `" . DB_PREFIX . "subscription` WHERE `store_id` = '" . (int)$store_id . "'");

		return (int)$query->row['total'];
	}

	/**
	 * Get Total Subscriptions By Subscription Status ID
	 *
	 * Get the total number of total subscriptions by subscription status records in the database.
	 *
	 * @param int $subscription_status_id primary key of the subscription_status record
	 *
	 * @return int total number of subscription records that have subscription status ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $subscription_total = $this->model_sale_subscription->getTotalSubscriptionsBySubscriptionStatusId($subscription_status_id);
	 */
	public function getTotalSubscriptionsBySubscriptionStatusId(int $subscription_status_id): int {
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM `" . DB_PREFIX . "subscription` WHERE `subscription_status_id` = '" . (int)$subscription_status_id . "'");

		return (int)$query->row['total'];
	}

	/**
	 * Delete Product
	 *
	 * Delete subscription product records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->deleteProducts($subscription_id);
	 */
	public function deleteProducts(int $subscription_id): void {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "subscription_product` WHERE `subscription_id` = '" . (int)$subscription_id . "'");
	}

	/**
	 * Get Subscribed Products
	 *
	 * Get the record of the subscribed product records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return array<int, array<string, mixed>> product records that have subscription ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $products = $this->model_sale_subscription->getProducts($subscription_id);
	 */
	public function getProducts(int $subscription_id): array {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_product` WHERE `subscription_id` = '" . (int)$subscription_id . "'");

		return $query->rows;
	}

	/**
	 * Get Options
	 *
	 * Get the record of the subscription option records in the database.
	 *
	 * @param int $subscription_id         primary key of the subscription record
	 * @param int $subscription_product_id primary key of the subscription product record
	 * @param int $order_id                primary key of the order record
	 * @param int $order_product_id        primary key of the order product record
	 *
	 * @return array<int, array<string, mixed>> option records that have subscription ID, subscription product ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $options = $this->model_sale_subscription->getOptions($subscription_id, $subscription_product_id);
	 */
	public function getOptions(int $subscription_id, int $subscription_product_id): array {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_option` WHERE `subscription_id` = '" . (int)$subscription_id . "' AND `subscription_product_id` = '" . (int)$subscription_product_id . "'");

		return $query->rows;
	}

	/**
	 * Delete Options
	 *
	 * Delete subscription option records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->deleteOptions($subscription_id);
	 */
	public function deleteOptions(int $subscription_id): void {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "subscription_option` WHERE `subscription_id` = '" . (int)$subscription_id . "'");
	}

	/**
	 * Add History
	 *
	 * Create a new subscription history record in the database.
	 *
	 * @param int    $subscription_id        primary key of the subscription record
	 * @param int    $subscription_status_id primary key of the subscription status record
	 * @param string $comment
	 * @param bool   $notify
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->addHistory($subscription_id, $subscription_status_id, $comment, $notify);
	 */
	public function addHistory(int $subscription_id, int $subscription_status_id, string $comment = '', bool $notify = false): void {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "subscription_history` SET `subscription_id` = '" . (int)$subscription_id . "', `subscription_status_id` = '" . (int)$subscription_status_id . "', `comment` = '" . $this->db->escape($comment) . "', `notify` = '" . (int)$notify . "', `date_added` = NOW()");

		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET `subscription_status_id` = '" . (int)$subscription_status_id . "' WHERE `subscription_id` = '" . (int)$subscription_id . "'");
	}

	/**
	 * Delete Histories
	 *
	 * Delete subscription history records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->deleteHistories($subscription_id);
	 */
	public function deleteHistories(int $subscription_id): void {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "subscription_history` WHERE `subscription_id` = '" . (int)$subscription_id . "'");
	}

	/**
	 * Get Histories
	 *
	 * Get the record of the subscription history records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 * @param int $start
	 * @param int $limit
	 *
	 * @return array<int, array<string, mixed>> history records that have subscription ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $results = $this->model_sale_subscription->getHistories($subscription_id, $start, $limit);
	 */
	public function getHistories(int $subscription_id, int $start = 0, int $limit = 10): array {
		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 10;
		}

		$query = $this->db->query("SELECT *, (SELECT `ss`.`name` FROM `" . DB_PREFIX . "subscription_status` `ss` WHERE `ss`.`subscription_status_id` = `sh`.`subscription_status_id` AND `ss`.`language_id` = '" . (int)$this->config->get('config_language_id') . "') AS `subscription_status` FROM `" . DB_PREFIX . "subscription_history` `sh` WHERE `sh`.`subscription_id` = '" . (int)$subscription_id . "' ORDER BY `sh`.`date_added` DESC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}

	/**
	 * Get Total Histories
	 *
	 * Get the total number of total subscription history records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return int total number of history records that have subscription ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $history_total = $this->model_sale_subscription->getTotalHistories($subscription_id);
	 */
	public function getTotalHistories(int $subscription_id): int {
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM `" . DB_PREFIX . "subscription_history` WHERE `subscription_id` = '" . (int)$subscription_id . "'");

		return (int)$query->row['total'];
	}

	/**
	 * Get Total Histories By Subscription Status ID
	 *
	 * Get the total number of total subscription histories by subscription status records in the database.
	 *
	 * @param int $subscription_status_id primary key of the subscription status record
	 *
	 * @return int total number of history records that have subscription status ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $history_total = $this->model_sale_subscription->getTotalHistoriesBySubscriptionStatusId($subscription_status_id);
	 */
	public function getTotalHistoriesBySubscriptionStatusId(int $subscription_status_id): int {
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM `" . DB_PREFIX . "subscription_history` WHERE `subscription_status_id` = '" . (int)$subscription_status_id . "'");

		return (int)$query->row['total'];
	}

	/**
	 * Delete Logs
	 *
	 * Delete subscription log records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $this->model_sale_subscription->deleteLogs($subscription_id);
	 */
	public function deleteLogs(int $subscription_id): void {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "subscription_log` WHERE `subscription_id` = '" . (int)$subscription_id . "'");
	}

	/**
	 * Get Logs
	 *
	 * Get the record of the subscription log records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 * @param int $start
	 * @param int $limit
	 *
	 * @return array<int, array<string, mixed>> log records that have subscription ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $results = $this->model_sale_subscription->getLogs($subscription_id, $start, $limit);
	 */
	public function getLogs(int $subscription_id, int $start = 0, int $limit = 10): array {
		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 10;
		}

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_log` WHERE `subscription_id` = '" . (int)$subscription_id . "' ORDER BY `date_added` DESC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}

	/**
	 * Get Total Logs
	 *
	 * Get the total number of total subscription log records in the database.
	 *
	 * @param int $subscription_id primary key of the subscription record
	 *
	 * @return int total number of log records that have subscription ID
	 *
	 * @example
	 *
	 * $this->load->model('sale/subscription');
	 *
	 * $subscription_total = $this->model_sale_subscription->getTotalLogs($subscription_id);
	 */
	public function getTotalLogs(int $subscription_id): int {
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM `" . DB_PREFIX . "subscription_log` WHERE `subscription_id` = '" . (int)$subscription_id . "'");

		return (int)$query->row['total'];
	}

	/**
	 * Pause Subscription
	 *
	 * Pause a subscription until a specified date
	 *
	 * @param int    $subscription_id primary key of the subscription record
	 * @param string $paused_until    date until paused
	 * @param string $comment         optional comment
	 * @param string $modified_by     who made the change
	 *
	 * @return bool
	 */
	public function pauseSubscription(int $subscription_id, string $paused_until, string $comment = '', string $modified_by = 'admin'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`paused_until` = '" . $this->db->escape($paused_until) . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		$this->addSubscriptionHistory($subscription_id, 'pause', null, $paused_until, $comment, $modified_by);
		
		return true;
	}

	/**
	 * Resume Subscription
	 *
	 * Resume a paused subscription
	 *
	 * @param int    $subscription_id primary key of the subscription record
	 * @param string $comment         optional comment
	 * @param string $modified_by     who made the change
	 *
	 * @return bool
	 */
	public function resumeSubscription(int $subscription_id, string $comment = '', string $modified_by = 'admin'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		$old_value = $subscription['paused_until'];
		
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`paused_until` = NULL,
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		$this->addSubscriptionHistory($subscription_id, 'resume', $old_value, null, $comment, $modified_by);
		
		return true;
	}

	/**
	 * Skip Next Delivery
	 *
	 * Skip the next scheduled delivery
	 *
	 * @param int    $subscription_id primary key of the subscription record
	 * @param int    $skip_count      number of deliveries to skip
	 * @param string $comment         optional comment
	 * @param string $modified_by     who made the change
	 *
	 * @return bool
	 */
	public function skipNextDelivery(int $subscription_id, int $skip_count = 1, string $comment = '', string $modified_by = 'admin'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		if ($skip_count < 1) {
			$skip_count = 1;
		}
		
		$skipped_date = $subscription['date_next'];
		
		$current_date = new \DateTime($subscription['date_next']);
		
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
		
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`date_next` = '" . $this->db->escape($new_date_next) . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		$log_comment = $comment;
		if ($skip_count > 1) {
			$log_comment = 'Skipped ' . $skip_count . ' deliveries. ' . ($comment ? $comment : '');
		}
		$this->addSubscriptionHistory($subscription_id, 'skip', null, $skipped_date, $log_comment, $modified_by);
		
		return true;
	}

	/**
	 * Change Subscription Frequency
	 *
	 * Change the frequency and cycle of a subscription
	 *
	 * @param int    $subscription_id             primary key of the subscription record
	 * @param int    $subscription_plan_frequency_id new frequency plan ID
	 * @param string $frequency                   new frequency
	 * @param int    $cycle                       new cycle
	 * @param string $comment                     optional comment
	 * @param string $modified_by                 who made the change
	 *
	 * @return bool
	 */
	public function changeFrequency(int $subscription_id, int $subscription_plan_frequency_id, string $frequency, int $cycle, string $comment = '', string $modified_by = 'admin'): bool {
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
		
		$date_next = date('Y-m-d', strtotime('+' . $cycle . ' ' . $frequency));
		
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`subscription_plan_frequency_id` = '" . (int)$subscription_plan_frequency_id . "',
			`frequency` = '" . $this->db->escape($frequency) . "',
			`cycle` = '" . (int)$cycle . "',
			`date_next` = '" . $this->db->escape($date_next) . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		$this->addSubscriptionHistory($subscription_id, 'frequency_change', $old_value, $new_value, $comment, $modified_by);
		
		return true;
	}

	/**
	 * Change Delivery Date
	 *
	 * Change the preferred delivery date
	 *
	 * @param int    $subscription_id primary key of the subscription record
	 * @param string $delivery_date   new delivery date
	 * @param string $comment         optional comment
	 * @param string $modified_by     who made the change
	 *
	 * @return bool
	 */
	public function changeDeliveryDate(int $subscription_id, string $delivery_date, string $comment = '', string $modified_by = 'admin'): bool {
		$subscription = $this->getSubscription($subscription_id);
		
		if (!$subscription) {
			return false;
		}
		
		$old_value = $subscription['date_next'];
		
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`date_next` = '" . $this->db->escape($delivery_date) . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		$this->addSubscriptionHistory($subscription_id, 'delivery_date_change', $old_value, $delivery_date, $comment, $modified_by);
		
		return true;
	}

	/**
	 * Change Subscription Plan
	 *
	 * Change the subscription plan
	 *
	 * @param int    $subscription_id     primary key of the subscription record
	 * @param int    $subscription_plan_id new plan ID
	 * @param float  $price               new price
	 * @param string $comment             optional comment
	 * @param string $modified_by         who made the change
	 *
	 * @return bool
	 */
	public function changeSubscriptionPlan(int $subscription_id, int $subscription_plan_id, float $price, string $comment = '', string $modified_by = 'admin'): bool {
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
		
		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`subscription_plan_id` = '" . (int)$subscription_plan_id . "',
			`price` = '" . (float)$price . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "',
			`date_modified` = NOW()
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");
		
		$this->addSubscriptionHistory($subscription_id, 'plan_change', $old_value, $new_value, $comment, $modified_by);
		
		return true;
	}

	/**
	 * Change Delivery Address
	 *
	 * Update the shipping address for a subscription
	 *
	 * @param int    $subscription_id primary key of the subscription record
	 * @param int    $address_id      primary key of the new shipping address
	 * @param string $comment         optional comment
	 * @param string $modified_by     who made the change
	 *
	 * @return bool
	 */
	public function changeDeliveryAddress(int $subscription_id, int $address_id, string $comment = '', string $modified_by = 'admin'): bool {
		$query = $this->db->query("SELECT shipping_address_id FROM `" . DB_PREFIX . "subscription` WHERE subscription_id = '" . (int)$subscription_id . "'");
		
		if (!$query->num_rows) {
			return false;
		}

		$old_address_id = $query->row['shipping_address_id'];

		$this->db->query("UPDATE `" . DB_PREFIX . "subscription` SET 
			`shipping_address_id` = '" . (int)$address_id . "',
			`last_modified_by` = '" . $this->db->escape($modified_by) . "'
			WHERE `subscription_id` = '" . (int)$subscription_id . "'");

		$log_comment = 'Delivery address changed from address ID #' . $old_address_id . ' to #' . $address_id;
		if ($comment) {
			$log_comment .= '. Admin note: ' . $comment;
		}

		$this->addSubscriptionHistory($subscription_id, 'address_change', (string)$old_address_id, (string)$address_id, $log_comment, $modified_by);

		return true;
	}

	/**
	 * Add Subscription History
	 *
	 * Add a history record for subscription management actions
	 *
	 * @param int    $subscription_id primary key of the subscription record
	 * @param string $action_type     type of action
	 * @param string $old_value       old value
	 * @param string $new_value       new value
	 * @param string $comment         optional comment
	 * @param string $modified_by     who made the change
	 *
	 * @return int
	 */
	public function addSubscriptionHistory(int $subscription_id, string $action_type, ?string $old_value, ?string $new_value, string $comment = '', string $modified_by = 'admin'): int {
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
