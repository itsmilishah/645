select managerid
from dept
group by managerid
having sum(budget)>5000000
order by managerid