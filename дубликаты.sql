1) Просто список повторяющихся
with c as (
SELECT u.*, RANK() OVER (ORDER BY email) r
FROM internet.users u
) 
SELECT email, R FROM c GROUP BY email,R HAVING COUNT(*)>1

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