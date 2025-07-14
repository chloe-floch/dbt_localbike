SELECT
  category_id,         
  category_name        
FROM {{ source('sales_localbike', 'category') }}