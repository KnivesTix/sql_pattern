--1. Вывести кол-во заказов выполненных с начала текущего года
select count(distinct order_id)
    from orders
    where order_date >= '2023-01-01';
    
--2. Вывести месяц в формате (YYYYMM - год месяц), в котором продано товаров на самую большую сумму. Если таковых несколько, то вывести месяца с самими большими продажами
with a as (select extract (year from to_date(order_date, 'yyyy-mm-dd')) order_year, extract (month from to_date(order_date, 'yyyy-mm-dd')) order_month, sum(amount_number) sum_amount
      from orders
      group by  extract (year from to_date(order_date, 'yyyy-mm-dd')), extract (month from to_date(order_date, 'yyyy-mm-dd'))
)
select order_year || order_month from (
select order_year, order_month, sum_amount, rank() over(order by sum_amount desc) r 
from a
) where r = 1;

--3. Вывести топ 3 самых дорогих товаров за весь период. При условии, что стоимость товара может изменяться
select item_id from (select item_id, rank() over (order by amount_number desc) r
from orders
)
where r < 4;

select item_id, max(amount_number) sum_amount
from orders
group by item_id
order by max(amount_number) desc
fetch first 3 rows only;

--4. Вывести нарастающим итого продажи за день в разрезе каждого месяца
select extract (month from to_date(order_date, 'yyyy-mm-dd')),amount_number, 
 sum(amount_number) over(partition by extract (month from to_date(order_date, 'yyyy-mm-dd')) order by extract (day from to_date(order_date, 'yyyy-mm-dd')) rows between unbounded preceding and current row) b
from orders;

--5. Выгрузить продажи за каждый месяц

select extract (month from to_date(order_date, 'yyyy-mm-dd')), sum(amount_number)
from orders
group by extract (month from to_date(order_date, 'yyyy-mm-dd')), extract (year from to_date(order_date, 'yyyy-mm-dd'));

--6. Вывести дату, с самой большой выручкой за день
select order_date from orders
group by order_date
having sum(amount_number) = max(amount_number)
order by max(amount_number) desc
/*7. Вывести продажи по группам товаров за весь период. Группы товаров: 
a.  1 - от 10 до 20 
b.  2 - от 21 до 50
c.  3 - более 50 
d.  -1 - Если товар не относится ни к одной группе
*/
select case when amount_number between 10 and 20 then 1 
  when amount_number between 21 and 50 then 2 
  when amount_number > 50 then 1  
  else -1 end group_id,
  sum(amount_number)
  from orders
group by case when amount_number between 10 and 20 then 1 
 when amount_number between 21 and 50 then 2 
  when amount_number > 50 then 1  
  else -1 end;
  
--8. Вывести продажи за каждый месяц и категории с подытогом за месяц и общим тотал за весь период
select extract(month from to_date(order_date, 'yyyy-mm-dd')), sum(amount_number)
from orders
group by grouping sets(extract(month from to_date(order_date, 'yyyy-mm-dd')), ());

--9. Вывести продажи по категории, наименование которой заканчивается на '2'
select amount_number
from orders
where type_item like '%2';

--10. Найти дубли в таблице и вывести их. дублем являются записи, у которых значения всех полей совпадают

select order_id, order_date, item_id, amount_number, type_item
from orders
group by order_id, order_date, item_id, amount_number, type_item
having count(*) > 1;

select * from(
select order_id, order_date, item_id, amount_number, type_item, row_number() over (partition  by order_id, order_date, item_id, amount_number, type_item order by order_id, order_date, item_id, amount_number, type_item) rn
from orders)
where rn > 1
