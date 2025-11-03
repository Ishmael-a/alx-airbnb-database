-- =====================================================
-- Airbnb Database — Index Optimization Script
-- Author: Yusif Kwesi Abu-Ishmael
-- Repository: alx-airbnb-database
-- File: database_index.sql
-- Description: Create indexes on high-usage columns to optimize performance
-- =====================================================

-- =====================================================
-- 1️⃣ Users Table Indexes
-- =====================================================

-- Optimize frequent lookups by email (used in authentication)
CREATE INDEX IF NOT EXISTS idx_users_email ON Users (email);

-- Optimize role-based filtering and sorting (e.g., listing hosts)
CREATE INDEX IF NOT EXISTS idx_users_role ON Users (role);

-- =====================================================
-- 2️⃣ Property Table Indexes
-- =====================================================

-- Optimize JOIN between Property and Users (via host_id)
CREATE INDEX IF NOT EXISTS idx_property_host_id ON Property (host_id);

-- Optimize location-based filtering and price sorting
CREATE INDEX IF NOT EXISTS idx_property_location ON Property (location);
CREATE INDEX IF NOT EXISTS idx_property_price ON Property (price_per_night);

-- =====================================================
-- 3️⃣ Booking Table Indexes
-- =====================================================

-- Optimize JOINs between Booking ↔ Users and Booking ↔ Property
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking (user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking (property_id);

-- Optimize frequent filtering by booking status and date
CREATE INDEX IF NOT EXISTS idx_booking_status ON Booking (status);
CREATE INDEX IF NOT EXISTS idx_booking_date_range ON Booking (start_date, end_date);

-- =====================================================
-- 4️⃣ Review Table Indexes
-- =====================================================

-- Optimize JOINs between Review ↔ Property and Review ↔ Users
CREATE INDEX IF NOT EXISTS idx_review_property_id ON Review (property_id);
CREATE INDEX IF NOT EXISTS idx_review_user_id ON Review (user_id);

-- =====================================================
-- 5️⃣ Query Performance Testing
-- =====================================================

-- Example: Compare query plan before and after indexes
-- Run this BEFORE adding indexes:
-- EXPLAIN ANALYZE
-- SELECT * FROM Booking b
-- INNER JOIN Users u ON b.user_id = u.user_id
-- WHERE b.status = 'confirmed';

-- After adding indexes, re-run the same query:
-- EXPLAIN ANALYZE
-- SELECT * FROM Booking b
-- INNER JOIN Users u ON b.user_id = u.user_id
-- WHERE b.status = 'confirmed';

-- Expected result: Reduced cost and faster execution time

-- =====================================================
-- END OF INDEX OPTIMIZATION SCRIPT
-- =====================================================
