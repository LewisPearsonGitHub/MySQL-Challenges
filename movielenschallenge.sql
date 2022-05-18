-- MOVIELENS CHALLENGE

USE movielens;

-- QUESTION 1 - List the titles and release dates of movies released between 1983-1993 in reverse chronological order.

SELECT title, release_date FROM movies WHERE release_date>='1983-01-01' AND release_date<'1994-01-01' ORDER BY release_date DESC;

-- QUESTION 2 - Without using LIMIT, list the title of the movies with the lowest average rating

SELECT title,avg(rating)FROM movies m
JOIN ratings r ON m.id=r.movie_id
GROUP BY title
HAVING avg(rating)=min(avg(rating))
ORDER BY avg(rating) ASC;
 -- doesn't work yet
 
 
-- QUESTION 3 -List the unique records for Sci-Fi movies where male 24-year-old students have given 5 star ratings

SELECT DISTINCT title, gender, age, o.`name`, rating, g.`name` FROM ratings r
JOIN users u ON r.user_id = u.id
JOIN occupations o ON u.occupation_id = o.id
JOIN movies m ON r.movie_id = m.id
JOIN genres_movies gm ON r.movie_id = gm.id
JOIN genres g ON gm.genre_id = g.id
WHERE o.`name`="student" AND age=24 AND gender='m' AND rating='5' AND g.`name`='Sci-fi'
GROUP BY m.title;

-- QUESTION 4 - List the unique titles of each of the movies released on the most popular release date

SELECT DISTINCT title, release_date, count(title) FROM ratings r
JOIN users u ON r.user_id = u.id
JOIN occupations o ON u.occupation_id = o.id
JOIN movies m ON r.movie_id = m.id
JOIN genres_movies gm ON r.movie_id = gm.id
JOIN genres g ON gm.genre_id = g.id

GROUP BY release_date
ORDER BY count(release_date) DESC;

-- doesn't work either