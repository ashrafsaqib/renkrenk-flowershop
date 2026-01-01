<?php
namespace Opencart\Admin\Controller\Extension\Opencart\Module;
/**
 * Class Topic
 *
 * @package Opencart\Admin\Controller\Extension\Opencart\Module
 */
class Topic extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return void
	 */
	public function index(): void {
		$this->load->language('extension/opencart/module/topic');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = [];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'user_token=' . $this->session->data['user_token'])
		];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('marketplace/extension', 'user_token=' . $this->session->data['user_token'] . '&type=module')
		];

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = [
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/opencart/module/topic', 'user_token=' . $this->session->data['user_token'])
			];
		} else {
			$data['breadcrumbs'][] = [
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/opencart/module/topic', 'user_token=' . $this->session->data['user_token'] . '&module_id=' . $this->request->get['module_id'])
			];
		}

		if (!isset($this->request->get['module_id'])) {
			$data['save'] = $this->url->link('extension/opencart/module/topic.save', 'user_token=' . $this->session->data['user_token']);
		} else {
			$data['save'] = $this->url->link('extension/opencart/module/topic.save', 'user_token=' . $this->session->data['user_token'] . '&module_id=' . $this->request->get['module_id']);
		}

		$data['back'] = $this->url->link('marketplace/extension', 'user_token=' . $this->session->data['user_token'] . '&type=module');

		// Extension
		if (isset($this->request->get['module_id'])) {
			$this->load->model('setting/module');

			$module_info = $this->model_setting_module->getModule($this->request->get['module_id']);
		}

		if (isset($module_info['name'])) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

		// Load models
		$this->load->model('cms/topic');
		$this->load->model('cms/article');
		$this->load->model('tool/image');

		// Get saved items
		$data['items'] = [];

		if (!empty($module_info['items'])) {
			$items = $module_info['items'];
		} else {
			$items = [];
		}

		foreach ($items as $item) {
			if ($item['type'] == 'topic') {
				$id = explode('-', $item['id'])[1];
				$topic_info = $this->model_cms_topic->getTopic((int)$id);

				if ($topic_info) {
					// Use custom image if set, otherwise use default
					$image = !empty($item['custom_image']) ? $item['custom_image'] : $topic_info['image'];
					
					$data['items'][] = [
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
					// Use custom image if set, otherwise use default
					$image = !empty($item['custom_image']) ? $item['custom_image'] : $article_info['image'];
					
					$data['items'][] = [
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

		if (isset($module_info['status'])) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}

		if (isset($this->request->get['module_id'])) {
			$data['module_id'] = (int)$this->request->get['module_id'];
		} else {
			$data['module_id'] = 0;
		}

		$data['user_token'] = $this->session->data['user_token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/opencart/module/topic', $data));
	}

	/**
	 * Save
	 *
	 * @return void
	 */
	public function save(): void {
		$this->load->language('extension/opencart/module/topic');

		$json = [];

		if (!$this->user->hasPermission('modify', 'extension/opencart/module/topic')) {
			$json['error']['warning'] = $this->language->get('error_permission');
		}

		$required = [
			'module_id' => 0,
			'name'      => ''
		];

		$post_info = $this->request->post + $required;

		if (!oc_validate_length($post_info['name'], 3, 64)) {
			$json['error']['name'] = $this->language->get('error_name');
		}

		if (!$json) {
			// Extension
			$this->load->model('setting/module');

			if (!$post_info['module_id']) {
				$json['module_id'] = $this->model_setting_module->addModule('opencart.topic', $post_info);
			} else {
				$this->model_setting_module->editModule($post_info['module_id'], $post_info);
			}

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
