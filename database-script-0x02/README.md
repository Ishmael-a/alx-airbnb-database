# Airbnb Database Seeding Script

## 📘 Overview
This script populates the **Airbnb Database** with sample data to simulate real-world usage.  
It includes realistic relationships between users, properties, bookings, payments, reviews, and messages.

---

## 📂 Files
- **seed.sql** — SQL script to insert sample data.

---

## ⚙️ Usage Instructions

```bash
# 1. Make sure the schema is already created
mysql -u root -p < ../database-script-0x01/schema.sql

# 2. Seed the database with data
mysql -u root -p < seed.sql

# 3. Verify sample records
mysql> USE airbnb_db;
mysql> SELECT * FROM User;
mysql> SELECT * FROM Property;
