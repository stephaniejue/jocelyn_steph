-- RELATIVELY SIMPLE JOINS
--
-- What languages are spoken in the United States? (12) Brazil? (not Spanish...) Switzerland? (6)
SELECT
  *
FROM
public.countrylanguage,
  public.country

WHERE
  country.code = countrylanguage.countrycode AND country.name = 'United States'


-- What are the cities of the US? (274) India? (341)

SELECT
  *
FROM
  public.city,
  public.country
WHERE
  city.countrycode = country.code AND
  country.name = 'United States'

-- LANGUAGES
--
-- What are the official languages of Switzerland? (4 languages)

SELECT
  *
FROM
public.countrylanguage,
  public.country

WHERE
  country.code = countrylanguage.countrycode AND country.name = 'Switzerland' AND countrylanguage.isofficial = true

-- Which country or contries speak the most languages? (12 languages)
-- Hint: Use GROUP BY and COUNT(...)
SELECT
  country.name,
  count(*) AS count_of_languages
FROM
  countrylanguage,
  country
WHERE
  country.code = countrylanguage.countrycode
GROUP BY
 country.name
ORDER BY
 count_of_languages DESC


-- Which country or contries have the most offficial languages? (4 languages)
-- Hint: Use GROUP BY and ORDER BY

SELECT
  country.name,
  count(*) AS count_of_languages
FROM
  countrylanguage,
  country
WHERE
  country.code = countrylanguage.countrycode AND
  countrylanguage.isofficial = true
GROUP BY
 country.name
ORDER BY
 count_of_languages DESC

-- Which languages are spoken in the ten largest (area) countries?
-- Hint: Use WITH to get the countries and join with that table

WITH
	largest_ten AS
	(SELECT
		*
	FROM
		country
	ORDER BY
		country.surfacearea DESC
	LIMIT
		10)
SELECT
	largest_ten.code,
	largest_ten.name,
	countrylanguage.language
FROM
	largest_ten,
	countrylanguage
WHERE
	countrylanguage.countrycode = largest_ten.code
ORDER BY
	largest_ten.code

-- What languages are spoken in the 20 poorest (GNP/ capita) countries in the world? (94 with GNP > 0)
-- Hint: Use WITH to get the countries, and SELECT DISTINCT to remove duplicates

WITH
	twenty_poorest AS
	(SELECT
		*
	FROM
		country
	WHERE
		population > 0
	ORDER BY
		gnp/population
	LIMIT
		20)
SELECT
	twenty_poorest.code,
	twenty_poorest.name,
	countrylanguage.language
FROM
	twenty_poorest,
	countrylanguage
WHERE
	countrylanguage.countrycode = twenty_poorest.code
ORDER BY
	twenty_poorest.code

-- Are there any countries without an official language?

SELECT
	country.name,
	count(*) AS count_language
FROM
	countrylanguage,
	country
WHERE
	country.code = countrylanguage.countrycode AND
	country.code NOT IN (
	SELECT countrylanguage.countrycode
	FROM countrylanguage
	WHERE countrylanguage.isofficial = true)
GROUP BY
	country.name

-- Which countries have the highest proportion of official language speakers?

SELECT
	*
FROM
	countrylanguage,
	country
WHERE
	countrylanguage.countrycode = country.code AND
	countrylanguage.isofficial = true
ORDER By
	countrylanguage.percentage DESC

-- What is the most spoken language in the world? (Chinese)

SELECT
	countrylanguage.language,
	SUM(country.population * countrylanguage.percentage) AS sum_languages

FROM
	country,
	countrylanguage
WHERE
	country.code = countrylanguage.countrycode AND
	country.population > 0
GROUP BY
	countrylanguage.language
ORDER BY
	sum_languages DESC

-- CITIES
--
-- What is the population of the United States? What is the city population of the United States?

SELECT
	city.name,
	city.population
FROM
	country,
	city
WHERE
	country.code = city.countrycode AND
	country.name = 'United States'
ORDER BY
	city.population DESC

-- What is the population of the India? What is the city population of the India?

SELECT
	country.name,
	city.name,
	city.population
FROM
	country,
	city
WHERE
	country.code = city.countrycode AND
	country.name = 'India'
ORDER BY
	city.population DESC

-- Which countries have no cities? (7 not really contries...)

SELECT
	country.code,
	country.name
FROM
	country
WHERE
	country.code NOT IN (
	SELECT
		city.countrycode
	FROM
		city)


-- LANGUAGES AND CITIES
--
-- What is the total population of cities where English is the offical language? Spanish?

SELECT
	sum(city.population) AS total_city_pop
FROM
	city,
	countrylanguage
WHERE
	city.countrycode = countrylanguage.countrycode AND
	countrylanguage.language = 'English' AND
	countrylanguage.isofficial = true

-- Hint: The official language of a city is based on country.
-- Which countries have the 100 biggest cities in the world?

SELECT
	country.name,
	country.code,
	city.name,
	city.population
FROM
	country,
	city
WHERE
	country.code = city.countrycode
ORDER BY
	country.code
LIMIT
	100

-- What languages are spoken in the countries with the 100 biggest cities in the world?

WITH
	biggest_cities AS
	(SELECT
		*
	FROM
		city
	ORDER BY
		city.population DESC
	LIMIT
		100)
SELECT
	country.name,
	country.code,
	countrylanguage.language
FROM
	country,
	countrylanguage,
	biggest_cities
WHERE
	country.code = biggest_cities.countrycode AND
	countrylanguage.countrycode = country.code
