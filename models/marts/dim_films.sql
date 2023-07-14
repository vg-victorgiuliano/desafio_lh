with films as(
    select * from {{ ref('stg_films') }}
),

film_categories as(
    select * from {{ ref('stg_film_categories') }}
),

film_actors as(
    select * from {{ ref('stg_film_actors') }}
),

categories as(
    select * from {{ ref('stg_categories') }}
),

actors as(
    select * from {{ ref('stg_actors') }}
),

films_known_actors as(
    select
        {{ dbt_utils.generate_surrogate_key(['films.film_id']) }} as sk_film
        , films.film_id
        , films.film_title
        , films.film_release_year 
        , categories.category_name
        , array_agg(actors.actor_full_name) as list_of_actors
        , films.rental_duration
        , films.rental_rate
        , films.film_length
        , films.replacement_cost
        , films.film_rating
    from films
    left join film_categories using (film_id)
    left join categories using (category_id)
    left join film_actors using (film_id)
    left join actors using (actor_id)
    where film_id not in (257.0, 323.0, 803.0)
    group by 1, 2, 3, 4, 5, 7, 8, 9, 10, 11
),

films_unknown_actors as(
    select
        {{ dbt_utils.generate_surrogate_key(['films.film_id']) }} as sk_film
        , films.film_id
        , films.film_title
        , films.film_release_year 
        , categories.category_name
        , array["unknown_actors"] as list_of_actors
        , films.rental_duration
        , films.rental_rate
        , films.film_length
        , films.replacement_cost
        , films.film_rating
    from films
    left join film_categories using (film_id)
    left join categories using (category_id)
    left join film_actors using (film_id)
    left join actors using (actor_id)
    where film_id in (257.0, 323.0, 803.0)
    group by 1, 2, 3, 4, 5, 7, 8, 9, 10, 11
    
),

final as(
    select * from films_known_actors
    union all 
    select * from films_unknown_actors
)

select * from final
