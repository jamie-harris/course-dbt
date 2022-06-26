
{{
    config(
        materialized = 'view'
    )
}}

select user_guid
, {{ dbt_privacy.mask_email("email", 
    n=4,
    domain_n=0,
) }} as masked_email
 from {{ ref('stg_greenery_users') }}
