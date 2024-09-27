SELECT
 c.first_name || ' ' || c.last_name AS customer_name, r.rental_date, r.return_date
FROM
 rental r
JOIN
 customer c ON r.customer_id = c.customer_id
WHERE
 r.return_date > r.rental_date + INTERVAL '7 DAY';
 

WITH MondayRentals AS (
 SELECT
 r.customer_id,
 r.rental_date
 FROM
 rental r
 WHERE
 EXTRACT(DOW FROM r.rental_date) = 1 -- 1 biasanya mewakili Senin
),
CustomerTransactionCount AS (
 SELECT
 customer_id,
 COUNT(*) AS TOTAL_MONDAY_TRANSACTION
 FROM
 MondayRentals
 GROUP BY
 customer_id
 HAVING
 COUNT(*) > 1
)
SELECT
 c.first_name || ' ' || c.last_name AS customer_name, TOTAL_MONDAY_TRANSACTION
FROM
 CustomerTransactionCount ct
JOIN
 customer c ON ct.customer_id = c.customer_id
order by customer_name;



SELECT
 actor_name,
 film_count,
 RANK() OVER (ORDER BY film_count DESC) AS actor_rank
FROM (
 SELECT
 a.actor_id,
 a.first_name || ' ' || a.last_name AS actor_name,
 COUNT(f.film_id) AS film_count
 FROM
 actor a
 JOIN
 film_actor fa ON a.actor_id = fa.actor_id
 JOIN
 film f ON fa.film_id = f.film_id
 GROUP BY
 a.actor_id, a.first_name, a.last_name
) AS ActorFilmCounts
ORDER BY
 actor_rank ASC;

