with receiptdetails as (
    select * from {{ ref('stg_receiptdetails') }}
),

receipts as (
    select * from {{ ref('stg_receipts') }}
)

select
    receiptdetails.receipt_id,
    receipts.receipt_date,
    receipts.client_id,
    receipts.user_id,
    receiptdetails.item_barcode,
    receiptdetails.item_count,
    receiptdetails.item_buy_price,
    receiptdetails.item_sell_price,
    (receiptdetails.item_sell_price - receiptdetails.item_buy_price) * receiptdetails.item_count as margin,
    receipts.total_incl_vat,
    receipts.total_excl_vat,
    receipts.vat_amount
from receiptdetails
left join receipts on receiptdetails.receipt_id = receipts.receipt_id