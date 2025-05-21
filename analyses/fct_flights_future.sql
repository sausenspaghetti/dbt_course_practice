
select
    count(*) as {{ adapter.quote('cnt some data') }}
from
    {{ ref('fct_flights')}} 
where
        scheduled_departure >= '{{ run_started_at }}'::timestamp - interval '10' year 
    and scheduled_departure <= '{{ run_started_at }}'::timestamp




