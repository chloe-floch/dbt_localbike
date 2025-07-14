{{ config(
  partition_by = {
    'field': 'ordered_at',
    'data_type': 'timestamp',
    'granularity': 'day'
  },
  cluster_by = ['store_id', 'staff_id', 'product_id']
) }}

WITH base_order_lines AS (
  SELECT *
  FROM {{ ref('int_sales_localbike__order_lines') }}
),

product_details AS (
  SELECT *
  FROM {{ ref('int_sales_localbike__product_details') }}
),

staff AS (
  SELECT
    staff_id,
    staff_first_name,
    staff_last_name,
    manager_id_corrected,
    manager_first_name_corrected,
    manager_last_name_corrected
  FROM {{ ref('int_sales_localbike__staff') }}
)

SELECT
  bol.pk_order_item_id,
  bol.order_id,
  bol.ordered_at,
  bol.store_id,

  bol.staff_id,
  s.staff_first_name,
  s.staff_last_name,
  s.manager_id_corrected,
  s.manager_first_name_corrected,
  s.manager_last_name_corrected,

  bol.customer_id,

  bol.product_id,
  pd.product_name,
  pd.brand_id,
  pd.brand_name,
  pd.category_id,
  pd.category_name,

  bol.quantity_ordered,
  bol.unit_price,
  bol.discount,
  bol.total_order_item_amount

FROM base_order_lines bol
LEFT JOIN product_details pd
  USING (product_id)
LEFT JOIN staff s 
  USING (staff_id)
