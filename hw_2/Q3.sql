-- Make Author
delete from Author;
drop sequence if exists seq;
create sequence seq;

with 
  names as (select distinct v as name from Field where p='author')
, names_ids
	as (select field.k as pubid, field.v as name
		from field
		where field.k like 'homepages%' and field.p='author')
, author_homepages
	as (select name, max(field.v) as homepage
		from names_ids join field on pubid=field.k
		where field.p='url'
		group by name)
, joined
	as (select names.name, homepage
		from names left outer join 
			author_homepages
			on names.name=author_homepages.name)
insert into Author(select nextval('seq') as id, name, homepage from joined)
on conflict do nothing;

drop sequence seq;


--Make Publication
delete from Publication;
drop sequence if exists seq;
create sequence seq;

with f_title as (select k , v as title from Field where Field.p='title')
, f_year as (select k , cast(v as int) as year from Field where Field.p='year')
, pubs
	as (select distinct Field.k as p_text
		from Field join Pub on Field.k=Pub.k
		where pub.p in ('book', 'article', 'inproceedings', 'incollection'))
, joined
	as (select distinct p_text, title, year
		from pubs
			left outer join f_title on p_text=f_title.k
			left outer join f_year on p_text=f_year.k)
insert into Publication
(select nextval('seq') as pubid, p_text as pubkey, title, year from joined)
on conflict do nothing;

drop sequence seq;


--Make Article
delete from Article;

with f_journal as (select k , v as journal from Field where Field.p='journal')
, f_month as (select k , v as month from Field where Field.p='month')
, f_volume as (select k , v as volume from Field where Field.p='volume')
, f_number as (select k , v as number from Field where Field.p='number')
, joined
	as (select Field.k as pubkey, Publication.pubid as pubid
		from Field
			join Publication on Publication.pubkey=Field.k
			join Pub on Field.k=Pub.k
		where Pub.p='article')
, arts
as (select distinct pubid, journal, month, volume, number
	from joined
		left outer join f_month on pubkey=f_month.k
		left outer join f_journal on pubkey=f_journal.k
		left outer join f_volume on pubkey=f_volume.k
		left outer join f_number on pubkey=f_number.k)
insert into Article
(select pubid, journal, month, volume, number from arts);


--Make book
delete from Book;
with joined
	as (select Field.k as pubkey, Publication.pubid as pubid
		from Field
			join Publication on Publication.pubkey=Field.k
			join Pub on Field.k=Pub.k
		where Pub.p='book')
, f_publisher as (select k , v as publisher from Field where Field.p='publisher')
, f_isbn as (select k , v as isbn from Field where Field.p='isbn')
, arts
as (select distinct pubid, publisher, isbn
	from joined
		left outer join f_publisher on pubkey=f_publisher.k
		left outer join f_isbn on pubkey=f_isbn.k)
insert into Book
(select pubid, publisher, isbn from arts) on conflict do nothing;


--Make incollection
delete from Incollection;
with joined
	as (select Field.k as pubkey, Publication.pubid as pubid
		from Field
			join Publication on Publication.pubkey=Field.k
			join Pub on Field.k=Pub.k
		where Pub.p='incollection')
, f_booktitle as (select k , v as booktitle from Field where Field.p='booktitle')
, f_publisher as (select k , v as publisher from Field where Field.p='publisher')
, f_isbn as (select k , v as isbn from Field where Field.p='isbn')
, arts
as (select distinct pubid, booktitle, publisher, isbn
	from joined
		left outer join f_booktitle on pubkey=f_booktitle.k
		left outer join f_publisher on pubkey=f_publisher.k
		left outer join f_isbn on pubkey=f_isbn.k)
insert into Incollection
(select pubid, booktitle, publisher, isbn from arts) on conflict do nothing;


--Make inproceedings
delete from Inproceedings;
with joined
	as (select Field.k as pubkey, Publication.pubid as pubid
		from Field
			join Publication on Publication.pubkey=Field.k
			join Pub on Field.k=Pub.k
		where Pub.p='inproceedings')
, f_booktitle as (select k , v as booktitle from Field where Field.p='booktitle')
, f_editor as (select k , v as editor from Field where Field.p='editor')
, arts
as (select distinct pubid, booktitle, editor
	from joined
		left outer join f_booktitle on pubkey=f_booktitle.k
		left outer join f_editor on pubkey=f_editor.k)
insert into Inproceedings
(select pubid, booktitle, editor from arts) on conflict do nothing;


--make Authored
with buf
as (select Author.id as id, Publication.pubid as pubid
	from Field
		join Author on Field.v=Author.name
		join Publication on Field.k=Publication.pubkey
	where Field.p='author')
insert into Authored
(select id, pubid from buf);




alter table Authored add foreign key(id) references Author(id);
alter table Authored add foreign key(pubid) references Publication(pubid);

alter table Article add foreign key(pubid) references Publication(pubid);
alter table Book add foreign key(pubid) references Publication(pubid);
alter table Incollection add foreign key(pubid) references Publication(pubid);
alter table Inproceedings add foreign key(pubid) references Publication(pubid);

