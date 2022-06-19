{{
  config(
    materialized='view'
  )
}}

with session_detail as (
  select
      session_id
      , user_id
      , min(created_at_utc) as session_start
      , max(created_at_utc) as session_end
      , count(event_guid) as session_event_count
      , count(distinct product_id) as session_unique_products_engaged
      , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_ship_count
      , sum(case when event_type = 'page_view' then 1 else 0 end) as page_view_count
      , sum(case when event_type = 'checkout' then 1 else 0 end) as checkout_count
      , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart_count
  from {{ ref('stg_greenery_events')}}
  group by 1,2
)

select * from session_detail