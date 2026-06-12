with source as (
    select * from {{ source('pos_retail_source', 'users') }}
)

select
    "ID"          as user_id,
    "Username"    as username,
    "Nom"         as full_name,
    "AccessLevel" as access_level,
    "Lock"        as is_locked
from source