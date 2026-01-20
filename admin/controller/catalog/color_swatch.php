<?php
namespace Opencart\Admin\Controller\Catalog;
/**
 * Class ColorSwatch
 *
 * Can be loaded using $this->load->controller('catalog/color_swatch');
 *
 * @package Opencart\Admin\Controller\Catalog
 */
class ColorSwatch extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return void
	 */
	public function index(): void {
		$this->load->language('catalog/color_swatch');

		$this->document->setTitle($this->language->get('heading_title'));

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = [];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'user_token=' . $this->session->data['user_token'])
		];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/color_swatch', 'user_token=' . $this->session->data['user_token'] . $url)
		];

		$data['add'] = $this->url->link('catalog/color_swatch.form', 'user_token=' . $this->session->data['user_token'] . $url);
		$data['delete'] = $this->url->link('catalog/color_swatch.delete', 'user_token=' . $this->session->data['user_token']);

		$data['list'] = $this->load->controller('catalog/color_swatch.getList');

		$data['user_token'] = $this->session->data['user_token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/color_swatch', $data));
	}

	/**
	 * List
	 *
	 * @return void
	 */
	public function list(): void {
		$this->load->language('catalog/color_swatch');

		$this->response->setOutput($this->load->controller('catalog/color_swatch.getList'));
	}

	/**
	 * Get List
	 *
	 * @return string
	 */
	public function getList(): string {
		if (isset($this->request->get['sort'])) {
			$sort = (string)$this->request->get['sort'];
		} else {
			$sort = 'title';
		}

		if (isset($this->request->get['order'])) {
			$order = (string)$this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = (int)$this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['action'] = $this->url->link('catalog/color_swatch.list', 'user_token=' . $this->session->data['user_token'] . $url);

		// Color Swatches
		$data['color_swatches'] = [];

		$filter_data = [
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_pagination_admin'),
			'limit' => $this->config->get('config_pagination_admin')
		];

		// Image
		$this->load->model('tool/image');

		$this->load->model('catalog/color_swatch');

		$results = $this->model_catalog_color_swatch->getColorSwatches($filter_data);

		foreach ($results as $result) {
			$image = $result['image'] && is_file(DIR_IMAGE . html_entity_decode($result['image'], ENT_QUOTES, 'UTF-8'))
				? $result['image']
				: 'no_image.png';

			$data['color_swatches'][] = [
				'image' => $this->model_tool_image->resize($image, 40, 40),
				'edit'  => $this->url->link('catalog/color_swatch.form', 'user_token=' . $this->session->data['user_token'] . '&color_swatch_id=' . $result['color_swatch_id'] . $url),
			] + $result;
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		$data['sort_title'] = $this->url->link('catalog/color_swatch.list', 'user_token=' . $this->session->data['user_token'] . '&sort=title' . $url);
		$data['sort_sort_order'] = $this->url->link('catalog/color_swatch.list', 'user_token=' . $this->session->data['user_token'] . '&sort=sort_order' . $url);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$color_swatch_total = $this->model_catalog_color_swatch->getTotalColorSwatches();

		$data['pagination'] = $this->load->controller('common/pagination', [
			'total' => $color_swatch_total,
			'page'  => $page,
			'limit' => $this->config->get('config_pagination_admin'),
			'url'   => $this->url->link('catalog/color_swatch.list', 'user_token=' . $this->session->data['user_token'] . $url . '&page={page}')
		]);

		$data['results'] = sprintf($this->language->get('text_pagination'), ($color_swatch_total) ? (($page - 1) * $this->config->get('config_pagination_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_pagination_admin')) > ($color_swatch_total - $this->config->get('config_pagination_admin'))) ? $color_swatch_total : ((($page - 1) * $this->config->get('config_pagination_admin')) + $this->config->get('config_pagination_admin')), $color_swatch_total, ceil($color_swatch_total / $this->config->get('config_pagination_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		return $this->load->view('catalog/color_swatch_list', $data);
	}

	/**
	 * Form
	 *
	 * @return void
	 */
	public function form(): void {
		$this->load->language('catalog/color_swatch');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['text_form'] = !isset($this->request->get['color_swatch_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = [];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'user_token=' . $this->session->data['user_token'])
		];

		$data['breadcrumbs'][] = [
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/color_swatch', 'user_token=' . $this->session->data['user_token'] . $url)
		];

		$data['save'] = $this->url->link('catalog/color_swatch.save', 'user_token=' . $this->session->data['user_token']);
		$data['back'] = $this->url->link('catalog/color_swatch', 'user_token=' . $this->session->data['user_token'] . $url);

		if (isset($this->request->get['color_swatch_id'])) {
			$this->load->model('catalog/color_swatch');

			$color_swatch_info = $this->model_catalog_color_swatch->getColorSwatch((int)$this->request->get['color_swatch_id']);
		}

		if (!empty($color_swatch_info)) {
			$data['color_swatch_id'] = $color_swatch_info['color_swatch_id'];
		} else {
			$data['color_swatch_id'] = 0;
		}

		if (!empty($color_swatch_info)) {
			$data['title'] = $color_swatch_info['title'];
		} else {
			$data['title'] = '';
		}

		if (!empty($color_swatch_info)) {
			$data['color_code'] = $color_swatch_info['color_code'];
		} else {
			$data['color_code'] = '';
		}

		// Image
		if (!empty($color_swatch_info)) {
			$data['image'] = $color_swatch_info['image'];
		} else {
			$data['image'] = '';
		}

		$this->load->model('tool/image');

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', $this->config->get('config_image_default_width'), $this->config->get('config_image_default_height'));

		if ($data['image'] && is_file(DIR_IMAGE . html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8'))) {
			$data['thumb'] = $this->model_tool_image->resize($data['image'], $this->config->get('config_image_default_width'), $this->config->get('config_image_default_height'));
		} else {
			$data['thumb'] = $data['placeholder'];
		}

		if (!empty($color_swatch_info)) {
			$data['sort_order'] = $color_swatch_info['sort_order'];
		} else {
			$data['sort_order'] = '';
		}

		if (!empty($color_swatch_info)) {
			$data['status'] = $color_swatch_info['status'];
		} else {
			$data['status'] = true;
		}

		$data['user_token'] = $this->session->data['user_token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/color_swatch_form', $data));
	}

	/**
	 * Save
	 *
	 * @return void
	 */
	public function save(): void {
		$this->load->language('catalog/color_swatch');

		$json = [];

		if (!$this->user->hasPermission('modify', 'catalog/color_swatch')) {
			$json['error']['warning'] = $this->language->get('error_permission');
		}

		$required = [
			'color_swatch_id' => 0,
			'title'           => '',
			'color_code'      => '#000000',
			'image'           => '',
			'sort_order'      => 0,
			'status'          => 0
		];

		$post_info = $this->request->post + $required;

		if (!oc_validate_length($post_info['title'], 1, 64)) {
			$json['error']['title'] = $this->language->get('error_title');
		}

		// At least one of color_code or image must be provided
		if (empty($post_info['color_code']) && empty($post_info['image'])) {
			$json['error']['warning'] = $this->language->get('error_color_or_image');
		}

		// Validate color code format if provided
		if (!empty($post_info['color_code']) && !preg_match('/^#[a-fA-F0-9]{6}$/', $post_info['color_code'])) {
			$json['error']['color_code'] = $this->language->get('error_color_code');
		}

		if (isset($json['error']) && !isset($json['error']['warning'])) {
			$json['error']['warning'] = $this->language->get('error_warning');
		}

		if (!$json) {
			$this->load->model('catalog/color_swatch');

			if (!$post_info['color_swatch_id']) {
				$json['color_swatch_id'] = $this->model_catalog_color_swatch->addColorSwatch($post_info);
			} else {
				$this->model_catalog_color_swatch->editColorSwatch($post_info['color_swatch_id'], $post_info);
			}

			$json['success'] = $this->language->get('text_success');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Delete
	 *
	 * @return void
	 */
	public function delete(): void {
		$this->load->language('catalog/color_swatch');

		$json = [];

		if (isset($this->request->post['selected'])) {
			$selected = (array)$this->request->post['selected'];
		} else {
			$selected = [];
		}

		if (!$this->user->hasPermission('modify', 'catalog/color_swatch')) {
			$json['error'] = $this->language->get('error_permission');
		}

		if (!$json) {
			$this->load->model('catalog/color_swatch');

			foreach ($selected as $color_swatch_id) {
				$this->model_catalog_color_swatch->deleteColorSwatch((int)$color_swatch_id);
			}

			$json['success'] = $this->language->get('text_success');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
