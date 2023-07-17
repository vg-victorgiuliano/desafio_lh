with source as(
    select * from {{ source('discorama', 'customers') }}
),

transformed as(
    select 
        cast(customer_id as integer) as customer_id
        , cast(store_id as integer) as store_id
        , cast(first_name as string) as customer_firstname
        , cast(last_name as string) as customer_lastname
        , cast(first_name || ' ' || last_name as string) as customer_fullname
        , cast(email as string) as customer_email
        , cast(address_id as integer) as address_id
        -- , cast(activebool as integer) as activebool_int, todos os valores são 1(true)
        , cast(create_date as date) as created_at
        , cast(last_update as timestamp) as updated_at
        , cast(active as integer) as active
    from source
)

select *
from transformed
