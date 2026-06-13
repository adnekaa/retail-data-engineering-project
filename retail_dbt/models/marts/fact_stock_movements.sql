with stockmvt as (
    select * from {{ ref('stg_stockmvt') }}
)

select
    movement_id,
    movement_date,
    item_id,
    item_barcode,
    quantity_change,
    bl_id,
    receipt_id,
    invoice_number,
    client_id,
    supplier_id,
    be_id,
    br_id,
    buy_price_excl_vat,
    sell_price_excl_vat,
    source_doc_type,
    source_doc_number
from stockmvt