with users as (
    select * from {{ ref('stg_users') }}
)

select
    user_id,
    username,
    full_name,
    access_level,
    is_locked
from users