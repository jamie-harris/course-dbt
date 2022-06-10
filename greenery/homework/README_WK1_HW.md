# Week 1 Project
## How many users do we have?
### 130 users
```
select COUNT(distinct user_guid) 
from dbt.dbt_jamie_h.stg_greenery_users

```
## On average, how many orders do we receive per hour?
### Average of 8 orders/hr, rounded.
```
with hour as (
select count( DISTINCT order_guid) as order_count
, date_trunc('hour',created_at_utc) as order_hour
from dbt.dbt_jamie_h.stg_greenery_orders 
GROUP BY 2)
select round(sum(order_count)/count(DISTINCT order_hour)) as average_order_hour
from hour

```
## On average, how long does an order take from being placed to being delivered?
### 3 days, 21 hours
```
SELECT AVG(delivered_at_utc - created_at_utc) AS order_time 
FROM dbt.dbt_jamie_h.stg_greenery_orders 
WHERE delivered_at_utc IS NOT NULL

```
## How many users have only made one purchase? Two purchases? Three+ purchases?
#### Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
### 1 - 25; 2- 28; 3+ - 71
```
with order_totals as (
SELECT user_id
, count(distinct order_guid) as order_count
      FROM dbt.dbt_jamie_h.stg_greenery_orders 
      GROUP BY 1
)
, order_counts as (
SELECT CASE 
      WHEN order_count = 1 THEN '1'
      WHEN order_count = 2 THEN '2'
      WHEN order_count >= 3 THEN '3+'
      ELSE NULL
      END AS order_count_category
      , COUNT(DISTINCT user_id) as user_count
FROM order_totals
GROUP BY order_count_category
)
select * from order_counts


```


## On average, how many unique sessions do we have per hour?
### 16.3 sessions
```
{
with hourly_counts as (
SELECT DATE_TRUNC('hour', created_at_utc) AS hour
, COUNT(DISTINCT session_id) as session_count
    FROM dbt.dbt_jamie_h.stg_greenery_events
    GROUP BY 1
    )
    
SELECT AVG(session_count)
FROM hourly_counts

}

```