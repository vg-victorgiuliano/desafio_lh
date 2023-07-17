with source as(
    select * from {{ source('discorama', 'payments') }}
),

transformed as(
    select 
        cast(payment_id as integer) as payment_id
        , cast(customer_id as integer) as customer_id
        , cast(staff_id as integer) as staff_id
        , cast(rental_id as integer) as rental_id  -- rental_id = 4591.0 com 5 pagamentos
        , cast(amount as numeric) as payment_amount
        , cast(payment_date as timestamp) as payment_date -- min 2007-02-14, max 2007-05-14
    from source
)

select * from transformed
