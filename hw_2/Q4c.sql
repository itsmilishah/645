with pods_pubs
as (select pubid
	from Inproceedings
	where booktitle='PODS')
, sigmod_pubs
as (select pubid
	from Inproceedings
	where booktitle='SIGMOD Conference')
, pods
as (select id
	from Authored
	where pubid in (select pubid from pods_pubs))
, sig
as (select id, count(pubid) as cnt
	from Authored
	where pubid in (select pubid from sigmod_pubs)
	group by id
	having count(pubid)>=2)
select name, cnt
from Author natural join sig
where id not in (select id from pods)
order by cnt desc, name asc;
