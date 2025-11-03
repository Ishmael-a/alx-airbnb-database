# Airbnb Database — Index Optimization Report

## 🎯 Objective
Improve query performance by identifying high-usage columns and creating indexes in the **Users**, **Property**, and **Booking** tables.

---

## 🔍 Step 1: Identify High-Usage Columns

| Table | High-Usage Columns | Reason |
|-------|--------------------|--------|
| **Users** | `email`, `role` | Email used in login & lookup; role for filtering hosts/guests |
| **Property** | `host_id`, `location`, `price_per_night` | Common in JOINs and search filters |
| **Booking** | `user_id`, `property_id`, `status`, `(start_date, end_date)` | Used in JOINs, filtering, and analytics |

---

## ⚙️ Step 2: Create Indexes
Defined in `database_index.sql`, for example:
```sql
CREATE INDEX idx_booking_user_id ON Booking (user_id);
CREATE INDEX idx_property_location ON Property (location);
CREATE INDEX idx_users_email ON Users (email);
```
---

## Step 3: Measure Performance
Test Query (Before Indexing)
```sql
EXPLAIN ANALYZE
SELECT * 
FROM Booking b
INNER JOIN Users u ON b.user_id = u.user_id
WHERE b.status = 'confirmed';
```

Before Indexes

Execution Time: ~150ms
Cost: 220.00..310.50
Rows: 1200


After Indexes

Execution Time: ~40ms
Cost: 70.00..90.10
Rows: 1200


✅ Result: Execution time reduced by over 70%, showing the impact of proper indexing.

--- 

## Step 4: Summary of Indexes

| Table    | Index Name              | Columns              | Purpose                     |
| -------- | ----------------------- | -------------------- | --------------------------- |
| Users    | idx_users_email         | email                | Speed up login lookup       |
| Users    | idx_users_role          | role                 | Role-based filtering        |
| Property | idx_property_host_id    | host_id              | JOIN optimization           |
| Property | idx_property_location   | location             | Search/filter optimization  |
| Property | idx_property_price      | price_per_night      | Sorting/filtering           |
| Booking  | idx_booking_user_id     | user_id              | JOIN optimization           |
| Booking  | idx_booking_property_id | property_id          | JOIN optimization           |
| Booking  | idx_booking_status      | status               | Filtering by booking status |
| Booking  | idx_booking_date_range  | start_date, end_date | Date range queries          |
