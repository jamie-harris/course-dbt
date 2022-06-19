{{
    config(
        materialized = 'view'
    )
}}

with order_items as (
    select * from {{ ref('stg_greenery_order_items') }}
)

, products_join as (
    select order_guid
    , product_id
    , quantity as quantity_ordered
    , name as product_name
    , price as individual_item_price
    , inventory as item_inventory_count
    , (quantity * price) as total_order_expense_item
    from order_items
    INNER JOIN {{ ref('stg_greenery_products') }} as products
    on products.product_guid = order_items.product_id
)

select * from products_join