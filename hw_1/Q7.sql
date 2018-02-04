select ename
from emp natural join 
	(select distinct eid, did
	from works natural join
		(select did
		from dept
		where budget>12000000))
group by eid
having count(did)=(select count(did)
		from dept
		where budget>12000000)
order by ename

/*with S
	as (select did
		from dept
		where budget>12000000) 
,R
	as (select eid, did 
		from works
       Where did in S)

select distinct ename 
from R natural join emp
where eid not in
	(select eid 
		from
			((select eid from R)
			cross join
			S)
		where (eid, did) not in R)
order by ename*/