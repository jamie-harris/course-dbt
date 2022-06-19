{{
    config(
        materialized = 'table' 
    )
}}


select * from  {{ ref('int_order_items_products') }}