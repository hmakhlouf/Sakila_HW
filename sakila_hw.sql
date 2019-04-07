USE sakila;
------------------------------------------------------


-- 1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT UPPER(CONCAT(first_name,'  ',last_name)) AS 'Actor Name' FROM actor;

-- 2a. 
SELECT actor_id, first_name, Last_name From actor WHERE first_name = 'Joe';

-- 2b. Find all actors whose last name contain the letters GEN.

SELECT first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';

-- 2c. 
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name, first_name;

-- 2d.
SELECT country_id, country FROM country WHERE country IN ('Afghanistan','Bangladesh', 'China');

-- 3a. 
ALTER TABLE actor ADD descreption BLOB;

-- 3b 
ALTER TABLE actor DROP COLUMN descreption;











