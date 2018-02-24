select p, count(k)
from Pub
group by p
order by count(k) desc;
