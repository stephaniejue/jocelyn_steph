-- What are the categories of the movies that have never sold? (43 items)

SELECT
*
FROM
  public.category AS cats FULL OUTER JOIN
  film_categories AS film_cats ON (cats.category_id = film_cats.category_id) FULL OUTER JOIN
  inventory AS inv ON (film_cats.film_id = inv.film_id) FULL OUTER JOIN
  rentals AS rents ON (inv.inventory_id = rents.inventory_id) FULL OUTER JOIN
  customers AS custs ON (rents.customer_id = custs.customer_id)
 WHERE
	custs.customer_id IS null

ORDER BY
	cats.category_id,
	film_cats.category_id,
	film_cats.film_id,
	inv.inventory_id,
	rents.rental_id,
	custs.customer_id
