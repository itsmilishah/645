select f
from
	(select distinct Field.p as f, Pub.p as t
	from Pub cross join Field
	where Field.k = Pub.k) as pairs
group by f
having count(t)=
	(select count(distinct p) from Pub)
