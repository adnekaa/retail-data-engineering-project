with source as (
    select * from {{ source('pos_retail_source', 'supplierpayment') }}
)

select
    "paymentid"     as payment_id,
    "paymentdate"   as payment_date,
    "beid"          as be_id,
    "supplierid"    as supplier_id,
    "paymenttype"   as payment_type,
    "paymentamount" as payment_amount,
    "paymentrs"     as withholding_tax_amount
from source