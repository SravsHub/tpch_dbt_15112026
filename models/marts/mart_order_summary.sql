-- models/marts/mart_order_summary.sql 
select 
    order_key, 
    customer_key, 
    order_date,
    order_status, 
    order_priority, 
    count(*) as total_line_items, 
    sum(quantity) as total_quantity, 
    ROUND(sum(extended_price),2) as total_extended_price, 
    ROUND(sum(effective_revenue),2) as total_effective_revenue, 
    ROUND(sum(extended_price - effective_revenue),2) as total_discount_amount,
    avg(discount) as avg_discount_pct, 
    max(iff(is_returned='Y', 1, 0)) = 1 as has_returned_items 
from {{ ref('int_orders_enriched') }} 
group by 
    order_key, customer_key, order_date, order_status, order_priority