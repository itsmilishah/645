select substring(homepage from '.*//(.*?)/.*') as hp, count(pubid) as n_pubs
from author natural join authored natural join Publication
where homepage is not null and pubkey like '%pvldb%'
group by homepage
order by n_pubs desc, hp asc
limit 20;
