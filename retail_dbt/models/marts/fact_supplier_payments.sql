with supplierpayment as (
    select * from {{ ref('stg_supplierpayment') }}
)

select
    payment_id,
    payment_date,
    be_id,
    supplier_id,
    payment_type,
    payment_amount,
    withholding_tax_amount
from supplierpayment