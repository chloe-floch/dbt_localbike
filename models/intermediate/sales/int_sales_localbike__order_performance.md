{% docs int_sales_localbike__order_performance %}

This model provides detailed sales performance at the order line level,
enriched with product and staff hierarchy information.

### Key Fields:
- **pk_order_item_id**: Primary Key — one row per order line.
- **staff_id**: Linked staff member handling the sale.
- **product_id**: Linked product sold.
- **ordered_at**: Order date for time-based analysis.

{% enddocs %}
