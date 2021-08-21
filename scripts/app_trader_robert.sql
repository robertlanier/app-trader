SELECT AVG(CAST(review_count AS numeric))
FROM app_store_apps;


SELECT AVG(rating)
FROM app_store_apps;


SELECT AVG(review_count)
FROM play_store_apps;


SELECT AVG(rating)
FROM play_store_apps;


SELECT *
FROM app_store_apps
WHERE price <= 1.00
	AND rating <= 4.0
ORDER BY CAST(review_count AS int) DESC
LIMIT 50;


SELECT *
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1.00 AS money) AND rating <= 4.5 AND content_rating = 'Everyone'
ORDER BY review_count DESC
LIMIT 50;


SELECT name, rating
FROM app_store_apps
WHERE price <= 1.00
	AND rating >= 4.0
	AND CAST(review_count AS numeric) >= 12893
UNION
SELECT name, rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1.00 AS money)
	AND rating >= 4.0 
	AND content_rating = 'Everyone' 
	AND review_count >= 444153
ORDER BY rating DESC;


SELECT DISTINCT *
FROM app_store_apps AS a
FULL JOIN play_store_apps AS p
USING (name)
ORDER BY name;


SELECT DISTINCT name,
	p.price AS playstore_price,
	a.price AS appstore_price,
	p.review_count AS playstore_review_count,
	a.review_count AS appstore_review_count,
	p.rating AS playstore_stars,
	a.rating AS appstore_stars,
	p.content_rating AS playstore_rating,
	a.content_rating AS appstore_rating,
	genres
FROM app_store_apps AS a
FULL JOIN play_store_apps AS p
USING (name)
ORDER BY name;


SELECT distinct a.primary_genre, COUNT(name), ROUND(AVG(rating), 2) AS avg_rating, subquery.high_rated_total
FROM
	(SELECT primary_genre, COUNT(distinct name) AS high_rated_total
	FROM app_store_apps
	WHERE rating >= 4.5
	GROUP BY primary_genre) AS subquery
JOIN app_store_apps AS a
ON subquery.primary_genre = a.primary_genre
GROUP BY subquery.primary_genre, a.primary_genre, subquery.high_rated_total
ORDER BY avg_rating DESC;	

---------------
-- First CTE --
---------------
WITH app_store AS
(SELECT name, primary_genre AS app_store_genres, price AS app_store_price, rating AS app_store_rating
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
GROUP BY name, primary_genre, price, rating
ORDER BY name ASC),
---------------
-- Second CTE --
---------------
play_store AS 
(SELECT name, genres AS play_store_genres, price AS play_store_price, rating AS play_store_rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name, genres, price, rating
ORDER BY name ASC)
----------------
-- Both CTEs --
----------------
SELECT p.name, p.play_store_genres, a.app_store_genres, p.play_store_price, a.app_store_price, p.play_store_rating, a.app_store_rating
FROM play_store AS p
INNER JOIN app_store AS a ON p.name = a.name
ORDER BY p.name ASC, p.play_store_rating DESC;


---------------
-- First CTE --
---------------
WITH app_store AS 
(SELECT name, primary_genre AS app_store_genres, price AS app_store_price, rating AS app_store_rating
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
GROUP BY name, primary_genre, price, rating
ORDER BY name ASC),
---------------
-- Second CTE --
---------------
play_store AS 
(SELECT name, genres AS play_store_genres, price AS play_store_price, rating AS play_store_rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name, genres, price, rating
ORDER BY name ASC)
----------------
-- Both CTEs --
----------------
SELECT p.name, p.play_store_genres, a.app_store_genres, p.play_store_price, a.app_store_price, p.play_store_rating, ROUND(ROUND(p.play_store_rating/5,1)*5,1) AS rounded_play_store_rating , a.app_store_rating
FROM play_store AS p
INNER JOIN app_store AS a ON p.name = a.name
ORDER BY p.name ASC, p.play_store_rating DESC;

