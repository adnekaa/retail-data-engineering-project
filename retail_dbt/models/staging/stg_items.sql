with source as (
    select * from {{ source('pos_retail_source', 'items') }}
)

select
    "Barcode"    as item_barcode,
    "EAN"        as item_ean,
    "Category"   as category_id,
    "ItemName"   as item_name,
    "BuyPrice"   as buy_price,
    "SellPrice"  as sell_price,
    "ItemStock"  as item_stock,
    "ItemBrand"  as brand_id,
    "tva"        as vat_rate,
    "fodec"      as fodec_rate,
    "discount"   as discount_pct,
    "marge"      as margin_pct,
    "Status"     as is_active
from source