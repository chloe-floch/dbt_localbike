{{ config(
  cluster_by = ['store_id', 'product_id']
) }}

WITH stock AS (
  SELECT
    pk_stock_id,
    store_id,
    product_id,
    quantity_available
  FROM {{ ref('stg_sales_localbike__stock') }}
),

product_details AS (
  SELECT *
  FROM {{ ref('int_sales_localbike__product_details') }}
),

order_perf AS (
  SELECT 
    product_id,
    store_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity_ordered) AS total_quantity,
    DATE_DIFF(MAX(ordered_at), MIN(ordered_at), DAY) AS days_range
  FROM {{ ref('int_sales_localbike__order_performance') }}
  GROUP BY product_id, store_id
),

sales_speed AS (
  SELECT
    product_id,
    store_id,
    SAFE_DIVIDE(total_quantity, NULLIF(days_range/7, 0)) AS avg_weekly_sales
  FROM order_perf
)


SELECT
  s.pk_stock_id,
  s.store_id,
  s.product_id,
  pd.product_name,
  pd.brand_id,
  pd.brand_name,
  pd.category_id,
  pd.category_name,
  s.quantity_available,

  ss.avg_weekly_sales,

  SAFE_DIVIDE(s.quantity_available, NULLIF(ss.avg_weekly_sales / 7, 0)) AS stock_cover_days

FROM stock s
LEFT JOIN product_details pd USING (product_id)
LEFT JOIN sales_speed ss
  ON s.store_id = ss.store_id
  AND s.product_id = ss.product_id
