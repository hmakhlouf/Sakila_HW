/*###################################################
 Hocine Makhlouf 
 RICE UNIVERSITY DATA ANALYTICS BOOT CAMP 
 Unit 10 Assignment - SQL
###################################################*/




USE sakila;
------------------------------------------------------

-- 1a. 
SELECT first_name, last_name FROM actor;

-- 1b. 
SELECT UPPER(CONCAT(first_name,'  ',last_name)) AS 'Actor Name' FROM actor;

-- 2a. 
SELECT actor_id, first_name, Last_name From actor WHERE first_name = 'Joe';

-- 2b. 

SELECT first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';

-- 2c. 
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name, first_name;

-- 2d.
SELECT country_id, country FROM country WHERE country IN ('Afghanistan','Bangladesh', 'China');

-- 3a. 
ALTER TABLE actor ADD descreption BLOB;

-- 3b 
ALTER TABLE actor DROP COLUMN descreption;

-- 4a. 
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

-- 4b.
SELECT last_name, COUNT(last_name) FROM actor  GROUP BY last_name HAVING COUNT(last_name)>= 2; 

-- 4c. 
UPDATE actor SET first_name = 'HARPO' WHERE last_name = 'WILLIAMS';

-- 4d. 
UPDATE actor SET first_name = 'GROUCHO' WHERE last_name='WILLIAMS';

-- 5a.


-- 6a.
SELECT staff.first_name, staff.last_name, address.address 
FROM staff
JOIN address 
ON staff.address_id=address.address_id;


-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT s.first_name, s.last_name ,p.payment_date, SUM(p.amount) as 'Total Amount'  
FROM staff as s
JOIN payment as p
ON s.staff_id=p.staff_id
WHERE month(p.payment_date)=8 and year(p.payment_date)=2005
GROUP BY  first_name, last_name;


-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT f.title, count(a.film_id) as 'Number of Actors'
FROM film f 
INNER JOIN  film_actor a 
ON f.film_id = a.film_id
GROUP BY f.title; 


-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT f.title, count(i.film_id) as 'Number of Copies'
FROM film f 
INNER JOIN inventory i 
ON f.film_id = i.film_id
GROUP BY f.title
HAVING f.title = 'Hunchback Impossible';


-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT c.first_name, c.last_name, SUM(p.amount) as 'Total Paid' 
FROM customer c 
INNER JOIN payment p
ON p.customer_id = c.customer_id 
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name ASC;


/*7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with 
the letters K and Q whose language is English.*/

SELECT f.title
FROM film f 
INNER JOIN language l 
ON f.language_id = l.language_id
WHERE name = 'English'
HAVING f.title LIKE 'K%' OR f.title LIKE 'Q%'; 


-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT  first_name, last_name
FROM  actor 
WHERE actor_id IN 
(
  SELECT actor_id 
  FROM film_actor
  WHERE film_id IN 
   ( 
     SELECT film_id 
     FROM film 
     WHERE title = 'Alone Trip'
	)
);
	
    
/* 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
 Use joins to retrieve this information */
 
SELECT c.first_name, c.last_name, c.email
FROM customer c
INNER JOIN address a 
ON c.address_id = a.address_id
INNER JOIN city 
ON a.city_id = city.city_id
INNER JOIN country co
ON city.country_id = co.country_id
WHERE co.country = 'Canada';


-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title
FROM film f
INNER JOIN film_category fct 
ON f.film_id = fct.film_id
INNER JOIN category c 
ON fct.category_id = c.category_id
WHERE name = 'Family';


-- 7e. Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(title) 'Rental Frequency'
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
INNER JOIN rental r 
ON i.inventory_id = r.inventory_id
INNER JOIN payment p 
ON r.rental_id = p.rental_id
GROUP BY f.title
ORDER BY COUNT(title) DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT  s.store_id 'Store', SUM(amount) 'Store Revenue'
FROM store s
INNER JOIN inventory i ON s.store_id = i.store_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;


-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id 'Store ID', city.city, co.country
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city ON a.city_id = city.city_id
INNER JOIN country co ON city.country_id = country.country_id;

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT c.name, SUM(amount) 'Gross Revenue'
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN inventory i ON fc.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(amount) DESC
LIMIT 5;


-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
create view top_five_gross_revenue as
SELECT  c.name, SUM(amount) 'Gross Revenue'
FROM category c
INNER JOIN film_category fc 
ON c.category_id = fc.category_id
INNER JOIN inventory i 
ON fc.film_id = i.film_id
INNER JOIN rental r 
ON i.inventory_id = r.inventory_id
INNER JOIN payment p 
ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(amount) DESC
LIMIT 5;


-- 8b. How would you display the view that you created in 8a?
show create view top_five_gross_revenue;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
drop view top_five_gross_revenue;
