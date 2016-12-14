
-- Which customer placed the orders on the earliest date? What did they order?

SELECT
  customers.first_name,
  customers.last_name,
  rentals.rental_date,
  films.title
FROM
  customers,
  rentals,
  inventory,
  films
WHERE
  customers.customer_id = rentals.customer_id AND
  rentals.inventory_id = inventory.inventory_id AND
  inventory.film_id = films.film_id
ORDER BY
	rentals.rental_date

-- Which product do we have the most of? Find the order ids and customer names for all orders for that item.

  -- Most product
  SELECT
	films.film_id,
	films.title,
	count(*) AS count_films
FROM
	films,
	inventory
WHERE
	films.film_id = inventory.film_id
GROUP BY
	films.film_id
ORDER BY
	count_films DESC

-- What orders have there been from Texas? In June?

SELECT
	pays.payment_id,
	pays.payment_date,
	custs.first_name,
	custs.last_name,
	films.title
FROM
	payments AS pays JOIN
	customers AS custs ON (pays.customer_id = custs.customer_id) JOIN
	rentals AS rents ON (custs.customer_id = rents.customer_id) JOIN
	inventory AS inv ON (rents.inventory_id = inv.inventory_id) JOIN
	films ON (inv.film_id = films.film_id)
WHERE
	films.title = 'Shock Cabin'

  -- JuneSELECT DISTINCT (by payments)
  SELECT DISTINCT
  	pays.payment_id,
  	pays.payment_date,
  	custs.first_name,
  	custs.last_name,
  	adresses.district
  FROM
  	payments AS pays JOIN
  	customers AS custs ON (pays.customer_id = custs.customer_id) JOIN
  	rentals AS rents ON (custs.customer_id = rents.customer_id) JOIN
  	inventory AS inv ON (rents.inventory_id = inv.inventory_id) JOIN
  	films ON (inv.film_id = films.film_id),
  	adresses
  WHERE
  	custs.address_id = adresses.address_id AND
  	adresses.district LIKE '%Texas%' AND
  	EXTRACT (MONTH FROM pays.payment_date) > 1 --There were no payments in June
  ORDER BY
  	pays.payment_id

    --June Select (by rentals); to make distinct, removed payments
  SELECT
  	rents.rental_id,
  	rents.rental_date,
  	films.title,
  	custs.first_name,
  	custs.last_name,
  	adresses.district
  FROM
  	customers AS custs JOIN
  	rentals AS rents ON (custs.customer_id = rents.customer_id) JOIN
  	inventory AS inv ON (rents.inventory_id = inv.inventory_id) JOIN
  	films ON (inv.film_id = films.film_id),
  	adresses
  WHERE
  	custs.address_id = adresses.address_id AND
  	adresses.district LIKE '%Texas%' AND
  	EXTRACT (MONTH FROM rents.rental_date) = 6
  ORDER BY
  	rents.rental_id

-- How many orders have we had for sci-fi films? From Texas?


-- Which actors have not appeared in a Sci-Fi film?


-- Find all customers who have not ordered a Sci-Fi film.
