{% docs int_sales_localbike__order_lines %}

This model consolidates orders and order items at the order line level.
Each row represents a single product line within an order, enriched with customer and store context.

### Key Fields:
- **pk_order_item_id**: Primary Key — unique identifier combining `order_id` and `item_id`.
- **order_id**: Parent order ID.
- **product_id**: Product purchased.
- **quantity_ordered**: Units purchased in this line.

{% enddocs %}
