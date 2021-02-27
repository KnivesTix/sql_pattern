select *
from (select acc_id, 
extract(year from date_pay) year, 
extract(month from date_pay) month, 
sum_pay,
sum_pay as total from history2020.pay2020) p
where acc_id = 123
model
dimension by (row_number() over (order by p.month) as rn)
measures (acc_id,
sum_pay,
total)
rules (total[rn >= 2] = total[cv() -1] + sum_pay[cv()] )
