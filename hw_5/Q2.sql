with bd as
(
	select id as paper_id, venue as venue_id
	from papers
	where to_tsvector('english', name) @@ to_tsquery('english', 'big & data')
)
select type, name, id, count(paper_id) as count
from bd join venue on venue_id = id
group by grouping sets (type, name, id)
;
