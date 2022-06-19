{{
    config(
        materialized = 'table' 
    )
}}


select * from  {{ ref('int_promo_popularity_orders') }}