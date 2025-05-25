{{
  config(
        materialized = 'table',
        post_hook="
            {% do log(this.node, info=True) %}
            {# {% set dependencies_count = get_dependencies_count(this) %}
            {% do log(dependencies_count, info=True) %} #}
        "
    )
}}
select
    flight_id,
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    departure_airport,
    arrival_airport,
    "status",
    aircraft_code,
    actual_departure,
    actual_arrival,
    {{ concat_columns(['flight_id', 'flight_no']) }} as flight_info
from
    {{ ref('stg_flights__flights') }}