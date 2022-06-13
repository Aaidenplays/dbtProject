{{ config(materialized="view", alias="most_valued_user", schema="BUSINESS_QUERY_VIEWS", database="FOOD_DELIVERY") }}

with orders AS (
    select * 
    from {{ source('denormalized_orders', 'DENORMALIZED_ORDERS') }}
)

select USER_PK, USERS_NAME, SUM(PRICE) AS AGG_PRICE
from orders
group by USER_PK, USERS_NAME
ORDER BY AGG_PRICE DESC
LIMIT 1
