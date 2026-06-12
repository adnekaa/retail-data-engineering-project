with stg_clients as (
    select * from {{ ref('stg_clients') }}
)

select
    client_id,
    client_name,
    client_tax_id,
    client_balance,
    client_past_balance,
    is_vat_exempt,
    has_stamp_duty,
    client_discount_pct,
    is_active
from stg_clients