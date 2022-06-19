{{
    config(
        materialized = 'view'
    )
}}

with users as (
    select * from {{ ref('stg_greenery_users') }}
)

, address_join as (
    select user_guid
    , first_name
    , last_name
    , email
    , phone_number
    , created_at_utc
    , updated_at_utc
    , address_id 
    , address
    , zipcode
    , state
    , country
    from users
    INNER JOIN {{ ref('stg_greenery_addresses') }} as addresses
    on addresses.address_guid = users.address_id
)

select * from address_join