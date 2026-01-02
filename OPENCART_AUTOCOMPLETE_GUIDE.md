# OpenCart Autocomplete Widget Implementation Guide

## Overview
OpenCart has a custom autocomplete widget that differs from jQuery UI's autocomplete. Understanding its specific requirements is crucial for proper implementation.

## Key Differences from jQuery UI Autocomplete

| Aspect | jQuery UI Autocomplete | OpenCart Autocomplete |
|--------|----------------------|---------------------|
| Source Parameter | `request` object with `term` property | Direct string value |
| Dropdown Element | Auto-generated | Must be manually created |
| Linking | Automatic | Requires `data-oc-target` attribute |
| Response Format | Array of objects | Array of objects with `label` and `value` |

## Required HTML Structure

### 1. Input Field
```html
<input 
    type="text" 
    id="input-category" 
    data-oc-target="autocomplete-category"
    class="form-control" 
    autocomplete="off"
    placeholder="Start typing..."
/>
```

**Key attributes:**
- `data-oc-target`: Links to the dropdown menu ID (REQUIRED)
- `autocomplete="off"`: Prevents browser's native autocomplete
- `id`: For JavaScript targeting

### 2. Dropdown Menu
```html
<ul id="autocomplete-category" class="dropdown-menu"></ul>
```

**Important:**
- Must be placed immediately after the input field
- ID must match the `data-oc-target` value
- Class `dropdown-menu` is required for Bootstrap styling
- OpenCart populates this automatically

## JavaScript Implementation

### Basic Structure
```javascript
$('#input-category').autocomplete({
    'source': function(searchTerm, response) {
        // searchTerm is a STRING, not an object
        // Make AJAX call here
    },
    'select': function(item) {
        // Handle selection
        // item contains { label: '...', value: '...' }
    }
});
```

### Complete Working Example
```javascript
$('#input-category').autocomplete({
    'source': function(searchTerm, response) {
        $.ajax({
            url: 'index.php?route=controller/path.autocomplete&user_token=' + userToken + '&filter_name=' + encodeURIComponent(searchTerm),
            dataType: 'json',
            success: function(json) {
                var results = $.map(json, function(item) {
                    return {
                        label: item['name'],        // Display text
                        value: item['category_id']  // Value to use
                    }
                });
                
                response(results);
            },
            error: function() {
                response([]);
            }
        });
    },
    'select': function(item) {
        // Clear input
        $('#input-category').val('');
        
        // Check for duplicates
        if ($('#category-' + item['value']).length) {
            return;
        }
        
        // Add to list
        $('#category-list').append(
            '<div id="category-' + item['value'] + '">' +
            '<i class="fa-solid fa-minus-circle"></i> ' + 
            item['label'] + 
            '<input type="hidden" name="categories[]" value="' + item['value'] + '"/>' +
            '</div>'
        );
    }
});
```

## Backend Controller (PHP)

### Autocomplete Method
```php
public function autocomplete(): void {
    $json = [];

    if (isset($this->request->get['filter_name'])) {
        $this->load->model('catalog/category');

        $filter_data = [
            'filter_name' => $this->request->get['filter_name'],
            'start'       => 0,
            'limit'       => 5
        ];

        $results = $this->model_catalog_category->getCategories($filter_data);

        foreach ($results as $result) {
            $json[] = [
                'category_id' => $result['category_id'],
                'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
            ];
        }
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
}
```

## Common Mistakes & Solutions

### ❌ Mistake 1: Wrong Source Parameter
```javascript
// WRONG - treating searchTerm as an object
'source': function(request, response) {
    url: '...?filter_name=' + encodeURIComponent(request.term)
}
```

```javascript
// CORRECT - searchTerm is already a string
'source': function(searchTerm, response) {
    url: '...?filter_name=' + encodeURIComponent(searchTerm)
}
```

### ❌ Mistake 2: Missing Dropdown Element
```html
<!-- WRONG - no dropdown element -->
<input type="text" id="input-category" data-oc-target="autocomplete-category" />
```

```html
<!-- CORRECT - dropdown element present -->
<input type="text" id="input-category" data-oc-target="autocomplete-category" />
<ul id="autocomplete-category" class="dropdown-menu"></ul>
```

### ❌ Mistake 3: Missing data-oc-target Attribute
```html
<!-- WRONG - no data-oc-target -->
<input type="text" id="input-category" />
<ul id="autocomplete-category" class="dropdown-menu"></ul>
```

```html
<!-- CORRECT - properly linked -->
<input type="text" id="input-category" data-oc-target="autocomplete-category" />
<ul id="autocomplete-category" class="dropdown-menu"></ul>
```

### ❌ Mistake 4: Incorrect Response Format
```javascript
// WRONG - missing value or label
response([
    { id: 1, text: 'Category 1' }
]);
```

```javascript
// CORRECT - using label and value
response([
    { label: 'Category 1', value: 1 }
]);
```

## How OpenCart Autocomplete Works Internally

1. **On Focus/Input**: Triggers the `source` function
2. **Source Function**: Makes AJAX call and calls `response()` with results
3. **Response Processing**: OpenCart formats results and populates dropdown
4. **Dropdown Display**: Shows results with proper Bootstrap styling
5. **Selection**: Triggers the `select` function with the chosen item

## Advanced Features

### Grouped Results
```javascript
response([
    {
        label: 'Product 1',
        value: 1,
        category: 'Electronics'  // Optional grouping
    },
    {
        label: 'Product 2',
        value: 2,
        category: 'Electronics'
    },
    {
        label: 'Book 1',
        value: 3,
        category: 'Books'
    }
]);
```

### Loading Indicator
OpenCart automatically shows a loading spinner:
```html
<li id="autocomplete-loading">
    <span class="dropdown-item text-center disabled">
        <i class="fa-solid fa-circle-notch fa-spin"></i>
    </span>
</li>
```

## Complete Template Example (Twig)

```twig
<div class="row mb-3">
    <label class="col-sm-2 col-form-label">Categories</label>
    <div class="col-sm-10">
        <input 
            type="text" 
            id="input-category" 
            data-oc-target="autocomplete-category"
            class="form-control" 
            autocomplete="off"
            placeholder="Start typing to search..."
        />
        <ul id="autocomplete-category" class="dropdown-menu"></ul>
        
        <div id="category-list" class="form-control" style="height: 150px; overflow: auto;">
            {% for category in categories %}
                <div id="category-{{ category.category_id }}">
                    <i class="fa-solid fa-minus-circle"></i> {{ category.name }}
                    <input type="hidden" name="categories[]" value="{{ category.category_id }}"/>
                </div>
            {% endfor %}
        </div>
    </div>
</div>

<script type="text/javascript"><!--
$('#input-category').autocomplete({
    'source': function(searchTerm, response) {
        $.ajax({
            url: 'index.php?route=design/homepage.autocomplete&user_token={{ user_token }}&filter_name=' + encodeURIComponent(searchTerm),
            dataType: 'json',
            success: function(json) {
                response($.map(json, function(item) {
                    return {
                        label: item['name'],
                        value: item['category_id']
                    }
                }));
            },
            error: function() {
                response([]);
            }
        });
    },
    'select': function(item) {
        $('#input-category').val('');
        
        if ($('#category-' + item['value']).length) {
            return;
        }

        $('#category-list').append(
            '<div id="category-' + item['value'] + '" style="padding: 5px;">' +
            '<i class="fa-solid fa-minus-circle" style="cursor: pointer;"></i> ' + 
            item['label'] + 
            '<input type="hidden" name="categories[]" value="' + item['value'] + '"/>' +
            '</div>'
        );
    }
});

$('#category-list').on('click', '.fa-minus-circle', function() {
    $(this).parent().remove();
});
//--></script>
```

## Debugging Tips

1. **Check Console for Errors**: Open browser console to see JavaScript errors
2. **Verify AJAX Response**: Check Network tab to ensure JSON format is correct
3. **Inspect Dropdown Element**: Make sure it exists in DOM with correct ID
4. **Test data-oc-target**: Verify the attribute matches dropdown ID exactly
5. **Check Response Format**: Ensure all items have `label` and `value` properties

## Summary Checklist

- [ ] Input has `data-oc-target` attribute
- [ ] Dropdown `<ul>` element exists with matching ID
- [ ] Dropdown has `dropdown-menu` class
- [ ] Source function treats first parameter as string
- [ ] Response includes objects with `label` and `value`
- [ ] Backend returns proper JSON array
- [ ] Select function handles the chosen item

## Reference
- Location: `/admin/view/javascript/common.js` (lines 349-450)
- Widget: `$.fn.autocomplete`
- Bootstrap Version: 5.x (for dropdown styling)
