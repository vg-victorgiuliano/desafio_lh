with rentals as(
    select * from {{ ref('stg_rentals') }}
),

payments as(
    select * from {{ ref('stg_payments') }}
),

inventory as(
    select * from {{ ref('stg_inventory') }}
),

payment_sum as(
    select 
        rental_id
        , sum(payment_amount) as payment_amount
        , max(payment_date) as payment_date
    from payments
    group by 1
),

joined as(
    select
        rentals.rental_id
        , inventory.film_id
        , rentals.customer_id
        , rentals.staff_id
        , rentals.rental_date
        , rentals.return_date
        , date_diff(cast(rentals.return_date as date), 
                    cast(rentals.rental_date as date), day) as rental_duration
        , rentals.inventory_id
        , coalesce(payment_sum.payment_amount, 0) as payment_amount
        , payment_sum.payment_date
    from rentals
    left join inventory using (inventory_id)
    left join payment_sum using (rental_id)
    
), 


final as(
    select
        {{ dbt_utils.generate_surrogate_key(['joined.rental_id']) }} as sk_rental
        , *
    from joined
)


select * from final
