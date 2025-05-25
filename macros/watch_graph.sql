{% macro print_graph_nodes() %}
  {% for node in graph.nodes.values() %}
    {% do log("[" ~ node.resource_type ~ "] " ~ node.name ~ ' ' ~ node.path, info=True) %}
  {% endfor %}
{% endmacro %}


{% macro print_objects_counts() %}
    {% set model_nodes = graph.nodes.values() | selectattr("resource_type", "equalto", "model") | list %}
    {% set model_count = model_nodes | length %}   

    {% set seed_nodes = graph.nodes.values() | selectattr("resource_type", "equalto", "seed") | list %}
    {% set seed_count = seed_nodes | length %}   

    {% set snapshot_nodes = graph.nodes.values() | selectattr("resource_type", "equalto", "snapshot") | list %}
    {% set snapshot_count = snapshot_nodes | length %}   

    {% do log("[" ~ model_count ~"] models", info=True) %}
    {% do log("[" ~ seed_count ~"] seeds", info=True) %}
    {% do log("[" ~ snapshot_count ~"] snapshots", info=True) %}

{% endmacro %}


{# {% macro check_dependencies_count() %}
    {% set this_model =  %}
{% endmacro %} #}


-- macros/get_dependencies_of_this.sql
{% macro get_dependencies_count(this) %}
    {% set this_model = graph.nodes.get(this.unique_id) %}
    {% set dependencies = this_model.depends_on.nodes | list %}
    {% set dependencies_count = dependencies | length  %}
    {% do return(dependencies_count) %}
{% endmacro %}