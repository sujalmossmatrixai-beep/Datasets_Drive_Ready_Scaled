# Business Data Glossary - Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30
- **Component**: Source Database Schema (Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
- **Theme Focus**: Connected Consumer Digital Ecosystem, On-Demand Delivery, Transit & Social
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `tbl_customers`
**Description**: Domain table for `tbl_customers` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | **Customer Id** | `INT` | `PRIMARY KEY` | Customer primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Customer name |
| `phone` | **Phone** | `VARCHAR(20)` | `NOT NULL` | Phone number |

---

---

### Table: `tbl_delivery_orders`
**Description**: Domain table for `tbl_delivery_orders` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | **Order Id** | `INT` | `PRIMARY KEY` | Order primary key ID |
| `restaurant_id` | **Restaurant Id** | `INT` | `FOREIGN KEY` | FK to tbl_restaurants |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `rider_id` | **Rider Id** | `INT` | `FOREIGN KEY` | FK to tbl_riders |
| `total_amount` | **Total Amount** | `DECIMAL(10,2)` | `NOT NULL` | Order total USD |
| `order_time` | **Order Time** | `TIMESTAMP` | `NOT NULL` | Placement timestamp |

---

---

### Table: `tbl_delivery_tracking`
**Description**: Domain table for `tbl_delivery_tracking` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tracking_id` | **Tracking Id** | `INT` | `PRIMARY KEY` | Tracking primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_delivery_orders |
| `pickup_time` | **Pickup Time** | `TIMESTAMP` | `NULL` | Restaurant pickup time |
| `delivered_time` | **Delivered Time** | `TIMESTAMP` | `NULL` | Customer dropoff time |

---

---

### Table: `tbl_menu_items`
**Description**: Domain table for `tbl_menu_items` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `menu_item_id` | **Menu Item Id** | `INT` | `PRIMARY KEY` | Menu item primary key ID |
| `restaurant_id` | **Restaurant Id** | `INT` | `FOREIGN KEY` | FK to tbl_restaurants |
| `dish_name` | **Dish Name** | `VARCHAR(100)` | `NOT NULL` | Dish title |
| `price` | **Price** | `DECIMAL(8,2)` | `NOT NULL` | Price USD |

---

---

### Table: `tbl_order_line_items`
**Description**: Domain table for `tbl_order_line_items` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `line_item_id` | **Line Item Id** | `INT` | `PRIMARY KEY` | Line item primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_delivery_orders |
| `menu_item_id` | **Menu Item Id** | `INT` | `FOREIGN KEY` | FK to tbl_menu_items |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Portion quantity |

---

---

### Table: `tbl_restaurants`
**Description**: Domain table for `tbl_restaurants` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `restaurant_id` | **Restaurant Id** | `INT` | `PRIMARY KEY` | Restaurant primary key ID |
| `restaurant_name` | **Restaurant Name** | `VARCHAR(100)` | `NOT NULL` | Business name |
| `cuisine_type` | **Cuisine Type** | `VARCHAR(40)` | `NOT NULL` | Cuisine category (ITALIAN/MEXICAN) |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City |

---

---

### Table: `tbl_riders`
**Description**: Domain table for `tbl_riders` in `Food_Delivery_App_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rider_id` | **Rider Id** | `INT` | `PRIMARY KEY` | Rider primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Rider name |
| `vehicle_type` | **Vehicle Type** | `VARCHAR(20)` | `NOT NULL` | BICYCLE/SCOOTER/CAR |
| `rating` | **Rating** | `DECIMAL(3,2)` | `NOT NULL` | Rider rating 1-5 |

---

---

### Table: `tbl_driver_payouts`
**Description**: Domain table for `tbl_driver_payouts` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payout_id` | **Payout Id** | `INT` | `PRIMARY KEY` | Payout primary key ID |
| `driver_id` | **Driver Id** | `INT` | `FOREIGN KEY` | FK to tbl_drivers |
| `payout_amount` | **Payout Amount** | `DECIMAL(10,2)` | `NOT NULL` | Weekly earnings payout |

---

---

### Table: `tbl_driver_vehicles`
**Description**: Domain table for `tbl_driver_vehicles` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vehicle_id` | **Vehicle Id** | `INT` | `PRIMARY KEY` | Vehicle primary key ID |
| `driver_id` | **Driver Id** | `INT` | `FOREIGN KEY` | FK to tbl_drivers |
| `license_plate` | **License Plate** | `VARCHAR(15)` | `NOT NULL` | Plate code |
| `make_model` | **Make Model** | `VARCHAR(60)` | `NOT NULL` | Car model string |

---

---

### Table: `tbl_drivers`
**Description**: Domain table for `tbl_drivers` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `driver_id` | **Driver Id** | `INT` | `PRIMARY KEY` | Driver primary key ID |
| `license_number` | **License Number** | `VARCHAR(30)` | `NOT NULL` | Drivers license code |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Driver full name |
| `rating` | **Rating** | `DECIMAL(3,2)` | `NOT NULL` | Star rating |

---

---

### Table: `tbl_fare_payments`
**Description**: Domain table for `tbl_fare_payments` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fare_id` | **Fare Id** | `INT` | `PRIMARY KEY` | Fare primary key ID |
| `trip_id` | **Trip Id** | `INT` | `FOREIGN KEY` | FK to tbl_ride_trips |
| `base_fare` | **Base Fare** | `DECIMAL(8,2)` | `NOT NULL` | Base charge |
| `tip_amount` | **Tip Amount** | `DECIMAL(8,2)` | `NOT NULL` | Tip amount |

---

---

### Table: `tbl_passengers`
**Description**: Domain table for `tbl_passengers` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `passenger_id` | **Passenger Id** | `INT` | `PRIMARY KEY` | Passenger primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |
| `phone` | **Phone** | `VARCHAR(20)` | `NOT NULL` | Phone number |

---

---

### Table: `tbl_ride_requests`
**Description**: Domain table for `tbl_ride_requests` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `request_id` | **Request Id** | `INT` | `PRIMARY KEY` | Request primary key ID |
| `passenger_id` | **Passenger Id** | `INT` | `FOREIGN KEY` | FK to tbl_passengers |
| `pickup_city` | **Pickup City** | `VARCHAR(50)` | `NOT NULL` | City |
| `requested_time` | **Requested Time** | `TIMESTAMP` | `NOT NULL` | Request timestamp |

---

---

### Table: `tbl_ride_trips`
**Description**: Domain table for `tbl_ride_trips` in `Ride_Sharing_Transit_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `trip_id` | **Trip Id** | `INT` | `PRIMARY KEY` | Trip primary key ID |
| `request_id` | **Request Id** | `INT` | `FOREIGN KEY` | FK to tbl_ride_requests |
| `driver_id` | **Driver Id** | `INT` | `FOREIGN KEY` | FK to tbl_drivers |
| `distance_miles` | **Distance Miles** | `DECIMAL(6,2)` | `NOT NULL` | Trip length miles |
| `duration_minutes` | **Duration Minutes** | `INT` | `NOT NULL` | Duration in minutes |

---

---

### Table: `tbl_comments`
**Description**: Domain table for `tbl_comments` in `Social_Media_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `comment_id` | **Comment Id** | `INT` | `PRIMARY KEY` | Comment primary key ID |
| `post_id` | **Post Id** | `INT` | `FOREIGN KEY` | FK to tbl_posts |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `comment_text` | **Comment Text** | `VARCHAR(255)` | `NOT NULL` | Comment message |

---

---

### Table: `tbl_direct_messages`
**Description**: Domain table for `tbl_direct_messages` in `Social_Media_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `message_id` | **Message Id** | `INT` | `PRIMARY KEY` | Message primary key ID |
| `sender_user_id` | **Sender User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `recipient_user_id` | **Recipient User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `message_body` | **Message Body** | `TEXT` | `NOT NULL` | Encrypted chat body |

---

---

### Table: `tbl_post_likes`
**Description**: Domain table for `tbl_post_likes` in `Social_Media_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `like_id` | **Like Id** | `INT` | `PRIMARY KEY` | Like primary key ID |
| `post_id` | **Post Id** | `INT` | `FOREIGN KEY` | FK to tbl_posts |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |

---

---

### Table: `tbl_posts`
**Description**: Domain table for `tbl_posts` in `Social_Media_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `post_id` | **Post Id** | `INT` | `PRIMARY KEY` | Post primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `post_caption` | **Post Caption** | `TEXT` | `NULL` | Post text body |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Publish timestamp |

---

---

### Table: `tbl_user_follows`
**Description**: Domain table for `tbl_user_follows` in `Social_Media_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `follow_id` | **Follow Id** | `INT` | `PRIMARY KEY` | Follow primary key ID |
| `follower_user_id` | **Follower User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `followed_user_id` | **Followed User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |

---

---

### Table: `tbl_users`
**Description**: Domain table for `tbl_users` in `Social_Media_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_id` | **User Id** | `INT` | `PRIMARY KEY` | User primary key ID |
| `username` | **Username** | `VARCHAR(30)` | `NOT NULL` | Unique social tag |
| `display_name` | **Display Name** | `VARCHAR(60)` | `NOT NULL` | Profile name |

---