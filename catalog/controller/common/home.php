<?php
namespace Opencart\Catalog\Controller\Common;
/**
 * Class Home
 *
 * Can be called from $this->load->controller('common/home');
 *
 * @package Opencart\Catalog\Controller\Common
 */
class Home extends \Opencart\System\Engine\Controller {
		/**
	 * Save user location (city and district) from AJAX request to session
	 */
	public function location(): void {
		$city = isset($this->request->post['city']) ? $this->request->post['city'] : '';
		$district = isset($this->request->post['district']) ? $this->request->post['district'] : '';

		$this->session->data['user_city'] = $city;
		$this->session->data['user_district'] = $district;

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode([
			'success' => true,
			'city' => $city,
			'district' => $district
		]));
	}
	/**
	 * Index
	 *
	 * @return void
	 */
	public function index(): void {
		$description = $this->config->get('config_description');
		$language_id = $this->config->get('config_language_id');

		if (isset($description[$language_id])) {
			$this->document->setTitle($description[$language_id]['meta_title']);
			$this->document->setDescription($description[$language_id]['meta_description']);
			$this->document->setKeywords($description[$language_id]['meta_keyword']);
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/home', $data));
	}
}
