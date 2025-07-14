select
  customer_id,
  first_name as customer_first_name,
  last_name as customer_last_name,
  email as customer_email,
  street as customer_street,
  city as customer_city,
  state as customer_state,
  zip_code as customer_zipcode,
from {{ source('sales_localbike', 'customer') }}