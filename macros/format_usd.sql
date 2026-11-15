-- macros/format_usd.sql 
{% macro format_usd(column_name) %} 
    to_char({{ column_name }}, 'FM$999,999,999,990.00') 
{% endmacro %}