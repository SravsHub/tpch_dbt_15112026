with source_data as (
    select * 
    from {{ source('tpch_raw','PART') }}
),
resultset as (

    select 
        P_PARTKEY   as part_key, 
        P_NAME      as  part_name, 
        P_BRAND     as brand, 
        P_TYPE      as part_type, 
        P_SIZE      as size,
        {{format_usd('P_RETAILPRICE')}} as retail_price
    from source_data
)

select * from resultset
