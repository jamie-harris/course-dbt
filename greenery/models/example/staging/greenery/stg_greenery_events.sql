{{
    config(
        materialized = 'view'
    )
}}

with events_source as (
    select * from {{ source('src_greenery', 'events') }}
)

, renamed_recast as (
    select event_id as event_guid
    , session_id
    , user_id
    , page_url
    , created_at as created_at_utc
    , event_type
    , order_id
    , product_id
    from events_source
)
select * from renamed_recast