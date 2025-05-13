{{
    config (
        materialized = 'table'
    )
}}
select
    tf.ticket_no,
    tf.flight_id,
    tf.fare_conditions,
    tf.amount,
    case 
        when bp.boarding_no is not null then 1
        else 0 
    end as boarding_pass_exists, 
    bp.boarding_no,
    bp.seat_no
from 
    {{ ref('stg_flights__ticket_flights') }} tf

left join {{ ref('stg_flights__boarding_passes')}} bp
    on bp.ticket_no = tf.ticket_no and bp.flight_id = tf.flight_id
