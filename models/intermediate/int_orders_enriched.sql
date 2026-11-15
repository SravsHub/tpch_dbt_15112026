-- models/intermediate/int_orders_enriched.sql 
with lineitems as ( 
    select * from {{ ref('stg_lineitems') }} 
), 
orders as ( 
    select * from {{ ref('stg_orders') }} 
), 
parts as ( 
    select * from {{ ref('stg_parts') }} 
) 
select 
    li.order_key, 
    li.line_number, 
    li.part_key, 
    li.quantity, 
    li.extended_price, 
    li.discount, 
    li.effective_revenue, 
    li.is_returned,
    o.customer_key, 
    o.order_date, 
    o.order_status,
    o.order_priority, 
    p.part_name, 
    p.brand, 
    p.part_type 
from lineitems li 
left join orders o 
on li.order_key = o.order_key 
left join parts p 
on li.part_key = p.part_key