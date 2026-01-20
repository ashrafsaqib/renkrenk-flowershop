<?php
namespace Opencart\Admin\Model\Catalog;
/**
 * Class ColorSwatch
 *
 * Can be loaded using $this->load->model('catalog/color_swatch');
 *
 * @package Opencart\Admin\Model\Catalog
 */
class ColorSwatch extends \Opencart\System\Engine\Model {
	/**
	 * Add Color Swatch
	 *
	 * Create a new color swatch record in the database.
	 *
	 * @param array<string, mixed> $data array of data
	 *
	 * @return int returns the primary key of the new color swatch record
	 *
	 * @example
	 *
	 * $color_swatch_data = [
	 *     'title'      => 'Red',
	 *     'color_code' => '#FF0000',
	 *     'image'      => 'path/to/image.png',
	 *     'sort_order' => 1,
	 *     'status'     => 1
	 * ];
	 *
	 * $this->load->model('catalog/color_swatch');
	 *
	 * $color_swatch_id = $this->model_catalog_color_swatch->addColorSwatch($color_swatch_data);
	 */
	public function addColorSwatch(array $data): int {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "color_swatch` SET `title` = '" . $this->db->escape((string)$data['title']) . "', `color_code` = '" . $this->db->escape((string)$data['color_code']) . "', `image` = '" . $this->db->escape((string)$data['image']) . "', `sort_order` = '" . (int)$data['sort_order'] . "', `status` = '" . (bool)($data['status'] ?? 1) . "'");

		$color_swatch_id = $this->db->getLastId();

		$this->cache->delete('color_swatch');

		return $color_swatch_id;
	}

	/**
	 * Edit Color Swatch
	 *
	 * Edit color swatch record in the database.
	 *
	 * @param int                  $color_swatch_id primary key of the color swatch record
	 * @param array<string, mixed> $data            array of data
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $color_swatch_data = [
	 *     'title'      => 'Blue',
	 *     'color_code' => '#0000FF',
	 *     'image'      => 'path/to/image.png',
	 *     'sort_order' => 2,
	 *     'status'     => 1
	 * ];
	 *
	 * $this->load->model('catalog/color_swatch');
	 *
	 * $this->model_catalog_color_swatch->editColorSwatch($color_swatch_id, $color_swatch_data);
	 */
	public function editColorSwatch(int $color_swatch_id, array $data): void {
		$this->db->query("UPDATE `" . DB_PREFIX . "color_swatch` SET `title` = '" . $this->db->escape((string)$data['title']) . "', `color_code` = '" . $this->db->escape((string)$data['color_code']) . "', `image` = '" . $this->db->escape((string)$data['image']) . "', `sort_order` = '" . (int)$data['sort_order'] . "', `status` = '" . (bool)($data['status'] ?? 1) . "' WHERE `color_swatch_id` = '" . (int)$color_swatch_id . "'");

		$this->cache->delete('color_swatch');
	}

	/**
	 * Delete Color Swatch
	 *
	 * Delete color swatch record in the database.
	 *
	 * @param int $color_swatch_id primary key of the color swatch record
	 *
	 * @return void
	 *
	 * @example
	 *
	 * $this->load->model('catalog/color_swatch');
	 *
	 * $this->model_catalog_color_swatch->deleteColorSwatch($color_swatch_id);
	 */
	public function deleteColorSwatch(int $color_swatch_id): void {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "color_swatch` WHERE `color_swatch_id` = '" . (int)$color_swatch_id . "'");

		$this->cache->delete('color_swatch');
	}

	/**
	 * Get Color Swatch
	 *
	 * Get the record of the color swatch record in the database.
	 *
	 * @param int $color_swatch_id primary key of the color swatch record
	 *
	 * @return array<string, mixed> color swatch record that has color swatch ID
	 *
	 * @example
	 *
	 * $this->load->model('catalog/color_swatch');
	 *
	 * $color_swatch_info = $this->model_catalog_color_swatch->getColorSwatch($color_swatch_id);
	 */
	public function getColorSwatch(int $color_swatch_id): array {
		$query = $this->db->query("SELECT DISTINCT * FROM `" . DB_PREFIX . "color_swatch` WHERE `color_swatch_id` = '" . (int)$color_swatch_id . "'");

		return $query->row;
	}

	/**
	 * Get Color Swatches
	 *
	 * Get the record of the color swatch records in the database.
	 *
	 * @param array<string, mixed> $data array of filters
	 *
	 * @return array<int, array<string, mixed>> color swatch records
	 *
	 * @example
	 *
	 * $filter_data = [
	 *     'sort'  => 'title',
	 *     'order' => 'ASC',
	 *     'start' => 0,
	 *     'limit' => 10
	 * ];
	 *
	 * $this->load->model('catalog/color_swatch');
	 *
	 * $results = $this->model_catalog_color_swatch->getColorSwatches($filter_data);
	 */
	public function getColorSwatches(array $data = []): array {
		$sql = "SELECT * FROM `" . DB_PREFIX . "color_swatch`";

		if (!empty($data['filter_title'])) {
			$sql .= " WHERE LCASE(`title`) LIKE '" . $this->db->escape(oc_strtolower($data['filter_title']) . '%') . "'";
		}

		$sort_data = [
			'title',
			'color_code',
			'sort_order'
		];

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY `title`";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	/**
	 * Get Total Color Swatches
	 *
	 * Get the total number of color swatch records in the database.
	 *
	 * @return int total number of color swatch records
	 *
	 * @example
	 *
	 * $this->load->model('catalog/color_swatch');
	 *
	 * $color_swatch_total = $this->model_catalog_color_swatch->getTotalColorSwatches();
	 */
	public function getTotalColorSwatches(): int {
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM `" . DB_PREFIX . "color_swatch`");

		return (int)$query->row['total'];
	}
}
