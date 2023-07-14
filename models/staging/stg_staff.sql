with source as(
    select * 
    from {{ source('discorama', 'staff') }}
),

transformed as(
    select 
    cast(staff_id as integer) as staff_id
    , cast(first_name as string) as staff_firstname
    , cast(last_name as string) as staff_lastname
    , cast(first_name || ' ' || last_name as string) as staff_fullname
    , cast(address_id as integer) as address_id
    , cast(email as string) as staff_email
    , cast(store_id as integer) as store_id
    , cast(active as integer) as active_int
    , cast(last_update as timestamp) as updated_at

    from source
)

select * 
from transformed 