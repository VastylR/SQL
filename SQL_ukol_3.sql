-- Radka V.
-- 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuálně meziroční nárůst)?

-- banány žluté 116103

SELECT 
	b.*,
	ROUND((b.avg_price - b.prev_price) * 100 / b.prev_price, 2) AS growth_price
FROM (
	SELECT 
		a.*,
		ROUND(LAG(avg_price) OVER (PARTITION BY category_code ORDER BY price_year), 3) AS prev_price
	FROM (
		SELECT DISTINCT 
			category_code,
			food_name,
			price_year,
			avg_price
		FROM t_radka_vastylova_project_SQL_primary_final 
		) a
	) b
WHERE b.prev_price IS NOT NULL
ORDER BY growth_price;


SELECT 
	b.category_code,
	b.food_name,
	ROUND(AVG((b.avg_price - b.prev_price) * 100 / b.prev_price), 2) AS avg_growth_price
 FROM (
	SELECT 
		a.*,
		ROUND(LAG(avg_price) OVER (PARTITION BY category_code ORDER BY price_year), 3) AS prev_price
	FROM (
		SELECT DISTINCT 
			category_code,
			food_name,
			price_year,
			avg_price		
		FROM t_radka_vastylova_project_SQL_primary_final
		) a
	) b
WHERE b.prev_price IS NOT NULL
GROUP BY b.category_code, b.food_name
ORDER BY avg_growth_price;

-- nejpomalěji roste cena banány žluté, ceny rajčat a cukru se snížily

SELECT DISTINCT 
	food_name,
	avg_price, 
	price_year 
FROM t_radka_vastylova_project_SQL_primary_final 
WHERE category_code = '116103'
AND price_year BETWEEN  2006 AND 2018
GROUP BY food_name,avg_price, price_year
ORDER BY price_year ;


SELECT DISTINCT 
	food_name,
	avg_price, 
	price_year 
FROM t_radka_vastylova_project_SQL_primary_final  
WHERE category_code IN ('117101','118101','116103')
AND price_year BETWEEN  2006 AND 2018
GROUP BY food_name,avg_price, price_year
ORDER BY price_year ;