with source as (
    select * from {{ source('pos_retail_source', 'bedetails') }}
)

select
    "id"          as detail_id,
    "beid"        as be_id,
    "itemid"      as item_id,
    "quantity"    as quantity,
    "prixachatht" as buy_price_excl_vat,
    "prixachat"   as buy_price_incl_vat,
    "tauxtva"     as vat_rate,
    "remise"      as discount_pct,
    "fodec"       as fodec_rate,
    "montant"     as line_total,
    "lot"         as lot_number
from source