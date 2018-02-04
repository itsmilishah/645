select distinct ename
from emp natural join works natural join dept
where budget<1000000
and ename not in
(
select ename
from emp natural join works natural join dept
where budget>=1000000
)
order by ename