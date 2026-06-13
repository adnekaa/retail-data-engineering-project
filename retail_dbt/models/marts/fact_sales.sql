with facturedetails as (
    select * from {{ ref('stg_facturedetails') }}
),

factures as (
    select * from {{ ref('stg_factures') }}
)

select
    facturedetails.detail_id,
    factures.invoice_id,
    factures.invoice_date,
    factures.client_id,
    facturedetails.item_id,
    facturedetails.quantity,
    facturedetails.sell_price_incl_vat,
    facturedetails.sell_price_excl_vat,
    facturedetails.discount_pct,
    facturedetails.line_total,
    facturedetails.line_vat_total
from facturedetails
left join factures on facturedetails.invoice_id = factures.invoice_id