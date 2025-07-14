SELECT
  brand_id,
  brand_name
FROM {{ source('sales_localbike', 'brand') }}