{{
  config(
    materialized='table'
  )
}}

with product_session_detail as (
  select DISTINCT
      product_id as unique_products_engaged
      , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_ship_count
      , sum(case when event_type = 'page_view' then 1 else 0 end) as page_view_count
      , sum(case when event_type = 'checkout' then 1 else 0 end) as checkout_count
      , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart_count
  from {{ ref('stg_greenery_events')}}

  group by 1
)

select * from product_session_detail