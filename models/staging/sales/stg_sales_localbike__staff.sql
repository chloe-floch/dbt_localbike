select
  staff_id,
  first_name as staff_first_name,
  last_name as staff_last_name,
  store_id,
  active,

  -- Normalize manager_id to INT64: handles '-' and '' as NULL
  SAFE_CAST(NULLIF(NULLIF(manager_id, '-'), '') AS INT64) AS manager_id
  
from {{ source('sales_localbike', 'staff') }}