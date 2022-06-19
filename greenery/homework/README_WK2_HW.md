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
1. I created a user information model, with contact info from addresses and users combined in core. I also created a dimension table for products and a fact table for events, as those will be useful for many different purposes and audiences. I also created the order_items_products table in core, and it reflects how much people spend per order on specific products.  Again, I think there will be general interest in those metrics.
2. For the marketing directory, I created a model to reflect order information and include an indication of if an order had an associated promo, and how popular that promo was overall.  This could be of use to the marketing team to be able to easily look at which promos were most successful.
3. For the product directory, I created a model that aggregates session data into it's most usable format, so that the product team can easily see session start and end, how many pages were viewed and how many of each action on our pages occured.  It's very similar to what we were shown during the jumpstart, with some minor modifications.
4. If I were to do this for a project at my job, I would probably want to start with a better understanding of the business logic we're using and create more transformative and exploratory models.  My DAG is pretty clear and readable right now, but if I were doing this for an organization, I can see how it would very quickly become complex and layered.

# PART 2 (TESTS)
## What assumptions are you making about each model? (i.e. why are you adding each test?)
### I'm largely assuming uniqueness and presence of user ids for all of my user-centered tables, and also ensuring that there are no product ids in orders that were not present in the products model.

## Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
### All of my tests passed, but I think that over the next week, I'll find that adding more custom tests will highlight flaws in the data or my own personal assumptions.

##  Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
### I would want to set up orchestration and alerts to ensure that these tests are running with every model run (and would probably use the dbt build command).  
