
-- drop table if exists types;
-- create temp table types(type_id INTEGER primary key, type_name VARCHAR(50));
-- insert into types values(0, 'Journal Articles');
-- insert into types values(1, 'Conference and Workshop Papers');
-- insert into types values(3, 'Books and Thesis');

-- with ans as
-- (
-- select *
-- from crosstab
-- (
	-- 'select year, type_name, count(papers.id) as publications
	-- from papers
		-- join venue on papers.venue = venue.id
		-- join types on venue.type = types.type_id
	-- where year != 0
	-- group by year, type_name
	-- order by year, type_name desc',
	-- 'select distinct type_name from types'
-- ) as res(year integer, "journal_articles_publications"	 integer,
		-- "books_and_thesis_publications" integer,
		-- "conference_and_workshop_papers_publications" integer)
-- )
-- select year,
	-- journal_articles_publications,
	-- coalesce(books_and_thesis_publications, 0)
		-- as books_and_thesis_publications,
	-- coalesce(conference_and_workshop_papers_publications, 0)
		-- as conference_and_workshop_papers_publications
-- from ans
-- ;

-- drop table if exists types;

create extension tablefunc;
with ans as
(
select *
from crosstab
(
	'select year, type, count(papers.id) as publications
	from papers
		join venue on papers.venue = venue.id
	where year != 0
	group by year, type
	order by year, type',
	'select distinct type
	from venue
	order by type'
) as res(year integer, "journal_articles_publications"	 integer,
		"conference_and_workshop_papers_publications" integer,
		"books_and_thesis_publications" integer
		)
)
select year,
	journal_articles_publications,
	coalesce(conference_and_workshop_papers_publications, 0)
		as conference_and_workshop_papers_publications,
	coalesce(books_and_thesis_publications, 0)
		as books_and_thesis_publications
from ans
;
