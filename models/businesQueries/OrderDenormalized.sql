{{ config(materialized="view", alias="denormalized_orders") }}

WITH ORDERS AS (
    select
        PK as order_pk,
        MENU_ITEM_FK,
        RESTAURANT_FK,
        USER_FK,
        CREATED_TS AS ORDER_CREATED_TS
    from {{ source('orders', 'ORDERS') }}
),
RESTAURANTS AS (
    select 
        PK as RESTAURANT_PK,
        NAME AS RESTAURANT_NAME,	
        TYPE,	
        CREATED_TS AS RESTAURANTS_CREATED_TS
    from {{ source('food_delivery', 'RESTAURANTSDATASEED') }}
),
USERS AS (
    select 
        PK as USER_PK,	
        NAME AS USERS_NAME,	
        ADDRESS AS USERS_ADDRESS,	
        AGE,	
        GENDER
    from {{ source('users', 'USERS') }}
),
MENU_ITEMS AS (
    select 
        PK AS MENU_PK,
        NAME AS ITEM_NAME,
        PRICE,
        CREATED_TS AS MENU_ITEMS_CREATED_TS
    from {{ source('food_delivery', 'MENU_ITEMS') }}
),
FINAL AS (
    select *
    from ORDERS O
    JOIN USERS U
    ON O.USER_FK = U.USER_PK
    JOIN RESTAURANTS R 
    ON O.RESTAURANT_FK = R.RESTAURANT_PK
    JOIN MENU_ITEMS M
    ON O.MENU_ITEM_FK = M.MENU_PK
)

select *
from FINAL
