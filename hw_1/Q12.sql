select ename
from emp natural join
	(select managerid 
		from dept
		group by managerid
		having min(budget)>1000000
		and
		min(budget)<5000000
		)
where eid=managerid
order by ename