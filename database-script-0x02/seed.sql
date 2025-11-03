-- =====================================================
-- Airbnb Database Sample Data Seed
-- Author: Yusif Kwesi Abu-Ishmael
-- Repository: alx-airbnb-database
-- Directory: database-script-0x02
-- File: seed.sql
-- Description: Sample dataset for Airbnb database
-- =====================================================

-- USE airbnb_db;

-- TRUNCATE TABLE message, review, payment, booking, property, users RESTART IDENTITY CASCADE;

-- =====================================================
-- USERS
-- =====================================================
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('uuid-001', 'Kwesi', 'Abu', 'kwesi.abu@example.com', 'hashed_pw_001', '+233201234567', 'host'),
('uuid-002', 'Ama', 'Mensah', 'ama.mensah@example.com', 'hashed_pw_002', '+233502223344', 'guest'),
('uuid-003', 'Kojo', 'Owusu', 'kojo.owusu@example.com', 'hashed_pw_003', '+233550987654', 'guest'),
('uuid-004', 'Esi', 'Boateng', 'esi.boateng@example.com', 'hashed_pw_004', '+233207777888', 'host'),
('uuid-005', 'Admin', 'User', 'admin@example.com', 'hashed_pw_admin', NULL, 'admin');

-- =====================================================
-- PROPERTIES
-- =====================================================
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
('prop-001', 'uuid-001', 'Seaside Villa', 'Beautiful beachfront villa with ocean view.', 'Cape Coast', 250.00),
('prop-002', 'uuid-001', 'Accra City Apartment', 'Modern apartment in the heart of Accra.', 'Accra', 150.00),
('prop-003', 'uuid-004', 'Kumasi Bungalow', 'Quiet home near the city center.', 'Kumasi', 120.00);

-- =====================================================
-- BOOKINGS
-- =====================================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('book-001', 'prop-001', 'uuid-002', '2025-11-01', '2025-11-05', 1000.00, 'confirmed'),
('book-002', 'prop-002', 'uuid-003', '2025-12-10', '2025-12-12', 300.00, 'pending'),
('book-003', 'prop-003', 'uuid-002', '2025-11-15', '2025-11-18', 360.00, 'canceled');

-- =====================================================
-- PAYMENTS
-- =====================================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
('pay-001', 'book-001', 1000.00, 'credit_card'),
('pay-002', 'book-002', 300.00, 'paypal');

-- =====================================================
-- REVIEWS
-- =====================================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
('rev-001', 'prop-001', 'uuid-002', 5, 'Amazing view and very clean!'),
('rev-002', 'prop-003', 'uuid-002', 4, 'Nice and peaceful environment.'),
('rev-003', 'prop-002', 'uuid-003', 3, 'Good location but a bit noisy.');

-- =====================================================
-- MESSAGES
-- =====================================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
('msg-001', 'uuid-002', 'uuid-001', 'Hi Kwesi, is the villa available for next weekend?'),
('msg-002', 'uuid-001', 'uuid-002', 'Yes, the villa is available from Friday to Sunday.'),
('msg-003', 'uuid-003', 'uuid-004', 'Hello Esi, can I book your bungalow for next week?'),
('msg-004', 'uuid-004', 'uuid-003', 'Sure, please confirm your dates!');

-- =====================================================
-- END OF SEED DATA
-- =====================================================
