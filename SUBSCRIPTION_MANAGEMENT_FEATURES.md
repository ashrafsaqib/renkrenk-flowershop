# Subscription Self-Service Management System

## Overview
Complete customer self-service system for managing subscriptions with pause, skip, frequency change, delivery date change, plan change, and cancellation capabilities.

## Features Implemented

### 1. Pause Subscription
**Use Case:** "I'm going on vacation" or "I don't need flowers for a while"

**How it Works:**
- Customer selects a date until which they want to pause
- Cron job checks `paused_until` field before processing
- Subscription automatically resumes after the pause date
- Customer can manually resume anytime

**Database:**
- Field: `oc_subscription.paused_until` (DATE)
- Index: `idx_paused_until` for performance

### 2. Skip Next Delivery
**Use Case:** "I have too many flowers this month"

**How it Works:**
- Sets `skip_next_delivery` flag to 1
- Cron job detects the flag and skips processing
- Automatically resets flag and calculates next delivery date
- Only affects the immediate next delivery

**Database:**
- Field: `oc_subscription.skip_next_delivery` (TINYINT)
- Index: `idx_skip_next` for performance

### 3. Change Frequency
**Use Case:** "Weekly is too often, I want bi-weekly instead"

**How it Works:**
- Customer selects new frequency from available options
- Updates `frequency`, `cycle`, and `subscription_plan_frequency_id`
- Recalculates `date_next` based on new frequency
- All future deliveries use new frequency

**Affected Fields:**
- `subscription_plan_frequency_id`
- `frequency` (day, week, month, year)
- `cycle` (number)
- `date_next` (recalculated)

### 4. Change Delivery Date
**Use Case:** "I need this week's flowers delivered on Tuesday instead of Friday"

**How it Works:**
- Customer selects new preferred delivery date/day
- Updates `delivery_date` field
- Future orders use new delivery preference

**Affected Fields:**
- `delivery_date`

### 5. Change Subscription Plan
**Use Case:** "I want to try the 'Premium' subscription instead of 'Classic'"

**How it Works:**
- Customer selects different subscription plan
- Updates `subscription_plan_id` and `price`
- Next order will include products from new plan

**Affected Fields:**
- `subscription_plan_id`
- `price`

### 6. Cancel Subscription
**Use Case:** "I need to stop for now"

**How it Works:**
- Optional feedback collection (reason for cancellation)
- Sets `subscription_status_id` to cancelled status
- Subscription stops processing
- Customer can view history but no new orders created

**Features:**
- Feedback form with predefined reasons
- Additional comment field
- Logged in subscription history

## Database Schema

### New Columns in `oc_subscription`
```sql
ALTER TABLE `oc_subscription`
  ADD COLUMN `paused_until` DATE NULL,
  ADD COLUMN `skip_next_delivery` TINYINT(1) DEFAULT 0,
  ADD COLUMN `last_modified_by` VARCHAR(20) DEFAULT 'system';
```

### New Table: `oc_subscription_history`
Tracks all customer actions and changes:
```sql
CREATE TABLE `oc_subscription_history` (
  `subscription_history_id` INT(11) AUTO_INCREMENT PRIMARY KEY,
  `subscription_id` INT(11) NOT NULL,
  `action_type` VARCHAR(50) NOT NULL,
  `old_value` TEXT NULL,
  `new_value` TEXT NULL,
  `comment` TEXT NULL,
  `modified_by` VARCHAR(20) DEFAULT 'customer',
  `date_added` DATETIME NOT NULL,
  FOREIGN KEY (`subscription_id`) REFERENCES `oc_subscription`(`subscription_id`) ON DELETE CASCADE
);
```

## API Endpoints

All endpoints require customer authentication via `customer_token`.

### POST /account/subscription.pause
**Parameters:**
- `subscription_id` (required)
- `paused_until` (required) - Date in Y-m-d format
- `comment` (optional) - Customer reason

**Response:**
```json
{
  "success": "Success: Your subscription has been paused!"
}
```

### POST /account/subscription.resume
**Parameters:**
- `subscription_id` (required)
- `comment` (optional)

**Response:**
```json
{
  "success": "Success: Your subscription has been resumed!"
}
```

### POST /account/subscription.skip
**Parameters:**
- `subscription_id` (required)
- `comment` (optional) - Reason for skipping

**Response:**
```json
{
  "success": "Success: Next delivery will be skipped!"
}
```

### POST /account/subscription.changeFrequency
**Parameters:**
- `subscription_id` (required)
- `frequency_id` (required) - subscription_plan_frequency_id
- `comment` (optional)

**Response:**
```json
{
  "success": "Success: Subscription frequency has been updated!"
}
```

### POST /account/subscription.changeDeliveryDate
**Parameters:**
- `subscription_id` (required)
- `delivery_date` (required) - Date in Y-m-d format
- `comment` (optional)

**Response:**
```json
{
  "success": "Success: Delivery date has been updated!"
}
```

### POST /account/subscription.changePlan
**Parameters:**
- `subscription_id` (required)
- `plan_id` (required) - subscription_plan_id
- `comment` (optional)

**Response:**
```json
{
  "success": "Success: Subscription plan has been changed!"
}
```

### POST /account/subscription.cancel
**Parameters:**
- `subscription_id` (required)
- `comment` (optional) - Cancellation reason/feedback

**Response:**
```json
{
  "success": "Success: Your subscription has been canceled!"
}
```

## Cron Job Integration

The subscription renewal cron (`catalog/controller/cron/subscription.php`) has been enhanced to:

### Check Pause Status
```php
if (!empty($result['paused_until']) && strtotime($result['paused_until']) >= strtotime(date('Y-m-d'))) {
    // Skip processing
    continue;
}
```

### Handle Skip Delivery
```php
if (!empty($result['skip_next_delivery']) && $result['skip_next_delivery'] == 1) {
    // Reset flag
    // Calculate next date
    // Log action
    continue;
}
```

### Respects All Changes
- Uses current frequency settings
- Uses current plan and pricing
- Logs all automated actions

## User Interface

### Subscription Info Page
Location: `catalog/view/template/account/subscription_info.twig`

**Features:**
- Visual status indicators (paused subscriptions)
- Action buttons organized in responsive grid
- Bootstrap 5 modals for each action
- Form validation
- AJAX submission with feedback
- Automatic page reload on success

**Buttons:**
- 🟡 Pause Subscription
- 🟢 Resume Subscription (when paused)
- 🔵 Skip Next Delivery
- 📅 Change Frequency
- ⏰ Change Delivery Date
- 🔄 Change Plan
- 🔴 Cancel Subscription

### Modals
Each action has a dedicated modal with:
- Clear description of the action
- Required fields with validation
- Optional comment/feedback field
- Confirmation button
- Cancel option

## Model Methods

### Location: `catalog/model/checkout/subscription.php`

#### pauseSubscription($subscription_id, $paused_until, $comment, $modified_by)
Pauses subscription until specified date.

#### resumeSubscription($subscription_id, $comment, $modified_by)
Resumes a paused subscription immediately.

#### skipNextDelivery($subscription_id, $comment, $modified_by)
Skips the next scheduled delivery.

#### changeFrequency($subscription_id, $frequency_id, $frequency, $cycle, $comment, $modified_by)
Changes delivery frequency and recalculates next date.

#### changeDeliveryDate($subscription_id, $delivery_date, $comment, $modified_by)
Updates preferred delivery date.

#### changeSubscriptionPlan($subscription_id, $plan_id, $price, $comment, $modified_by)
Switches to a different subscription plan.

#### cancelSubscription($subscription_id, $comment, $modified_by)
Cancels the subscription with optional feedback.

#### addSubscriptionHistory($subscription_id, $action_type, $old_value, $new_value, $comment, $modified_by)
Logs subscription management actions.

#### getSubscriptionHistory($subscription_id)
Retrieves all history records for a subscription.

## Installation Steps

### 1. Run Database Migrations
```bash
mysql -u username -p database_name < subscription_management_updates.sql
```

### 2. Verify Files Updated
- ✅ `catalog/model/checkout/subscription.php`
- ✅ `catalog/controller/account/subscription.php`
- ✅ `catalog/controller/cron/subscription.php`
- ✅ `catalog/view/template/account/subscription_info.twig`
- ✅ `catalog/language/en-gb/account/subscription.php`

### 3. Test Each Feature
1. Log in as customer with active subscription
2. Navigate to Account → Subscriptions → View Subscription
3. Test each action button
4. Verify changes in database
5. Run cron job to test automation

## Testing Scenarios

### Test 1: Pause/Resume Flow
1. Pause subscription for 7 days
2. Verify `paused_until` date set
3. Run cron - should skip processing
4. Resume subscription
5. Verify `paused_until` cleared
6. Run cron - should process normally

### Test 2: Skip Delivery
1. Note current `date_next`
2. Click "Skip Next Delivery"
3. Verify `skip_next_delivery = 1`
4. Run cron job
5. Verify flag reset to 0
6. Verify `date_next` moved forward

### Test 3: Change Frequency
1. Note current frequency (e.g., Weekly)
2. Change to Bi-Weekly
3. Verify `frequency`, `cycle`, and `date_next` updated
4. Run cron - next order should be bi-weekly

### Test 4: Change Plan
1. Note current plan (e.g., Classic)
2. Change to Premium
3. Verify `subscription_plan_id` and `price` updated
4. Run cron - products should be from new plan

### Test 5: Cancel with Feedback
1. Click "Cancel Subscription"
2. Select reason "Too expensive"
3. Add comment
4. Confirm cancellation
5. Verify status changed to cancelled
6. Verify feedback logged in history
7. Run cron - should not process

## History Tracking

All actions are logged in `oc_subscription_history`:

**Example Records:**
```sql
-- Frequency change
action_type: 'frequency_change'
old_value: '{"frequency_id":1,"frequency":"week","cycle":1}'
new_value: '{"frequency_id":2,"frequency":"week","cycle":2}'

-- Pause
action_type: 'pause'
old_value: NULL
new_value: '2025-12-15'

-- Cancel
action_type: 'cancel'
old_value: 'active'
new_value: 'cancelled'
comment: 'Too expensive. Found better alternative.'
```

## Customer Benefits

1. **Flexibility:** Full control over subscription without contacting support
2. **Convenience:** Instant changes, no waiting for approval
3. **Transparency:** Clear history of all changes
4. **No Lock-in:** Easy cancellation process
5. **Vacation Mode:** Pause instead of cancel

## Business Benefits

1. **Reduced Churn:** Pause/skip options keep customers longer
2. **Valuable Feedback:** Cancellation reasons for business insights
3. **Lower Support Costs:** Self-service reduces support tickets
4. **Increased Flexibility:** Easy plan upgrades increase revenue
5. **Better Data:** Track customer behavior and preferences

## Security

- All actions require customer authentication
- Ownership validation (customer can only modify their subscriptions)
- SQL injection protection via parameterized queries
- XSS protection in templates
- CSRF tokens in forms
- Action logging with `modified_by` tracking

## Future Enhancements

- Email notifications for all changes
- Admin dashboard for subscription analytics
- Retention campaigns for cancelling customers
- Special offers during cancellation flow
- Gift subscription transfers
- Multiple delivery addresses
- Prepaid subscription credits

## Troubleshooting

### Actions Not Working
- Check customer is logged in
- Verify customer_token is valid
- Check browser console for JavaScript errors
- Verify database columns exist

### Cron Not Respecting Changes
- Verify cron job file updated
- Check subscription status is active
- Review cron logs for errors
- Ensure database values are correct

### Modals Not Appearing
- Check Bootstrap 5 is loaded
- Verify jQuery is loaded
- Check for JavaScript conflicts
- Review browser console errors

## Support

For issues or questions:
1. Check subscription_history table for action logs
2. Review browser console for client-side errors
3. Check OpenCart error logs
4. Verify database schema matches documentation
5. Test with browser dev tools network tab
