

-- query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT b.user_id, COUNT(*) as total_bookings
FROM booking b
GROUP BY b.user_id;


-- window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
-- SELECT p.property_id, p.host_id, 
-- 		COUNT(*) OVER(PARTITION BY b.property_id) AS total_bookings_per_property,  
-- 		RANK() OVER (
--             ORDER BY COUNT(*) OVER(PARTITION BY b.property_id) DESC
--         ) AS ranks
-- FROM property p
-- INNER JOIN booking b
-- ON b.property_id = p.property_id;

WITH BookingCounts AS (
    SELECT 
        property_id, 
        COUNT(*) AS booking_count
    FROM 
        booking
    GROUP BY 
        property_id
)

SELECT 
    p.property_id, 
    p.host_id, 
    bc.booking_count AS total_bookings_per_property,
    RANK() OVER (
        ORDER BY bc.booking_count DESC
    ) AS ranks,
    ROW_NUMBER() OVER (
        ORDER BY bc.booking_count DESC
    ) AS row_num
FROM property p
INNER JOIN BookingCounts bc ON bc.property_id = p.property_id;
