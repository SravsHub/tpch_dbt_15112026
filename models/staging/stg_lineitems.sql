with source_data as (
    select * 
    from {{ source('tpch_raw','LINEITEM') }}
),
resultset as (

    select 
        L_ORDERKEY   as order_key, 
        L_LINENUMBER as line_number, 
        L_PARTKEY  as part_key, 
        L_QUANTITY as quantity, 
        L_EXTENDEDPRICE as extended_price,
        L_DISCOUNT as discount,
        L_RETURNFLAG as return_flag,
        L_SHIPMODE as ship_mode,
        L_EXTENDEDPRICE * (1 - L_DISCOUNT) as effective_revenue, 
        L_EXTENDEDPRICE * L_TAX as tax_amount, 
        CASE WHEN (L_RETURNFLAG = 'R') THEN 'Y'
        ELSE 'N'
        END is_returned
    from source_data
)
select * from resultset

