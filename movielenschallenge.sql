-- MOVIELENS CHALLENGE

USE movielens;

-- QUESTION 1 - List the titles and release dates of movies released between 1983-1993 in reverse chronological order.

SELECT title, release_date FROM movies WHERE release_date>='1983-01-01' AND release_date<'1994-01-01' ORDER BY release_date DESC;

-- QUESTION 2 - Without using LIMIT, list the title of the movies with the lowest average rating

SELECT title, avg(rating) AS `Average Rating` FROM movies
JOIN ratings ON movies.id = ratings.movie_id
GROUP BY movies.title
HAVING avg(rating) = (
		SELECT MIN(avg_rating)
        FROM ( 
				SELECT AVG(rating) AS avg_rating
                FROM ratings
                GROUP BY movie_id
                ) AS table1
		)
ORDER BY AVG(rating);
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


SELECT DISTINCT title, release_date FROM movies
GROUP BY title
HAVING release_date = (
		SELECT release_date
        FROM ( 
				SELECT release_date
                FROM movies
                GROUP BY release_date
                ORDER BY count(id) DESC
                LIMIT 1
                ) AS table2
		)
;

-- QUESTION 5 - Find the total number of movies in each genre; list the results in ascending numeric order. 

SELECT count(g.`name`), g.`name` FROM genres g 
JOIN genres_movies gm ON g.id = gm.genre_id
GROUP BY g.`name`
ORDER BY count(g.`name`) ASC;