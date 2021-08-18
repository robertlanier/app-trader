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

SELECT name, rating, price, genres, review_count 
FROM play_store_apps
WHERE CAST(price AS money) < CAST(1 AS money) AND rating > 4.5
ORDER BY rating DESC, CAST(price AS money) DESC;
-- all apps less than a dollar with higher than 4.5 star rating from the play store (1744)

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
