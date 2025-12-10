<?php
namespace Opencart\Catalog\Controller\Account;
/**
 * Class Subscription
 *
 * @package Opencart\Catalog\Controller\Account
 */
class Subscription extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return void
	 */
	public function index(): void {
		$this->load->language('account/subscription');

		if (isset($this->request->get['page'])) {
			$page = (int)$this->request->get['page'];
		} else {
			$page = 1;
		}

		if (!$this->load->controller('account/login.validate')) {
			$this->session->data['redirect'] = $this->url->link('account/subscription', 'language=' . $this->config->get('config_language'));

			$this->response->redirect($this->url->link('account/login', 'language=' . $this->config->get('config_language'), true));
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = [];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'language=' . $this->config->get('config_language'))
		];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'])
		];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('account/subscription', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'] . $url)
		];

		$limit = 10;

		$data['subscriptions'] = [];

		// Subscription
		$this->load->model('account/subscription');

		// Currency
		$this->load->model('localisation/currency');

		// Subscription Status
		$this->load->model('localisation/subscription_status');

		$results = $this->model_account_subscription->getSubscriptions(($page - 1) * $limit, $limit);

		foreach ($results as $result) {
			$description = '';

			if ($result['trial_status']) {
				$trial_price = $this->currency->format($result['trial_price'], $result['currency']);
				$trial_cycle = $result['trial_cycle'];
				$trial_frequency = $this->language->get('text_' . $result['trial_frequency']);
				$trial_duration = $result['trial_duration'];

				$description .= sprintf($this->language->get('text_subscription_trial'), $trial_price, $trial_cycle, $trial_frequency, $trial_duration);
			}

			$price = $this->currency->format($result['price'], $result['currency']);
			$cycle = $result['cycle'];
			$frequency = $this->language->get('text_' . $result['frequency']);
			$duration = $result['duration'];

			if ($duration) {
				$description .= sprintf($this->language->get('text_subscription_duration'), $price, $cycle, $frequency, $duration);
			} else {
				$description .= sprintf($this->language->get('text_subscription_cancel'), $price, $cycle, $frequency);
			}

			$subscription_status_info = $this->model_localisation_subscription_status->getSubscriptionStatus($result['subscription_status_id']);

			if ($subscription_status_info) {
				$subscription_status = $subscription_status_info['name'];
			} else {
				$subscription_status = '';
			}

			$data['subscriptions'][] = [
				'product_total' => $this->model_account_subscription->getTotalProducts($result['subscription_id']),
				'description'   => $description,
				'status'        => $subscription_status,
				'date_added'    => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'view'          => $this->url->link('account/subscription.info', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'] . '&subscription_id=' . $result['subscription_id'])
			] + $result;
		}

		$subscription_total = $this->model_account_subscription->getTotalSubscriptions();

		$data['pagination'] = $this->load->controller('common/pagination', [
			'total' => $subscription_total,
			'page'  => $page,
			'limit' => $limit,
			'url'   => $this->url->link('account/subscription', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'] . '&page={page}')
		]);

		$data['results'] = sprintf($this->language->get('text_pagination'), ($subscription_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($subscription_total - $limit)) ? $subscription_total : ((($page - 1) * $limit) + $limit), $subscription_total, ceil($subscription_total / $limit));

		$data['continue'] = $this->url->link('account/account', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token']);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('account/subscription_list', $data));
	}

	/**
	 * Info
	 *
	 * @return \Opencart\System\Engine\Action|null
	 */
	public function info(): ?\Opencart\System\Engine\Action {
		$this->load->language('account/subscription');

		if (isset($this->request->get['subscription_id'])) {
			$subscription_id = (int)$this->request->get['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		if (!$this->load->controller('account/login.validate')) {
			$this->session->data['redirect'] = $this->url->link('account/subscription', 'language=' . $this->config->get('config_language'));

			$this->response->redirect($this->url->link('account/login', 'language=' . $this->config->get('config_language'), true));
		}

		$this->load->model('account/subscription');

		$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

		if ($subscription_info) {
			$heading_title = sprintf($this->language->get('text_subscription'), $subscription_info['subscription_id']);

			$this->document->setTitle($heading_title);

			$data['heading_title'] = $heading_title;

			// Get subscription plan name
			$data['subscription_plan_name'] = '';
			if ($subscription_info['subscription_plan_id']) {
				$plan_query = $this->db->query("SELECT spd.name 
					FROM `" . DB_PREFIX . "subscription_plan_description` spd 
					WHERE spd.subscription_plan_id = '" . (int)$subscription_info['subscription_plan_id'] . "' 
					AND spd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
				
				if ($plan_query->num_rows) {
					$data['subscription_plan_name'] = $plan_query->row['name'];
				}
			}

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$data['breadcrumbs'] = [];

			$data['breadcrumbs'][] = [
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home', 'language=' . $this->config->get('config_language'))
			];

			$data['breadcrumbs'][] = [
				'text' => $this->language->get('text_account'),
				'href' => $this->url->link('account/account', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'])
			];

			$data['breadcrumbs'][] = [
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('account/subscription', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'] . $url)
			];

			$data['breadcrumbs'][] = [
				'text' => $heading_title,
				'href' => $this->url->link('account/subscription.info', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'] . '&subscription_id=' . $this->request->get['subscription_id'] . $url)
			];

			$data['subscription_id'] = $subscription_info['subscription_id'];
			$data['order_id'] = $subscription_info['order_id'];

			// Payment Address
			$this->load->model('account/address');

			$address_info = $this->model_account_address->getAddress($this->customer->getId(), $subscription_info['payment_address_id']);

			if ($address_info) {
				if ($address_info['address_format']) {
					$format = $address_info['address_format'];
				} else {
					$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
				}

				$find = [
					'{firstname}',
					'{lastname}',
					'{company}',
					'{address_1}',
					'{address_2}',
					'{city}',
					'{postcode}',
					'{zone}',
					'{zone_code}',
					'{country}'
				];

				$replace = [
					'firstname' => $address_info['firstname'],
					'lastname'  => $address_info['lastname'],
					'company'   => $address_info['company'],
					'address_1' => $address_info['address_1'],
					'address_2' => $address_info['address_2'],
					'city'      => $address_info['city'],
					'postcode'  => $address_info['postcode'],
					'zone'      => $address_info['zone'],
					'zone_code' => $address_info['zone_code'],
					'country'   => $address_info['country']
				];

				$pattern_1 = [
					"\r\n",
					"\r",
					"\n"
				];

				$pattern_2 = [
					"/\\s\\s+/",
					"/\r\r+/",
					"/\n\n+/"
				];

				$data['payment_address'] = str_replace($pattern_1, '<br/>', preg_replace($pattern_2, '<br/>', trim(str_replace($find, $replace, $format))));
			} else {
				$data['payment_address'] = '';
			}

			// Shipping Address
			$this->load->model('account/address');

			$address_info = $this->model_account_address->getAddress($this->customer->getId(), $subscription_info['shipping_address_id']);

			if ($address_info) {
				if ($address_info['address_format']) {
					$format = $address_info['address_format'];
				} else {
					$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
				}

				$find = [
					'{firstname}',
					'{lastname}',
					'{company}',
					'{address_1}',
					'{address_2}',
					'{city}',
					'{postcode}',
					'{zone}',
					'{zone_code}',
					'{country}'
				];

				$replace = [
					'firstname' => $address_info['firstname'],
					'lastname'  => $address_info['lastname'],
					'company'   => $address_info['company'],
					'address_1' => $address_info['address_1'],
					'address_2' => $address_info['address_2'],
					'city'      => $address_info['city'],
					'postcode'  => $address_info['postcode'],
					'zone'      => $address_info['zone'],
					'zone_code' => $address_info['zone_code'],
					'country'   => $address_info['country']
				];

				$pattern_1 = [
					"\r\n",
					"\r",
					"\n"
				];

				$pattern_2 = [
					"/\\s\\s+/",
					"/\r\r+/",
					"/\n\n+/"
				];

				$data['shipping_address'] = str_replace($pattern_1, '<br/>', preg_replace($pattern_2, '<br/>', trim(str_replace($find, $replace, $format))));
			} else {
				$data['shipping_address'] = '';
			}

			if ($subscription_info['shipping_method']) {
				$data['shipping_method'] = $subscription_info['shipping_method']['name'];
			} else {
				$data['shipping_method'] = '';
			}

			if ($subscription_info['payment_method']) {
				$data['payment_method'] = $subscription_info['payment_method']['name'];
			} else {
				$data['payment_method'] = '';
			}

			// Product
			$data['products'] = [];

			$this->load->model('catalog/product');

			$results = $this->model_account_subscription->getProducts($subscription_id);

			foreach ($results as $result) {
				$option_data = [];

				$options = $this->model_account_subscription->getOptions($result['product_id'], $result['subscription_product_id']);

				foreach ($options as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = ['value' => (oc_strlen($value) > 20 ? oc_substr($value, 0, 20) . '..' : $value)] + $option;
				}

				// Build subscription plan description
				$subscription_plan = '';

				if ($subscription_info['trial_status']) {
					$trial_price = $this->currency->format($subscription_info['trial_price'] + ($this->config->get('config_tax') ? $subscription_info['trial_tax'] : 0), $subscription_info['currency']);
					$trial_cycle = $subscription_info['trial_cycle'];
					$trial_frequency = $this->language->get('text_' . $subscription_info['trial_frequency']);
					$trial_duration = $subscription_info['trial_duration'];

					$subscription_plan .= sprintf($this->language->get('text_subscription_trial'), $trial_price, $trial_cycle, $trial_frequency, $trial_duration);
				}

				$price = $this->currency->format($subscription_info['price'] + ($this->config->get('config_tax') ? $subscription_info['tax'] : 0), $subscription_info['currency']);
				$cycle = $subscription_info['cycle'];
				$frequency = $this->language->get('text_' . $subscription_info['frequency']);
				$duration = $subscription_info['duration'];

				if ($duration) {
					$subscription_plan .= sprintf($this->language->get('text_subscription_duration'), $price, $cycle, $frequency, $duration);
				} else {
					$subscription_plan .= sprintf($this->language->get('text_subscription_cancel'), $price, $cycle, $frequency);
				}

				$data['products'][] = [
					'option'       => $option_data,
					'subscription' => $subscription_plan,
					'trial_price'  => $this->currency->format($result['trial_price'] + ($this->config->get('config_tax') ? $result['trial_tax'] : 0), $subscription_info['currency']),
					'price'        => $this->currency->format($result['price'] + ($this->config->get('config_tax') ? $result['tax'] : 0), $subscription_info['currency']),
					'view'         => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				] + $result;
			}

			$data['description'] = '';

			if ($subscription_info['trial_status']) {
				$trial_price = $this->currency->format($subscription_info['trial_price'] + ($this->config->get('config_tax') ? $subscription_info['trial_tax'] : 0), $subscription_info['currency']);
				$trial_cycle = $subscription_info['trial_cycle'];
				$trial_frequency = $this->language->get('text_' . $subscription_info['trial_frequency']);
				$trial_duration = $subscription_info['trial_duration'];

				$data['description'] .= sprintf($this->language->get('text_subscription_trial'), $trial_price, $trial_cycle, $trial_frequency, $trial_duration);
			}

			$price = $this->currency->format($subscription_info['price'] + ($this->config->get('config_tax') ? $result['trial_tax'] : 0), $subscription_info['currency']);
			$cycle = $subscription_info['cycle'];
			$frequency = $this->language->get('text_' . $subscription_info['frequency']);
			$duration = $subscription_info['duration'];

			if ($duration) {
				$data['description'] .= sprintf($this->language->get('text_subscription_duration'), $price, $cycle, $frequency, $duration);
			} else {
				$data['description'] .= sprintf($this->language->get('text_subscription_cancel'), $price, $cycle, $frequency);
			}

			$data['date_next'] = date($this->language->get('date_format_short'), strtotime($subscription_info['date_next']));
			$data['duration'] = $subscription_info['duration'];
			$data['trial_duration'] = $subscription_info['trial_duration'];
			$data['remaining'] = $subscription_info['trial_remaining'] + $subscription_info['remaining'];

			// Subscription details for display
			$data['frequency_text'] = $this->language->get('text_' . $subscription_info['frequency']);
			$data['cycle'] = $subscription_info['cycle'];
			$data['frequency_display'] = 'Every ' . $subscription_info['cycle'] . ' ' . ucfirst($subscription_info['frequency']);
			
			if ($subscription_info['duration']) {
				$data['duration_display'] = $subscription_info['duration'] . ' ' . ucfirst($subscription_info['frequency']) . '(s)';
			} else {
				$data['duration_display'] = 'Until Cancelled';
			}
			
			// Check if this is a gift subscription
			$data['is_gift'] = isset($subscription_info['is_gift']) ? $subscription_info['is_gift'] : 0;

			// Orders
			$data['history'] = $this->getHistory();
			$data['order'] = $this->getOrders();

			if ($subscription_info['order_id']) {
				$data['order_link'] = $this->url->link('account/order.info', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'] . '&order_id=' . $subscription_info['order_id']);
			} else {
				$data['order_link'] = '';
			}

			// Add pause status
			$data['paused_until'] = isset($subscription_info['paused_until']) ? date($this->language->get('date_format_short'), strtotime($subscription_info['paused_until'])) : '';

			// Check if subscription is cancelled
			$data['is_cancelled'] = ($subscription_info['subscription_status_id'] == $this->config->get('config_subscription_canceled_status_id'));
			
			// Get subscription plan link for resubscribe
			if ($subscription_info['subscription_plan_id']) {
				$data['subscription_plan_link'] = $this->url->link('product/subscription', 'language=' . $this->config->get('config_language') . '&subscription_plan_id=' . $subscription_info['subscription_plan_id']);
			} else {
				$data['subscription_plan_link'] = '';
			}

			// Get available frequencies for the subscription plan
			$data['frequencies'] = [];
			$frequency_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_plan_frequency` 
				WHERE `subscription_plan_id` = '" . (int)$subscription_info['subscription_plan_id'] . "'");
			$data['frequencies'] = $frequency_query->rows;

		// Get available plans (same product subscription plans)
		$data['plans'] = [];
		$plan_query = $this->db->query("
			SELECT sp.*, spd.name 
			FROM `" . DB_PREFIX . "subscription_plan` sp
			LEFT JOIN `" . DB_PREFIX . "subscription_plan_description` spd 
				ON (sp.subscription_plan_id = spd.subscription_plan_id) 
			WHERE sp.subscription_plan_id != '" . (int)$subscription_info['subscription_plan_id'] . "' 
			AND sp.status = 1 
			AND spd.language_id = '" . (int)$this->config->get('config_language_id') . "'
		");
		foreach ($plan_query->rows as $plan) {
			$data['plans'][] = [
				'subscription_plan_id' => $plan['subscription_plan_id'],
				'name' => $plan['name'],
				'price' => $this->currency->format($plan['price'], $this->session->data['currency'])
			];
		}

			// Get customer addresses for address change
			$data['addresses'] = [];
			$this->load->model('account/address');
			$addresses = $this->model_account_address->getAddresses($this->customer->getId());
			
			foreach ($addresses as $address) {
				$data['addresses'][] = [
					'address_id' => $address['address_id'],
					'address' => $address['firstname'] . ' ' . $address['lastname'] . ', ' . 
								$address['address_1'] . ', ' . $address['city'] . ', ' . 
								$address['postcode'] . ', ' . $address['country'],
					'is_current' => ($address['address_id'] == $subscription_info['shipping_address_id'])
				];
			}

			// Get current shipping address details for editing
			$current_address = $this->model_account_address->getAddress($this->customer->getId(), $subscription_info['shipping_address_id']);
			if ($current_address) {
				$data['current_address'] = $current_address;
			} else {
				$data['current_address'] = [];
			}

			// Load countries for address form
			$this->load->model('localisation/country');
			$data['countries'] = $this->model_localisation_country->getCountries();

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$data['continue'] = $this->url->link('account/subscription', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'] . $url);

			$data['language'] = $this->config->get('config_language');

			$data['customer_token'] = $this->session->data['customer_token'];

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('account/subscription_info', $data));
		} else {
			return new \Opencart\System\Engine\Action('error/not_found');
		}

		return null;
	}

	/**
	 * Cancel Subscription
	 *
	 * @return void
	 */
	public function cancel(): void {
		$this->load->language('account/subscription');

		$json = [];

		if (isset($this->request->post['subscription_id'])) {
			$subscription_id = (int)$this->request->post['subscription_id'];
		} elseif (isset($this->request->get['subscription_id'])) {
			$subscription_id = (int)$this->request->get['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		if (!$this->load->controller('account/login.validate')) {
			$this->session->data['redirect'] = $this->url->link('account/subscription', 'language=' . $this->config->get('config_language'));

			$json['redirect'] = $this->url->link('account/login', 'language=' . $this->config->get('config_language'), true);
		}

		if (!$json) {
			$this->load->model('account/subscription');

			$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

			if ($subscription_info) {
				// Validate customer owns this subscription
				if ($subscription_info['customer_id'] != $this->customer->getId()) {
					$json['error'] = $this->language->get('error_subscription');
				}
				
				if ($subscription_info['subscription_status_id'] == $this->config->get('config_subscription_canceled_status_id')) {
					$json['error'] = $this->language->get('error_canceled');
				}
			} else {
				$json['error'] = $this->language->get('error_subscription');
			}
		}

		if (!$json) {
			$this->load->model('checkout/subscription');

			$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';

			if ($this->model_checkout_subscription->cancelSubscription($subscription_id, $comment, 'customer')) {
				$json['success'] = $this->language->get('text_cancel_success');
			} else {
				$json['error'] = $this->language->get('error_cancel');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * History
	 *
	 * @return void
	 */
	public function history(): void {
		$this->load->language('account/subscription');

		if (!$this->load->controller('account/login.validate')) {
			$this->session->data['redirect'] = $this->url->link('account/subscription', 'language=' . $this->config->get('config_language'));

			$this->response->redirect($this->url->link('account/login', 'language=' . $this->config->get('config_language'), true));
		}

		$this->response->setOutput($this->getHistory());
	}

	/**
	 * Get History
	 *
	 * @return string
	 */
	protected function getHistory(): string {
		if (isset($this->request->get['subscription_id'])) {
			$subscription_id = (int)$this->request->get['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		if (isset($this->request->get['page']) && $this->request->get['route'] == 'account/subscription.history') {
			$page = (int)$this->request->get['page'];
		} else {
			$page = 1;
		}

		$limit = 10;

		if (!$this->load->controller('account/login.validate')) {
			return '';
		}

		// Histories
		$data['histories'] = [];

		$this->load->model('account/subscription');

		$results = $this->model_account_subscription->getHistories($subscription_id, ($page - 1) * $limit, $limit);

		foreach ($results as $result) {
			// Format action type into readable text
			$action_text = '';
			if (!empty($result['action_type'])) {
				switch ($result['action_type']) {
					case 'pause':
						$action_text = 'Subscription Paused' . ($result['new_value'] ? ' until ' . date($this->language->get('date_format_short'), strtotime($result['new_value'])) : '');
						break;
					case 'resume':
						$action_text = 'Subscription Resumed';
						break;
					case 'skip':
						$action_text = 'Skipped Delivery' . ($result['new_value'] ? ' on ' . date($this->language->get('date_format_short'), strtotime($result['new_value'])) : '');
						break;
					case 'frequency_change':
						$action_text = 'Frequency Changed';
						if ($result['old_value'] && $result['new_value']) {
							$action_text .= ' from ' . $result['old_value'] . ' to ' . $result['new_value'];
						}
						break;
					case 'delivery_date_change':
						$action_text = 'Delivery Date Changed';
						if ($result['old_value'] && $result['new_value']) {
							$action_text .= ' from ' . date($this->language->get('date_format_short'), strtotime($result['old_value'])) . ' to ' . date($this->language->get('date_format_short'), strtotime($result['new_value']));
						}
						break;
					case 'plan_change':
						$action_text = 'Subscription Plan Changed';
						break;
					case 'address_change':
						$action_text = 'Delivery Address Updated';
						break;
					case 'cancel':
						$action_text = 'Subscription Cancelled';
						break;
					default:
						$action_text = ucfirst(str_replace('_', ' ', $result['action_type']));
				}
			} elseif (!empty($result['status'])) {
				$action_text = $result['status'];
			}
			
			$data['histories'][] = [
				'action'     => $action_text,
				'comment'    => nl2br($result['comment']),
				'date_added' => date($this->language->get('datetime_format'), strtotime($result['date_added'])),
				'modified_by' => ucfirst($result['modified_by'] ?? 'system')
			] + $result;
		}

		$subscription_total = $this->model_account_subscription->getTotalHistories($subscription_id);

		$data['pagination'] = $this->load->controller('common/pagination', [
			'total' => $subscription_total,
			'page'  => $page,
			'limit' => $limit,
			'url'   => $this->url->link('account/subscription.history', 'customer_token=' . $this->session->data['customer_token'] . '&subscription_id=' . $subscription_id . '&page={page}')
		]);

		$data['results'] = sprintf($this->language->get('text_pagination'), ($subscription_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($subscription_total - $limit)) ? $subscription_total : ((($page - 1) * $limit) + $limit), $subscription_total, ceil($subscription_total / $limit));

		return $this->load->view('account/subscription_history', $data);
	}

	/**
	 * Order
	 *
	 * @return void
	 */
	public function order(): void {
		$this->load->language('account/subscription');

		if (!$this->load->controller('account/login.validate')) {
			$this->session->data['redirect'] = $this->url->link('account/subscription', 'language=' . $this->config->get('config_language'));

			$this->response->redirect($this->url->link('account/login', 'language=' . $this->config->get('config_language'), true));
		}

		$this->response->setOutput($this->getOrders());
	}

	/**
	 * Get Orders
	 *
	 * @return string
	 */
	protected function getOrders(): string {
		if (isset($this->request->get['subscription_id'])) {
			$subscription_id = (int)$this->request->get['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		if (isset($this->request->get['page']) && $this->request->get['route'] == 'account/subscription.order') {
			$page = (int)$this->request->get['page'];
		} else {
			$page = 1;
		}

		if (!$this->load->controller('account/login.validate')) {
			return '';
		}

		$limit = 10;

		// Order
		$data['orders'] = [];

		$this->load->model('account/order');

		$results = $this->model_account_order->getOrdersBySubscriptionId($subscription_id, ($page - 1) * $limit, $limit);

		foreach ($results as $result) {
			$data['orders'][] = [
				'total'      => $this->currency->format($result['total'], $result['currency_code'], $result['currency_value']),
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'view'       => $this->url->link('account/order.info', 'language=' . $this->config->get('config_language') . '&customer_token=' . $this->session->data['customer_token'] . '&order_id=' . $result['order_id'])
			] + $result;
		}

		$order_total = $this->model_account_order->getTotalOrdersBySubscriptionId($subscription_id);

		$data['pagination'] = $this->load->controller('common/pagination', [
			'total' => $order_total,
			'page'  => $page,
			'limit' => $limit,
			'url'   => $this->url->link('account/subscription.order', 'customer_token=' . $this->session->data['customer_token'] . '&subscription_id=' . $subscription_id . '&page={page}')
		]);

		$data['results'] = sprintf($this->language->get('text_pagination'), ($order_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($order_total - $limit)) ? $order_total : ((($page - 1) * $limit) + $limit), $order_total, ceil($order_total / $limit));

		return $this->load->view('account/subscription_order', $data);
	}

	/**
	 * Pause Subscription
	 *
	 * @return void
	 */
	public function pause(): void {
		$this->load->language('account/subscription');

		$json = [];

		if (!$this->load->controller('account/login.validate')) {
			$json['error'] = $this->language->get('error_login');
		}

		if (isset($this->request->post['subscription_id'])) {
			$subscription_id = (int)$this->request->post['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		$this->load->model('account/subscription');

		$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

		if (!$subscription_info) {
			$json['error'] = $this->language->get('error_subscription');
		}

		// Validate customer owns this subscription
		if ($subscription_info && $subscription_info['customer_id'] != $this->customer->getId()) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if (!isset($this->request->post['paused_until']) || empty($this->request->post['paused_until'])) {
			$json['error'] = $this->language->get('error_pause_date');
		}

		if (!$json) {
			$this->load->library('subscription_manager', $this->registry);

			$paused_until = $this->request->post['paused_until'];
			$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';

			if ($this->library_subscription_manager->pauseSubscription($subscription_id, $paused_until, $comment, 'customer')) {
				$json['success'] = $this->language->get('text_pause_success');
			} else {
				$json['error'] = $this->language->get('error_pause');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Resume Subscription
	 *
	 * @return void
	 */
	public function resume(): void {
		$this->load->language('account/subscription');

		$json = [];

		if (!$this->load->controller('account/login.validate')) {
			$json['error'] = $this->language->get('error_login');
		}

		if (isset($this->request->post['subscription_id'])) {
			$subscription_id = (int)$this->request->post['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		$this->load->model('account/subscription');

		$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

		if (!$subscription_info) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if ($subscription_info && $subscription_info['customer_id'] != $this->customer->getId()) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if (!$json) {
			$this->load->library('subscription_manager', $this->registry);

			$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';

			if ($this->library_subscription_manager->resumeSubscription($subscription_id, $comment, 'customer')) {
				$json['success'] = $this->language->get('text_resume_success');
			} else {
				$json['error'] = $this->language->get('error_resume');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Skip Next Delivery
	 *
	 * @return void
	 */
	public function skip(): void {
		$this->load->language('account/subscription');

		$json = [];

		if (!$this->load->controller('account/login.validate')) {
			$json['error'] = $this->language->get('error_login');
		}

		if (isset($this->request->post['subscription_id'])) {
			$subscription_id = (int)$this->request->post['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		$this->load->model('account/subscription');

		$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

		if (!$subscription_info) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if ($subscription_info && $subscription_info['customer_id'] != $this->customer->getId()) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if (!$json) {
			$this->load->library('subscription_manager', $this->registry);

			$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';
			$skip_count = isset($this->request->post['skip_count']) ? (int)$this->request->post['skip_count'] : 1;
			
			// Validate skip count
			if ($skip_count < 1 || $skip_count > 5) {
				$skip_count = 1;
			}

			if ($this->library_subscription_manager->skipNextDelivery($subscription_id, $skip_count, $comment, 'customer')) {
				if ($skip_count == 1) {
					$json['success'] = $this->language->get('text_skip_success');
				} else {
					$json['success'] = sprintf('Successfully skipped the next %d deliveries.', $skip_count);
				}
			} else {
				$json['error'] = $this->language->get('error_skip');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Change Frequency
	 *
	 * @return void
	 */
	public function changeFrequency(): void {
		$this->load->language('account/subscription');

		$json = [];

		if (!$this->load->controller('account/login.validate')) {
			$json['error'] = $this->language->get('error_login');
		}

		if (isset($this->request->post['subscription_id'])) {
			$subscription_id = (int)$this->request->post['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		$this->load->model('account/subscription');

		$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

		if (!$subscription_info) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if ($subscription_info && $subscription_info['customer_id'] != $this->customer->getId()) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if (!isset($this->request->post['frequency_id']) || empty($this->request->post['frequency_id'])) {
			$json['error'] = $this->language->get('error_frequency');
		}

		if (!$json) {
			$this->load->library('subscription_manager', $this->registry);

			$frequency_id = (int)$this->request->post['frequency_id'];
			$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';

			// Get frequency details
			$frequency_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "subscription_plan_frequency` WHERE `subscription_plan_frequency_id` = '" . (int)$frequency_id . "'");

			if ($frequency_query->num_rows) {
				$frequency_data = $frequency_query->row;

				if ($this->library_subscription_manager->changeFrequency($subscription_id, $frequency_id, $frequency_data['frequency'], $frequency_data['cycle'], $comment, 'customer')) {
					$json['success'] = $this->language->get('text_frequency_success');
				} else {
					$json['error'] = $this->language->get('error_frequency_change');
				}
			} else {
				$json['error'] = $this->language->get('error_frequency');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Change Delivery Date
	 *
	 * @return void
	 */
	public function changeDeliveryDate(): void {
		$this->load->language('account/subscription');

		$json = [];

		if (!$this->load->controller('account/login.validate')) {
			$json['error'] = $this->language->get('error_login');
		}

		if (isset($this->request->post['subscription_id'])) {
			$subscription_id = (int)$this->request->post['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		$this->load->model('account/subscription');

		$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

		if (!$subscription_info) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if ($subscription_info && $subscription_info['customer_id'] != $this->customer->getId()) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if (!isset($this->request->post['delivery_date']) || empty($this->request->post['delivery_date'])) {
			$json['error'] = $this->language->get('error_delivery_date');
		}

		if (!$json) {
			$this->load->library('subscription_manager', $this->registry);

			$delivery_date = $this->request->post['delivery_date'];
			$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';

			if ($this->library_subscription_manager->changeDeliveryDate($subscription_id, $delivery_date, $comment, 'customer')) {
				$json['success'] = $this->language->get('text_delivery_date_success');
			} else {
				$json['error'] = $this->language->get('error_delivery_date_change');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Change Subscription Plan
	 *
	 * @return void
	 */
	public function changePlan(): void {
		$this->load->language('account/subscription');

		$json = [];

		if (!$this->load->controller('account/login.validate')) {
			$json['error'] = $this->language->get('error_login');
		}

		if (isset($this->request->post['subscription_id'])) {
			$subscription_id = (int)$this->request->post['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		$this->load->model('account/subscription');

		$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

		if (!$subscription_info) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if ($subscription_info && $subscription_info['customer_id'] != $this->customer->getId()) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if (!isset($this->request->post['plan_id']) || empty($this->request->post['plan_id'])) {
			$json['error'] = $this->language->get('error_plan');
		}

		if (!$json) {
			$this->load->library('subscription_manager', $this->registry);
			$this->load->model('catalog/subscription_plan');

			$plan_id = (int)$this->request->post['plan_id'];
			$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';

			// Get plan details
			$plan_info = $this->model_catalog_subscription_plan->getSubscriptionPlan($plan_id);

			if ($plan_info) {
				if ($this->library_subscription_manager->changeSubscriptionPlan($subscription_id, $plan_id, $plan_info['price'], $comment, 'customer')) {
					$json['success'] = $this->language->get('text_plan_success');
				} else {
					$json['error'] = $this->language->get('error_plan_change');
				}
			} else {
				$json['error'] = $this->language->get('error_plan');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Change Delivery Address
	 *
	 * @return void
	 */
	public function changeAddress(): void {
		$this->load->language('account/subscription');

		$json = [];

		if (!$this->load->controller('account/login.validate')) {
			$json['error'] = $this->language->get('error_login');
		}

		if (isset($this->request->post['subscription_id'])) {
			$subscription_id = (int)$this->request->post['subscription_id'];
		} else {
			$subscription_id = 0;
		}

		$this->load->model('account/subscription');

		$subscription_info = $this->model_account_subscription->getSubscription($subscription_id);

		if (!$subscription_info) {
			$json['error'] = $this->language->get('error_subscription');
		}

		if ($subscription_info && $subscription_info['customer_id'] != $this->customer->getId()) {
			$json['error'] = $this->language->get('error_subscription');
		}

		$this->load->model('checkout/subscription');
		$this->load->model('account/address');

		// Check if user wants to update existing address or select a different one
		if (isset($this->request->post['update_current']) && $this->request->post['update_current'] == '1') {
			// Update current address with new details
			$address_id = $subscription_info['shipping_address_id'];
			
			// Validate required fields
			if (!isset($this->request->post['firstname']) || empty(trim($this->request->post['firstname']))) {
				$json['error'] = 'First name is required!';
			}
			
			if (!isset($this->request->post['lastname']) || empty(trim($this->request->post['lastname']))) {
				$json['error'] = 'Last name is required!';
			}
			
			if (!isset($this->request->post['address_1']) || empty(trim($this->request->post['address_1']))) {
				$json['error'] = 'Address is required!';
			}
			
			if (!isset($this->request->post['city']) || empty(trim($this->request->post['city']))) {
				$json['error'] = 'City is required!';
			}
			
			if (!isset($this->request->post['country_id']) || empty($this->request->post['country_id'])) {
				$json['error'] = 'Country is required!';
			}

			if (!$json) {
				// Update the address
				$address_data = [
					'firstname'  => $this->request->post['firstname'],
					'lastname'   => $this->request->post['lastname'],
					'company'    => isset($this->request->post['company']) ? $this->request->post['company'] : '',
					'address_1'  => $this->request->post['address_1'],
					'address_2'  => isset($this->request->post['address_2']) ? $this->request->post['address_2'] : '',
					'city'       => $this->request->post['city'],
					'postcode'   => isset($this->request->post['postcode']) ? $this->request->post['postcode'] : '',
					'country_id' => $this->request->post['country_id'],
					'zone_id'    => isset($this->request->post['zone_id']) ? $this->request->post['zone_id'] : 0
				];

				$this->model_account_address->editAddress($this->customer->getId(), $address_id, $address_data);

				$this->load->library('subscription_manager', $this->registry);
				$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : 'Address updated';
				$this->library_subscription_manager->changeDeliveryAddress($subscription_id, $address_id, $comment, 'customer');

				$json['success'] = $this->language->get('text_address_success');
			}
		} else {
			// Select existing address
			if (!isset($this->request->post['address_id']) || empty($this->request->post['address_id'])) {
				$json['error'] = $this->language->get('error_address');
			}

			if (!$json) {
				$this->load->library('subscription_manager', $this->registry);
				$address_id = (int)$this->request->post['address_id'];
				$comment = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';

				// Verify address belongs to customer
				$address_info = $this->model_account_address->getAddress($this->customer->getId(), $address_id);

				if ($address_info) {
					if ($this->library_subscription_manager->changeDeliveryAddress($subscription_id, $address_id, $comment, 'customer')) {
						$json['success'] = $this->language->get('text_address_success');
					} else {
						$json['error'] = $this->language->get('error_address_change');
					}
				} else {
					$json['error'] = $this->language->get('error_address');
				}
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
