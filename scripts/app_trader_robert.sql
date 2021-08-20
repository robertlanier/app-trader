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