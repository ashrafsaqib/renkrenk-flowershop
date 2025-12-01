<?php
namespace Opencart\Catalog\Controller\Common;
/**
 * Class Cart
 *
 * Can be called from $this->load->controller('common/cart');
 *
 * @package Opencart\Catalog\Controller\Common
 */
class Cart extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return string
	 */
	public function index(): string {
		$this->load->language('common/cart');

		$totals = [];
		$taxes = $this->cart->getTaxes();
		$total = 0;

		// Cart
		$this->load->model('checkout/cart');

		// Image
		$this->load->model('tool/image');

		// Product model (used to resolve gift/vase names)
		$this->load->model('catalog/product');

		// Display prices
		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
			($this->model_checkout_cart->getTotals)($totals, $taxes, $total);

			$price_status = true;
		} else {
			$price_status = false;
		}

		$data['text_items'] = sprintf($this->language->get('text_items'), $this->cart->countProducts(), $this->currency->format($total, $this->session->data['currency']));

		// Products
		$data['products'] = [];

		$products = $this->model_checkout_cart->getProducts();

		foreach ($products as $product) {
			if ($product['option']) {
				foreach ($product['option'] as $key => $option) {
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

					$product['option'][$key]['value'] = (oc_strlen($value) > 20 ? oc_substr($value, 0, 20) . '..' : $value);
				}
			}

			$subscription = '';

			if ($product['subscription']) {
				if ($product['subscription']['duration']) {
					$subscription .= sprintf($this->language->get('text_subscription_duration'), $price_status ?? $product['subscription']['price_text'], $product['subscription']['cycle'], $product['subscription']['frequency'], $product['subscription']['duration']);
				} else {
					$subscription .= sprintf($this->language->get('text_subscription_cancel'), $price_status ?? $product['subscription']['price_text'], $product['subscription']['cycle'], $product['subscription']['frequency']);
				}
			}

			// Resolve gift/vase names when present in override metadata
			if (!empty($product['gift_id'])) {
				$gift_info = $this->model_catalog_product->getProduct((int)$product['gift_id']);
				if ($gift_info) {
					$product['gift_name'] = $gift_info['name'];
				}
			}

			if (!empty($product['vase_id'])) {
				$vase_info = $this->model_catalog_product->getProduct((int)$product['vase_id']);
				if ($vase_info) {
					$product['vase_name'] = $vase_info['name'];
				}
			}

			$data['products'][] = [
				'thumb'        => $this->model_tool_image->resize($product['image'], 80,80),
				'subscription' => $subscription,
				'price'        => $price_status ? $product['price_text'] : '',
				'total'        => $price_status ? $product['total_text'] : '',
				'href'         => $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . $product['product_id'])
			] + $product + [
				'gift_name' => $product['gift_name'] ?? '',
				'vase_name' => $product['vase_name'] ?? ''
			];
		}

		// Totals
		$data['totals'] = [];

		foreach ($totals as $total) {
			$data['totals'][] = ['text' => $this->currency->format($total['value'], $this->session->data['currency'])] + $total;
		}

		$data['list'] = $this->url->link('common/cart.info', 'language=' . $this->config->get('config_language'));
		$data['remove'] = $this->url->link('common/cart.remove', 'language=' . $this->config->get('config_language'));

		$data['cart'] = $this->url->link('checkout/cart', 'language=' . $this->config->get('config_language'));
		$data['checkout'] = $this->url->link('checkout/checkout', 'language=' . $this->config->get('config_language'));

		return $this->load->view('common/cart', $data);
	}

	/**
	 * Info
	 *
	 * @return void
	 */
	public function info(): void {
		$this->load->language('common/cart');

		$totals = [];
		$taxes = $this->cart->getTaxes();
		$total = 0;

		// Cart
		$this->load->model('checkout/cart');

		// Image
		$this->load->model('tool/image');

		// Display prices
		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
			($this->model_checkout_cart->getTotals)($totals, $taxes, $total);

			$price_status = true;
		} else {
			$price_status = false;
		}

		// Products
		$data['products'] = [];

		$products = $this->model_checkout_cart->getProducts();

		foreach ($products as $product) {
			if ($product['option']) {
				foreach ($product['option'] as $key => $option) {
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

					$product['option'][$key]['value'] = (oc_strlen($value) > 20 ? oc_substr($value, 0, 20) . '..' : $value);
				}
			}

			$subscription = '';

			if ($product['subscription']) {
				if ($product['subscription']['duration']) {
					$subscription .= sprintf($this->language->get('text_subscription_duration'), $price_status ?? $product['subscription']['price_text'], $product['subscription']['cycle'], $product['subscription']['frequency'], $product['subscription']['duration']);
				} else {
					$subscription .= sprintf($this->language->get('text_subscription_cancel'), $price_status ?? $product['subscription']['price_text'], $product['subscription']['cycle'], $product['subscription']['frequency']);
				}
			}
			
			$product_data = [
				'thumb'        => $this->model_tool_image->resize($product['image'], 120, 120),
				'subscription' => $subscription,
				'price'        => $price_status ? $product['price_text'] : '',
				'total'        => $price_status ? $product['total_text'] : '',
				'href'         => $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . $product['product_id'])
			] + $product;
			
			// Add subscription options data similar to popup
			// Note: cart library merges override fields directly into product array
			if (isset($product['subscription_plan_id']) && $product['subscription_plan_id'] > 0) {
				$product_data['subscription_options'] = [];
				
				// Add frequency
				if (isset($product['subscription_plan_frequency_id'])) {
					$freq_query = $this->db->query("SELECT `frequency`, `cycle` FROM `" . DB_PREFIX . "subscription_plan_frequency` WHERE `subscription_plan_frequency_id` = '" . (int)$product['subscription_plan_frequency_id'] . "' LIMIT 1");
					if ($freq_query->num_rows) {
						$product_data['subscription_options']['frequency'] = 'Every ' . $freq_query->row['cycle'] . ' ' . strtoupper($freq_query->row['frequency']);
					}
				}
				
				// Add delivery date
				if (isset($product['delivery_date'])) {
					$product_data['subscription_options']['delivery_date'] = date('F j, Y', strtotime($product['delivery_date']));
				}
				
				// Add duration
				if (isset($product['duration']) && $product['duration'] > 0) {
					$dur_query = $this->db->query("SELECT `label` FROM `" . DB_PREFIX . "subscription_plan_duration` WHERE `subscription_plan_duration_id` = '" . (int)$product['duration'] . "' LIMIT 1");
					if ($dur_query->num_rows) {
						$product_data['subscription_options']['duration'] = $dur_query->row['label'];
					}
				} elseif (isset($product['duration'])) {
					$product_data['subscription_options']['duration'] = 'On Going';
				}
				
				// Add gift status
				if (isset($product['is_gift'])) {
					$product_data['subscription_options']['is_gift'] = $product['is_gift'] ? 'Yes' : 'No';
				}
			}
			
			$data['products'][] = $product_data;
		}

		// Totals
		$data['totals'] = [];

		foreach ($totals as $total) {
			$data['totals'][] = ['text' => $this->currency->format($total['value'], $this->session->data['currency'])] + $total;
		}

		$data['list'] = $this->url->link('common/cart.info', 'language=' . $this->config->get('config_language'));
		$data['remove'] = $this->url->link('common/cart.remove', 'language=' . $this->config->get('config_language'));

		$data['cart'] = $this->url->link('checkout/cart', 'language=' . $this->config->get('config_language'));
		$data['checkout'] = $this->url->link('checkout/checkout', 'language=' . $this->config->get('config_language'));

		$data['text_cart'] = $this->language->get('text_cart');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_model'] = $this->language->get('text_model');
		$data['text_subscription'] = $this->language->get('text_subscription');
		$data['text_points'] = $this->language->get('text_points');
		$data['button_remove'] = $this->language->get('button_remove');

		$this->response->setOutput($this->load->view('common/cart', $data));
	}

	/**
	 * Remove Product
	 *
	 * @return void
	 */
	public function remove(): void {
		$this->load->language('checkout/cart');

		$json = [];

		if (isset($this->request->post['key'])) {
			$key = (int)$this->request->post['key'];
		} else {
			$key = 0;
		}

		if (!$this->cart->has($key)) {
			$json['error'] = $this->language->get('error_product');
		}

		if (!$json) {
			$this->cart->remove($key);

			$json['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Popup
	 *
	 * @return string
	 */
	public function popup(): string {
		$this->load->language('common/cart');

		$data['text_success_added'] = $this->language->get('text_success_added') ?: 'Product successfully added to your cart!';
		$data['text_related_products'] = $this->language->get('text_related_products') ?: 'You may also like';
		$data['text_model'] = $this->language->get('text_model') ?: 'Model';
		$data['text_quantity'] = $this->language->get('text_quantity') ?: 'Quantity';
		$data['text_price'] = $this->language->get('text_price') ?: 'Price';
		
		$data['button_buy_now'] = $this->language->get('button_buy_now') ?: 'Buy Now';
		$data['button_view_cart'] = $this->language->get('button_view_cart') ?: 'View Cart';
		$data['button_continue'] = $this->language->get('button_continue') ?: 'Continue Shopping';

		$data['cart'] = $this->url->link('checkout/cart', 'language=' . $this->config->get('config_language'));
		$data['checkout'] = $this->url->link('checkout/checkout', 'language=' . $this->config->get('config_language'));
		$data['language'] = $this->config->get('config_language');

		return $this->load->view('common/cart_popup', $data);
	}
}
