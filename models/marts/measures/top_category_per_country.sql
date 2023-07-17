with customers as(
    select * from {{ ref('dim_customers') }}
),

rentals as (
    select * from {{ ref('fct_rentals') }}
),

films as(
    select * from {{ ref('dim_films') }}
),

joined as(
    select
        customer_country
        , category_name
        , count(sk_rental) as n_rentals
        , rank() over (partition by customer_country order by count(sk_rental) desc) as rn
    from rentals
    left join customers on customers.sk_customer = rentals.fk_customer
    left join films on rentals.fk_film = films.sk_film
    group by 1, 2
),

top_categories as(
    select 
        customer_country
        , string_agg(category_name, ', ') as category_name
    from joined
    where rn = 1
    group by 1
    order by 1
)

select * from top_categories