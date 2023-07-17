with rentals as(
    select * from {{ ref('int_rentals') }}
),

films as(
    select * from {{ ref('dim_films') }}
),

staff as(
    select * from {{ ref('dim_staff') }}
),

customers as(
    select * from {{ ref('dim_customers') }}
),

joined as (
    select 
        rentals.sk_rental
        , rentals.rental_id
        , films.sk_film as fk_film
        , customers.sk_customer as fk_customer 
        , staff.sk_staff as fk_staff
        , films.rental_duration as predicted_duration
        , rentals.rental_date
        , rentals.return_date
        , rentals.rental_duration as actual_duration
        , rentals.payment_amount as total_payment
        , rentals.payment_date
    from rentals
    left join films using (film_id)
    left join staff using (staff_id)
    left join customers using (customer_id)
),

final as(
    select 
        *
        , case 
            when predicted_duration >= actual_duration then 'No prazo'
            when predicted_duration < actual_duration then 'Atrasado'
            when actual_duration is null then 'Não voltou'
            end as late_label
        , case
            when total_payment = 0 then 'Não pagou'
            when total_payment <> 0 then 'Pago'
            end as paid_label
    from joined
)

select  * from final
