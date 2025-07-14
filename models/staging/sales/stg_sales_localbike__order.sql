select
  order_id,
  customer_id,
  store_id,
  staff_id,
  order_status,
  SAFE_CAST(order_date as DATE) as ordered_at,
  SAFE_CAST(required_date as DATE) as required_at,
  SAFE.PARSE_DATE('%Y-%m-%d', shipped_date) AS shipped_at,

  -- Delivery type flag
  case
    when shipped_date is null and order_date = required_date then 'In-store pickup'
    when shipped_date is null then 'Pending shipment'
    else 'Shipped'
  end as delivery_type

from {{ source('sales_localbike', 'order') }}