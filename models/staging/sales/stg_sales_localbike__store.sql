select
  store_id,
  store_name,
  street as store_street,
  city as store_city,
  'state' as store_state,
  zip_code as store_zip_code,
  phone as store_phone,
  email as store_email

from {{ source('sales_localbike', 'store') }}