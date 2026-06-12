with source as (
    select * from {{ source('pos_retail_source', 'factures') }}
)

select
    "id"              as invoice_id,
    "factnum"         as invoice_number,
    "datefact"        as invoice_date,
    "idclient"        as client_id,
    "total"           as total_amount,
    "paymentstatus"   as payment_status,
    "paymentid"       as payment_id,
    "remiseglobale"   as global_discount_pct,
    "timbre"          as stamp_duty,
    "factureavoirnum" as credit_note_number,
    "avoirfacturenum" as original_invoice_number
from source