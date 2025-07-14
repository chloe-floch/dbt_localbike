{% docs int_sales_localbike__product_details %}

This model enriches each product with its related brand and category information.
It serves as a unified dimension for all downstream analyses needing consistent product context.

### Key Fields:
- **product_id**: Primary Key — one row per product.
- **brand_id**, **brand_name**: Brand details.
- **category_id**, **category_name**: Category details.

{% enddocs %}
