/*###################################################
 Hocine Makhlouf 
 RICE UNIVERSITY DATA ANALYTICS BOOT CAMP 
 Unit 10 Assignment - SQL
*/###################################################




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






  








