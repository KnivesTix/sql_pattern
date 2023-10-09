1) Просто список повторяющихся
with c as (
SELECT u.*, RANK() OVER (ORDER BY email) r
FROM internet.users u
) 
SELECT email, R FROM c GROUP BY email,R HAVING COUNT(*)>1

- пересечение диапазонов дат (объединить таблицу саму с собой)
select a.empno,a.ename,
 'project '||b.proj_id||
 ' overlaps project '||a.proj_id as msg
 from emp_project a,
 emp_project b
 where a.empno = b.empno
 and b.proj_start >= a.proj_start --дата начала больше или равна другой
 and b.proj_start <= a.proj_end -- дата начала меньше или равно даты завершения
 and a.proj_id != b.proj_id -- и идентификаторы не равны

select id,last_name,
sum(id) over () sum1, --общая сумма
sum(id) over (order by id) sum2, --нарастающий итог
sum(id) over (partition by last_name order by id, last_name) sum3 --сумма в группе
from family;

2)
select * from inet.users h 
where exists 
(select id from inet.users
where email = h.email 
and ID < h.ID)

3)
select * from inet.users t
where id in (select id from (
	select id, row_number() over (
		partition by email order by email) rn 
	from inet.users) where rn > 1)

4)
select * from inet.users i
where id not in (
	select min(id) id 
	from inet.users 
	group by email)

5)
select rowid, email
from (
select email, row_number() over(partition by email order by email) rn
from inet.users) i
where rn>1
