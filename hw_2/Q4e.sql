with temp
as (select distinct a.name as author_1, b.id as author_2
	from
		(Authored natural join Author) as a
		join
		Authored as b
		on a.pubid=b.pubid
	where a.id!=b.id)
select author_1, count(author_2) as cnt
from temp
group by author_1
order by cnt desc, author_1 asc
limit 20;
