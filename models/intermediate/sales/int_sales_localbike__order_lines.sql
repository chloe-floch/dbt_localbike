{{ config(
  partition_by = {
    'field': 'ordered_at',
    'data_type': 'timestamp',
    'granularity': 'day'
  },
  cluster_by = ['store_id', 'staff_id', 'customer_id']
) }}



WITH orders AS (
  SELECT
    order_id,
    customer_id,
    store_id,
    staff_id,
    ordered_at
  FROM {{ ref('stg_sales_localbike__order') }}
),

order_items AS (
  SELECT
    pk_order_item_id,
    order_id,
    product_id,
    quantity_ordered,
    unit_price,
    discount,
    total_order_item_amount
  FROM {{ ref('stg_sales_localbike__order_item') }}
)

SELECT
  oi.pk_order_item_id,
  oi.order_id,

  o.customer_id,
  o.store_id,
  o.staff_id,
  o.ordered_at,

  oi.product_id,
  oi.quantity_ordered,
  oi.unit_price,
  oi.discount,
  oi.total_order_item_amount

FROM order_items oi
LEFT JOIN orders o
  ON oi.order_id = o.order_id
