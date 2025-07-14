SELECT 
  CONCAT(CAST(store_id AS STRING), '-', CAST(product_id AS STRING)) AS pk_stock_id,              
  store_id,                
  product_id,              
  quantity as quantity_available
FROM {{ source('sales_localbike', 'stock') }}