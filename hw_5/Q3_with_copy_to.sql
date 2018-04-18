drop table if exists types;

create temp table types(type_id INTEGER primary key, type_name text);
insert into types values(0, 'Journal Articles');
insert into types values(1, 'Conference and Workshop Papers');
insert into types values(3, 'Books and Thesis');

copy
(
	select type_name as type, count(papers.id) as publications
	from papers
		join venue on papers.venue = venue.id
		join types on venue.type = types.type_id
	where year != 0
	group by type_name
)
to '/tmp/papers_count_per_type.csv'
with delimiter ',' csv header;

drop table if exists types;
