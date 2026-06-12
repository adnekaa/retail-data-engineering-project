with source as (
    select * from {{ source('pos_retail_source', 'bl') }}
)

select
    "id"            as bl_id,
    "blnum"         as bl_number,
    "datebl"        as bl_date,
    "idclient"      as client_id,
    "total"         as total_amount,
    "paymentstatus" as payment_status,
    "paymentid"     as payment_id,
    "remiseglobale" as global_discount_pct
from source