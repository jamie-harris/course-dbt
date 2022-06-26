{{
    config(
        materialized = 'view'
    )
}}


with session_count AS (
SELECT DISTINCT
  count(distinct session_id) as session_counts
 , product_id

FROM {{ref('stg_greenery_events')}}
WHERE product_id IS NOT NULL
GROUP BY 2

)

SELECT 
  (sum(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END)/
    avg(sessions.session_counts)::float)*100 as conversion_rate
  , sessions.product_id
  , product.name
FROM {{ref('stg_greenery_events')}} AS events
LEFT JOIN {{ref('stg_greenery_order_items')}} AS order_items
ON events.order_id = order_items.order_guid
LEFT JOIN session_count AS sessions
ON order_items.product_id = sessions.product_id
LEFT JOIN {{ref('stg_greenery_products')}} as product
ON order_items.product_id = product.product_guid
WHERE sessions.product_id IS NOT NULL
GROUP BY 2,3
ORDER BY 1 DESC