CREATE FUNCTION generate_year_series()
	RETURNS textarray AS $$ SELECT CONCAT('year_', s) FROM generate_series(1995, 2015)) $$ language sql;
