with rentals as(
    select * from {{ ref('stg_rentals') }}
),

payments as(
    select * from {{ ref('stg_payments') }}
),

inventory as(
    select * from {{ ref('stg_inventory') }}
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
        , coalesce(payments.payment_amount, 0) as payment_amount
        , payments.payment_date
    from rentals
    left join inventory using (inventory_id)
    left join payments using (rental_id)
    where rental_id <> 4591.0
    
), 


final as(
    select
        {{ dbt_utils.generate_surrogate_key(['joined.rental_id']) }} as sk_rental
        , *
    from joined
)


select * from final
