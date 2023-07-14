with source as(
    select * from {{ source('discorama', 'categories') }}
),

transformed as(
    select
        cast(category_id as integer) as category_id
        , cast(name as string) as category_name
        , cast(last_update as timestamp) as updated_at
    from source
)
select * from transformed
