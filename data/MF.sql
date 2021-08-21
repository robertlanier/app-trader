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


select *
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
ORDER BY p.name ASC, a.app_store_rating desc;


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



