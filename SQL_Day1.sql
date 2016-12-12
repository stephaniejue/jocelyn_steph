--SQL Country Database Challenges

-- What is the population of the US? (starts with 2, ends with 000)
SELECT
	population
FROM
	country
WHERE
	name = 'United States'

-- What is the area of the US? (starts with 9, ends with million square miles)
SELECT
	surfacearea
FROM
	country
WHERE
	name = 'United States'


--List the countries in Africa that have a population smaller than 30,000,000 and a life expectancy of more than 45? (all 37 of them)
SELECT
	*
FROM
	country
WHERE
	continent = 'Africa'
AND
	population < 30000000
AND
	lifeexpectancy > 45

-- Which countries are something like a republic? (are there 122 or 143 countries or ?) 143!
SELECT
	*
FROM
	country
WHERE
	governmentform LIKE '%Republic%'

-- Which countries are some kind of republic and acheived independence after 1945?
SELECT
	*
FROM
	country
WHERE
	governmentform LIKE '%Republic%'
AND
	indepyear > 1945


-- Which countries acheived independence after 1945 and are not some kind of republic?
SELECT
	*
FROM
	country
WHERE
	indepyear > 1945
AND NOT
	governmentform LIKE '%Republic%'

--Which fifteen countries have the highest life expactancy?
SELECT
	*
FROM
	country
WHERE
	lifeexpectancy IS NOT null
ORDER BY
	lifeexpectancy DESC
LIMIT
	15

--Which five countries have the lowest population density?
SELECT
	name,
	population/surfacearea
FROM
	country
WHERE
	population != 0
ORDER BY
	population/surfacearea
LIMIT
	15

-- Which five countries have the highest population density?
SELECT
	name,
	population/surfacearea
FROM
	country
WHERE
	population != 0
ORDER BY
	population/surfacearea DESC
LIMIT
	15

--Which is the smallest country, by area and population? the 10 smallest countries, by area and population?
SELECT
	name,
	population,
	surfacearea
FROM
	country
WHERE
	population > 0
ORDER BY
	population, surfacearea
LIMIT
	10
-- Which is the biggest country, by area and population? the 10 biggest countries, by area and population?
SELECT
	name,
	population,
	surfacearea
FROM
	country
WHERE
	population > 0
ORDER BY
	surfacearea DESC, population DESC
LIMIT
	10

--Of the smallest 10 countries, which has the biggest per capita gnp?
WITH
	smallest_countries AS
	(SELECT
		name,
		surfacearea,
		population,
		gnp,
		gnp/population
	FROM
		country
	WHERE
		population > 0
	ORDER BY
		surfacearea, population
	LIMIT
		10)
SELECT
	name,
	surfacearea,
	population,
	gnp,
	gnp/population
FROM
	smallest_countries
WHERE
	gnp > 0
ORDER BY
	gnp/population DESC

--Of the biggest 10 countries, which has the biggest per capita gnp?
WITH
	largest_countries AS
	(SELECT
		name,
		surfacearea,
		population,
		gnp,
		gnp/population
	FROM
		country
	WHERE
		population > 0
	ORDER BY
		surfacearea DESC, population DESC
	LIMIT
		10)
SELECT
	name,
	surfacearea,
	population,
	gnp,
	gnp/population
FROM
	largest_countries
WHERE
	gnp IS NOT null
ORDER BY
	gnp/population DESC

-- What is the sum of surface area of the 10 biggest countries in the world?
WITH
	largest_countries AS
	(SELECT
		name,
		surfacearea,
		population,
		gnp,
		gnp/population
	FROM
		country
	WHERE
		population > 0
	ORDER BY
		surfacearea DESC, population DESC
	LIMIT
		10)
SELECT
	SUM(surfacearea)
FROM
	largest_countries
WHERE
	surfacearea IS NOT null

-- What is the sum of surface area of the 10 smallest countries in the world?

WITH
	smallest_countries AS
	(SELECT
		name,
		surfacearea,
		population,
		gnp,
		gnp/population
	FROM
		country
	WHERE
		population > 0
	ORDER BY
		surfacearea, population
	LIMIT
		10)
SELECT
	SUM(surfacearea)
FROM
	smallest_countries
WHERE
	surfacearea IS NOT null

-- Who is the most influential head of state measured by surface area?
SELECT
	continent,
	SUM(country.surfacearea) AS sum_surface,
	SUM(country.population) AS sum_pop
FROM
	country
GROUP BY
	continent

SELECT
	headofstate,
	SUM(surfacearea) AS sum_surfacearea
FROM
	country
WHERE
	headofstate != ''
GROUP BY
	headofstate
ORDER BY
	sum_surfacearea DESC

-- What are the forms of government for the top ten richest nations? (technically most productive)
WITH
	largest_countries AS
	(SELECT
		name,
		gnp,
		governmentform
	FROM
		country
	ORDER BY
		gnp DESC
	LIMIT
		10)

SELECT
	governmentform,
	count(governmentform) AS count_gov
FROM
	largest_countries
WHERE
	governmentform != ''
GROUP BY
	governmentform
ORDER BY
	count_gov DESC

-- Which countries are in the top 5% in terms of area? (hint: use a SELECT in a LIMIT clause)

SELECT
	name,
	surfacearea
FROM
	country
ORDER BY
	surfacearea DESC
LIMIT
	(SELECT (COUNT(surfacearea) * .05) FROM country)

-- Count countries with Z in name
WITH
	z_countries AS
	(SELECT
		name
	FROM
		country
	WHERE
		name LIKE '%z%' or name LIKE '%Z%')
SELECT
	COUNT(name)
FROM
	z_countries

-- Select countries without an official language

SELECT
	name,
	code
FROM
	country
WHERE
	code NOT IN  (SELECT countrycode FROM countrylanguage WHERE isofficial = TRUE)
