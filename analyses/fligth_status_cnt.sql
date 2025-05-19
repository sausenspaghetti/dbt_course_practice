{%- set flights_status_query %}
select
    distinct sff."status"
from
    {{ ref('stg_flights__flights')}} sff
{%- endset %}

{%- set flights_status_result = run_query(flights_status_query) %}
{%- if execute %}
    {% set unique_statuses = flights_status_result.columns[0].values() %}
{%- else %}
    {% set unique_statuses = [] %}
{%- endif %}

select
    {%- for status in unique_statuses %}
    SUM(CASE WHEN status = '{{ status }}' THEN 1 ELSE 0 END) as "status_'{{ status }}'"
    {%- if not loop.last%}, {% endif %}
    {%- endfor %}
from
    {{ ref('stg_flights__flights')}}