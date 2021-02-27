with c as (
SELECT u.*, RANK() OVER (ORDER BY email) r
FROM inet.users u
) 
SELECT email, R FROM c GROUP BY email,R HAVING COUNT(*)>1
