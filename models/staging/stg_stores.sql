with source as(
    select * from {{ source('discorama', 'stores') }}
),

transformed as(
    select 
    cast(store_id as integer) as store_id
    , cast(manager_staff_id as integer) as manager_staff_id
    , cast(address_id as integer) as address_id
    , cast(last_update as timestamp) as updated_at
        
    from source
)

select * from transformed