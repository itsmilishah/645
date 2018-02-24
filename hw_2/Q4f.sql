with temp
as (select year, id, count(pubid) as n_pubs
	from Authored natural join Publication
	group by year, id)
, temp2
as (select year as y, max(n_pubs) as m_pubs
	from temp
	group by year)
select year, name, n_pubs
from temp natural join Author
where n_pubs = (select m_pubs from temp2 where y=year)
order by year asc, name asc;
