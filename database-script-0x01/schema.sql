-- =====================================================
-- Airbnb Database Schema Definition
-- Author: Yusif Kwesi Abu-Ishmael
-- Repository: alx-airbnb-database
-- Directory: database-script-0x01
-- File: schema.sql
-- Description: Database schema in 3NF for Airbnb system
-- =====================================================

-- Use a dedicated database
-- CREATE DATABASE IF NOT EXISTS airbnb_db;
-- USE airbnb_db;

-- =====================================================
-- USER TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS Users (
    user_id CHAR(36) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_email ON Users (email);

-- =====================================================
-- PROPERTY TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS Property (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(100) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_property_host ON Property (host_id);

-- =====================================================
-- BOOKING TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS Booking (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_booking_property ON Booking (property_id);
CREATE INDEX idx_booking_user ON Booking (user_id);

-- =====================================================
-- PAYMENT TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS Payment (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(10) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);

CREATE INDEX idx_payment_booking ON Payment (booking_id);

-- =====================================================
-- REVIEW TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS Review (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_review_property ON Review (property_id);
CREATE INDEX idx_review_user ON Review (user_id);

-- =====================================================
-- MESSAGE TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS Message (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_message_sender ON Message (sender_id);
CREATE INDEX idx_message_recipient ON Message (recipient_id);

-- =====================================================
-- END OF SCHEMA
-- =====================================================



