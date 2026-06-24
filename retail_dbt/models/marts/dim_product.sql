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
    brands.brand_name,
    -- Segmentation prix
    case
        when items.sell_price > 30 then 'Premium'
        when items.sell_price > 20  then 'Milieu de gamme'
        else 'Entrée de gamme'
    end as price_segment,
    -- Flag marge faible (< 10%)
    case
        when items.margin_pct < 10 then true
        else false
    end as is_low_margin,
    -- Flag stock faible (< 5 unités)
    case
        when items.item_stock < 5 then true
        else false
    end as is_low_stock
from items
left join categories on items.category_id = categories.category_id
left join brands on items.brand_id = brands.brand_id