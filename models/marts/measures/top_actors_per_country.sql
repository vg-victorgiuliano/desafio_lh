with actors as(
    select * from {{ ref('stg_actors') }}
),

film_actors as(
    select * from {{ ref('stg_film_actors') }}
),

films as(
    select * from {{ ref('stg_films') }}
),

customers as(
    select * from {{ ref('dim_customers') }}
),

rentals as(
select * from {{ ref('stg_rentals') }}
),

inventory as(
    select * from {{ ref('stg_inventory') }}
),

ranked_actors as(
    select
        customers.customer_country
        , actors.actor_full_name
        , count(rentals.rental_id) as n_rentals
        , rank() over(partition by customer_country order by count(rentals.rental_id) desc) as rn
    from rentals
    left join customers using (customer_id)
    left join inventory using (inventory_id)
    left join films using (film_id)
    left join film_actors using (film_id)
    left join actors using (actor_id)
    group by 1, 2
),

top_actors as(
    select
        customer_country
        , string_agg(actor_full_name, ', ') as list_of_actors
    from ranked_actors
    where rn = 1
    group by 1
    order by 1
)

select * from top_actors