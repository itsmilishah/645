select distinct ename
from emp join
	(select managerid, max(budget) from dept)
where eid=managerid
order by ename