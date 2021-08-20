SELECT name, CAST(price AS varchar), rating, primary_genre
FROM app_store_apps
UNION
SELECT name, CAST(price AS varchar), rating, genres
FROM play_store_apps;
-- just a quick union to see what i'm working with 

SELECT *
FROM play_store_apps AS p
WHERE name IN
	(SELECT name
	FROM app_store_apps)
AND rating >= 4.0
ORDER BY rating DESC, review_count DESC;
-- pulls all apps that are in both stores with a rating over 4.0, lots of duplicates though

SELECT name, rating, price, primary_genre, review_count 
FROM app_store_apps
WHERE price < 1 AND rating > 4.5
ORDER BY rating DESC, price DESC;
-- all apps less than a dollar with higher than 4.5 star rating from the app store (315)

SELECT distinct name, rating, price, genres, review_count 
FROM play_store_apps
WHERE CAST(price AS money) < CAST(1 AS money) AND rating > 4.5
ORDER BY rating DESC;
-- all apps less than a dollar with higher than 4.5 star rating from the play store (1673)

SELECT p.name, p.rating, p.price, p.review_count 
FROM play_store_apps AS p
INNER JOIN app_store_apps AS a
ON p.name = a.name
WHERE CAST(p.price AS money) < CAST(1 AS money) AND p.rating > 4.5
ORDER BY p.rating DESC, CAST(p.price AS money) DESC;

SELECT distinct name, CAST(price AS money), rating, review_count, content_rating, genres 
FROM play_store_apps
WHERE CAST(price AS money) < CAST(1 AS money) 
AND rating >= 4.7
AND review_count >= 100000
UNION
SELECT distinct name, CAST(price AS money), rating, CAST(review_count AS integer), content_rating, primary_genre
FROM app_store_apps
WHERE CAST(price AS money) < CAST(1 AS money) 
AND rating >= 4.7
AND CAST(review_count AS integer) >= 100000
ORDER BY rating DESC, CAST(price AS money) ASC
-- test query for union

SELECT p.name AS play_name, a.name AS app_name, p.rating AS play_rating, a.rating AS app_rating, ROUND((p.rating+a.rating)/2, 2) AS avg_rating, p.content_rating AS play_content_rating, a.content_rating AS app_content_rating
FROM play_store_apps AS p
INNER JOIN app_store_apps AS a
ON p.name = a.name
ORDER BY avg_rating DESC

-- returns all apps listed in both matched on name

WITH app_store AS 
(SELECT name, primary_genre AS app_store_genres, price AS app_store_price, rating AS app_store_rating
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
GROUP BY name, primary_genre, price, rating
ORDER BY name ASC),

play_store AS 
(SELECT name, genres AS play_store_genres, price AS play_store_price, rating AS play_store_rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name, genres, price, rating
ORDER BY name ASC)

SELECT p.name, p.play_store_genres, a.app_store_genres, p.play_store_price, a.app_store_price, p.play_store_rating, a.app_store_rating
FROM play_store AS p
INNER JOIN app_store AS a ON p.name = a.name
ORDER BY p.name ASC, p.play_store_rating DESC;

-- returns all apps with 4.5 rating in both stores under 1 dollar

WITH app_content_ratings AS (SELECT name, rating,
	SUM(CASE WHEN content_rating = '4+' THEN 1 ELSE 0 END) AS everyone,
	SUM(CASE WHEN content_rating = '9+' THEN 1 ELSE 0 END) AS everyone9,
	SUM(CASE WHEN content_rating = '12+' THEN 1 ELSE 0 END) AS teen,
	SUM(CASE WHEN content_rating = '17+' THEN 1 ELSE 0 END) as mature
FROM app_store_apps
GROUP BY name, rating)

SELECT ROUND(SUM(everyone)/COUNT(name), 2) AS everyone_pct, ROUND(SUM(everyone9)/COUNT(name), 2) AS everyone9_pct,
ROUND(SUM(teen)/COUNT(name), 2) AS teen_pct, ROUND(SUM(mature)/COUNT(name), 2) AS mature_pct
FROM app_content_ratings







select distinct content_rating
from app_store_apps


		


	









