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
		// Load models
		$this->load->model('catalog/category');
		$this->load->model('cms/topic');
		$this->load->model('cms/article');
		$this->load->model('tool/image');

		$data['sections'] = [];

		// Section 1: Text Block
		$data['text_block_heading'] = html_entity_decode($this->config->get('homepage_text_block_heading'), ENT_QUOTES, 'UTF-8');
		$data['text_block'] = html_entity_decode($this->config->get('homepage_text_block'), ENT_QUOTES, 'UTF-8');

		// Section 2: Featured Categories
		$data['featured_categories'] = [];

		if ($this->config->get('homepage_featured_categories')) {
			foreach ($this->config->get('homepage_featured_categories') as $item) {
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
		$gift_subscriptions_image = $this->config->get('homepage_gift_subscriptions_image');
		$data['gift_subscriptions_image'] = $gift_subscriptions_image ? $this->model_tool_image->resize($gift_subscriptions_image, 400, 400) : '';

		// Section 3: Static Image
		$static_image = $this->config->get('homepage_static_image');
		$data['static_image'] = 'image/'.$static_image;
		$data['static_image_original'] = $static_image;

		// Section 4: Static Image Text
		$data['static_image_text'] = $this->config->get('homepage_static_image_text');
        //homepage_static_image_header
        $data['static_image_header'] = $this->config->get('homepage_static_image_header');

		// Section 5: Featured Topics/Articles
		$data['featured_header'] = $this->config->get('homepage_featured_header');
		$data['featured_items'] = [];

		if ($this->config->get('homepage_featured_items')) {
			foreach ($this->config->get('homepage_featured_items') as $item) {
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
		$meet_image = $this->config->get('homepage_meet_image');
		$data['meet_image'] = $meet_image ? $this->model_tool_image->resize($meet_image, 600, 600) : '';
		$data['meet_header'] = $this->config->get('homepage_meet_header');
        //nl2br
		$data['meet_paragraph'] =  nl2br($this->config->get('homepage_meet_paragraph'));

		// Section 7: Full Width Banner
		$banner_image = $this->config->get('homepage_banner_image');
		$data['banner_image'] = $banner_image ? $this->model_tool_image->resize($banner_image, 1920, 600) : '';
		$data['banner_image_original'] = $banner_image;

		return $this->load->view('common/homepage_sections', $data);
	}
}
