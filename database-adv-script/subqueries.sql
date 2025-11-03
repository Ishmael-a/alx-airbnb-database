

-- Write a correlated subquery to find users who have made more than 3 bookings.
SELECT 
    u.user_id, 
    u.first_name, 
    u.last_name, 
    u.email
FROM 
    users u
WHERE 
    (SELECT COUNT(*) 
     FROM booking b 
     WHERE b.user_id = u.user_id) > 3;


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
