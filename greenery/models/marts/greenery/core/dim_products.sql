{{
    config(
        materialized = 'table' 
    )
}}


select * from  {{ ref('stg_greenery_products') }}