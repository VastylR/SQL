Cílem Engeto SQL projektu bylo pomocí SQL dotazů odpovědět na 5 otázek.
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední
srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční
nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd
(větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP
vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve
stejném nebo násdujícím roce výraznějším růstem?

Pro finální dotazy byly nejdříve vytvořeny 2 SQL tabulky s názvy:
1. t_radka_vastylova_projekt_SQL_primary_final.sql (po vybrání relevantních dat byly
vytvořeny 2 pohledy, které po spojení tvoří novou tabulku)
2. t_radka_vastylova_projekt_SQL_secondary_final.sql (po vybrání relevantních dat byly
propojeny vybrané sloupce do nové tabulky)

Poté bylo vytvořeno 5 SQL scriptů, které vytvářejí podklady pro odpovědi na dané otázky.
