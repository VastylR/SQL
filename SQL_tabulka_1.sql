 -- avg_payroll = průměrná mzda dané období
 -- prev_avg_payroll = průměrná mzda předchozí období

SELECT 
	 ROUND(AVG(cpay.value),2) AS avg_payroll,
	 LAG(AVG(cpay.value)) OVER (PARTITION BY cpay.industry_branch_code ORDER BY cpay.payroll_year) AS prev_avg_payroll,
	 cpay.industry_branch_code ,
	 cpay.payroll_year AS year_payroll
FROM czechia_payroll cpay
WHERE cpay.value_type_code = 5958
	AND cpay.calculation_code = 200
GROUP BY cpay.industry_branch_code,
	cpay.payroll_year 
ORDER BY cpay.payroll_year,
cpay.industry_branch_code ;

-- avg_value = průměrné roční ceny produktů 

SELECT 
	ROUND(AVG(cp.value),2) AS avg_value,
	cp.category_code ,
	YEAR (cp.date_from) AS year_price
FROM czechia_price cp
WHERE cp.region_code IS NULL 
GROUP BY cp.category_code ,
	YEAR (cp.date_from);

-- roční průměrná mzda jednotlivých odvětví
	 
CREATE or REPLACE VIEW view_no1_payroll AS 
SELECT 
	ROUND(AVG(cpay.value),2) AS avg_payroll,
	cpay.industry_branch_code ,
	cpib.name AS industry_name,
	cpay.payroll_year
FROM czechia_payroll cpay
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cpay.industry_branch_code = cpib.code 
WHERE cpay.value_type_code = 5958
	AND cpay.calculation_code =200
GROUP BY cpay.industry_branch_code , cpay.payroll_year 
ORDER BY cpay.payroll_year, cpay.industry_branch_code ;

SELECT 
	*
FROM view_no1_payroll;

-- roční průměrné ceny produktů

CREATE or REPLACE VIEW view_no2_price AS 
SELECT 
	ROUND(AVG(cp.value),2) AS avg_price,
	cp.category_code ,
	YEAR (cp.date_from) AS price_year,
	cpc.name AS food_name,
	CONCAT(cpc.price_value,'', cpc.price_unit ) AS units
FROM czechia_price cp
JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code 
WHERE cp.region_code IS NULL 
GROUP BY cp.category_code , YEAR (cp.date_from);

SELECT
	*
FROM view_no2_price;

SELECT 
	*
FROM view_no1_payroll;

CREATE OR REPLACE TABLE  t_radka_vastylova_project_SQL_primary_final AS 
SELECT  
	*
FROM view_no2_price vn2p
JOIN view_no1_payroll vn1p
	ON vn2p.price_year = vn1p.payroll_year ;

SELECT 
	*
FROM t_radka_vastylova_project_SQL_primary_final a;