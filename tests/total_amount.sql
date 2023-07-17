with fct_rentals as(
    select * from {{ ref('fct_rentals') }}
)

select 
    sum(total_payment) as total_amount
from fct_rentals
having total_amount <> 61312.04