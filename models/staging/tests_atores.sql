with films as(
    select * from {{ ref('stg_films') }}
),

actors as(
    select * from {{ ref('stg_actors') }}
),

film_actors as(
    select * from {{ ref('stg_film_actors') }}
),

rentals as(
    select * from {{ ref('stg_rentals') }}
),

inventory as(
    select * from {{ ref('stg_inventory') }}
),

joined as(
    select 
        rentals.rental_id
        , rentals.inventory_id
        , rentals.rental_date
        , films.film_title
        , actors.actor_full_name
    from rentals
    left join inventory using (inventory_id)
    left join films using (film_id)
    left join film_actors using (film_id)
    left join actors using (actor_id)
),

final as(
    select * from joined
)

select 
    actor_full_name, 
    count(distinct rental_id) as counted_rentals 
from final
group by 1
order by counted_rentals desc