{{
    config (
        materialized = 'table'
    )
}}
select
    {{ adapter.quote("ticket_no") }},
    {{ adapter.quote("flight_id") }},
    {{ adapter.quote("boarding_no") }},
    {{ adapter.quote("seat_no") }}
from 
    {{ source('demo_src', 'boarding_passes') }}

    