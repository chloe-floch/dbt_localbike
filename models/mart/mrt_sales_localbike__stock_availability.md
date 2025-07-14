{% docs mrt_sales_localbike__stock_availability %}

This mart shows current stock levels by product and store, enriched with sales speed to estimate how many days the current stock will cover.

It includes:
- **quantity_available**: Current stock on hand.
- **avg_weekly_sales**: Average units sold per week for this product and store.
- **stock_cover_days**: Estimated days of coverage based on sales speed.
- **stock_status**: Stock alert level: `OK`, `Low Stock`, or `Critical`.

Use this mart to prioritize which products require urgent restocking, especially those with high sales velocity and low coverage.

{% enddocs %}
