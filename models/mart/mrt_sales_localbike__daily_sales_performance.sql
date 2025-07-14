WITH daily_orders AS (
SELECT
  ordered_at,
  store_id,
  manager_id_corrected,
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(quantity_ordered) AS total_items_sold,
  SUM(total_order_item_amount) AS total_revenue,
FROM {{ ref('int_sales_localbike__order_performance') }}
GROUP BY 
  ordered_at,
  store_id,
  manager_id_corrected
)

SELECT
  ordered_at,
  store_id,
  manager_id_corrected,
  total_orders,
  total_revenue,
  {{ calculate_avg_order_value('total_revenue', 'total_orders') }} AS avg_order_value
FROM daily_orders
ORDER BY 
  ordered_at,
  store_id,
  manager_id_corrected

