SELECT
  c.customer_id,
  c.customer_email,
  c.customer_city,
  c.customer_zipcode,
  CASE
  WHEN ROUND(total_revenue, 0) >= 1000 THEN 'High Value'
  WHEN ROUND(total_revenue, 0) BETWEEN 500 AND 999 THEN 'Medium Value'
  ELSE 'Low Value'
END AS customer_segment,
  number_of_orders,
  total_revenue,
  avg_order_value

FROM {{ ref('int_sales_localbike__customer_orders') }} c

ORDER BY 
  total_revenue DESC
