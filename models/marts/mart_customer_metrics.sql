-- models/marts/mart_customer_metrics.sql
with customer_orders as ( 
    select * from {{ ref('mart_order_summary') }} 
), 
customers as ( 
    select * from {{ ref('stg_customers') }} 
) 
select 
    c.customer_key, 
    c.customer_name, 
    c.market_segment, 
    c.account_balance, 
    count(o.order_key) as total_orders, 
    coalesce(sum(o.total_effective_revenue), 0) as total_revenue, 
    avg(o.total_effective_revenue) as avg_order_value, 
    min(o.order_date) as first_order_date,
    max(o.order_date) as last_order_date,
    CASE WHEN coalesce(sum(o.total_effective_revenue),0)=0 THEN 'No Orders'
    WHEN coalesce(SUM(o.total_effective_revenue),0)>=60000 THEN 'Higher'
    WHEN coalesce(SUM(o.total_effective_revenue),0)>=30000 THEN 'Medium'
    WHEN coalesce(SUM(o.total_effective_revenue),0)>0 THEN 'Low'
    END as Spend_tier
from customers c 
left join customer_orders o 
    on c.customer_key = o.customer_key 
group by 
    c.customer_key, c.customer_name, c.market_segment, c.account_balance

