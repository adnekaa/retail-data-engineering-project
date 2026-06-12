with source as (
    select * from {{ source('pos_retail_source', 'itemcategories') }}
)

select
    "IDCategory"  as category_id,
    "Category"    as category_name,
    "CatStatus"   as is_active,
    "CatShortcut" as show_on_pos
from source