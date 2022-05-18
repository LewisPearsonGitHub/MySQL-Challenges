-- World Challenge

USE world;

-- Question 1. Using COUNT, get the number of cities in the USA.

SELECT count(ID) FROM city WHERE CountryCode='USA';

-- QUESTION 2. Find out the population and life expectancy for people in Argentina

SELECT population, lifeexpectancy FROM country WHERE `name`='argentina'; 

-- QUESTION 3. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?

SELECT lifeexpectancy FROM country WHERE lifeexpectancy IS NOT NULL ORDER BY lifeexpectancy DESC LIMIT 1;

-- QUESTION 4 Using JOIN ... ON, find the capital of Spain

SELECT capital,c.id,c.`name` FROM city c
JOIN country co ON c.`countrycode`=co.`code`
WHERE co.`code`="ESP" AND c.id=capital;

-- QUESTION 5 Using JOIN ... ON, list all the language spoken in the Southeast Asia Region

SELECT `language` FROM countrylanguage cl
JOIN country c ON cl.countrycode = c.`code`
WHERE region LIKE "southeast asia"
GROUP BY `language`;

-- QUESTION 6 Using a single query, list 25 cities around the world that start with the letter F.

SELECT `name` FROM city WHERE `name` LIKE "F%" LIMIT 25;

-- QUESTION 7 Using COUNT and JOIN ... ON, get the number of cities in China

SELECT count(c.`name`) FROM city
JOIN country C ON city.countrycode = c.code
WHERE c.`name`='China';

-- QUESTION 8 Using IS NOT NULL, ORDER BY, and LIMIT, which counry has the lowest population? Discard non-zero populations.

SELECT population, `name` FROM country WHERE population IS NOT NULL AND population > 0 ORDER BY population ASC LIMIT 1;

-- QUESTION 9 Using aggregate functions, return the number of countries the database contains.

SELECT count(`name`) FROM country;

-- QUESTION 10 What are the top ten largest countries by area?

SELECT `name`, surfacearea FROM country ORDER BY surfacearea DESC LIMIT 10;

-- QUESTION 11 List the five largest cities by population in Japan

SELECT c.`name`, c.population FROM city c 
JOIN country co ON c.countrycode = co.`code`
WHERE co.`name`="Japan"
LIMIT 5;

-- QUESTION 12 List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
UPDATE country
SET HeadOfState="Elizabeth II"
WHERE HeadOfState="Elisabeth II";

SELECT headofstate, `name`, `code` FROM country WHERE headofstate="Elizabeth II";

-- QUESTION 13 List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0. 

SELECT `name`,round(population/surfacearea) AS 'population-to-area ratio' FROM country
 WHERE round(population/surfacearea)>0 ORDER BY population/surfacearea ASC LIMIT 10;

-- QUESTION 14 List every unique world language

SELECT DISTINCT `language` FROM countrylanguage;

-- QUESTION 15 List the names and GNP of the world's top 10 richest countries

SELECT `name`, GNP FROM country ORDER BY GNP DESC LIMIT 10;

-- QUESTION 16 List the names of, and number of languages spoken by, the top ten most multilingual countries

SELECT co.`name`, `language`, count(language) FROM countrylanguage cl
JOIN country co ON cl.countrycode = co.`code`
GROUP BY cl.countrycode
ORDER BY count(language) DESC
LIMIT 10;

-- QUESTION 17 List every country where over 50% of its population can speak German.

SELECT co.`name`, percentage FROM countrylanguage cl
JOIN country co ON cl.countrycode = co.`code`
WHERE percentage>49 AND `language`='german'
GROUP BY co.`name`;

-- QUESTION 18 Which country has the worst life expectancy? Discard zero or null values.

SELECT `name`, lifeexpectancy FROM country WHERE lifeexpectancy IS NOT NULL AND lifeexpectancy>0 ORDER BY lifeexpectancy ASC LIMIT 1;

-- QUESTION 19 List the top three most common goverment forms.

SELECT governmentform,count(governmentform) FROM country GROUP BY governmentform ORDER BY count(governmentform) DESC LIMIT 3;

-- QUESTION 20 How many countries have gained independence since records began?

SELECT count(`name`) AS 'How many countries gained independence since records began?'
FROM country WHERE indepyear IS NOT NULL;
