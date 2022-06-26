# Wk 3 Project
# PART 1 
## What is our overall conversion rate?
### 62%
```
SELECT
   ROUND(SUM(checkout_count)*100 / COUNT(DISTINCT session_id)) AS conversion_rate
FROM dbt_jamie_h.fct_session_detail

```

## What is our conversion rate by product? 

### Adding top 3.

| conversion_rate | product_name     |
|-----------------|------------------|
| 60.93 %         | String of Pearls |
| 55.55 %         | Arrow Head       |
| 54.54 %         | Cactus           |

#### Created model int_conversion_rate.sql
```
select * from dbt_jamie_h.int_conversion_rate
order by conversion_rate desc
```
#### Model
```
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

```


# PART 2
## Create a macro to simplify part of a model(s).
### Document the macro(s) using a .yml file in the macros directory.
### Created a grants macro.

# PART 3
## Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

### Added!

# PART 4
## Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

### Applied the privacy macro to mask emails. Now I have a view that allows me to see the user_guid and an email address that only gives me domain information.
```
select * from dbt_jamie_h.int_masked_email
```




