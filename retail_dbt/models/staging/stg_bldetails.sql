with source as (
    select * from {{ source('pos_retail_source', 'bldetails') }}
)

select
    "id"            as detail_id,
    "blid"          as bl_id,
    "itemid"        as item_id,
    "quantity"      as quantity,
    "prixvente"     as sell_price_incl_vat,
    "prixdeventeht" as sell_price_excl_vat,
    "remise"        as discount_pct,
    "montant"       as line_total
from source