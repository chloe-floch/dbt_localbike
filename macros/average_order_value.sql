{#
This macro calculates the average order value by dividing the total revenue by the number of orders.
It uses `SAFE_DIVIDE` to handle division by zero safely and `NULLIF` to ensure that if the number of orders is zero, the result returns NULL instead of throwing an error.

This macro can be reused across multiple models to ensure consistent business logic.

**Parameters:**
- **total_revenue**: Total revenue amount (numeric).
- **number_of_orders**: Number of orders (integer).

**Example usage:**
```sql
{{ calculate_avg_order_value('total_revenue', 'number_of_orders') }} AS avg_order_value

#}

{% macro calculate_avg_order_value(total_revenue, number_of_orders) %}
  SAFE_DIVIDE({{ total_revenue }}, NULLIF({{ number_of_orders }}, 0))
{% endmacro %}
