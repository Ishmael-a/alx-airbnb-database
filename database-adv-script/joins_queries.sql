SELECT * FROM users;
SELECT * FROM property;
SELECT * FROM booking;
SELECT * FROM payment;
SELECT * FROM review;
SELECT * FROM message;


-- retrieve all bookings and the respective users who made those bookings
SELECT b.booking_id, b.property_id, b.start_date, b.end_date, b.total_price, b.status, 
	   u.user_id, u.first_name, u.last_name, u.email, u.role
FROM booking b
INNER JOIN users u
ON u.user_id = b.user_id
ORDER BY b.start_date DESC;

-- LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT p.property_id, p.host_id, p.name, p.location, p.price_per_night, r.rating, r.comment
FROM property p
LEFT JOIN review r
ON p.property_id = r.property_id;

-- FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT u.user_id, u.first_name, u.last_name, u.email, u.role, 
	   b.booking_id, b.property_id, b.start_date, b.end_date, b.total_price, b.status
FROM users u
FULL OUTER JOIN booking b
ON u.user_id = b.user_id;

