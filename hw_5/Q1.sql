drop table if exists big_data_pubs;
create table big_data_pubs as
(
	select id, name, venue
	from papers
	where to_tsvector('english', name) @@ to_tsquery('english', 'big & data')
)
;


select count(distinct id)
from big_data_pubs;
