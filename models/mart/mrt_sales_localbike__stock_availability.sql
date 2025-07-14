SELECT
  store_id,
  product_id,
  product_name,
  brand_id,
  brand_name,
  category_id,
  category_name,
  quantity_available,
  avg_weekly_sales,
  stock_cover_days,

  CASE 
    WHEN quantity_available < 5 THEN 'Low Stock'
    WHEN stock_cover_days < 7 THEN 'Critical'
    ELSE 'OK'
  END AS stock_status

FROM {{ ref('int_sales_localbike__stock_operations') }}

ORDER BY 
  store_id,
  stock_status DESC,
  quantity_available