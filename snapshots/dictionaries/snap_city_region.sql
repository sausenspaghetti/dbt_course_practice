{% snapshot snap_city_region %}

{{
   config(
        target_schema='snapshot',
        unique_key='city',

        strategy='timestamp',
        updated_at='updated_at',
        dbt_valid_to_current="'9999-01-01'::date",

        hard_deletes = 'new_record',
        snapshot_meta_column_names={
            "dbt_is_deleted": "dbt_is_deleted"
        }

   )
}}

select
    cr.city,
    cr.region,
    cr.updated_at
from
    {{ ref('city_region')}} cr


{% endsnapshot %}