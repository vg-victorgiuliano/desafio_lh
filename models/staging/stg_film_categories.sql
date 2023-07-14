with source as(
    select * from {{ source('discorama', 'film_categories') }}
),

transformed as(
    select 
        cast(category_id as integer) as category_id
        , cast(film_id as integer) as film_id
        , cast(last_update as timestamp) as updated_at
    from source
)

select *
from transformed
