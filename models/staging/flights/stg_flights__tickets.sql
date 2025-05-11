{{
    config (
        materialized = 'table'
    )
}}
select
    {{ adapter.quote("ticket_no") }},
    {{ adapter.quote("book_ref") }},
    {{ adapter.quote("passenger_id") }},
    {{ adapter.quote("passenger_name") }},
    {{ adapter.quote("contact_data") }}

from 
    {{ source('demo_src', 'tickets') }}

    