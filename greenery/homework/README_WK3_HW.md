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


# PART 2
## Create a macro to simplify part of a model(s).
### Document the macro(s) using a .yml file in the macros directory.

# PART 3
## Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

### Added!

# PART 4
## Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project



