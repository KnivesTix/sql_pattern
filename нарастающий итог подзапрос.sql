select acc_id,
extract(year from pay.date_pay) year, 
extract(month from pay.date_pay) month,
sum_pay,
 (select sum(sum_pay) from h20.pay2020 h where h.acc_id = pay.acc_id and pay.date_pay < h.date_pay) totl from  h20.pay2020 pay
where acc_id = 77711

order by extract(month from pay.date_pay)
