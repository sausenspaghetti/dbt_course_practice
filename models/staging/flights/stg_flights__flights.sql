{{
    config (
        materialized = 'table'
    )
}}
select
    {{ adapter.quote("flight_id") }},
    {{ adapter.quote("flight_no") }},
    {{ adapter.quote("scheduled_departure") }},
    {{ adapter.quote("scheduled_arrival") }},
    {{ adapter.quote("departure_airport") }},
    {{ adapter.quote("arrival_airport") }},
    {{ adapter.quote("status") }},
    {{ adapter.quote("aircraft_code") }},
    {{ adapter.quote("actual_departure") }},
    {{ adapter.quote("actual_arrival") }}

from 
    {{ source('demo_src', 'flights') }}

    