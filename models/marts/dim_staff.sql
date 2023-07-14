with staff as(
    select * from {{ ref('stg_staff') }}
),

stores as(
    select * from {{ ref('stg_stores') }}
),

address as(
    select * from {{ ref('int_address') }}
),

final as(
    select
        {{ dbt_utils.generate_surrogate_key(['staff.staff_id']) }} as sk_staff
        , staff.staff_id
        , staff.staff_fullname
        , staff.store_id
        , address.city_name as store_city
        , address.district as store_district
        , address.country_name as store_country
    from staff
    left join stores using (store_id)
    left join address on stores.address_id = address.address_id
)

select * from final