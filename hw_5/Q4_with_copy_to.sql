create extension tablefunc;

copy(
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

)
to '/tmp/papers_count_per_type_per_year.csv'
with delimiter ',' csv header;
;
