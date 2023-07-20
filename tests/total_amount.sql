with fct_rentals as(
    select * from {{ ref('fct_rentals') }}
)

select 
    sum(total_payment) as total_amount
from fct_rentals
where rental_date >= '2005-05-23' and rental_date <= '2006-02-15'
having total_amount <> 61312.04