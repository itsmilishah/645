select year, type, count(papers.id) as publications
	from papers
		join venue on papers.venue = venue.id
	where year != 0
	group by year, type
	order by year, type
