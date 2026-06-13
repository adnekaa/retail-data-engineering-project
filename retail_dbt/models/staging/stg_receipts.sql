with source as (
    select * from {{ source('pos_retail_source', 'receipts') }}
)

select
    "ReceiptID"       as receipt_id,
    "ReceiptDate"     as receipt_date,
    "ReceiptTotalHT"  as total_excl_vat,
    "ReceiptTVA"      as vat_amount,
    "ReceiptTotal"    as total_incl_vat,
    "ReceiptCashier"  as cashier_name,
    "ReceiptClientID" as client_id,
    "ReceiptStatus"   as receipt_status,
    "ReceiptTable"    as table_number,
    "ReceiptUserId"   as user_id
from source