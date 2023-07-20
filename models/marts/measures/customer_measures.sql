with customers as(
    select * from {{ ref('dim_customers') }}
),

rentals as(
    select * from {{ ref('fct_rentals') }}
),

films as(
    select * from {{ ref('dim_films') }}
),

joined as(
    select 
        customers.sk_customer
        , customers.customer_fullname
        , customers.customer_country
        , rentals.sk_rental
        , rentals.rental_date
        , rentals.total_payment
        , films.film_title
        , films.category_name
    from customers
    left join rentals on customers.sk_customer = rentals.fk_customer
    left join films on rentals.fk_film = films.sk_film
),

gap_period as(
    select 
        sk_customer
        , date_diff(rental_date, lag(rental_date) over 
            (partition by customer_fullname 
            order by rental_date), day) as gap_between_rentals
    from joined
    where rental_date <'2006-02-14'
),

maximum as(
    select 
        joined.sk_customer
        , max(rental_date) as most_recent
        , max(gap_between_rentals) as max_gap
    from joined
    left join gap_period using (sk_customer)
    where rental_date <'2006-02-14'
    group by 1
),

totals as(
    select
        sk_customer
        , customer_fullname
        , customer_country
        , count(sk_rental) as n_rentals
        , sum(total_payment) as life_value
    from joined
    group by 1, 2, 3
),

ranked_category as(
    select 
        sk_customer
        , customer_fullname
        , category_name
        , count(sk_rental) as n_rentals
        , rank() over(partition by customer_fullname order by count(sk_rental)) as rn
    from joined
    group by 1, 2, 3
),

top_category as(
    select 
        sk_customer
        , customer_fullname
        , string_agg(category_name, ', ') as fav_categories
    from ranked_category
    where rn = 1
    group by 1, 2
),

final as(
    select 
        totals.sk_customer
        , totals.customer_fullname
        , totals.customer_country
        , totals.n_rentals
        , maximum.max_gap
        , totals.life_value
        , maximum.most_recent
        , top_category.fav_categories
    from totals
    left join maximum using (sk_customer)
    left join top_category using (sk_customer)
)
select * from final


