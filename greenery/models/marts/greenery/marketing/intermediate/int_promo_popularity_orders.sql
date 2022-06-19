{{
    config(
        materialized = 'view'
    )
}}

with promo_count as (
    select promo_id
    , count(order_guid) as overall_promo_usage
     from {{ ref('stg_greenery_orders') }}
    group by 1
)
, promos as (
    select promo_id
    , discount
    , status as promo_status
    , overall_promo_usage
    from promo_count
    INNER JOIN  {{ ref('stg_greenery_promos') }} as promotions
    on promotions.promo_guid = promo_count.promo_id
)
, orders_complete as (
select order_guid
    , user_id
    , orders.promo_id
    , address_id
    , created_at_utc
    , order_cost
    , shipping_cost
    , order_total
    , tracking_id
    , shipping_service
    , estimated_delivery_at_utc
    , delivered_at_utc
    , orders.status as order_status
    , discount
    , promo_status
    , overall_promo_usage
    from {{ ref('stg_greenery_orders') }} as orders
    INNER JOIN promos
    on promos.promo_id = orders.promo_id
)

select * from orders_complete