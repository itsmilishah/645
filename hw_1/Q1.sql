SELECT DISTINCT ename, age FROM 
((SELECT did from dept WHERE dname="Legal") NATURAL JOIN works NATURAL JOIN emp) 
ORDER BY ename, age