# Subscription Contract System Documentation

## Overview
The subscription contract system tracks all orders related to a subscription, including the initial order and all renewal orders created by the cron job.

## Database Schema

### 1. oc_subscription Table (Enhanced)
Added metadata columns to track subscription-specific details:
- `subscription_plan_frequency_id` - Selected frequency option
- `delivery_date` - Preferred delivery date
- `is_gift` - Whether this is a gift subscription
- `gift_id` - Associated gift card product ID
- `vase_id` - Associated vase product ID
- `duration_id` - Selected duration option

### 2. oc_subscription_order Table (New)
Tracks the relationship between subscriptions and all related orders:
- `subscription_order_id` - Primary key
- `subscription_id` - Foreign key to oc_subscription
- `order_id` - Foreign key to oc_order
- `is_initial_order` - Boolean flag (1 for first order, 0 for renewals)
- `iteration_number` - Which cycle of the subscription (1, 2, 3, etc.)
- `date_added` - Timestamp when the record was created

## Implementation Details

### Initial Order Creation
When a customer places an order with a subscription:

1. **Cart Stage** (`catalog/controller/checkout/cart.php`)
   - Subscription metadata stored in cart override JSON
   - Vase and gift card added as separate products with linking flags

2. **Order Creation** (`catalog/model/checkout/order.php`)
   - Metadata extracted from cart override and saved to oc_order_subscription
   - When order status changes to processing/complete, subscription contract is created

3. **Subscription Contract Creation** (`catalog/model/checkout/subscription.php`)
   - `addSubscription()` method creates subscription with all metadata
   - `addSubscriptionOrder()` method links the subscription to the initial order
   - Sets `is_initial_order = 1` and `iteration_number = 1`

### Renewal Orders
The cron job (`catalog/controller/cron/subscription.php`) processes renewals:

1. **Query Due Subscriptions**
   - Finds subscriptions where `date_next <= NOW()` and `remaining > 0`
   - Only processes active subscriptions

2. **Create Renewal Order**
   - Creates new order with same customer/address/payment info
   - Adds all subscription products to the new order
   - Links the renewal order to subscription via `addSubscriptionOrder()`
   - Sets `is_initial_order = 0` and increments `iteration_number`

3. **Update Subscription**
   - Decrements `remaining` counter
   - Calculates next `date_next` based on frequency
   - If `remaining` reaches 0, marks subscription as expired

## Data Flow Diagram

```
Initial Order:
Customer → Cart → Order → Subscription Contract → oc_subscription_order (iteration 1)
                                                     ↓
                                              is_initial_order = 1

Cron Job Renewal:
Cron → Find Due Subscriptions → Create Order → Link to Subscription → oc_subscription_order (iteration N)
                                                                          ↓
                                                                   is_initial_order = 0
```

## SQL Installation

Run the following SQL file to add the necessary columns and table:
```sql
-- File: subscription_contract_updates.sql

ALTER TABLE `oc_subscription`
  ADD COLUMN IF NOT EXISTS `subscription_plan_frequency_id` INT(11) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `delivery_date` DATE NULL,
  ADD COLUMN IF NOT EXISTS `is_gift` TINYINT(1) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `gift_id` INT(11) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `vase_id` INT(11) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `duration_id` INT(11) DEFAULT 0;

CREATE TABLE IF NOT EXISTS `oc_subscription_order` (
  `subscription_order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `subscription_id` INT(11) NOT NULL,
  `order_id` INT(11) NOT NULL,
  `is_initial_order` TINYINT(1) DEFAULT 0,
  `iteration_number` INT(11) DEFAULT 1,
  `date_added` DATETIME NOT NULL,
  PRIMARY KEY (`subscription_order_id`),
  KEY `subscription_id` (`subscription_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `fk_subscription_order_subscription` 
    FOREIGN KEY (`subscription_id`) 
    REFERENCES `oc_subscription` (`subscription_id`) 
    ON DELETE CASCADE,
  CONSTRAINT `fk_subscription_order_order` 
    FOREIGN KEY (`order_id`) 
    REFERENCES `oc_order` (`order_id`) 
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

## Key Features

### 1. Complete Order History
Query all orders for a subscription:
```php
$query = $this->db->query("
    SELECT so.*, o.order_id, o.date_added, o.total, o.order_status_id
    FROM " . DB_PREFIX . "subscription_order so
    LEFT JOIN " . DB_PREFIX . "order o ON so.order_id = o.order_id
    WHERE so.subscription_id = " . (int)$subscription_id . "
    ORDER BY so.iteration_number ASC
");
```

### 2. Find Initial Order
```php
$query = $this->db->query("
    SELECT order_id 
    FROM " . DB_PREFIX . "subscription_order 
    WHERE subscription_id = " . (int)$subscription_id . " 
    AND is_initial_order = 1
");
```

### 3. Track Renewal Orders
```php
$query = $this->db->query("
    SELECT * 
    FROM " . DB_PREFIX . "subscription_order 
    WHERE subscription_id = " . (int)$subscription_id . " 
    AND is_initial_order = 0
    ORDER BY iteration_number ASC
");
```

### 4. Get Subscription by Order
```php
$query = $this->db->query("
    SELECT s.* 
    FROM " . DB_PREFIX . "subscription s
    INNER JOIN " . DB_PREFIX . "subscription_order so ON s.subscription_id = so.subscription_id
    WHERE so.order_id = " . (int)$order_id . "
");
```

## Usage Examples

### Admin: View All Orders for a Subscription
When viewing a subscription in admin, you can show all related orders:
```php
// In admin/controller/sale/subscription.php
$this->load->model('checkout/subscription');
$subscription_orders = $this->model_checkout_subscription->getSubscriptionOrders($subscription_id);

foreach ($subscription_orders as $sub_order) {
    echo "Order #" . $sub_order['order_id'];
    echo " - Iteration: " . $sub_order['iteration_number'];
    echo " - Type: " . ($sub_order['is_initial_order'] ? 'Initial' : 'Renewal');
}
```

### Customer: View Subscription Orders in Account
```php
// In catalog/controller/account/subscription.php
$subscription_orders = $this->model_checkout_subscription->getSubscriptionOrders($subscription_id);
// Display order history to customer
```

### Analytics: Calculate Subscription Metrics
```php
// Total revenue from a subscription
$query = $this->db->query("
    SELECT SUM(o.total) as total_revenue
    FROM " . DB_PREFIX . "subscription_order so
    INNER JOIN " . DB_PREFIX . "order o ON so.order_id = o.order_id
    WHERE so.subscription_id = " . (int)$subscription_id . "
");

// Average order value for subscriptions
// Subscription retention rate
// etc.
```

## Cron Job Setup

The subscription renewal cron is already configured in OpenCart. Ensure it runs regularly:

1. **Via System Cron** (Recommended)
   ```bash
   # Run every hour
   0 * * * * php /path/to/opencart/index.php route=cron/subscription
   ```

2. **Via OpenCart Admin**
   - Go to System → Maintenance → Cron Jobs
   - Ensure subscription cron is enabled and runs hourly

## Testing

### Test Initial Order
1. Add a subscription product to cart
2. Select frequency, duration, gift options
3. Complete checkout
4. Verify subscription created in oc_subscription
5. Verify subscription_order record created with:
   - is_initial_order = 1
   - iteration_number = 1

### Test Renewal
1. Manually set a subscription's date_next to a past date
2. Run the cron job
3. Verify new order created
4. Verify subscription_order record created with:
   - is_initial_order = 0
   - iteration_number = 2
5. Verify subscription updated (remaining decreased, date_next updated)

## Troubleshooting

### Renewal Orders Not Being Created
- Check subscription status is active
- Verify date_next is in the past
- Check remaining > 0
- Review cron job logs for errors
- Ensure payment method is still valid

### Subscription Order Records Missing
- Run subscription_contract_updates.sql
- Check for foreign key constraint errors
- Verify subscription_id and order_id exist

### Metadata Not Showing
- Verify cart override contains all fields
- Check order_subscription table has metadata columns
- Ensure subscription table has new metadata columns
