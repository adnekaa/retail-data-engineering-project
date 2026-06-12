with source as (
    select * from {{ source('pos_retail_source', 'be') }}
)

select
    "id"            as be_id,
    "benum"         as be_number,
    "datebe"        as be_date,
    "idsupplier"    as supplier_id,
    "supplier"      as supplier_name,
    "total"         as total_amount,
    "paymentstatus" as payment_status,
    "paymentid"     as payment_id,
    "brofbe"        as related_br_id,
    "factureid"     as supplier_invoice_id
from source