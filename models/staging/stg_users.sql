{{ config(materialized="incremental",alias="USERS") }}

WITH USERS AS (
    select *
    from {{ source('food_delivery', 'USERS_STG') }}
)


SELECT 
    U.RAW_FILE:pk::VARCHAR(16777216) AS PK, 
    U.RAW_FILE:name::VARCHAR(16777216) AS NAME,  
    U.RAW_FILE:address::VARCHAR(16777216) AS ADDRESS,
    U.RAW_FILE:age::VARCHAR(16777216) AS AGE,
    U.RAW_FILE:gender::VARCHAR(16777216) AS GENDER
FROM USERS U