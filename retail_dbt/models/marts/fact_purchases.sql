with bedetails as (
    select * from {{ ref('stg_bedetails') }}
),

be as (
    select * from {{ ref('stg_be') }}
)

select
    bedetails.detail_id,
    be.be_id,
    be.be_date,
    be.supplier_id,
    bedetails.item_id,
    bedetails.quantity,
    bedetails.buy_price_excl_vat,
    bedetails.buy_price_incl_vat,
    bedetails.vat_rate,
    bedetails.discount_pct,
    bedetails.fodec_rate,
    bedetails.line_total,
    bedetails.lot_number
from bedetails
left join be on bedetails.be_id = be.be_id