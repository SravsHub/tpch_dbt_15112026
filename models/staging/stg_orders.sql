with source_data as (
    select * 
    from {{ source('tpch_raw','ORDERS') }}
),
resultset as (

    select 
        O_ORDERKEY   as order_key, 
        O_CUSTKEY    as customer_key, 
        O_ORDERSTATUS as order_status, 
        O_ORDERPRIORITY as order_priority, 
        O_TOTALPRICE as total_price,
        O_ORDERDATE as order_date,
        YEAR(O_ORDERDATE) as order_year,
        MONTH(O_ORDERDATE) as order_month
    from source_data
)

select * from resultset
