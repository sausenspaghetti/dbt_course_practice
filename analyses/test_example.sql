{# {%- set relation = adapter.get_relation(
      database="dwh_flights",
      schema="intermediate",
      identifier="fct_flights") -%}


-- Return the `database` for this relation
{{ relation.database }}

-- Return the `schema` (or dataset) for this relation
{{ relation.schema }}

-- Return the `identifier` for this relation
{{ relation.identifier }}

-- Return relation name without the database
{{ relation.include(database=false) }}

-- Return true if the relation is a table
{{ relation.is_table }}

-- Return true if the relation is a view
{{ relation.is_view }}

-- Return true if the relation is a cte
{{ relation.is_cte }} #}



-- {% set source_relation = load_relation( ref('fct_bookings') )%}
{# {% set source_relation = api.Relation.create( 
        database = "dwh_flights",
        schema = "intermediate",
        identifier = "fct_flights",
        type = "table"
    )
%}



{% set columns = adapter.get_columns_in_relation(source_relation) %}

{%- for column in columns -%}
    {{ 'column: ' ~ column }}
{% endfor %} #}




{# {% do adapter.create_schema(
        api.Relation.create(
            database = "dwh_flights",
            schema = "test_schema"
        )
    ) 
%} #}

{# {% do adapter.drop_schema(
        api.Relation.create(
            database = "dwh_flights",
            schema = "test_schema"
        )
    ) 
%} #}


{# {% set fct_flights = api.Relation.create(
        database = 'dwh_flights',
        schema = 'intermediate',
        identifier = 'fct_flights',
        type = 'table'
    ) 
%}


{% set stg_flights__flights = api.Relation.create(
        database = 'dwh_flights',
        schema = 'intermediate',
        identifier = 'stg_flights__flights',
        type = 'table'
    ) 
%}

{% for column in adapter.get_missing_columns(stg_flights__flights, fct_flights) %}
    {{ 'column: ' ~ column }}
{% endfor %} #}


-- dwh_fligths.intermediate.stg_flights__flights
{% set relation = api.Relation.create(
        database = 'dwh_flights',
        schema = 'intermediate',
        identifier = 'stg_flights__flights'
    )
%}

{% set columns = adapter.get_columns_in_relation(relation) %}

{%- for column in columns %}
    {{ column.name -}} 
{% endfor -%}