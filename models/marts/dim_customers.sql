with customers as(
    select * from {{ ref('stg_customers') }}
),

address as(
    select * from {{ ref('int_address') }}
),

final as (
    select 
        {{ dbt_utils.generate_surrogate_key(['customers.customer_id']) }} as sk_customer
        , customers.customer_id
        , customers.customer_fullname
        , customers.created_at
        , address.city_name as customer_city
        , address.district as customer_district
        , address.country_name as customer_country
    from customers
    left join address using (address_id)

)

select * from final