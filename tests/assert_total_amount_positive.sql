SELECT
  order_id,
  SUM(total_order_item_amount) AS total_amount
FROM {{ ref('stg_sales_localbike__order_item') }}
GROUP BY order_id
HAVING SUM(total_order_item_amount) < 0
