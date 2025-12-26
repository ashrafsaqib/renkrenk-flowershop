<?php
namespace Opencart\Catalog\Controller\Common;
/**
 * Class Menu
 *
 * Can be called from $this->load->controller('common/menu');
 *
 * @package Opencart\Catalog\Controller\Common
 */
class Menu extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return string
	 */
	public function index(): string {
		$this->load->language('common/menu');

		// Category
		$this->load->model('catalog/category');

		// Product
		$this->load->model('catalog/product');

		// Subscription Plan
		$this->load->model('catalog/subscription_plan');

		$data['categories'] = [];

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			// Level 2
			$children_data = [];

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			foreach ($children as $child) {
				$filter_data = [
					'filter_category_id'  => $child['category_id'],
					'filter_sub_category' => true
				];

				$children_data[] = [
					'name' => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' => $this->url->link('product/category', 'language=' . $this->config->get('config_language') . '&path=' . $category['category_id'] . '_' . $child['category_id'])
				];
			}

			// Level 1
			$data['categories'][] = [
				'children' => $children_data,
				'href'     => $this->url->link('product/category', 'language=' . $this->config->get('config_language') . '&path=' . $category['category_id'])
			] + $category;
		}

		// Subscriptions
		$data['subscriptions'] = [];

		$subscription_plans = $this->model_catalog_subscription_plan->getSubscriptionPlans(['filter_status' => 1]);

		foreach ($subscription_plans as $subscription_plan) {
			$data['subscriptions'][] = [
				'subscription_plan_id' => $subscription_plan['subscription_plan_id'],
				'name'                 => $subscription_plan['name'],
				'href'                 => $this->url->link('product/subscription', 'language=' . $this->config->get('config_language') . '&subscription_plan_id=' . $subscription_plan['subscription_plan_id'])
			];
		}

		// Link to all subscriptions page
		$data['all_subscriptions_href'] = $this->url->link('product/subscription_list', 'language=' . $this->config->get('config_language'));

		return $this->load->view('common/menu', $data);
	}
}
