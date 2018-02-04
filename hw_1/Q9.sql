select did, avg(salary)
from emp natural join works natural join dept
group by did
order by did