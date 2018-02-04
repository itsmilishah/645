select distinct ename from
(
select ename from
dept natural join emp natural join works
where 
(dname="Software" and pct_time>60)
intersect
select ename from
dept natural join emp natural join works
where 
(dname="Hardware" and pct_time>20)
)
order by ename