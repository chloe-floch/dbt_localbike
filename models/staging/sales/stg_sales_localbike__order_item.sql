select
  concat(cast(order_id as string), '_', cast(item_id as string)) as pk_order_item_id,
  order_id,
  item_id,
  product_id,
  quantity as quantity_ordered,
  list_price as unit_price,
  discount,
  quantity * list_price * (1 - discount) as total_order_item_amount

from {{ source('sales_localbike', 'order_item') }}