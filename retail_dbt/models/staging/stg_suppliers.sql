with source as (
    select * from {{ source('pos_retail_source', 'suppliers') }}
)

select
    "SupplierID"         as supplier_id,
    "SupplierName"       as supplier_name,
    "SupplierTaxCode"    as supplier_tax_code,
    "SupplierBalance"    as supplier_balance,
    "SupplierPastBalance" as supplier_past_balance,
    "SupplierDiscount"   as supplier_discount_pct,
    "SupplierStatus"     as is_active
from source