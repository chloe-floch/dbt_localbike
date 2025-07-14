{% docs int_sales_localbike__stock_operations %}

This intermediate model joins product details with current stock levels and calculates the average weekly sales and stock cover days for each product and store.

Key points:
- **avg_weekly_sales**: Computed from historical sales data. Shows the demand speed.
- **stock_cover_days**: Shows how many days the current stock can cover, based on the sales speed.
- NULL values in `avg_weekly_sales` or `stock_cover_days` indicate no sales history.

Use this as the base for your final stock availability mart.

{% enddocs %}
