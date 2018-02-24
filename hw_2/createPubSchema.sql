create table Author (id int primary key, name text, homepage text);
create table Publication (pubid int primary key, pubkey text, title text, year int);
create table Article (pubid int primary key, journal text, month text, volume text, number text);
create table Book (pubid int primary key, publisher text, isbn text);
create table Incollection (pubid int primary key, booktitle text, publisher text, isbn text);
create table Inproceedings (pubid int primary key, booktitle text, editor text);
create table Authored (id int, pubid int);