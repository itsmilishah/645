with ranges
as (select distinct
		a.year as start,
		a.year+9 as end
	from Publication as a)

select cast(ranges.start as varchar(10)) || '-' ||  cast(ranges.end as varchar(10)) as range, count(pubid)
from ranges cross join Publication
where Publication.year>=ranges.start and Publication.year<=ranges.end
group by range
order by range;
