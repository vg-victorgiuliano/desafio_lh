with source as(
    select * from {{ source('discorama', 'actors') }}
),

transformed as(
    select 
        cast(actor_id as integer) as actor_id
        , cast(first_name as string) as actor_first_name
        , cast(last_name as string) as actor_last_name
        , cast(first_name || ' ' || last_name as string) as actor_full_name
        , cast(last_update as timestamp) as updated_at
    from source
    order by 1
)

select * from transformed