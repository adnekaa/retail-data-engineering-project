with source as (
    select * from {{ source('pos_retail_source', 'clients') }}
)

select
    "ClientID"              as client_id,
    "ClientName"            as client_name,
    "ClientMatriculeFiscal" as client_tax_id,
    "ClientBalance"         as client_balance,
    "ClientPastBalance"     as client_past_balance,
    "ClientExonere"         as is_vat_exempt,
    "ClientTimbre"          as has_stamp_duty,
    "ClientDiscount"        as client_discount_pct,
    "ClientStatus"          as is_active
from source