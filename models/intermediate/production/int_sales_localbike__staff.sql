{{ config(materialized='view') }}

WITH base_staff AS (
  SELECT
    staff_id,
    staff_first_name,
    staff_last_name,
    store_id,
    manager_id,
    active
  FROM {{ ref('stg_sales_localbike__staff') }}
  WHERE active = 1
),

with_manager AS (
  SELECT
    s.*,
    m.store_id AS manager_store_id,
    m.staff_first_name AS manager_first_name,
    m.staff_last_name AS manager_last_name
  FROM base_staff s
  LEFT JOIN base_staff m
    ON s.manager_id = m.staff_id  
),

flagged AS (
  SELECT
    *,
    -- Flag potential hierarchy issues:
    -- 1) The manager_id exists but no matching manager found (manager_store_id is NULL)
    -- 2) The manager_id exists but the manager is assigned to a different store
    --    (except for the big boss with staff_id = 1 who can manage multiple stores)
    CASE
      WHEN manager_id IS NOT NULL 
        AND manager_store_id IS NULL THEN TRUE
      WHEN manager_id IS NOT NULL 
        AND manager_id != 1  
        AND store_id != manager_store_id THEN TRUE
      ELSE FALSE
    END AS hierarchy_issue_flag
  FROM with_manager
),

corrected AS (
  SELECT
    staff_id,
    staff_first_name,
    staff_last_name,
    store_id,
    manager_id,
    manager_first_name,
    manager_last_name,
    hierarchy_issue_flag,

    CASE
      WHEN hierarchy_issue_flag THEN NULL ELSE manager_id
    END AS manager_id_corrected,

    CASE
      WHEN hierarchy_issue_flag THEN NULL ELSE manager_first_name
    END AS manager_first_name_corrected,

    CASE
      WHEN hierarchy_issue_flag THEN NULL ELSE manager_last_name
    END AS manager_last_name_corrected

  FROM flagged
)

SELECT * FROM corrected
