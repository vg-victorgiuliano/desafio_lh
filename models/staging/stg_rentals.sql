with source as(
    select * from {{ source('discorama', 'rentals') }}
),

transformed as(
    select
    cast(rental_id as integer) as rental_id
    , cast(rental_date as timestamp) as rental_date -- minimum date 2005-05-24
    , cast(inventory_id as integer) as inventory_id
    , cast(customer_id as integer) as customer_id
    , cast(return_date as timestamp) as return_date -- maximum date 2005-09-02
    , cast(staff_id as integer) as staff_id
    , cast(last_update as timestamp) as updated_at

    from source
)

select * from transformed

