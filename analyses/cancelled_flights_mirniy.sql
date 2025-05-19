select
    ff.scheduled_departure::date as scheduled_departure
    , count(*)
from
    {{ ref('fct_flights')}}  ff
where
        ff.departure_airport = 'MJZ'
    and ff.status = 'Cancelled'
group by
    scheduled_departure::date

-- 'MJZ'