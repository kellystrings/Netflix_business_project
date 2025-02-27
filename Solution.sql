--Creating table
CREATE TABLE netflix
(
show_id	VARCHAR(6),
type	VARCHAR(10),
title	VARCHAR(150),
director VARCHAR(230),
casts	VARCHAR(1000),
country	VARCHAR(150),
date_added	VARCHAR(30),
release_year	INT,
rating	VARCHAR(20),
duration	VARCHAR(20),
listed_in	VARCHAR(150),
description VARCHAR(300)
);

SELECT * FROM netflix

-- to see the total content
SELECT 
	COUNT(*) as total_content 
FROM netflix;

-- to know the distint type
SELECT 
	DISTINCT type  
FROM netflix;

-- 15 Business Problems and Solution
-- 1. Count the number of Movies vs TV shows
SELECT 
	type,
	COUNT(*) as total_content
FROM netflix
GROUP BY type

--2. Find the most common rating for Movies and TV shows
SELECT
	type,
	rating
FROM

(
SELECT
	type,
	rating,
	COUNT(*),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*)DESC) as ranking
FROM netflix
GROUP BY 1, 2
--ORDER BY 1, 3 DESC
) as t1
WHERE ranking =1

--3. List all movies released in specific years (e.g 2021)

SELECT * FROM netflix
WHERE 
    type = 'Movie'
	AND
	release_year = 2020

--4. Find the top 5 countries with the most content on Netflix

SELECT
UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
count(show_id) as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--5. Identify the Longest movies or TV show duration

SELECT * FROM netflix
WHERE
type = 'Movie'
AND
duration = (SELECT MAX(duration) FROM netflix)


--6. Find content added in the last 5 years
SELECT
*
FROM netflix
WHERE
TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'


SELECT CURRENT_DATE - INTERVAL '5years'


--7. Find all the movies/TV shows by Directors e.g 'Rajiv Chilaka'
SELECT * FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%'


--8. List all TV shows with more than 5 seasons
SELECT
*
-- SPLIT_PART(duration, ' ', 1) as season
FROM netflix
WHERE 
type = 'TV Show'
AND
SPLIT_PART(duration, ' ', 1)::numeric > 5 


--9. Count the number of content item in each genre
SELECT
UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
COUNT(show_id) as total_content
FROM netflix
GROUP BY 1

--10. Find each year and the average numbers of contents by indians on netflix. return top 5 years with avg content release
SELECT 
EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as year,
COUNT(*) as Yearly_content,
ROUND(
COUNT(*)::numeric/(SELECT COUNT(*)FROM netflix WHERE country = 'India')::numeric * 100
,2) as Avg_Content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY 1

--11. List all movies that are documentaries
SELECT * FROM netflix
WHERE 
listed_in ILIKE '%documentaries%'

--12. Find all content without a director
SELECT * FROM netflix
WHERE director IS NULL

13. Find how man movie actors 'Salman Khan' appeared in the last 10 years
SELECT * FROM netflix
WHERE
casts ILIKE '%Salman Khan%'
AND
release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10


14. Find the top ten actors who have appeared in the highest number of movies produced in
SELECT
-- show_id,
-- casts,
UNNEST(STRING_TO_ARRAY(casts, ',')) as actors,
COUNT(*) as total_content
FROM netflix
WHERE country ILIKE '%india%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

15. Categorize the content based on presence of keywords 'kill' and 'violence' in the description field. 
	Lable content containing this keyword as 'Bad' and all other content as 'Good'. Count how many item 
	fall into each category
WITH new_table
AS
(
SELECT
*,
CASE
WHEN
description ILIKE '%kill%'
OR
description ILIKE '%violence' THEN 'Bad Content'
ELSE 'Good Content'
END category
FROM netflix
)
SELECT
category,
COUNT(*) as total_content
FROM new_table
GROUP BY 1











