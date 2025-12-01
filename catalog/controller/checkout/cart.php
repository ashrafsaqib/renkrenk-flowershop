<?php
namespace Opencart\Catalog\Controller\Checkout;
/**
 * Class Cart
 *
 * Can be loaded using $this->load->controller('checkout/cart');
 *
 * @package Opencart\Catalog\Controller\Checkout
 */
class Cart extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return void
	 */
	public function index(): void {
		$this->load->language('checkout/cart');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = [];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'language=' . $this->config->get('config_language'))
		];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('checkout/cart', 'language=' . $this->config->get('config_language'))
		];

		$data['list'] = $this->load->controller('checkout/cart.getList');

		$data['language'] = $this->config->get('config_language');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('checkout/cart', $data));
	}

	/**
	 * List
	 *
	 * @return void
	 */
	public function list(): void {
		$this->load->language('checkout/cart');

		$this->response->setOutput($this->getList());
	}

	/**
	 * Get List
	 *
	 * @return string
	 */
	public function getList(): string {
		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];

			unset($this->session->data['error']);
		} else {
			$data['error_warning'] = '';
		}

		if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
			$data['error_stock'] = $this->language->get('error_stock');
		} else {
			$data['error_stock'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
			$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', 'language=' . $this->config->get('config_language')), $this->url->link('account/register', 'language=' . $this->config->get('config_language')));
		} else {
			$data['attention'] = '';
		}

		if ($this->config->get('config_cart_weight')) {
			$data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
		} else {
			$data['weight'] = '';
		}

		$data['edit'] = $this->url->link('checkout/cart.edit', 'language=' . $this->config->get('config_language'));

		// Display prices
		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
			$price_status = true;
		} else {
			$price_status = false;
		}

		// Image
		$this->load->model('tool/image');

		// Upload
		$this->load->model('tool/upload');

		// Cart
		$data['products'] = [];

		$this->load->model('checkout/cart');

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

			if ($product['subscription'] && $price_status) {
				if ($product['subscription']['trial_status']) {
					$subscription .= sprintf($this->language->get('text_subscription_trial'), $product['subscription']['trial_price_text'], $product['subscription']['trial_cycle'], $product['subscription']['trial_frequency'], $product['subscription']['trial_duration']);
				}

				if ($product['subscription']['duration']) {
					$subscription .= sprintf($this->language->get('text_subscription_duration'), $product['subscription']['price_text'], $product['subscription']['cycle'], $product['subscription']['frequency'], $product['subscription']['duration']);
				} else {
					$subscription .= sprintf($this->language->get('text_subscription_cancel'), $product['subscription']['price_text'], $product['subscription']['cycle'], $product['subscription']['frequency']);
				}
			}
			
			$product_data = [
				'thumb'        => $this->model_tool_image->resize($product['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height')),
				'subscription' => $subscription,
				'stock'        => $product['stock_status'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
				'minimum'      => !$product['minimum_status'] ? sprintf($this->language->get('error_minimum'), $product['minimum']) : 0,
				'price'        => $price_status ? $product['price_text'] : '',
				'total'        => $price_status ? $product['total_text'] : '',
				'href'         => $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . $product['product_id']),
				'remove'       => $this->url->link('checkout/cart.remove', 'language=' . $this->config->get('config_language') . '&key=' . $product['cart_id'])
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
				
				// Add vase name
				if (isset($product['vase_id']) && $product['vase_id'] > 0) {
					$vase_query = $this->db->query("SELECT `name` FROM `" . DB_PREFIX . "product_description` WHERE `product_id` = '" . (int)$product['vase_id'] . "' AND `language_id` = '" . (int)$this->config->get('config_language_id') . "' LIMIT 1");
					if ($vase_query->num_rows) {
						$product_data['subscription_options']['vase'] = $vase_query->row['name'];
					}
				}
				
				// Add gift card name
				if (isset($product['gift_id']) && $product['gift_id'] > 0) {
					$gift_query = $this->db->query("SELECT `name` FROM `" . DB_PREFIX . "product_description` WHERE `product_id` = '" . (int)$product['gift_id'] . "' AND `language_id` = '" . (int)$this->config->get('config_language_id') . "' LIMIT 1");
					if ($gift_query->num_rows) {
						$product_data['subscription_options']['gift'] = $gift_query->row['name'];
					}
				}
			}
			
			$data['products'][] = $product_data;
		}

		$data['totals'] = [];

		$totals = [];
		$taxes = $this->cart->getTaxes();
		$total = 0;

		// Display prices
		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
			($this->model_checkout_cart->getTotals)($totals, $taxes, $total);

			foreach ($totals as $result) {
				$data['totals'][] = ['text' => $price_status ? $this->currency->format($result['value'], $this->session->data['currency']) : ''] + $result;
			}
		}

		$data['modules'] = [];

		// Extension
		$this->load->model('setting/extension');

		$extensions = $this->model_setting_extension->getExtensionsByType('total');

		foreach ($extensions as $extension) {
			$result = $this->load->controller('extension/' . $extension['extension'] . '/checkout/' . $extension['code']);

			if (!$result instanceof \Exception) {
				$data['modules'][] = $result;
			}
		}

		if ($products) {
			$data['continue'] = $this->url->link('common/home', 'language=' . $this->config->get('config_language'));
			$data['checkout'] = $this->url->link('checkout/checkout', 'language=' . $this->config->get('config_language'));
		} else {
			$data['continue'] = $this->url->link('common/home', 'language=' . $this->config->get('config_language'));
		}

		return $this->load->view('checkout/cart_list', $data);
	}

	/**
	 * Add
	 *
	 * @return void
	 */
	public function add(): void {
		$this->load->language('checkout/cart');

		$json = [];

		if (isset($this->request->post['product_id'])) {
			$product_id = (int)$this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = (int)$this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		if (isset($this->request->post['option'])) {
			$option = array_filter((array)$this->request->post['option']);
		} else {
			$option = [];
		}

		if (isset($this->request->post['subscription_plan_id'])) {
			$subscription_plan_id = (int)$this->request->post['subscription_plan_id'];
		} else {
			$subscription_plan_id = 0;
		}

		// Product
		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			// If variant get master product
			if ($product_info['master_id']) {
				$product_id = $product_info['master_id'];
			}

			// Only use values in the override
			if (isset($product_info['override']['variant'])) {
				$override = $product_info['override']['variant'];
			} else {
				$override = [];
			}

			// Merge variant code with options
			foreach ($product_info['variant'] as $key => $value) {
				if (array_key_exists($key, $override)) {
					$option[$key] = $value;
				}
			}

			// Validate options
			$product_options = $this->model_catalog_product->getOptions($product_id);

			foreach ($product_options as $product_option) {
				if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
					$json['error']['option_' . $product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
				} elseif (($product_option['type'] == 'text') && !empty($product_option['validation']) && !oc_validate_regex($option[$product_option['product_option_id']], $product_option['validation'])) {
					$json['error']['option_' . $product_option['product_option_id']] = sprintf($this->language->get('error_regex'), $product_option['name']);
				}
			}

			// Validate subscription products
			$subscriptions = $this->model_catalog_product->getSubscriptions($product_id);

			if ($subscriptions && (!$subscription_plan_id || !in_array($subscription_plan_id, array_column($subscriptions, 'subscription_plan_id')))) {
				$json['error']['subscription'] = $this->language->get('error_subscription');
			}
		} elseif ($subscription_plan_id) {
			// Allow subscription-only adds where no product record exists (product_id may be 0)
			// Create a minimal product_info stub so downstream logic can run without errors.
			$product_info = [
				'name' => $this->language->get('text_subscription') ?? 'Subscription',
				'master_id' => 0,
				'override' => [],
				'variant' => []
			];
		} else {
			$json['error']['warning'] = $this->language->get('error_product');
		}

		if (!$json) {
			// Prepare cart override metadata for subscriptions (kept separate from product option/variant override)
			$cart_override = [];

			if ($subscription_plan_id) {
				// Store metadata as top-level override keys so cart products keep full subscription data
				$cart_override['subscription_plan_id'] = $subscription_plan_id;

				if (isset($this->request->post['frequency_id'])) {
					$cart_override['subscription_plan_frequency_id'] = (int)$this->request->post['frequency_id'];
				}

				if (isset($this->request->post['delivery_date'])) {
					$cart_override['delivery_date'] = $this->request->post['delivery_date'];
				}

				if (isset($this->request->post['is_gift'])) {
					$cart_override['is_gift'] = $this->request->post['is_gift'] === 'yes' || (int)$this->request->post['is_gift'] ? 1 : 0;
				}

				if (isset($this->request->post['gift_id'])) {
					$cart_override['gift_id'] = (int)$this->request->post['gift_id'];
				}

				if (isset($this->request->post['vase_id'])) {
					$cart_override['vase_id'] = (int)$this->request->post['vase_id'];
				}

				// Map duration if provided
				if (isset($this->request->post['duration_id'])) {
					$cart_override['duration'] = (int)$this->request->post['duration_id'];
				}
			}

			$this->cart->add($product_id, $quantity, $option, $subscription_plan_id, $cart_override);

			// Add vase and gift card as separate products if selected
			$vase_product_info = null;
			$gift_product_info = null;
			
			if ($subscription_plan_id) {
				// Add vase as a separate product if selected
				if (isset($cart_override['vase_id']) && $cart_override['vase_id'] > 0) {
					$vase_product_info = $this->model_catalog_product->getProduct($cart_override['vase_id']);
					if ($vase_product_info) {
						$this->cart->add($cart_override['vase_id'], 1, [], 0, [
							'linked_to_subscription' => $subscription_plan_id,
							'is_vase_addon' => 1
						]);
					}
				}
				
				// Add gift card as a separate product if selected
				if (isset($cart_override['gift_id']) && $cart_override['gift_id'] > 0) {
					$gift_product_info = $this->model_catalog_product->getProduct($cart_override['gift_id']);
					if ($gift_product_info) {
						$this->cart->add($cart_override['gift_id'], 1, [], 0, [
							'linked_to_subscription' => $subscription_plan_id,
							'is_gift_addon' => 1
						]);
					}
				}
			}

			// Build a friendly name and link for success message.
			if (!empty($product_info) && isset($product_info['product_id']) && (int)$product_info['product_id']) {
				$product_link = $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . (int)$product_id);
				$product_name = $product_info['name'];
			} elseif ($subscription_plan_id) {
				// Try to resolve subscription plan name
				$plan_query = $this->db->query("SELECT `name` FROM `" . DB_PREFIX . "subscription_plan_description` WHERE `subscription_plan_id` = '" . (int)$subscription_plan_id . "' AND `language_id` = '" . (int)$this->config->get('config_language_id') . "' LIMIT 1");
				if ($plan_query->num_rows) {
					$product_name = $plan_query->row['name'];
				} else {
					$product_name = $product_info['name'] ?? $this->language->get('text_subscription') ?? 'Subscription';
				}

				$product_link = $this->url->link('product/subscription', 'language=' . $this->config->get('config_language') . '&subscription_plan_id=' . (int)$subscription_plan_id);
			} else {
				$product_link = $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . (int)$product_id);
				$product_name = $product_info['name'] ?? '';
			}

			$json['success'] = sprintf($this->language->get('text_success'), $product_link, $product_name, $this->url->link('checkout/cart', 'language=' . $this->config->get('config_language')));

			// Prepare popup data with product details
			$this->load->model('tool/image');
			
			$popup_product = [];
			
			if ($product_info && isset($product_info['product_id']) && $product_info['product_id']) {
				// Get full product details for popup
				$full_product = $this->model_catalog_product->getProduct($product_id);
				
				if ($full_product) {
					$popup_product = [
						'product_id' => $full_product['product_id'],
						'name' => $full_product['name'],
						'model' => $full_product['model'],
						'image' => $this->model_tool_image->resize($full_product['image'], 400, 400),
						'quantity' => $quantity,
						'price' => $this->currency->format($this->tax->calculate($full_product['price'], $full_product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']),
						'href' => $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . $full_product['product_id'])
					];
				}
			} elseif ($subscription_plan_id) {
				// Build popup data for subscription-only adds - fetch subscription plan details
				$this->load->model('catalog/subscription_plan');
				$subscription_plan_info = $this->model_catalog_subscription_plan->getSubscriptionPlan($subscription_plan_id);
				
				// Get subscription plan image
				$subscription_image = 'placeholder.png';
				if (!empty($subscription_plan_info['image'])) {
					$subscription_image = $subscription_plan_info['image'];
				}
				
				// Get subscription plan price
				$subscription_price = '';
				if (isset($subscription_plan_info['price']) && $subscription_plan_info['price'] > 0) {
					$subscription_price = $this->currency->format($subscription_plan_info['price'], $this->session->data['currency']);
				}
				
				$popup_product = [
					'product_id' => 0,
					'name' => $product_name,
					'model' => '',
					'image' => $this->model_tool_image->resize($subscription_image, 400, 400),
					'quantity' => $quantity,
					'price' => $subscription_price,
					'href' => $product_link
				];
			}
			
			if (!empty($popup_product)) {
				$popup_data = [
					'product' => $popup_product,
					'related' => []
				];
				
				// Get related products for regular products
				if ($product_id) {
					$related_products = $this->model_catalog_product->getRelated($product_id);
					
					if ($related_products) {
						$results = array_slice($related_products, 0, 4); // Limit to 4 related products
						
						foreach ($results as $related) {
							$related_info = $this->model_catalog_product->getProduct($related['product_id']);
							
							if ($related_info) {
								$popup_data['related'][] = [
									'product_id' => $related_info['product_id'],
									'name' => $related_info['name'],
									'thumb' => $this->model_tool_image->resize($related_info['image'], 200, 200),
									'price' => $this->currency->format($this->tax->calculate($related_info['price'], $related_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']),
									'href' => $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . $related_info['product_id'])
								];
							}
						}
					}
				}
				
				// Get related products for subscriptions
				if ($subscription_plan_id && empty($popup_data['related'])) {
					$related_products = $this->model_catalog_subscription_plan->getRelatedProducts($subscription_plan_id);
					
					if ($related_products) {
						$results = array_slice($related_products, 0, 4); // Limit to 4 related products
						
						foreach ($results as $related) {
							$related_info = $this->model_catalog_product->getProduct($related['product_id']);
							
							if ($related_info) {
								$popup_data['related'][] = [
									'product_id' => $related_info['product_id'],
									'name' => $related_info['name'],
									'thumb' => $this->model_tool_image->resize($related_info['image'], 200, 200),
									'price' => $this->currency->format($this->tax->calculate($related_info['price'], $related_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']),
									'href' => $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . $related_info['product_id'])
								];
							}
						}
					}
				}
				
				// Add addon products (vase and gift) to popup data
				$popup_data['addons'] = [];
				
				if ($vase_product_info) {
					$popup_data['addons'][] = [
						'type' => 'vase',
						'name' => $vase_product_info['name'],
						'image' => $this->model_tool_image->resize($vase_product_info['image'], 100, 100),
						'price' => $this->currency->format($this->tax->calculate($vase_product_info['price'], $vase_product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
					];
				}
				
				if ($gift_product_info) {
					$popup_data['addons'][] = [
						'type' => 'gift',
						'name' => $gift_product_info['name'],
						'image' => $this->model_tool_image->resize($gift_product_info['image'], 100, 100),
						'price' => $this->currency->format($this->tax->calculate($gift_product_info['price'], $gift_product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
					];
				}
				
				// Add subscription options to popup data if present
				if ($subscription_plan_id && !empty($cart_override)) {
					$popup_data['subscription_options'] = [];
					
					// Add frequency
					if (isset($cart_override['subscription_plan_frequency_id'])) {
						$freq_query = $this->db->query("SELECT `frequency`, `cycle` FROM `" . DB_PREFIX . "subscription_plan_frequency` WHERE `subscription_plan_frequency_id` = '" . (int)$cart_override['subscription_plan_frequency_id'] . "' LIMIT 1");
						if ($freq_query->num_rows) {
							$popup_data['subscription_options']['frequency'] = 'Every ' . $freq_query->row['cycle'] . ' ' . strtoupper($freq_query->row['frequency']);
						}
					}
					
					// Add delivery date
					if (isset($cart_override['delivery_date'])) {
						$popup_data['subscription_options']['delivery_date'] = date('F j, Y', strtotime($cart_override['delivery_date']));
					}
					
					// Add duration
					if (isset($cart_override['duration']) && $cart_override['duration'] > 0) {
						$dur_query = $this->db->query("SELECT `label` FROM `" . DB_PREFIX . "subscription_plan_duration` WHERE `subscription_plan_duration_id` = '" . (int)$cart_override['duration'] . "' LIMIT 1");
						if ($dur_query->num_rows) {
							$popup_data['subscription_options']['duration'] = $dur_query->row['label'];
						}
					} else {
						$popup_data['subscription_options']['duration'] = 'On Going';
					}
					
					// Add gift status
					if (isset($cart_override['is_gift'])) {
						$popup_data['subscription_options']['is_gift'] = $cart_override['is_gift'] ? 'Yes' : 'No';
					}
				}
				
				// Add URLs for the sidebar
				$popup_data['cart'] = $this->url->link('checkout/cart', 'language=' . $this->config->get('config_language'));
				$popup_data['checkout'] = $this->url->link('checkout/checkout', 'language=' . $this->config->get('config_language'));
				
				// Render popup HTML server-side
				$json['popup_html'] = $this->load->view('common/cart_popup_content', $popup_data);
			}

			// Unset all shipping and payment methods
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
		} else {
			$json['redirect'] = $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . $product_id, true);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Edit
	 *
	 * @return void
	 */
	public function edit(): void {
		$this->load->language('checkout/cart');

		$json = [];

		if (isset($this->request->post['key'])) {
			$key = (int)$this->request->post['key'];
		} else {
			$key = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = (int)$this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		// Handles single item update
		$this->cart->update($key, $quantity);

		if ($this->cart->hasProducts()) {
			$json['success'] = $this->language->get('text_edit');
		} else {
			$json['redirect'] = $this->url->link('checkout/cart', 'language=' . $this->config->get('config_language'), true);
		}

		unset($this->session->data['shipping_method']);
		unset($this->session->data['shipping_methods']);
		unset($this->session->data['payment_method']);
		unset($this->session->data['payment_methods']);
		unset($this->session->data['reward']);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Remove
	 *
	 * @return void
	 */
	public function remove(): void {
		$this->load->language('checkout/cart');

		$json = [];

		if (isset($this->request->get['key'])) {
			$key = (int)$this->request->get['key'];
		} else {
			$key = 0;
		}

		// Remove
		$this->cart->remove($key);

		if ($this->cart->hasProducts()) {
			$json['success'] = $this->language->get('text_remove');
		} else {
			$json['redirect'] = $this->url->link('checkout/cart', 'language=' . $this->config->get('config_language'), true);
		}

		unset($this->session->data['shipping_method']);
		unset($this->session->data['shipping_methods']);
		unset($this->session->data['payment_method']);
		unset($this->session->data['payment_methods']);
		unset($this->session->data['reward']);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
