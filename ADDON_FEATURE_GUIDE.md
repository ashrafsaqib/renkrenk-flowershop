# Add-ons Feature Implementation Guide

This document describes the implementation of the "Add ons" feature for the OpenCart flower shop.

## Overview

The Add-ons feature allows products to have associated add-on products that customers can select and add to their cart along with the main product. This works similarly to the existing vase feature.

## Files Modified

### Backend (Admin)

1. **Database Schema**
   - `product_addon_table.sql` - Creates the `oc_product_to_addon` table

2. **Model**
   - `admin/model/catalog/product.php`
     - Added `addAddon()` method
     - Added `deleteAddons()` method  
     - Added `getAddons()` method
     - Updated `addProduct()` to handle addons
     - Updated `editProduct()` to handle addons

3. **Controller**
   - `admin/controller/catalog/product.php`
     - Added logic to fetch and prepare addon data for the form

4. **View**
   - `admin/view/template/catalog/product_form.twig`
     - Added "Add ons" tab in navigation
     - Added addon selection interface (autocomplete + list)
     - Added JavaScript autocomplete for addon products

5. **Language**
   - `admin/language/en-gb/catalog/product.php`
     - Added `$_['tab_addon']` = 'Add ons'
     - Added `$_['entry_addon']` = 'Add on Products'
     - Added `$_['help_addon']` = '(Autocomplete)'

### Frontend (Catalog)

1. **Model**
   - `catalog/model/catalog/product.php`
     - Added `getAddons()` method to fetch addon products

2. **Controller**
   - `catalog/controller/product/product.php`
     - Added logic to fetch and prepare addon data for display
   - `catalog/controller/checkout/cart.php`
     - Added logic to handle addon_id from POST data
     - Added logic to add selected addons as separate cart items

3. **View**
   - `catalog/view/template/product/product.twig`
     - Added addon selection UI with checkboxes
     - Added JavaScript for addon selection toggle
     - Added CSS styles for addon buttons
   - `catalog/view/template/checkout/cart_list.twig`
     - Added display for addon items in cart

## Database Setup

Run the following SQL file to create the required table:

```bash
mysql -u [username] -p [database_name] < product_addon_table.sql
```

Or execute the SQL directly:

```sql
CREATE TABLE IF NOT EXISTS `oc_product_to_addon` (
  `product_id` int(11) NOT NULL,
  `addon_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`addon_id`),
  KEY `addon_id` (`addon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `oc_product_to_addon`
  ADD CONSTRAINT `fk_product_to_addon_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_product_to_addon_addon` FOREIGN KEY (`addon_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;
```

## How to Use

### Admin Side

1. Go to Catalog > Products
2. Edit or create a product
3. Click on the "Add ons" tab
4. Use the autocomplete field to search and add products as add-ons
5. Selected add-ons will appear in the list below
6. Click the minus button to remove an add-on
7. Save the product

### Customer Side

1. Navigate to a product page that has add-ons configured
2. Below the vase selection (if present), you'll see an "Add ons" section
3. Click on addon images to select/deselect them (checkboxes)
4. Selected addons will have a green border
5. Add the product to cart - selected addons will be added as separate items
6. In the cart, addon items are marked with "➕ Product Addon"

## Features

- **Multiple Selection**: Unlike vases (radio buttons), addons use checkboxes allowing multiple selections
- **Visual Feedback**: Selected addons have a green border and active state
- **Separate Cart Items**: Each selected addon is added as a separate line item in the cart
- **Subscription Support**: Addons are linked to subscription products when applicable
- **Autocomplete**: Easy search and selection in admin panel
- **Responsive Design**: Works on all screen sizes

## Technical Details

### Data Flow

1. Admin selects addon products via autocomplete
2. Product IDs are stored in `oc_product_to_addon` table
3. Frontend fetches addons using `getAddons()` method
4. Customer selects addons via checkboxes
5. Selected addon IDs are sent as array in POST data: `addon_id[]`
6. Cart controller adds each addon as separate cart item with metadata:
   - `is_addon` = 1
   - `linked_to_subscription` = subscription_plan_id (if applicable)

### Differences from Vase Feature

- **Selection Type**: Checkboxes (multiple) vs Radio buttons (single)
- **Border Color**: Green for active addons vs Blue for active vase
- **Field Name**: `addon_id[]` (array) vs `vase_id` (single value)
- **Database Table**: `oc_product_to_addon` vs `oc_product_to_vase`

## Future Enhancements

Potential improvements for this feature:

1. Add pricing display for each addon
2. Add quantity selection for addons
3. Add required/optional flag for addons
4. Add sorting/ordering for addons
5. Add addon categories/groups
6. Add conditional display based on product options
