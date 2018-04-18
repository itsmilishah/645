drop table if exists types;
create temp table types(type_id INTEGER, type_name VARCHAR(50));
insert into types values(0, 'Journal Articles');
insert into types values(1, 'Conference and Workshop Papers');
insert into types values(3, 'Books and Thesis');

select type_name as type, count(papers.id) as publications
from papers
	join venue on papers.venue = venue.id
	join types on venue.type = types.type_id
where year != 0
group by type_name;


drop table if exists types;
