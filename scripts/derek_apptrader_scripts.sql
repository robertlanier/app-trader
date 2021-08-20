-- SELECT name, ROUND(ROUND(rating/5,1)*5,1) AS rounded_rating,
-- 		CASE 
-- 			WHEN ROUND(ROUND(rating/5,1)*5,1) = 5 THEN 11
-- 			WHEN ROUND(ROUND(rating/5,1)*5,1) = 4.5 THEN 10
-- 			WHEN ROUND(ROUND(rating/5,1)*5,1) = 4 THEN 9
-- 			ELSE 0 END AS Longevity_years
-- FROM play_store_apps
-- WHERE CAST (price AS MONEY) <= CAST(1 AS MONEY); 

-- AND Longevity_years >10;

--Michael's queries
-- select *
-- from app_store_apps
-- where content_rating ilike '4+'
-- and rating = 5 and price <= .99
-- order by cast(price as money) desc;

-- select *
-- from play_store_apps
-- where content_rating ilike 'everyone'
-- and rating = 5 and (cast(price as money) <= '.99')
-- order by price desc;

-- SELECT name, rating
-- FROM app_store_apps
-- WHERE price <= 1.00
-- 	AND rating >= 4.0
-- 	AND CAST(review_count AS numeric) >= 12893
-- UNION
-- SELECT name, rating
-- FROM play_store_apps
-- WHERE CAST(price AS money) <= CAST(1.00 AS money)
-- 	AND rating >= 4.0 
-- 	AND content_rating = 'Everyone' 
-- 	AND review_count >= 444153
-- ORDER BY rating DESC;

-- WITH app_store AS 
-- (SELECT distinct name, primary_genre AS app_store_primary_genre
-- FROM app_store_apps
-- WHERE price <= 1 AND rating >= 4.5
-- ORDER BY name ASC),
 
-- play_store AS 
-- (SELECT name, category AS play_store_category, genres AS play_store_genres
-- FROM play_store_apps
-- WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
-- GROUP BY name, category, genres
-- ORDER BY name ASC)

-- SELECT p.name, p.play_store_category, p.play_store_genres, app_store.app_store_primary_genre
-- FROM play_store AS p
-- INNER JOIN app_store ON p.name = app_store.name
-- ORDER BY p.name ASC;

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

SELECT p.name, p.play_store_genres, a.app_store_genres, p.play_store_price, a.app_store_price, p.play_store_rating, ROUND(ROUND(p.play_store_rating/5,1)*5,1) AS rounded_play_store_rating , a.app_store_rating
FROM play_store AS p
INNER JOIN app_store AS a ON p.name = a.name
ORDER BY p.name ASC, p.play_store_rating DESC;
