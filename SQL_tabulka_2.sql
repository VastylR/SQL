-- economies => year = rok
-- GDP= HDP,
-- countries => country
 
SELECT 
	*
FROM economies e ;

SELECT 
	*
FROM countries c ;

CREATE TABLE IF NOT EXISTS  t_radka_vastylova_project_SQL_secondary_final AS 
SELECT 
	c.country,
	e.`year`,
	e.GDP,
	e.population 
FROM economies e 
JOIN countries c 
	ON e.country=c.country 	
WHERE c.country = 'Czech republic'
	AND e.`year` BETWEEN 2006 AND 2018
ORDER BY e.country , e.`year` ;

SELECT 
	*
FROM t_radka_vastylova_project_SQL_secondary_final;