SELECT
  p.product_id,
  p.product_name,
  p.unit_price AS base_unit_price,
  
  p.brand_id,
  b.brand_name,

  p.category_id,
  c.category_name

FROM {{ ref('stg_sales_localbike__product') }} p
LEFT JOIN {{ ref('stg_sales_localbike__brand') }} b 
  USING (brand_id)
LEFT JOIN {{ ref('stg_sales_localbike__category') }} c 
  USING (category_id)