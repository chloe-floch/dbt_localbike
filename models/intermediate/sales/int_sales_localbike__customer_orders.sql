WITH base_order_lines AS (
  SELECT *
  FROM {{ ref('int_sales_localbike__order_lines') }}
),

agg_per_customer AS (
  SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS number_of_orders,
    SUM(total_order_item_amount) AS total_revenue
  FROM base_order_lines
  GROUP BY customer_id
)

SELECT
  c.customer_id,
  c.customer_email,
  c.customer_city,
  REGEXP_REPLACE(c.customer_street, r'^\d+\s+', '') AS customer_street_clean,
  c.customer_zipcode,

  a.number_of_orders,
  a.total_revenue,
  {{ calculate_avg_order_value('a.total_revenue', 'a.number_of_orders') }} AS avg_order_value

FROM {{ ref('stg_sales_localbike__customer') }} c
LEFT JOIN agg_per_customer a
  USING (customer_id)
