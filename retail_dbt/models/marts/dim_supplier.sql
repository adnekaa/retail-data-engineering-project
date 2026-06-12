with suppliers as (
    select * from {{ ref('stg_suppliers') }}
)

select
    supplier_id,
    supplier_name,
    supplier_tax_code,
    supplier_balance,
    supplier_past_balance,
    supplier_discount_pct,
    is_active
from suppliers