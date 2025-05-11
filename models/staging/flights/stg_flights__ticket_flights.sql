{{
    config (
        materialized = 'table'
    )
}}
select
    {{ adapter.quote("ticket_no") }},
    {{ adapter.quote("flight_id") }},
    {{ adapter.quote("fare_conditions") }},
    {{ adapter.quote("amount") }}
from 
    {{ source('demo_src', 'ticket_flights') }}

    