with clientpayment as (
    select * from {{ ref('stg_clientpayment') }}
)

select
    payment_id,
    payment_date,
    receipt_id,
    client_id,
    payment_type,
    payment_amount,
    cashier_name
from clientpayment