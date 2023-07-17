with payments as(
    select * from {{ ref('stg_payments') }}
)

select
    rental_id
    , sum(payment_amount) as payment_sum
from payments
group by 1
having payment_sum < 0