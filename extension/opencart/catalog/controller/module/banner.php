<?php
namespace Opencart\Catalog\Controller\Extension\Opencart\Module;
/**
 * Class Banner
 *
 * @package Opencart\Catalog\Controller\Extension\Opencart\Module
 */
class Banner extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @param array<string, mixed> $setting array of filters
	 *
	 * @return string
	 */
	public function index(array $setting): string {
		static $module = 0;

		// Banner
		$this->load->model('design/banner');

		// Image
		$this->load->model('tool/image');

		$data['banners'] = [];

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . html_entity_decode($result['image'], ENT_QUOTES, 'UTF-8'))) {
				$data['banners'][] = [
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize(html_entity_decode($result['image'], ENT_QUOTES, 'UTF-8'), $setting['width'], $setting['height'])
				];
			}
		}

		if ($data['banners']) {
			$data['module'] = $module++;

			$data['effect'] = $setting['effect'];
			$data['controls'] = $setting['controls'];
			$data['indicators'] = $setting['indicators'];
			$data['items'] = $setting['items'];
			$data['interval'] = $setting['interval'];
			$data['width'] = $setting['width'];
			$data['height'] = $setting['height'];

			return $this->load->view('extension/opencart/module/banner', $data);
		} else {
			return '';
		}
	}

	/**
	 * Custom
	 * 
	 * Custom method that accepts banners array directly instead of loading from database
	 *
	 * @param array<string, mixed> $setting array of settings including banners array
	 *
	 * @return string
	 */
	public function custom(array $setting): string {
		static $module = 0;

		// Image
		$this->load->model('tool/image');

		$data['banners'] = [];

		// Use provided banners array
		if (isset($setting['banners']) && is_array($setting['banners'])) {
			foreach ($setting['banners'] as $result) {
				if (!empty($result['image']) && is_file(DIR_IMAGE . html_entity_decode($result['image'], ENT_QUOTES, 'UTF-8'))) {
					$data['banners'][] = [
						'title' => $result['title'] ?? '',
						'link'  => $result['link'] ?? '',
						'image' => 'image/'.html_entity_decode($result['image'], ENT_QUOTES, 'UTF-8')
					];
				}
			}
		}

		if ($data['banners']) {
			$data['module'] = $module++;

			$data['effect'] = $setting['effect'] ?? '';
			$data['controls'] = $setting['controls'] ?? true;
			$data['indicators'] = $setting['indicators'] ?? true;
			$data['items'] = $setting['items'] ?? 1;
			$data['interval'] = $setting['interval'] ?? 5000;
			$data['width'] = $setting['width'] ?? 1920;
			$data['height'] = $setting['height'] ?? 600;

			return $this->load->view('extension/opencart/module/banner', $data);
		} else {
			return '';
		}
	}
}
