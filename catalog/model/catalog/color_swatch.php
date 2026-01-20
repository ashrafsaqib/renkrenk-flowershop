<?php
namespace Opencart\Catalog\Model\Catalog;
/**
 * Class ColorSwatch
 *
 * Can be loaded using $this->load->model('catalog/color_swatch');
 *
 * @package Opencart\Catalog\Model\Catalog
 */
class ColorSwatch extends \Opencart\System\Engine\Model {
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
		$query = $this->db->query("SELECT DISTINCT * FROM `" . DB_PREFIX . "color_swatch` WHERE `color_swatch_id` = '" . (int)$color_swatch_id . "' AND `status` = '1'");

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
		$sql = "SELECT * FROM `" . DB_PREFIX . "color_swatch` WHERE `status` = '1'";

		$sort_data = [
			'title',
			'color_code',
			'sort_order'
		];

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY `sort_order`, `title`";
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
}
