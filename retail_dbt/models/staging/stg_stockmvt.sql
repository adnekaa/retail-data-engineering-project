with source as (
    select * from {{ source('pos_retail_source', 'stockmvt') }}
)

select
    "id"          as movement_id,
    "mvtdate"     as movement_date,
    "itemid"      as item_id,
    "itembarcode" as item_barcode,
    "movement"    as quantity_change,
    "blid"        as bl_id,
    "ticketid"    as receipt_id,
    "factnum"     as invoice_number,
    "clientid"    as client_id,
    "supplierid"  as supplier_id,
    "beid"        as be_id,
    "brid"        as br_id,
    "buypriceht"  as buy_price_excl_vat,
    "sellpriceht" as sell_price_excl_vat,
    "type"        as source_doc_type,
    "typenum"     as source_doc_number
from source