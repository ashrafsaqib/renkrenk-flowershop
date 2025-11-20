<?php
namespace Opencart\Catalog\Controller\Product;
/**
 * Class Subscription
 *
 * @package Opencart\Catalog\Controller\Product
 */
class Subscription extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return ?\Opencart\System\Engine\Action
	 */
	public function index(): ?\Opencart\System\Engine\Action {
		$this->load->language('product/subscription');

		if (isset($this->request->get['subscription_plan_id'])) {
			$subscription_plan_id = (int)$this->request->get['subscription_plan_id'];
		} else {
			$subscription_plan_id = 0;
		}

		$this->load->model('catalog/subscription_plan');

		$subscription_plan_info = $this->model_catalog_subscription_plan->getSubscriptionPlan($subscription_plan_id);

		if ($subscription_plan_info) {
			$this->document->setTitle($subscription_plan_info['name']);
			$this->document->setDescription($subscription_plan_info['name']);

			$data['breadcrumbs'] = [];

			$data['breadcrumbs'][] = [
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home', 'language=' . $this->config->get('config_language'))
			];

			$data['breadcrumbs'][] = [
				'text' => $this->language->get('text_subscription'),
				'href' => $this->url->link('product/subscription', 'language=' . $this->config->get('config_language') . '&subscription_plan_id=' . $subscription_plan_id)
			];

			$data['heading_title'] = $subscription_plan_info['name'];
			$data['description'] = isset($subscription_plan_info['description']) ? html_entity_decode($subscription_plan_info['description'], ENT_QUOTES, 'UTF-8') : '';
			$data['price'] = isset($subscription_plan_info['price']) ? $subscription_plan_info['price'] : 0;

			// Format price
			if ((float)$subscription_plan_info['price']) {
				$data['price_formatted'] = $this->currency->format($this->tax->calculate($subscription_plan_info['price'], $this->config->get('config_tax'), $this->config->get('config_tax')), $this->config->get('config_currency'));
			} else {
				$data['price_formatted'] = false;
			}

			// Subscription details
			$data['trial_price'] = isset($subscription_plan_info['trial_price']) ? $subscription_plan_info['trial_price'] : 0;
			$data['trial_frequency'] = isset($subscription_plan_info['trial_frequency']) ? $subscription_plan_info['trial_frequency'] : '';
			$data['trial_cycle'] = isset($subscription_plan_info['trial_cycle']) ? $subscription_plan_info['trial_cycle'] : 0;
			$data['trial_duration'] = isset($subscription_plan_info['trial_duration']) ? $subscription_plan_info['trial_duration'] : 0;
			$data['trial_status'] = isset($subscription_plan_info['trial_status']) ? $subscription_plan_info['trial_status'] : 0;

			$data['frequency'] = $this->language->get('text_' . $subscription_plan_info['frequency']);
			$data['cycle'] = $subscription_plan_info['cycle'];
			$data['duration'] = $subscription_plan_info['duration'];

			if ($subscription_plan_info['duration']) {
				$data['duration_text'] = sprintf($this->language->get('text_subscription_duration'), $data['price_formatted'], $data['cycle'], $data['frequency'], $subscription_plan_info['duration']);
			} else {
				$data['duration_text'] = sprintf($this->language->get('text_subscription_cancel'), $data['price_formatted'], $data['cycle'], $data['frequency']);
			}

			// Images
			$this->load->model('tool/image');

			if (isset($subscription_plan_info['image']) && $subscription_plan_info['image']) {
				$data['image'] = $this->model_tool_image->resize($subscription_plan_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
				$data['thumb'] = $this->model_tool_image->resize($subscription_plan_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
			} else {
				$data['image'] = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
				$data['thumb'] = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
			}

			$data['images'] = [];

			$results = $this->model_catalog_subscription_plan->getImages($subscription_plan_id);

			foreach ($results as $result) {
				$data['images'][] = [
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
				];
			}

			$data['subscription_plan_id'] = $subscription_plan_id;

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('product/subscription', $data));

			return null;
		} else {
			return new \Opencart\System\Engine\Action('error/not_found');
		}
	}
}
