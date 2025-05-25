{%- macro limit_data_dev(column_name, days=2) -%}
    {% if days < 0 %}
        {{ exceptions.raise_compiler_error("Invalid `days`. Got: " ~ days) }}
    {% endif %}

    {%- if target.name == 'dev' -%}
    where
        {{ column_name }} >= {{- dbt.dateadd(datepart="days", interval=-days, from_date_or_timestamp="current_date") -}}
    {%- endif -%} 
{%- endmacro -%}