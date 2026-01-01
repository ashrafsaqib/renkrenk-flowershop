<?php
namespace Opencart\Catalog\Controller\Extension\Opencart\Module;
/**
 * Class Topic
 *
 * @package Opencart\Catalog\Controller\Extension\Opencart\Module
 */
class Topic extends \Opencart\System\Engine\Controller {
	/**
	 * Index
	 *
	 * @return string
	 */
	public function index(array $setting = []): string {
		$this->load->language('extension/opencart/module/topic');

		$this->load->model('cms/topic');
		$this->load->model('cms/article');
		$this->load->model('tool/image');

		$data['items'] = [];

		if (!empty($setting['items'])) {
			foreach ($setting['items'] as $item) {
				if ($item['type'] == 'topic') {
					$id = explode('-', $item['id'])[1];
					$topic_info = $this->model_cms_topic->getTopic((int)$id);

					if ($topic_info && $topic_info['status']) {
						// Use custom image if set, otherwise use topic's image
						$image = !empty($item['custom_image']) ? $item['custom_image'] : $topic_info['image'];
						
						$data['items'][] = [
							'type'        => 'topic',
							'name'        => $topic_info['name'],
							'image'       => $image ? $this->model_tool_image->resize($image, 400, 400) : $this->model_tool_image->resize('placeholder.png', 400, 400),
							'href'        => $this->url->link('cms/blog', 'language=' . $this->config->get('config_language') . '&topic_id=' . $topic_info['topic_id']),
							'description' => $item['description'] ?? ''
						];
					}
				} elseif ($item['type'] == 'article') {
					$id = explode('-', $item['id'])[1];
					$article_info = $this->model_cms_article->getArticle((int)$id);

					if ($article_info && $article_info['status']) {
						// Use custom image if set, otherwise use article's image
						$image = !empty($item['custom_image']) ? $item['custom_image'] : $article_info['image'];
						
						$data['items'][] = [
							'type'        => 'article',
							'name'        => $article_info['name'],
							'image'       => $image ? $this->model_tool_image->resize($image, 400, 400) : $this->model_tool_image->resize('placeholder.png', 400, 400),
							'href'        => $this->url->link('cms/blog.info', 'language=' . $this->config->get('config_language') . '&article_id=' . $article_info['article_id']),
							'description' => $item['description'] ?? ''
						];
					}
				}
			}
		}

		if (!empty($data['items'])) {
			return $this->load->view('extension/opencart/module/topic', $data);
		}

		return '';
	}
}
