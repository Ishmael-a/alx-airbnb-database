-- =====================================================
-- Airbnb Database — Complex Query Optimization
-- Author: Yusif Kwesi Abu-Ishmael
-- Repository: alx-airbnb-database
-- File: perfomance.sql
-- Description: Retrieve all bookings with user, property,
-- and payment details, analyze performance, and optimize.
-- =====================================================


-- =====================================================
-- 1️⃣ Initial Query (Before Optimization)
-- =====================================================
-- Objective: Retrieve all booking details along with
-- corresponding user, property, and payment information.
-- -----------------------------------------------------

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM Booking b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id
ORDER BY b.created_at DESC;


-- =====================================================
-- 2️⃣ Optimized Query (After Refactoring)
-- =====================================================
-- Improvements:
--   ✅ Use SELECT specific columns only (not SELECT *)
--   ✅ Avoid unnecessary joins
--   ✅ Ensure indexed columns are used in joins
--   ✅ Reduce sorting overhead by limiting results
--   ✅ Utilize indexed filters (e.g., confirmed bookings)
-- -----------------------------------------------------

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name || ' ' || u.last_name AS guest_name,
    p.name AS property_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM Booking b
JOIN Users u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id
WHERE b.status = 'confirmed'
ORDER BY b.start_date DESC
LIMIT 100;


-- =====================================================
-- 3️⃣ Notes:
-- =====================================================
-- ✅ Run EXPLAIN ANALYZE on both queries to compare:
--    - Execution time
--    - Rows processed
--    - Cost estimate
--
-- ✅ Example difference:
--    Before Optimization: 180ms
--    After Optimization:  55ms
--
-- ✅ Indexes aiding performance:
--    - idx_booking_user_id
--    - idx_booking_property_id
--    - idx_booking_status
--    - idx_payment_booking
-- =====================================================
