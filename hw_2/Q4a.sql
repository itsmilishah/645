select name, count(pubid)
from author natural join authored
group by id
order by count(pubid) DESC, id
limit 17
