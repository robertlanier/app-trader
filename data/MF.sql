select  
rating from app_store_apps
order by rating desc limit 100;

select  
name, rating
from app_store_apps
order by rating desc limit 100;

select  
name, rating, install_count
where rating is not null
from play_store_apps
order by rating desc limit 100;


select name
where name ilike 'trek'
from play_store_apps

select *
from app_store_apps

select distinct content_rating
from app_store_apps;

select *
from play_store_apps
order by cast(price as money) asc;


-- query for apps that match everyone
select *
from app_store_apps
where content_rating ilike '4+'
and rating = 5 and price <= .99
order by cast(price as money) desc
limit 50;
-- query for apps that match everyone
select *
from play_store_apps
where content_rating ilike 'everyone'
and rating = 5 and (cast(price as money) <= '.99')
order by price desc
limit 50;

select *
from play_store_apps
group by content_rating
;


select *
from app_store_apps
order by price desc ;


select *
from play_store_apps
where rating is not null
group by rating
order by install_count desc;




select *
from app_store_apps

select *
from play_store_apps

select count (distinct (name))
from play_store_apps


-- 
select name, count (*)
from play_store_apps
where content_rating ilike 'everyone'
and rating = 5 and (cast(price as money) <= '.99')
group by name
having count(*) >1;

select *
	from play_store_apps  
	where content_rating ilike 'everyone'
	and rating = 5 and (cast(price as money) <= '.99')
	intersect
		select *
		from app_store_apps
		where content_rating ilike '4+'
		and rating = 5 and price <= .99
	
select
name, count(*)
from play_store_apps
where content_rating ilike 'everyone'
and rating = 5 and (cast(price as money) <= '.99')
group by name
having count(*) >1;

select name, count(*) 
from play_store_apps
group by name
having count(*) >1;

--select
--name,
--rating,
--price
--From
--(SELECT name, rating 
--FROM app_store_apps
--WHERE price <= 1.00 AND rating = 5.0
--row_number() over (partition by rating order by price desc) as row_num
--full j
--SELECT name, rating
--FROM play_store_apps
--WHERE CAST(price AS money) <= CAST(1.00 AS money) AND rating =5 AND content_rating = 'Everyone'
--group by rating)
--where row_num = 1;

select count (*)
SELECT name, rating
FROM app_store_apps
WHERE price <= 1.00
	AND rating >= 5.0
	and content_rating = '4+'
	AND CAST(review_count AS numeric) >= 12893
UNION
SELECT name, rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1.00 AS money)
	AND rating >= 5.0 
	AND content_rating = 'Everyone' 
	AND review_count >= 444153
ORDER BY rating DESC;

SELECT *
FROM app_store_apps
FULL JOIN play_store_apps
USING (name);
--group by name
--having count(*) >1;;
-----
WITH app_store AS 
(SELECT distinct name 
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
ORDER BY name ASC),
 
play_store AS 
(SELECT name
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name
ORDER BY name ASC)

SELECT p.name 
FROM play_store AS p
INNER JOIN app_store ON p.name = app_store.name
ORDER BY p.name ASC;
-------

WITH app_store AS 
(SELECT distinct name, priamry_genre as app_store_primary_genre 
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
ORDER BY name ASC),
 
play_store AS 
(SELECT name, category as play_store_category, genres as play_store_genres
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name, category, genres
ORDER BY name ASC)

SELECT p.name, p.play_store_category, p.play_store_genres
FROM play_store AS p
INNER JOIN app_store ON p.name = app_store.name
ORDER BY p.name ASC;

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

WITH app_store AS 
(SELECT distinct name, primary_genre AS app_store_primary_genre
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
ORDER BY name ASC),
 
play_store AS 
(SELECT name, category AS play_store_category, genres AS play_store_genres
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name, category, genres
ORDER BY name ASC)

SELECT p.name, p.play_store_category, p.play_store_genres, app_store.app_store_primary_genre
FROM play_store AS p
INNER JOIN app_store ON p.name = app_store.name
ORDER BY p.name ASC
having p.name count(*) >1;

------
--select distinct (play_store_genres, app_store_genres)

-- This one yields 39
WITH app_store AS 
(SELECT name, primary_genre AS app_store_genres, price AS app_store_price, rating AS app_store_rating, content_rating
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5 and content_rating = '4+'
GROUP BY name, primary_genre, price, rating, content_rating
ORDER BY name ASC),

play_store AS 
(SELECT name, genres AS play_store_genres, price AS play_store_price, rating AS play_store_rating, content_rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5 and content_rating = 'Everyone'
GROUP BY name, genres, price, rating, content_rating
ORDER BY name ASC)

SELECT p.name, p.play_store_genres, a.app_store_genres, p.play_store_price, a.app_store_price, p.play_store_rating, a.app_store_rating, p.content_rating
FROM play_store AS p
INNER JOIN app_store AS a ON p.name = a.name
ORDER BY p.name ASC, a.app_store_rating desc;

---------

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
row_number() over(partition by app_store_price order by app_store_rating desc) as row_num
FROM play_store AS p
INNER JOIN app_store AS a ON p.name = a.name
where row_num = 1
group by app_store rating;


------- specific selects on each of the tables

SELECT name, primary_genre AS app_store_genres, price AS app_store_price, rating AS app_store_rating
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
GROUP BY name, primary_genre, price, rating
ORDER BY price desc;

SELECT name, genres AS play_store_genres, price AS play_store_price, rating AS play_store_rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name, genres, price, rating
ORDER BY price desc;

------

WITH app_store AS 
(SELECT name, primary_genre AS app_store_genres, price AS app_store_price, rating AS app_store_rating, content_rating
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5 and content_rating = '4+'
GROUP BY name, primary_genre, price, rating, content_rating
ORDER BY name ASC),

play_store AS 
(SELECT name, genres AS play_store_genres, price AS play_store_price, rating AS play_store_rating, content_rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5 and content_rating = 'Everyone' 
GROUP BY name, genres, price, rating, content_rating
ORDER BY name ASC)

SELECT a.name,p.play_store_genres, a.app_store_genres,
p.play_store_price, a.app_store_price, p.Play_store_rating, p.play_store_rating, 
a.app_store_rating, a.content_rating, p.content_rating
FROM play_store AS p
INNER JOIN app_store AS a ON p.name = a.name
ORDER BY p.name ASC, a.app_store_rating desc;

--AST(REPLACE(REPLACE(p.install_count, '+', ''), ',', '') AS numeric)
WITH app_store AS 
(SELECT name, primary_genre AS app_store_genres, price AS app_store_price, rating AS app_store_rating, content_rating AS app_store_content_rating
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
GROUP BY name, primary_genre, price, rating, content_rating
ORDER BY name ASC),

play_store AS 
(SELECT name, genres AS play_store_genres, price AS play_store_price, rating AS play_store_rating, content_rating AS play_store_content_rating
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name, genres, price, rating, content_rating
ORDER BY name ASC),

both_stores AS 
(SELECT p.name, p.play_store_genres, a.app_store_genres, p.play_store_price, a.app_store_price, p.play_store_rating, a.app_store_rating, p.play_store_content_rating, a.app_store_content_rating
FROM play_store AS p
INNER JOIN app_store AS a ON p.name = a.name
ORDER BY p.name ASC, p.play_store_rating DESC),


/*SELECT play_store_content_rating, COUNT(name)
FROM both_stores
GROUP BY play_store_content_rating*/

/*SELECT app_store_content_rating, COUNT(name)
FROM both_stores
GROUP BY app_store_content_rating*/

---Christians Code>>>

both_stores_filtered AS (SELECT name, play_store_rating, play_store_price, app_store_price, play_store_content_rating, app_store_genres
FROM both_stores
WHERE app_store_content_rating = '4+'
GROUP BY name, play_store_rating, play_store_price, app_store_price, play_store_content_rating, app_store_genres
ORDER BY play_store_rating DESC),

both_filtered_final AS (SELECT b.name, p.install_count, b.play_store_rating, b.play_store_content_rating, b.app_store_genres
FROM both_stores_filtered AS b
LEFT JOIN play_store_apps AS p
ON b.name = p.name
GROUP BY b.name, p.install_count, b.play_store_rating, b.play_store_content_rating, b.app_store_genres
ORDER BY CAST(REPLACE(REPLACE(p.install_count, '+', ''), ',', '') AS numeric) ASC
)

SELECT name, play_store_rating, install_count, play_store_content_rating, app_store_genres
FROM both_filtered_final as top_25
ORDER BY CAST(REPLACE(REPLACE(install_count, '+', ''), ',', '') AS numeric) ASC
LIMIT 25;

------- Dereks'sCode
WITH app_store AS 
(SELECT name, primary_genre AS app_store_genres, price AS app_store_price, rating AS app_store_rating, ROUND(((ROUND(ROUND(rating/5,1)*5,1))/.5),0) AS app_store_years_estimate
FROM app_store_apps
WHERE price <= 1 AND rating >= 4.5
GROUP BY name, primary_genre, price, rating
ORDER BY name ASC),

play_store AS 
(SELECT name, install_count, genres AS play_store_genres, price AS play_store_price, rating AS play_store_rating, ROUND(((ROUND(ROUND(rating/5,1)*5,1))/.5),0) AS play_store_years_estimate
FROM play_store_apps
WHERE CAST(price AS money) <= CAST(1 AS money) AND rating >= 4.5
GROUP BY name, genres, price, rating, install_count
ORDER BY name ASC),

play_store_2 AS
(SELECT *, ((play_store_years_estimate*12)*5000) AS play_store_app_lifetime_income, ((play_store_years_estimate*12)*1000) AS play_store_app_lifetime_cost
 FROM play_store
),

app_store_2 AS
(SELECT *, ((app_store_years_estimate*12)*5000) AS app_store_app_lifetime_income, ((app_store_years_estimate*12)*1000) AS app_store_app_lifetime_cost
 FROM app_store
)


/*--removed from select
-- p.play_store_genres, 
-- a.app_store_genres, 
-- ROUND(ROUND(p.play_store_rating/5,1)*5,1) AS rounded_play_store_rating, 
-- a.app_store_rating, */
SELECT 
	p.name,
	t.name,
	p.play_store_years_estimate, 
	a.app_store_years_estimate,
	p.play_store_app_lifetime_income,
	a.app_store_app_lifetime_income,
	p.play_store_app_lifetime_cost + 10000 AS total_lifetime_cost,
	a.app_store_app_lifetime_income + p.play_store_app_lifetime_income AS both_store_total_lifetime_income
	
FROM play_store_2 AS p
INNER JOIN app_store_2 AS a 
ON p.name = a.name

JOIN top_25 as t
ON p.name = t.name

ORDER BY p.name ASC, p.play_store_rating DESC;

-- WITH app_content_ratings AS (SELECT name, rating,
-- 	SUM(CASE WHEN content_rating = '4+' THEN 1 ELSE 0 END) AS everyone,
-- 	SUM(CASE WHEN content_rating = '9+' THEN 1 ELSE 0 END) AS everyone9,
-- 	SUM(CASE WHEN content_rating = '12+' THEN 1 ELSE 0 END) AS teen,
-- 	SUM(CASE WHEN content_rating = '17+' THEN 1 ELSE 0 END) as mature
-- FROM app_store_apps
-- GROUP BY name, rating)

-- SELECT ROUND(SUM(everyone)/COUNT(name), 2) AS everyone_pct, ROUND(SUM(everyone9)/COUNT(name), 2) AS everyone9_pct,
-- ROUND(SUM(teen)/COUNT(name), 2) AS teen_pct, ROUND(SUM(mature)/COUNT(name), 2) AS mature_pct
-- FROM app_content_ratings
-- WHERE rating >= 4.5;

SELECT round(avg(rating),2), genres
from play_store_apps
group by genres

SELECT round(avg(rating),2), primary_genre
from app_store_apps
where primary_genre is not null
group by primary_genre

