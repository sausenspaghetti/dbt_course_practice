{%- macro kopeck_to_ruble(column_name, scale=2) -%}
    ({{ column_name  }} / 100)::numeric(16, {{ scale }})
{%- endmacro -%}


{% macro bookref_to_bigint(column_name) %}
    (('0x' || {{ column_name }} )::bigint)
{% endmacro %}
