/*
select name, count(pubid)
from Author natural join Authored natural join Publication
where pubkey='STOC'
group by id
order by count(pubid) DESC, id
limit 20
*/

select name, count(pubid) as n_pubs
from Publication natural join Authored natural join Author
where pubkey like '%/stoc/%'
group by name
order by n_pubs desc, name asc
limit 20;
