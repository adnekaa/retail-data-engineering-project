with items as (
    select * from {{ ref('stg_items') }}
),

categories as (
    select * from {{ ref('stg_itemcategories') }}
),

brands as (
    select * from {{ ref('stg_brands') }}
)

select
    items.item_barcode,
    items.item_ean,
    items.item_name,
    items.buy_price,
    items.sell_price,
    items.item_stock,
    items.vat_rate,
    items.fodec_rate,
    items.discount_pct,
    items.margin_pct,
    items.is_active,
    categories.category_id,
    categories.category_name,
    brands.brand_id,
    brands.brand_name
from items
left join categories on items.category_id = categories.category_id
left join brands on items.brand_id = brands.brand_id