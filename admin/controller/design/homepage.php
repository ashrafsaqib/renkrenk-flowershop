<?php
namespace Opencart\Admin\Controller\Design;
/**
 * Class HomePage
 *
 * @package Opencart\Admin\Controller\Design
 */
class HomePage extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return void
	 */
	public function index(): void {
		$this->load->model('tool/image');

		$this->load->language('design/homepage');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = [];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'user_token=' . $this->session->data['user_token'])
		];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('design/homepage', 'user_token=' . $this->session->data['user_token'])
		];

		$data['save'] = $this->url->link('design/homepage.save', 'user_token=' . $this->session->data['user_token']);
		$data['back'] = $this->url->link('common/dashboard', 'user_token=' . $this->session->data['user_token']);

		// Load settings
		$this->load->model('setting/setting');

		$setting_info = $this->model_setting_setting->getSetting('homepage');

		// Text Block
		if (isset($setting_info['homepage_text_block_heading'])) {
			$data['homepage_text_block_heading'] = $setting_info['homepage_text_block_heading'];
		} else {
			$data['homepage_text_block_heading'] = '';
		}

		if (isset($setting_info['homepage_text_block'])) {
			$data['homepage_text_block'] = $setting_info['homepage_text_block'];
		} else {
			$data['homepage_text_block'] = '';
		}

		// Featured Categories
		if (isset($setting_info['homepage_featured_categories'])) {
			$data['homepage_featured_categories'] = $setting_info['homepage_featured_categories'];
		} else {
			$data['homepage_featured_categories'] = [];
		}

		// Load categories for display
		$data['categories'] = [];

		if (!empty($data['homepage_featured_categories'])) {
			$this->load->model('catalog/category');

			foreach ($data['homepage_featured_categories'] as $item) {
				$category_id = is_array($item) && isset($item['category_id']) ? $item['category_id'] : $item;
				$category_info = $this->model_catalog_category->getCategory($category_id);

				if ($category_info) {
					$image = !empty($item['custom_image']) ? $item['custom_image'] : $category_info['image'];
					
					$data['categories'][] = [
						'category_id'  => $category_info['category_id'],
						'name'         => $category_info['name'],
						'image'        => $image ? $this->model_tool_image->resize($image, 40, 40) : '',
						'custom_image' => is_array($item) && isset($item['custom_image']) ? $item['custom_image'] : '',
						'thumb'        => $image ? $this->model_tool_image->resize($image, 100, 100) : ''
					];
				}
			}
		}

		// Static Image
		if (isset($setting_info['homepage_static_image'])) {
			$data['homepage_static_image'] = $setting_info['homepage_static_image'];
		} else {
			$data['homepage_static_image'] = '';
		}

        // subscription list link 
        $data['subscription_list_link'] = $this->url->link('marketing/subscription', 'user_token=' . $this->session->data['user_token']);

		// Static Image Header
		if (isset($setting_info['homepage_static_image_header'])) {
			$data['homepage_static_image_header'] = $setting_info['homepage_static_image_header'];
		} else {
			$data['homepage_static_image_header'] = '';
		}

		// Static Image Text
		if (isset($setting_info['homepage_static_image_text'])) {
			$data['homepage_static_image_text'] = $setting_info['homepage_static_image_text'];
		} else {
			$data['homepage_static_image_text'] = '';
		}

		// Featured Topics/Articles Header
		if (isset($setting_info['homepage_featured_header'])) {
			$data['homepage_featured_header'] = $setting_info['homepage_featured_header'];
		} else {
			$data['homepage_featured_header'] = '';
		}

		// Featured Topics/Articles Items
		$this->load->model('cms/topic');
		$this->load->model('cms/article');

		$data['featured_items'] = [];

		if (!empty($setting_info['homepage_featured_items'])) {
			$items = $setting_info['homepage_featured_items'];
		} else {
			$items = [];
		}

		foreach ($items as $item) {
			if ($item['type'] == 'topic') {
				$id = explode('-', $item['id'])[1];
				$topic_info = $this->model_cms_topic->getTopic((int)$id);

				if ($topic_info) {
					$image = !empty($item['custom_image']) ? $item['custom_image'] : $topic_info['image'];
					
					$data['featured_items'][] = [
						'id'           => $item['id'],
						'type'         => 'topic',
						'name'         => $topic_info['name'],
						'image'        => $image ? $this->model_tool_image->resize($image, 40, 40) : '',
						'custom_image' => $item['custom_image'] ?? '',
						'thumb'        => $image ? $this->model_tool_image->resize($image, 100, 100) : '',
						'description'  => $item['description'] ?? ''
					];
				}
			} elseif ($item['type'] == 'article') {
				$id = explode('-', $item['id'])[1];
				$article_info = $this->model_cms_article->getArticle((int)$id);

				if ($article_info) {
					$image = !empty($item['custom_image']) ? $item['custom_image'] : $article_info['image'];
					
					$data['featured_items'][] = [
						'id'           => $item['id'],
						'type'         => 'article',
						'name'         => $article_info['name'],
						'image'        => $image ? $this->model_tool_image->resize($image, 40, 40) : '',
						'custom_image' => $item['custom_image'] ?? '',
						'thumb'        => $image ? $this->model_tool_image->resize($image, 100, 100) : '',
						'description'  => $item['description'] ?? ''
					];
				}
			}
		}

		// Gift Subscriptions Image
		if (isset($setting_info['homepage_gift_subscriptions_image'])) {
			$data['homepage_gift_subscriptions_image'] = $setting_info['homepage_gift_subscriptions_image'];
		} else {
			$data['homepage_gift_subscriptions_image'] = '';
		}
		// Meet Section Image
		if (isset($setting_info['homepage_meet_image'])) {
			$data['homepage_meet_image'] = $setting_info['homepage_meet_image'];
		} else {
			$data['homepage_meet_image'] = '';
		}

		// Meet Section Header
		if (isset($setting_info['homepage_meet_header'])) {
			$data['homepage_meet_header'] = $setting_info['homepage_meet_header'];
		} else {
			$data['homepage_meet_header'] = '';
		}

		// Meet Section Paragraph
		if (isset($setting_info['homepage_meet_paragraph'])) {
			$data['homepage_meet_paragraph'] = $setting_info['homepage_meet_paragraph'];
		} else {
			$data['homepage_meet_paragraph'] = '';
		}

		// Full Width Banner
		if (isset($setting_info['homepage_banner_image'])) {
			$data['homepage_banner_image'] = $setting_info['homepage_banner_image'];
		} else {
			$data['homepage_banner_image'] = '';
		}

		// Image placeholder

		if (is_file(DIR_IMAGE . html_entity_decode($data['homepage_static_image'], ENT_QUOTES, 'UTF-8'))) {
			$data['static_image_thumb'] = $this->model_tool_image->resize(html_entity_decode($data['homepage_static_image'], ENT_QUOTES, 'UTF-8'), 100, 100);
		} else {
			$data['static_image_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		if (is_file(DIR_IMAGE . html_entity_decode($data['homepage_meet_image'], ENT_QUOTES, 'UTF-8'))) {
			$data['meet_image_thumb'] = $this->model_tool_image->resize(html_entity_decode($data['homepage_meet_image'], ENT_QUOTES, 'UTF-8'), 100, 100);
		} else {
			$data['meet_image_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		if (is_file(DIR_IMAGE . html_entity_decode($data['homepage_banner_image'], ENT_QUOTES, 'UTF-8'))) {
			$data['banner_image_thumb'] = $this->model_tool_image->resize(html_entity_decode($data['homepage_banner_image'], ENT_QUOTES, 'UTF-8'), 100, 100);
		} else {
			$data['banner_image_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		if (is_file(DIR_IMAGE . html_entity_decode($data['homepage_gift_subscriptions_image'], ENT_QUOTES, 'UTF-8'))) {
			$data['gift_subscriptions_image_thumb'] = $this->model_tool_image->resize(html_entity_decode($data['homepage_gift_subscriptions_image'], ENT_QUOTES, 'UTF-8'), 100, 100);
		} else {
			$data['gift_subscriptions_image_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$data['user_token'] = $this->session->data['user_token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('design/homepage', $data));
	}

	/**
	 * Save
	 *
	 * @return void
	 */
	public function save(): void {
		$this->load->language('design/homepage');

		$json = [];

		if (!$this->user->hasPermission('modify', 'design/homepage')) {
			$json['error'] = $this->language->get('error_permission');
		}

		if (!$json) {
			$this->load->model('setting/setting');

			$this->model_setting_setting->editSetting('homepage', $this->request->post);

			$json['success'] = $this->language->get('text_success');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Autocomplete
	 *
	 * @return void
	 */
	public function autocomplete(): void {
		$json = [];

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/category');
			$this->load->model('tool/image');

			$filter_data = [
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			];

			$results = $this->model_catalog_category->getCategories($filter_data);

			foreach ($results as $result) {
				$json[] = [
					'category_id' => $result['category_id'],
					'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'image'       => $result['image'] ? $this->model_tool_image->resize($result['image'], 40, 40) : ''
				];
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Autocomplete Topics/Articles
	 *
	 * @return void
	 */
	public function autocompleteTopics(): void {
		$json = [];

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('cms/topic');
			$this->load->model('cms/article');
			$this->load->model('tool/image');

			$filter_name = $this->request->get['filter_name'];

			// Search topics
			$filter_data = [
				'filter_name' => $filter_name,
				'start'       => 0,
				'limit'       => 5
			];

			$topics = $this->model_cms_topic->getTopics($filter_data);

			foreach ($topics as $topic) {
				$json[] = [
					'id'    => $topic['topic_id'],
					'type'  => 'topic',
					'name'  => strip_tags(html_entity_decode($topic['name'], ENT_QUOTES, 'UTF-8')),
					'image' => $topic['image'] ? $this->model_tool_image->resize($topic['image'], 40, 40) : ''
				];
			}

			// Search articles
			$filter_data = [
				'filter_name' => $filter_name,
				'start'       => 0,
				'limit'       => 5
			];

			$articles = $this->model_cms_article->getArticles($filter_data);

			foreach ($articles as $article) {
				$json[] = [
					'id'    => $article['article_id'],
					'type'  => 'article',
					'name'  => strip_tags(html_entity_decode($article['name'], ENT_QUOTES, 'UTF-8')),
					'image' => $article['image'] ? $this->model_tool_image->resize($article['image'], 40, 40) : ''
				];
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
