-- Radka V.


/* 
 * 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? 
 * Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
 */

SELECT 
	`year`,
	GDP,
	LAG(GDP) OVER (ORDER BY `year`) AS prev_GDP,
	ROUND((GDP - (LAG(GDP) OVER (ORDER BY `year`))) * 100 / (LAG(GDP) OVER (ORDER BY `year`)), 2) AS GDP_growth
FROM t_radka_vastylova_project_SQL_secondary_final
WHERE country = 'Czech Republic';


SELECT 
	a.payroll_year,
	ROUND((a.avg_payroll - b.avg_payroll) * 100 / b.avg_payroll, 2) AS growth_wages,
	ROUND(AVG((a.avg_price - b.avg_price) * 100 / b.avg_price), 2) AS growth_price,
	ROUND((c.GDP - d.GDP) * 100 / d.GDP, 2) AS growth_GDP
FROM t_radka_vastylova_project_sql_primary_final a
LEFT JOIN t_radka_vastylova_project_SQL_primary_final b
	ON a.category_code = b.category_code
	AND a.payroll_year = b.payroll_year + 1
LEFT JOIN t_radka_vastylova_project_SQL_secondary_final c
	ON a.payroll_year = c.`year`
LEFT JOIN t_radka_vastylova_project_SQL_secondary_final d
	ON a.payroll_year = d.`year` + 1
	AND c.country = d.country 
WHERE a.industry_branch_code IS NULL 
	AND a.payroll_year > 2006
	AND c.country = 'Czech Republic'
GROUP BY a.price_year 
;


SELECT 
	a.payroll_year,
	ROUND((a.avg_payroll - b.avg_payroll) * 100 / b.avg_payroll, 2) AS growth_wages,
	CASE 
		WHEN (a.avg_payroll - b.avg_payroll) * 100 / b.avg_payroll >= 5 THEN 'faster growth'
		WHEN (a.avg_payroll - b.avg_payroll) * 100 / b.avg_payroll <= -2 THEN 'fast growth '
		ELSE 'slow growth'
	END AS wages_growth_recap,
	ROUND(AVG((a.avg_price - b.avg_price) * 100 / b.avg_price), 2) AS growth_price,
	CASE 
		WHEN AVG((a.avg_price - b.avg_price) * 100 / b.avg_price) >= 5 THEN 'faster growth'
		WHEN AVG((a.avg_price - b.avg_price) * 100 / b.avg_price)<= -2 THEN 'fast growth'
		ELSE 'slow growth'
	END AS growth_price_recap,
	ROUND((c.GDP - d.GDP) * 100 / d.GDP, 2) AS growth_GDP,
	CASE 
		WHEN (c.GDP - d.GDP) * 100 / d.GDP >= 5 THEN 'faster growth'
		WHEN (c.GDP - d.GDP) * 100 / d.GDP <= -2 THEN 'fast growth'
		ELSE 'slow growth'
	END AS growth_GDP_recap
FROM t_radka_vastylova_project_SQL_primary_final a
LEFT JOIN t_radka_vastylova_project_SQL_primary_final b 
	ON a.category_code = b.category_code
	AND a.payroll_year = b.payroll_year + 1
LEFT JOIN t_radka_vastylova_project_SQL_secondary_final c 
	ON a.payroll_year = c.`year`
LEFT JOIN t_radka_vastylova_project_SQL_secondary_final d
	ON a.payroll_year= d.`year` + 1
	AND c.country = d.country 
WHERE a.industry_branch_code IS NULL 
	AND a.payroll_year > 2006
	AND c.country = 'Czech Republic'
GROUP BY a.price_year 
;