# Airbnb Database — Join Queries

This module demonstrates the use of different SQL JOIN operations to combine data across multiple related tables in the Airbnb database.

## Queries Overview

### INNER JOIN
Retrieves only matching records from both tables.
```sql
SELECT b.booking_id, b.property_id, b.start_date, b.end_date, b.total_price, b.status, 
	   u.user_id, u.first_name, u.last_name, u.email, u.role
FROM booking b
INNER JOIN users u
ON u.user_id = b.user_id;
```

### LEFT JOIN
Retrieves all records from the left table and matching ones from the right.
```sql
SELECT p.property_id, p.host_id, p.name, p.location, p.price_per_night, r.rating, r.comment
FROM property p
LEFT JOIN review r
ON p.property_id = r.property_id;
```

### FULL OUTER JOIN
Retrieves all records when there is a match in either left or right table.
```sql
SELECT u.user_id, u.first_name, u.last_name, u.email, u.role, 
	   b.booking_id, b.property_id, b.start_date, b.end_date, b.total_price, b.status
FROM users u
FULL OUTER JOIN booking b
ON u.user_id = b.user_id;
```

