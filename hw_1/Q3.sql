select ename 
from dept natural join emp natural join works
where dname="Software" and pct_time>60
order by ename