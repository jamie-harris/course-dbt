{{
    config(
        materialized = 'view'
    )
}}

with promos_source as (
    select * from {{ source('src_greenery', 'promos') }}
)

, renamed_recast as (
    select promo_id as promo_guid
    , discount
    , status
    
    from promos_source
)
select * from renamed_recast