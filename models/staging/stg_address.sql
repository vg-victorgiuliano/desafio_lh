with source as(
    select * from {{ source('discorama', 'address') }}
),

transformed as(
    select
        cast(address_id as integer) as address_id
        , cast(address as string) as address
        , cast(district as string) as district
        , cast(city_id as integer) as city_id
        , cast(postal_code as integer) as postal_code
        , cast(round(phone,0) as string) as phone_number
        , cast(last_update as timestamp) as updated_at
    from source	
)

select *
from transformed 
