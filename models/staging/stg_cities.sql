with source as(
    select * from {{ source('discorama', 'cities') }}
),

transformed as(
    select 
        cast(city_id as integer) as city_id
        , cast(city as string) as city_name
        , cast(country_id as integer) as country_id
        , cast(last_update as timestamp) as updated_at
    from source
)

select* from transformed