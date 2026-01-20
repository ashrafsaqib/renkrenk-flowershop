<?php
namespace Opencart\Catalog\Controller\Extension\Opencart\Module;
/**
 * Class Category
 *
 * @package Opencart\Catalog\Controller\Extension\Opencart\Module
 */
class Category extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return string
	 */
	public function index(): string {
		$this->load->language('extension/opencart/module/category');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = [];
		}

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		} else {
			$data['category_id'] = 0;
		}

		if (isset($parts[1])) {
			$data['child_id'] = $parts[1];
		} else {
			$data['child_id'] = 0;
		}

		// Category
		$this->load->model('catalog/category');

		// Product
		$this->load->model('catalog/product');

		$data['categories'] = [];

		// Check if we're on a category page and if it has subcategories
		$show_only_subcategories = false;
		if ($data['category_id']) {
			$subcategories = $this->model_catalog_category->getCategories($data['category_id']);
			if (!empty($subcategories)) {
				$show_only_subcategories = true;
				// Show only the subcategories of the current category
				foreach ($subcategories as $child) {
					$filter_data = [
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					];

					$data['categories'][] = [
						'category_id' => $child['category_id'],
						'name'        => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'children'    => [],
						'href'        => $this->url->link('product/category', 'language=' . $this->config->get('config_language') . '&path=' . $data['category_id'] . '_' . $child['category_id'])
					];
				}
			}
		}

		// If not showing only subcategories, show all top-level categories
		if (!$show_only_subcategories) {
			$categories = $this->model_catalog_category->getCategories(0);

			foreach ($categories as $category) {
				$children_data = [];

				if ($category['category_id'] == $data['category_id']) {
					$children = $this->model_catalog_category->getCategories($category['category_id']);

					foreach ($children as $child) {
						$filter_data = [
							'filter_category_id'  => $child['category_id'],
							'filter_sub_category' => true
						];

						$children_data[] = [
							'category_id' => $child['category_id'],
							'name'        => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
							'href'        => $this->url->link('product/category', 'language=' . $this->config->get('config_language') . '&path=' . $category['category_id'] . '_' . $child['category_id'])
						];
					}
				}

				$filter_data = [
					'filter_category_id'  => $category['category_id'],
					'filter_sub_category' => true
				];

				$data['categories'][] = [
					'category_id' => $category['category_id'],
					'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'children'    => $children_data,
					'href'        => $this->url->link('product/category', 'language=' . $this->config->get('config_language') . '&path=' . $category['category_id'])
				];
			}
		}

		$data['heading_title'] = $this->language->get('heading_title');

		return $this->load->view('extension/opencart/module/category', $data);
	}
}
