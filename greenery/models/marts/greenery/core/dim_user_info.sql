{{
    config(
        materialized = 'table' 
    )
}}


select * from  {{ ref('int_user_info') }}