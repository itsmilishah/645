select did
from works
group by did
having count(eid)>=2
order by did