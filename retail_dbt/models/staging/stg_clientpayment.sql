with source as (
    select * from {{ source('pos_retail_source', 'clientpayment') }}
)

select
    "PaymentID"      as payment_id,
    "PaymentDate"    as payment_date,
    "ReceiptID"      as receipt_id,
    "ClientID"       as client_id,
    "PaymentType"    as payment_type,
    "PaymentAmount"  as payment_amount,
    "PaymentCashier" as cashier_name
from source