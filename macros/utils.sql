{%- macro concat_columns(columns, sep = ', ') -%}
    {%- for column in columns -%}
        {{ column }} {% if not loop.last %} || '{{ sep }}' || {% endif %}
    {%- endfor -%}
{% endmacro %}





{% macro drop_old_relations(dryrun=False) %}

{# Получаем все models, seed, snapshot #}
{% set current_models = [] %}

{% for node in graph.nodes.values() 
    | selectattr("resource_type", "in", ["model", "snapshot", "seed"]) %}
    {% do current_models.append(node.name) %}
{% endfor %}

{% do log(current_models) %}


{# Формирование скрипта удаления всех таблиц, к-ые не соответствует ни одной моедил #}

{% set cleanup_query %}
with models_to_drop as (
    select
        case
            when table_type = 'BASE TABLE' then 'TABLE'
            when table_type = 'VIEW' then 'VIEW' 
        end as relation_type
        , table_schema
        , table_name
        , concat_ws('.', table_catalog, table_schema, table_name) as relation_name
    from
        {{ target.database }}.information_schema.tables
    where
            table_schema = '{{ target.schema }}'
        and upper(table_name) not in (
            {%- for model in current_models %}
                '{{ model.upper() }}'
                {%- if not loop.last -%} 
                ,  
                {%- endif -%}
            {% endfor %}
        )
)
select
    'drop ' || relation_type || ' ' || relation_name  || ';' as drop_commands
from
    models_to_drop;

{% endset %}

{% do log(cleanup_query) %}

{% set drop_commands = run_query(cleanup_query).columns[0].values() %}

{% do log(drop_commands) %}

{# удаление лишних таблиц / вывод в лог #}

{% if drop_commands %}
    {% if dryrun | as_bool == False %}
        {% do log('Executing DROP commands ...', True) %}
    {% else %}
        {% do log('Printing DROP commands ...', True) %}
    {% endif %}

    {% for drop_command in drop_commands %}
        {% do log(drop_command, True) %}
        {% if dryrun | as_bool == False %}
            {% do run_query(drop_command) %}
        {% endif %}
    {% endfor %}

{% else %}
    {% do log('No relations to clean.', True) %}

{% endif %}

{% endmacro %}





{% macro safe_select(identifier, schema = 'intermediate', database = 'dwh_flights') %}
    {% set relation = api.Relation.create(
            database = database,
            schema = schema,
            identifier = identifier
        )
    %}
    {% if relation %}
        'select  
            *
        from
            {{ database }}.{{ schema }}.{{ identifier }}'
    {% else %}
        'select null'
    {% endif %}
{% endmacro %}


{% macro show_columns_relation(relation_name) %}
    {%- set relation = ref(relation_name) -%}
    {%- set columns = adapter.get_columns_in_relation(relation) -%}
    {%- for column in columns -%}
        {{ column.column }} {%- if not loop.last -%},{% endif %}
    {% endfor -%}    
{% endmacro %}