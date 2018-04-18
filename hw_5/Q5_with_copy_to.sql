create extension tablefunc;

copy(
with ans as
(
select *
from crosstab
(
	'
	with coauthors
	as (select paperid, count(authid) as coauthors
		from paperauths
		group by paperid)
	, some_coauthors
	as (select paperid, coauthors, year
		from coauthors
			join papers on paperid = papers.id
			join venue on papers.venue = venue.id
		where year >= 1995 and year <= 2015)
	select coauthors, year, count(paperid)
	from some_coauthors
	group by coauthors, year
	order by coauthors, year',
	'
	with coauthors
	as (select paperid, count(authid) as coauthors
		from paperauths
		group by paperid)
	, some_coauthors
	as (select paperid, coauthors, year
		from coauthors
			join papers on paperid = papers.id
			join venue on papers.venue = venue.id
		where year >= 1995 and year <= 2015)
	select distinct year
	from some_coauthors
	order by year'
) as res(coauthors integer, year_1995 integer, year_1996 integer,
		year_1997 integer, year_1998 integer, year_1999 integer,
		year_2000 integer, year_2001 integer, year_2002 integer,
		year_2003 integer, year_2004 integer, year_2005 integer,
		year_2006 integer, year_2007 integer, year_2008 integer,
		year_2009 integer, year_2010 integer, year_2011 integer,
		year_2012 integer, year_2013 integer, year_2014 integer,
		year_2015 integer)

)
select coauthors as coauthors,
		coalesce(year_1995, 0) as year_1995,
		coalesce(year_1996, 0) as year_1996,
		coalesce(year_1997, 0) as year_1997,
		coalesce(year_1998, 0) as year_1998,
		coalesce(year_1999, 0) as year_1999,
		coalesce(year_2000, 0) as year_2000,
		coalesce(year_2001, 0) as year_2001,
		coalesce(year_2002, 0) as year_2002,
		coalesce(year_2003, 0) as year_2003,
		coalesce(year_2004, 0) as year_2004,
		coalesce(year_2005, 0) as year_2005,
		coalesce(year_2006, 0) as year_2006,
		coalesce(year_2007, 0) as year_2007,
		coalesce(year_2008, 0) as year_2008,
		coalesce(year_2009, 0) as year_2009,
		coalesce(year_2010, 0) as year_2010,
		coalesce(year_2011, 0) as year_2011,
		coalesce(year_2012, 0) as year_2012,
		coalesce(year_2013, 0) as year_2013,
		coalesce(year_2014, 0) as year_2014,
		coalesce(year_2015, 0) as year_2015
from ans
)
to '/tmp/papers_count_per_coauthors_between_1995_and_2015.csv'
with delimiter ',' csv header;
;
