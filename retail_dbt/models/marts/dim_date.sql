with date_dimension as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2020-01-01' as date)",
        end_date="cast('2027-01-01' as date)"
    ) }}
)

select
    cast(date_day as date)           as date_day,
    extract(year from date_day)      as year,
    extract(month from date_day)     as month,
    extract(day from date_day)       as day,
    extract(quarter from date_day)   as quarter,
    extract(dayofweek from date_day) as day_of_week,
    to_char(date_day, 'YYYY-MM')     as year_month,
    to_char(date_day, 'Month')       as month_name,
    to_char(date_day, 'Day')         as day_name,
    case
        when extract(dayofweek from date_day) in (1, 7) then true
        else false
    end as is_weekend
from date_dimension