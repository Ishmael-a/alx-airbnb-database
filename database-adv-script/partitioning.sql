-- ==========================================================
-- PARTITIONING LARGE TABLE: Booking Table
-- Objective: Improve query performance by partitioning data
-- ==========================================================

-- Step 1: Drop existing Booking table if needed (for testing)
DROP TABLE IF EXISTS Booking CASCADE;

-- Step 2: Create the parent Booking table (no actual data stored here)
CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20)
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions based on date ranges (example: yearly)
CREATE TABLE booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Optional: Default partition for any future dates
CREATE TABLE booking_future PARTITION OF Booking
    DEFAULT;

-- Step 4: Insert sample data for testing
INSERT INTO Booking (user_id, property_id, start_date, end_date, total_amount, status)
VALUES
(1, 101, '2023-03-10', '2023-03-15', 550.00, 'confirmed'),
(2, 102, '2024-06-12', '2024-06-18', 850.00, 'completed'),
(3, 103, '2025-01-20', '2025-01-25', 400.00, 'cancelled'),
(4, 104, '2026-02-10', '2026-02-15', 900.00, 'confirmed');

-- Step 5: Create an index on start_date for faster range queries
CREATE INDEX idx_booking_start_date ON Booking (start_date);

-- Step 6: Test query performance using EXPLAIN before and after partitioning
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
