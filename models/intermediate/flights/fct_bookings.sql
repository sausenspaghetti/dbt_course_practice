{{
  config(
        materialized = 'table',
        meta = {
            "owner": "sql_file_owner@gmail.com"
        }
    )
}}
select
    {# book_ref,
    book_date,
    total_amount #}
    {{ show_columns_relation('stg_flights__bookings') }}
from
    {{ ref('stg_flights__bookings') }}