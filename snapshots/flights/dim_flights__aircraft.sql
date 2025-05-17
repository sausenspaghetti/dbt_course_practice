{% snapshot dim_flights__aircraft %}

{{
   config(
        target_schema='snapshot',
        unique_key='aircraft_code',

        strategy='check',
        check_cols = ['model', 'range'],
        dbt_valid_to_current = "'9999-01-01'::date",
        hard_deletes = 'invalidate',
        snapshot_meta_column_names={
            "dbt_valid_from": "dbt_effective_date_from",
            "dbt_valid_to": "dbt_effective_date_to"
        }
   )
}}
select
    fa.aircraft_code,
    fa.model,
    fa."range"
from
    {{ ref('stg_flights__aircrafts')}} fa


{% endsnapshot %}