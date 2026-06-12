with source as (
    select * from {{ source('pos_retail_source', 'receiptdetails') }}
)

select
    "ReceiptID"     as receipt_id,
    "Barcode"       as item_barcode,
    "ItemName"      as item_name,
    "Itemcount"     as item_count,
    "ItemBuyPrice"  as item_buy_price,
    "ItemSellPrice" as item_sell_price,
    "ReceiptDate"   as receipt_date,
    "ReceiptCashier" as cashier_name
from source