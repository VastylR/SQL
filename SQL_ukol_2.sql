-- Radka V.
-- 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

-- category_code: 114201 = mléko polotučné pasterované, 111301 = chléb konzumní kmínový


SELECT *
FROM t_radka_vastylova_project_SQL_primary_final 
WHERE price_year IN (2006, 2018)
	AND (category_code = '114201' OR category_code = '111301');
	
SELECT 
	avg_payroll,
	industry_name ,
	payroll_year ,
	avg_price ,
	food_name ,	
	ROUND(avg_payroll / avg_price) AS purchase_power
FROM t_radka_vastylova_project_SQL_primary_final 
WHERE payroll_year IN (2006, 2018)
	AND (category_code = '114201' OR category_code='111301')
	AND industry_branch_code IS NULL;


SELECT 
	avg_payroll,
	industry_name ,
	payroll_year ,
	avg_price ,
	food_name ,	
	ROUND(avg_payroll / avg_price) AS purchase_power 
FROM t_radka_vastylova_project_SQL_primary_final 
WHERE payroll_year IN (2006, 2018)
	AND (category_code = '114201' OR category_code='111301')
GROUP  BY avg_payroll,industry_name , payroll_year ,
	avg_price ,food_name
ORDER BY purchase_power ;