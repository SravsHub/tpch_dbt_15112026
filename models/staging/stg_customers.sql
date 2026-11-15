with source_data as (
    select * 
    from {{ source('tpch_raw','CUSTOMER') }}
),
resultset as (

    select 
        C_CUSTKEY   as customer_key, 
        C_NAME      as customer_name, 
        C_MKTSEGMENT as market_segment, 
        C_ACCTBAL as account_balance, 
        CASE WHEN (C_ACCTBAL > 0) THEN 'Yes'
        ELSE 'Non'
        END AS is_positive_balance 
    from source_data
)

select * from resultset