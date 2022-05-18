-- SAKILA CHALLENGE

-- QUESTION 1. List all actors.

USE sakila;

SELECT concat(first_name, ' ', last_name)AS 'Actors' FROM actor;

-- QUESTION 2. Find the surname of the actor with the forename 'John'.

SELECT first_name, last_name FROM actor WHERE first_name='John'; 

-- QUESTION 3. Find all actors with surname 'Neeson'.alter

SELECT first_name, last_name FROM actor WHERE last_name='Neeson';

-- QUESTION 4. List all actors with ID numbers divisible by 10.

SELECT actor_id, first_name, last_name FROM actor WHERE actor_id%10=0;

-- QUESTION 5. What is the description of the movie with an ID of 100?

SELECT film_id, `description` FROM film WHERE film_id=100;

-- QUESTION 6. Find every R-rated movie

SELECT title,rating FROM film WHERE rating='R';

-- QUESTION 7. Find every non-R-rated movie

SELECT title,rating FROM film WHERE rating!='R';

-- QUESTION 8. Find the ten shortest movies.

SELECT title, length FROM film ORDER BY length ASC LIMIT 10;

-- QUESTION 9. Find the movies with the longest runtime, without using LIMIT.

SELECT title, length, max(length) FROM film WHERE length = (
	SELECT max(length) from film
)
GROUP BY title
ORDER BY length DESC;

-- QUESTION 10. Find all movies that have deleted scenes

SELECT title, special_features FROM film WHERE special_features="deleted scenes";

-- QUESTION 11: Using HAVING reverse-alphabetically list the last names that are not repeated

SELECT last_name FROM actor GROUP BY last_name HAVING count(last_name)=1 ORDER BY last_name DESC;

-- QUESTION 12: Using HAVING, list the last name that appear more than once, from highest to lowest frequency.

SELECT last_name, count(last_name) AS 'count' FROM actor GROUP BY last_name HAVING count(last_name)>1 ORDER BY count(last_name) DESC;

-- QUESTION 13: Which actor has appeared in the most films?

SELECT first_name, last_name, a.actor_id, film_id, count(fa.actor_id) AS 'Number of films acted in'
FROM film_actor fa
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id ORDER BY count(fa.actor_id) DESC;

-- QUESTION 14: When is 'Academy Dinosaur' due? 

-- Possibly not right?

SELECT r.rental_id, f.film_id, title,rental_date,rental_rate,amount,rental_duration,
(amount/rental_rate)*rental_duration AS "days till due",
date_add(rental_date,INTERVAL (amount/rental_rate)*rental_duration DAY) AS "return date" FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE title='Academy Dinosaur' AND return_date IS NULL;

-- QUESTION 15 What is the average runtime of all films?

SELECT avg(length) AS 'Average runtime of all films' FROM film;

-- QUESTION 16 List the average runtime for every film category

SELECT c.`name`, avg(length) FROM film f 
JOIN film_category fc ON  f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
GROUP BY c.`name`;

-- QUESTION 17 List all movies features a robot.

SELECT title, `description` FROM film WHERE `description`LIKE"%robot%";

-- QUESTION 18 How many movies were released in 2010?

SELECT COUNT(release_year) FROM film WHERE release_year='2010';

-- QUESTION 19 Find the titles of all the horror movies

SELECT f.title, c.`name` AS "Genre" FROM film f 
JOIN film_category fc ON  f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
WHERE `name`="horror";

-- QUESTION 20 List the full name of the staff member with the ID of 2

SELECT staff_id, first_name, last_name FROM staff WHERE staff_id=2;

-- QUESTION 21 List all the movies that Fred Costner has appeared in.

SELECT f.title, f.film_id, a.actor_id, a.first_name, a.last_name FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE a.first_name="Fred" AND a.last_name="Costner";

-- QUESTION 22 How many distinct countries are there?

SELECT DISTINCT count(country) FROM country;

-- QUESTION 23 List the name of every language in reverse-alphabetical order

SELECT `name` FROM `language` ORDER BY `name` DESC;

-- QUESTION 24 List the full name of every actor whose surname ends with '-son' in alphabetical order by their forename

SELECT first_name, last_name FROM actor WHERE last_name LIKE '%son' ORDER BY first_name ASC;

-- QUESTION 25 Which category contains the most films?

SELECT c.`name` AS "Genre", count(f.film_id) FROM film f 
JOIN film_category fc ON  f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
GROUP BY c.`name`;

