with source as(
    select * from {{ source('discorama', 'countries') }}
),

transformed as(
    select 
        cast(country_id as integer) as country_id
        , cast(country as string) as country_name
        , cast(last_update as timestamp) as updated_at
      
    from source
)

select* from transformed