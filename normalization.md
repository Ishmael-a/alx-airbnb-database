# Database Normalization – Airbnb System

## 🧩 Overview
This document explains how the Airbnb database schema was normalized to achieve **Third Normal Form (3NF)**.  
Normalization helps eliminate data redundancy, ensure data integrity, and make the schema scalable and maintainable.

---

## 1️⃣ First Normal Form (1NF)
**Rule:**  
- Each table must have a primary key.  
- All columns contain **atomic** (indivisible) values.  
- There should be **no repeating groups** or arrays.

**Check:**
- Each entity (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) has a defined primary key.  
- All fields store a single, atomic value (no multiple emails or nested lists).  
- There are no repeating or multivalued attributes.

✅ **Conclusion:** The database is in **1NF**.

---

## 2️⃣ Second Normal Form (2NF)
**Rule:**  
- The table is already in 1NF.  
- Every non-key attribute must depend on the **entire primary key**, not just a part of it.  
- This mainly applies to tables with **composite primary keys**.

**Check:**
- All tables have **single-column primary keys** (`user_id`, `property_id`, `booking_id`, etc.).  
- Therefore, no attribute can depend on part of a composite key.  
- Every non-key column depends fully on its table’s primary key.

✅ **Conclusion:** The database is in **2NF**.

---

## 3️⃣ Third Normal Form (3NF)
**Rule:**  
- The table is in 2NF.  
- There are **no transitive dependencies**, meaning non-key attributes do not depend on other non-key attributes.

### 🧍 User
| Attribute | Depends On | Valid? |
|------------|-------------|--------|
| first_name, last_name, email, password_hash, role, created_at | user_id | ✅ Direct dependency |

➡️ No transitive dependencies.

---

### 🏠 Property
| Attribute | Depends On | Valid? |
|------------|-------------|--------|
| host_id, name, description, location, price_per_night, created_at, updated_at | property_id | ✅ Direct dependency |
| host_id → user_id | ✅ Valid foreign key |

➡️ No transitive dependencies.

---

### 📅 Booking
| Attribute | Depends On | Valid? |
|------------|-------------|--------|
| property_id, user_id, start_date, end_date, total_price, status, created_at | booking_id | ✅ Direct dependency |

➡️ No transitive dependencies.

---

### 💳 Payment
| Attribute | Depends On | Valid? |
|------------|-------------|--------|
| booking_id, amount, payment_method, payment_date | payment_id | ✅ Direct dependency |
| booking_id → Booking table | ✅ Valid foreign key |

➡️ No transitive dependencies.

---

### ⭐ Review
| Attribute | Depends On | Valid? |
|------------|-------------|--------|
| property_id, user_id, rating, comment, created_at | review_id | ✅ Direct dependency |

➡️ No transitive dependencies.

---

### 💬 Message
| Attribute | Depends On | Valid? |
|------------|-------------|--------|
| sender_id, recipient_id, message_body, sent_at | message_id | ✅ Direct dependency |

➡️ No transitive dependencies.

---

## ✅ Final Normalization Result
| Normal Form | Status | Description |
|--------------|---------|-------------|
| **1NF** | ✅ Passed | Atomic values, no repeating groups |
| **2NF** | ✅ Passed | Full functional dependency on primary key |
| **3NF** | ✅ Passed | No transitive dependencies |

---

## 🧠 Summary
The Airbnb database schema is fully normalized up to **Third Normal Form (3NF)**.

### Benefits:
- **Data integrity:** Each fact is stored once and updated consistently.  
- **Reduced redundancy:** No unnecessary duplication of information.  
- **Scalability:** Schema is modular and easy to extend.  
- **Clarity:** Each table has a single, clear purpose.

### Entity Separation:
- `User` → Stores user details (hosts & guests)  
- `Property` → Stores property listings  
- `Booking` → Manages reservations between users and properties  
- `Payment` → Records transaction details  
- `Review` → Captures user feedback  
- `Message` → Manages communication between users  

✅ **Conclusion:** The Airbnb database design follows best normalization practices and fully satisfies **3NF**.

---
