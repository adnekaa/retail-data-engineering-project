with source as (
    select * from {{ source('pos_retail_source', 'brands') }}
)

select
    "BrandID"     as brand_id,
    "BrandName"   as brand_name,
    "BrandStatus" as is_active
from source