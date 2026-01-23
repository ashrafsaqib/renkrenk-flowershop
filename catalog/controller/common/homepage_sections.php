<?php
namespace Opencart\Catalog\Controller\Common;
/**
 * Class HomepageSections
 *
 * Can be called from $this->load->controller('common/homepage_sections');
 *
 * @package Opencart\Catalog\Controller\Common
 */
class HomepageSections extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return string
	 */
	public function index(): string {
		// Load language file
		$this->load->language('common/header');
		$this->load->language('common/homepage_sections');
		
		// Load models
		$this->load->model('catalog/category');
		$this->load->model('cms/topic');
		$this->load->model('cms/article');
		$this->load->model('tool/image');
		$this->load->model('setting/setting');

		$language_id = (int)$this->config->get('config_language_id');
		$setting_raw = $this->model_setting_setting->getSetting('homepage_' . $language_id);
		$setting_info = [];
		$setting_prefix = 'homepage_' . $language_id . '_';

		foreach ($setting_raw as $key => $value) {
			if (strpos($key, $setting_prefix) === 0) {
				$mapped_key = 'homepage_' . substr($key, strlen($setting_prefix));
				$setting_info[$mapped_key] = $value;
			}
		}

		$get_setting = function(string $key, $default = '') use ($setting_info) {
			return $setting_info[$key] ?? $default;
		};

		$data['sections'] = [];
		
		// Add language variables
		$data['text_from'] = $this->language->get('text_from');
		$data['text_gift_subscription'] = $this->language->get('text_gift_subscription');
		$data['text_shop_now'] = $this->language->get('text_shop_now');
		$data['text_subscribe_now'] = $this->language->get('text_subscribe_now');
		$data['text_discover_world'] = $this->language->get('text_discover_world');
		$data['text_read_more'] = $this->language->get('text_read_more');
		$data['text_discover_flowers'] = $this->language->get('text_discover_flowers');

		// Section 0: Slideshow (using banner module)
		$slideshow_data = $get_setting('homepage_slideshow', []);
		if ($slideshow_data && is_array($slideshow_data)) {
			// Prepare banners array for the banner module
			$banners = [];
			foreach ($slideshow_data as $slide) {
				if (!empty($slide['image'])) {
					$banners[] = [
						'title' => '',
						'link'  => $slide['link'] ?? '',
						'image' => $slide['image']
					];
				}
			}
			
			// Pass to banner module with slideshow settings
			if (!empty($banners)) {
				$setting = [
					'banners'    => $banners,
					'effect'     => 'fade',
					'controls'   => true,
					'indicators' => true,
					'items'      => 1,
					'interval'   => 5000,
					'width'      => 1920,
					'height'     => 600
				];
				
				$data['slideshow'] = $this->load->controller('extension/opencart/module/banner.custom', $setting);
			} else {
				$data['slideshow'] = '';
			}
		} else {
			$data['slideshow'] = '';
		}

		// Section 1: Text Block
		$data['text_block_heading'] = html_entity_decode($get_setting('homepage_text_block_heading'), ENT_QUOTES, 'UTF-8');
		$data['text_block'] = html_entity_decode($get_setting('homepage_text_block'), ENT_QUOTES, 'UTF-8');

		// Section 1.5: Featured Products
		$data['featured_products_header'] = html_entity_decode($get_setting('homepage_featured_products_header'), ENT_QUOTES, 'UTF-8');
		$data['featured_products'] = [];

		if ($get_setting('homepage_featured_products')) {
			$this->load->model('catalog/product');
			
			foreach ($get_setting('homepage_featured_products') as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], 400, 400);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', 400, 400);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					$data['featured_products'][] = [
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'price'       => $price,
						'special'     => $special,
						'tax'         => $this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')),
						'minimum'     => $product_info['minimum'] > 0 ? $product_info['minimum'] : 1,
						'rating'      => (int)$product_info['rating'],
						'href'        => $this->url->link('product/product', 'language=' . $this->config->get('config_language') . '&product_id=' . $product_info['product_id'])
					];
				}
			}
		}

		// Section 2: Featured Categories
		$data['featured_categories'] = [];

		if ($get_setting('homepage_featured_categories')) {
			foreach ($get_setting('homepage_featured_categories') as $item) {
				$category_id = is_array($item) && isset($item['category_id']) ? $item['category_id'] : $item;
				$category_info = $this->model_catalog_category->getCategory($category_id);

				if ($category_info) {
					// Use custom image if set, otherwise use category image
					$image = (is_array($item) && !empty($item['custom_image'])) ? $item['custom_image'] : $category_info['image'];
					
					$data['featured_categories'][] = [
						'category_id' => $category_info['category_id'],
						'name'        => $category_info['name'],
						'description' => $category_info['description'],
						'image'       => $image ? $this->model_tool_image->resize($image, 400, 400) : '',
						'href'        => $this->url->link('product/category', 'language=' . $this->config->get('config_language') . '&path=' . $category_info['category_id'])
					];
				}
			}
		}

		// Gift Subscriptions Image
		$gift_subscriptions_image = $get_setting('homepage_gift_subscriptions_image');
		$data['gift_subscriptions_image'] = $gift_subscriptions_image ? $this->model_tool_image->resize($gift_subscriptions_image, 400, 400) : '';
		
		// Subscription list link
		$data['subscription_list_link'] = $this->url->link('product/subscription', 'language=' . $this->config->get('config_language'));

		// Section 3: Static Image
		$static_image = $get_setting('homepage_static_image');
		$data['static_image'] = $static_image ? 'image/' . $static_image : '';
		$data['static_image_original'] = $static_image;

		// Section 4: Static Image Text
		$data['static_image_text'] = $get_setting('homepage_static_image_text');
        //homepage_static_image_header
		$data['static_image_header'] = $get_setting('homepage_static_image_header');

		// Section 5: Featured Topics/Articles
		$data['featured_header'] = $get_setting('homepage_featured_header');
		$data['featured_items'] = [];

		if ($get_setting('homepage_featured_items')) {
			foreach ($get_setting('homepage_featured_items') as $item) {
				if ($item['type'] == 'topic') {
					$id = explode('-', $item['id'])[1];
					$topic_info = $this->model_cms_topic->getTopic((int)$id);

					if ($topic_info && $topic_info['status']) {
						$image = !empty($item['custom_image']) ? $item['custom_image'] : $topic_info['image'];
						
						$data['featured_items'][] = [
							'type'        => 'topic',
							'name'        => $topic_info['name'],
							'image'       => $image ? $this->model_tool_image->resize($image, 400, 400) : '',
							'href'        => $this->url->link('cms/blog', 'language=' . $this->config->get('config_language') . '&topic_id=' . $topic_info['topic_id']),
							'description' => $item['description'] ?? ''
						];
					}
				} elseif ($item['type'] == 'article') {
					$id = explode('-', $item['id'])[1];
					$article_info = $this->model_cms_article->getArticle((int)$id);

					if ($article_info && $article_info['status']) {
						$image = !empty($item['custom_image']) ? $item['custom_image'] : $article_info['image'];
						
						$data['featured_items'][] = [
							'type'        => 'article',
							'name'        => $article_info['name'],
							'image'       => $image ? $this->model_tool_image->resize($image, 400, 400) : '',
							'href'        => $this->url->link('cms/blog.info', 'language=' . $this->config->get('config_language') . '&article_id=' . $article_info['article_id']),
							'description' => $item['description'] ?? ''
						];
					}
				}
			}
		}

		// Section 6: Meet Section
		$meet_image = $get_setting('homepage_meet_image');
		$data['meet_image'] = $meet_image ? $this->model_tool_image->resize($meet_image, 600, 600) : '';
		$data['meet_header'] = $get_setting('homepage_meet_header');
        //nl2br
		$data['meet_paragraph'] =  nl2br($get_setting('homepage_meet_paragraph'));

		// Section 7: Full Width Banner
		$banner_image = $get_setting('homepage_banner_image');
		$data['banner_image'] = $banner_image ? $this->model_tool_image->resize($banner_image, 1920, 600) : '';
		$data['banner_image_original'] = $banner_image;

		return $this->load->view('common/homepage_sections', $data);
	}
}
