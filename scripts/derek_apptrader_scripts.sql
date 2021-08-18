SELECT name, ROUND(ROUND(rating/5,1)*5,1) AS rounded_rating,
		CASE 
			WHEN ROUND(ROUND(rating/5,1)*5,1) = 5 THEN 11
			WHEN ROUND(ROUND(rating/5,1)*5,1) = 4.5 THEN 10
			WHEN ROUND(ROUND(rating/5,1)*5,1) = 4 THEN 9
			ELSE 0 END AS Longevity_years
FROM play_store_apps
WHERE CAST (price AS MONEY) <= CAST(1 AS MONEY) 

-- AND Longevity_years >10;

--Michael's queries
select *
from app_store_apps
where content_rating ilike '4+'
and rating = 5 and price <= .99
order by cast(price as money) desc;

select *
from play_store_apps
where content_rating ilike 'everyone'
and rating = 5 and (cast(price as money) <= '.99')
order by price desc;
