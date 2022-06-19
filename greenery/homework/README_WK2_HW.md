# Wk 2 Project
# PART 1 (MODELS)
## What is our user repeat rate?
### 79.83%
```
with orders_cohort as (
select user_id
, count(distinct order_guid) as user_orders
from dbt.dbt_jamie_h.stg_greenery_orders
group by 1
)

, users_bucket as (
select user_id
,  (user_orders = 1)::int as has_one_purchases
, (user_orders >= 2)::int as has_two_or_more_purchases
from orders_cohort
)
select (sum(has_two_or_more_purchases)::float / count(distinct user_id))*100 as repeat_rate_percentage
from users_bucket
```

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
###  
1. I would want to explore if there are any trends in purchase time or date of week for repeat customers vs one-time customers.  Are night owls more likely to make a repeat purchase of our products at 1am, or are our repeat customers people who do their purchasing on weekend afternoons? 
2. I would also look at the products they're purchasing-- are certain products more likely to be re-ordered than others? Is there a product that has little to no associated users with a second purchase? (Maybe the product is defective and gives people a bad experience with the company.)
3. I would want to see if there are any trends between who is taking advantage of our promotions and who is a repeat orderer.  Are certain promos more likely to compel a person to re-order?
4. Continuing on the exploration of user experience, I'd want to explore delivery time.  Are people who recieve quicker deliveries more or less likely to return?  If we're finding that there's some sweetspot for delivery time that results in returning customers, we can optimize our business model to allow for free shipping for customers with that delivery time, to maximize our customer loyality.

## Explain the marts models you added. Why did you organize the models in the way you did?
### 
