with source as(
    select * from {{ source('discorama', 'films') }}
),

transformed as(
    select 
    cast(film_id as integer) as film_id
    , cast(title as string) as film_title
    , cast(description as string) as film_description
    , cast(release_year as integer) as film_release_year -- todos os release_year são igual 2006
    -- , cast(language_id as integer) as film_language_id -- todos os IDS são igual a 1
    , cast(rental_duration as integer) as rental_duration
    , cast(rental_rate as numeric) as rental_rate
    , cast(length as numeric) as film_length
    , cast(replacement_cost as numeric) as replacement_cost
    , cast(rating as string) as film_rating
    , cast(last_update as timestamp) as updated_at
    , cast(special_features as string) as special_features
    from source
    order by 1
)

select * from transformed