select acc_id,
extract(year from pay.date_pay) year, 
extract(month from pay.date_pay) month,
sum_pay,
sum(sum_pay) over(order by acc_id desc,  pay.date_pay) running_total
from h20.pay2020 pay 
where acc_id = 77711
