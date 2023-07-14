with address as(
    select * from {{ ref('stg_address') }}
),

cities as(
    select * from {{ ref('stg_cities') }}
),

countries as(
    select * from {{ ref('stg_countries') }}
),

final as(
    select 
        address.address_id
        , address.address
        , cities.city_name
        , address.district
        , countries.country_name
        , address.postal_code
        , address.phone_number
    from address
    left join cities using (city_id)
    left join countries using (country_id)
)
 select * 
 from final
 order by 1