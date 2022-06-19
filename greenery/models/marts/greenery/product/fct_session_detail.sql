{{
    config(
        materialized = 'table' 
    )
}}


select * from  {{ ref('int_session_detail') }}