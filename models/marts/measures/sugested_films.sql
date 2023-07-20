with rentals as(
    select * from {{ ref('fct_rentals') }}
),

films as(
    select * from {{ ref('dim_films') }}
),

joined as(
    select 
        sk_rental
        , fk_film
        , fk_customer
        , film_title
    from rentals
    left join films on films.sk_film = rentals.fk_film
),

self_join as(
    select 
        least(rental1.film_title, rental2.film_title) as filme1
        , greatest(rental1.film_title, rental2.film_title) as filme2
        , count(distinct rental1.fk_customer) as total_customers
    from joined as rental1
    inner join joined as rental2 on rental1.fk_customer = rental2.fk_customer
      and rental1.fk_film <> rental2.fk_film
    group by 1, 2
    having count(distinct rental1.fk_customer) > 1
    order by total_customers desc
)
select * from self_join