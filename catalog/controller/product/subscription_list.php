<?php
namespace Opencart\Catalog\Controller\Product;
/**
 * Class SubscriptionList
 *
 * @package Opencart\Catalog\Controller\Product
 */
class SubscriptionList extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return void
	 */
	public function index(): void {
		$this->load->language('product/subscription_list');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = [];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'language=' . $this->config->get('config_language'))
		];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('product/subscription_list', 'language=' . $this->config->get('config_language'))
		];

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_no_subscriptions'] = $this->language->get('text_no_subscriptions');
		$data['button_subscribe'] = $this->language->get('button_subscribe');

		// Load subscription plans
		$this->load->model('catalog/subscription_plan');
		$this->load->model('tool/image');

		$data['subscriptions'] = [];

		$subscription_plans = $this->model_catalog_subscription_plan->getSubscriptionPlans(['filter_status' => 1]);

		foreach ($subscription_plans as $subscription_plan) {
			// Get image
			if (isset($subscription_plan['image']) && $subscription_plan['image']) {
				$image = $this->model_tool_image->resize($subscription_plan['image'], 300, 300);
			} else {
				$image = $this->model_tool_image->resize('placeholder.png', 300, 300);
			}

			// Format price
			if ((float)$subscription_plan['price']) {
				$price = $this->currency->format($this->tax->calculate($subscription_plan['price'], $this->config->get('config_tax'), $this->config->get('config_tax')), $this->config->get('config_currency'));
			} else {
				$price = false;
			}

			// Get frequency text
			$frequency = '';
			if (!empty($subscription_plan['frequency'])) {
				$frequency = $this->language->get('text_' . $subscription_plan['frequency']);
			}

			$data['subscriptions'][] = [
				'subscription_plan_id' => $subscription_plan['subscription_plan_id'],
				'name'                 => $subscription_plan['name'],
				'description'          => isset($subscription_plan['description']) ? html_entity_decode($subscription_plan['description'], ENT_QUOTES, 'UTF-8') : '',
				'image'                => $image,
				'price'                => $price,
				'frequency'            => $frequency,
				'cycle'                => $subscription_plan['cycle'],
				'duration'             => $subscription_plan['duration'],
				'href'                 => $this->url->link('product/subscription', 'language=' . $this->config->get('config_language') . '&subscription_plan_id=' . $subscription_plan['subscription_plan_id'])
			];
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('product/subscription_list', $data));
	}
}
