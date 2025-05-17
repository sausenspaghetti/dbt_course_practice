{% snapshot dim_flights__airports %}

{{
   config(
        target_schema='snapshot',
        unique_key='airport_code',

        strategy='check',
        check_cols = ['airport_name', 'city', 'coordinates', 'timezone'],
        dbt_valid_to_current = "'9999-01-01'::date",
        snapshot_meta_column_names={
            "dbt_valid_from": "dbt_effective_date_from",
            "dbt_valid_to": "dbt_effective_date_to"
        }
   )
}}
select
    fa.airport_code,
    fa.airport_name,
    fa.city,
    fa.coordinates,
    fa.timezone
from
    {{ ref('stg_flights__airports')}}  fa


{% endsnapshot %}