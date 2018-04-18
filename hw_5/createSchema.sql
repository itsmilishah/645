create table authors (id INTEGER PRIMARY KEY, name VARCHAR(200));
create table venue (id INTEGER PRIMARY KEY,
	name VARCHAR(200) NOT NULL, year INTEGER NOT NULL,
	school VARCHAR (200), volume VARCHAR(50),
	number VARCHAR(50), type INTEGER NOT NULL);
create table papers (id INTEGER PRIMARY KEY, name VARCHAR NOT NULL,
	venue INTEGER REFERENCES venue(id), pages VARCHAR(50),
	url VARCHAR);
create table paperauths (paperid INTEGER, authid INTEGER);
