{{
    config (
        materialized = 'table'
    )
}}
select
    ft.ticket_no,
    ft.book_ref,
    ft.passenger_id,
    ft.passenger_name,
    ft.contact_data
from 
    {{ ref('stg_flights__tickets') }} ft

left join {{ ref('employees')}} emp
    on emp.passenger_id = ft.passenger_id

where
     emp.passenger_id is null
