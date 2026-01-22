# Product Option Value Addon System

## Overview
This system allows you to associate specific addon products with individual product option values (currently for radio-type options only). For example, if a product has a "Size" option with values "Small", "Medium", and "Large", you can assign different addon products to each size.

## Database Structure

### Table: `oc_product_option_value_addon`
```sql
CREATE TABLE IF NOT EXISTS `oc_product_option_value_addon` (
  `product_option_value_addon_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `product_option_id` int(11) NOT NULL,
  `product_option_value_id` int(11) NOT NULL,
  `addon_product_id` int(11) NOT NULL,
  PRIMARY KEY (`product_option_value_addon_id`),
  KEY `product_id` (`product_id`),
  KEY `product_option_id` (`product_option_id`),
  KEY `product_option_value_id` (`product_option_value_id`),
  KEY `addon_product_id` (`addon_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```

## Data Flow

### 1. Form Submission
When saving a product, the data is submitted in this format:
```
product_option_addon[product_option_id][product_option_value_id][] = addon_product_id
```

**Example:**
```
product_option_addon[15][45][] = 123
product_option_addon[15][45][] = 456
product_option_addon[15][46][] = 789
```

This means:
- For product option ID 15, option value ID 45: addon products 123 and 456
- For product option ID 15, option value ID 46: addon product 789

### 2. Controller Processing (addProduct/editProduct)
The controller in `admin/model/catalog/product.php` processes this data:

```php
// Option Value Addons
$this->model_catalog_product->deleteOptionValueAddons($product_id);

if (isset($data['product_option_addon'])) {
    foreach ($data['product_option_addon'] as $product_option_id => $option_values) {
        foreach ($option_values as $product_option_value_id => $addon_products) {
            if (is_array($addon_products)) {
                foreach ($addon_products as $addon_product_id) {
                    if ((int)$addon_product_id > 0) {
                        $this->model_catalog_product->addOptionValueAddon(
                            $product_id, 
                            (int)$product_option_id, 
                            (int)$product_option_value_id, 
                            (int)$addon_product_id
                        );
                    }
                }
            }
        }
    }
}
```

### 3. Model Methods

#### addOptionValueAddon()
Adds a single option value addon record.
```php
public function addOptionValueAddon(
    int $product_id, 
    int $product_option_id, 
    int $product_option_value_id, 
    int $addon_product_id
): void
```

#### deleteOptionValueAddons()
Deletes all option value addons for a product.
```php
public function deleteOptionValueAddons(int $product_id): void
```

#### getOptionValueAddons()
Retrieves all option value addons for a product.
```php
public function getOptionValueAddons(int $product_id): array
```

Returns:
```php
[
    [
        'product_option_id' => 15,
        'product_option_value_id' => 45,
        'addon_product_id' => 123
    ],
    // ...
]
```

#### getOptionValueAddonsByOptionValue()
Gets addon products for a specific option value.
```php
public function getOptionValueAddonsByOptionValue(
    int $product_id, 
    int $product_option_value_id
): array
```

Returns: Array of addon product IDs

## Frontend Implementation

### HTML Structure
Located in `admin/view/template/catalog/product_form.twig` within the Addons tab:

```twig
<div class="row mb-3">
  <label class="col-sm-2 col-form-label">Product Option Related Values</label>
  <div class="col-sm-10">
    <div id="product-option-addon-container">
      {% if product_id %}
        <!-- Options loaded dynamically via AJAX -->
      {% else %}
        <div class="alert alert-info">
          Save product once to start adding option based addons.
        </div>
      {% endif %}
    </div>
  </div>
</div>
```

### JavaScript Functions

#### loadProductOptionAddons()
Fetches radio options and their values via AJAX, then renders the UI.

```javascript
$.ajax({
    url: 'index.php?route=catalog/product.getProductOptionsForAddons&user_token={{ user_token }}&product_id={{ product_id }}',
    // ...
});
```

#### initializeOptionAddonAutocomplete()
Sets up autocomplete on each option value input field to search and select addon products.

## AJAX Endpoint

### Route: `catalog/product.getProductOptionsForAddons`

**Request:**
```
GET index.php?route=catalog/product.getProductOptionsForAddons&user_token=XXX&product_id=123
```

**Response:**
```json
[
    {
        "product_option_id": 15,
        "option_id": 5,
        "name": "Size",
        "type": "radio",
        "product_option_value": [
            {
                "product_option_value_id": 45,
                "option_value_id": 12,
                "name": "Small",
                "addons": [
                    {
                        "product_id": 123,
                        "name": "Small Box"
                    }
                ]
            },
            {
                "product_option_value_id": 46,
                "option_value_id": 13,
                "name": "Large",
                "addons": []
            }
        ]
    }
]
```

## Usage Flow

1. **Create/Edit Product**: Navigate to Catalog > Products > Edit Product
2. **Add Options**: Go to the "Option" tab and add radio-type options with values
3. **Save Product**: Click Save to create the product
4. **Go to Addons Tab**: Click on the "Addons" tab
5. **Assign Option-Based Addons**:
   - The system automatically loads all radio options
   - For each option value, you'll see an autocomplete field
   - Search for products and select them as addons
   - Each option value can have multiple addon products
6. **Save**: Click Save to persist the relationships

## Installation

1. Run the SQL file to create the table:
```bash
mysql -u username -p database_name < product_option_value_addon_table.sql
```

2. All code changes are already implemented in:
   - `/admin/view/template/catalog/product_form.twig` (UI)
   - `/admin/controller/catalog/product.php` (Controller method)
   - `/admin/model/catalog/product.php` (Model methods and save logic)

## Future Enhancements

- Support for other option types (select, checkbox)
- Bulk management interface
- Import/export capabilities
- Frontend catalog integration to display related addons based on selected options
