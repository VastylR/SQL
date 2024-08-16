-- Radka V.

-- 4. Existuje rok, ve kterém byl mezi roční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 

SELECT
	*,
	LAG(avg_payroll) OVER (ORDER BY payroll_year) AS prev_wages
FROM (
	SELECT DISTINCT 
		payroll_year,
		avg_payroll
	FROM t_radka_vastylova_project_SQL_primary_final 
	WHERE industry_branch_code IS NULL
	) a;

 
SELECT 
	*,
	LAG(avg_price) OVER (PARTITION BY category_code ORDER BY price_year) AS prev_price
FROM (
	SELECT DISTINCT 
		price_year,
		category_code,
		food_name,
		avg_price
	FROM t_radka_vastylova_project_SQL_primary_final
	) a;

SELECT 
	a.payroll_year,
	ROUND((a.avg_payroll - b.avg_payroll) * 100 / b.avg_payroll, 2) AS wages_growth,
	ROUND(AVG((a.avg_price - b.avg_price) * 100 / b.avg_price), 2) AS price_growth,
	ROUND((AVG((a.avg_price - b.avg_price) * 100 / b.avg_price)) - ((a.avg_payroll - b.avg_payroll) * 100 / b.avg_payroll), 2) AS growth_diff
FROM t_radka_vastylova_project_SQL_primary_final a
LEFT JOIN t_radka_vastylova_project_SQL_primary_final b
	ON a.category_code = b.category_code
	AND a.payroll_year = b.payroll_year + 1
WHERE a.industry_branch_code IS NULL 
	AND a.payroll_year > 2006
GROUP BY a.price_year 
ORDER BY growth_diff DESC;