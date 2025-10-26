# Airbnb Database Schema

## 📘 Overview
This directory contains the SQL schema for the **Airbnb Database System**.  
It defines the structure of all entities and relationships based on the database specification.

## 🧱 Files
- **schema.sql** — Contains SQL `CREATE TABLE` statements, constraints, and indexes.

## 🧩 Entities
1. **User** — Stores user details (guests, hosts, admins).
2. **Property** — Represents listed properties.
3. **Booking** — Manages reservations between users and properties.
4. **Payment** — Tracks payment details for bookings.
5. **Review** — Stores user feedback on properties.
6. **Message** — Handles communication between users.

## ⚙️ Setup Instructions
```bash
# 1. Create and use the database
mysql -u root -p < schema.sql

# 2. Verify tables
mysql> SHOW TABLES;
