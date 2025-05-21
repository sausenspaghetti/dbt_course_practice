{{
  config(
        materialized = 'table',
        meta = {
            "owner": "sql_file_owner@gmail.com"
        }
    )
}}
select
    {{ show_columns_relation('stg_flights__bookings') }}
from
    {{ ref('stg_flights__bookings') }}