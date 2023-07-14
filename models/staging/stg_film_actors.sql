with source as(
    select * from {{ source('discorama', 'film_actors') }}
),

transformed as(
    select 
        cast(actor_id as integer) as actor_id
        , cast(film_id as integer) as film_id
        , cast(last_update as timestamp) as updated_at
       
    from source
)

select * from transformed