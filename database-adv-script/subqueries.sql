
-- Aggregations and Window Functions

-- query to find all properties where the average rating for that property is greater than 4.0 using a subquery.
SELECT property.*, 
	(
	 SELECT ROUND(AVG(rating), 2) 
     FROM review r 
     WHERE property.property_id = property.property_id
	) AS avg_rating
FROM property
WHERE property_id IN (
	SELECT property_id
	FROM review
	GROUP BY property_id
	HAVING AVG(rating) > 4.0
);

-- EXISTS VERSION
SELECT *
FROM property p
WHERE EXISTS (
    SELECT 1
    FROM review r
    WHERE r.property_id = p.property_id
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);
