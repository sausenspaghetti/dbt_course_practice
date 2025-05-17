{% snapshot dim_flights__aircraft_seats %}

{{
   config(
        target_schema='snapshot',
        unique_key = ['aircraft_code','seat_no'],

        strategy='check',
        check_cols = ['fare_conditions'],
        dbt_valid_to_current = "'9999-01-01'::date",
        hard_deletes = 'invalidate',
        snapshot_meta_column_names={
            "dbt_valid_from": "dbt_effective_date_from",
            "dbt_valid_to": "dbt_effective_date_to"
        }
   )
}}
select
    sfs.aircraft_code,
    sfs.seat_no,
    sfs.fare_conditions
from
    {{ ref('stg_flights__seats')}} sfs


{% endsnapshot %}