# Business Data Glossary - Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30
- **Component**: Target Database Schema (Dataset_10_ConnectedConsumer_LifeServices_Digital_20x30_target)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Target Tables**: 30
- **Theme Focus**: Connected Consumer Digital Ecosystem, On-Demand Delivery, Transit & Social
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `dim_customer`
**Description**: Domain table for `dim_customer` in `Food_Delivery_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_key` | **Customer Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Name |

---

---

### Table: `dim_restaurant`
**Description**: Domain table for `dim_restaurant` in `Food_Delivery_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `restaurant_key` | **Restaurant Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_restaurant_id` | **Source Restaurant Id** | `INT` | `NOT NULL` | Natural ID |
| `restaurant_name` | **Restaurant Name** | `VARCHAR(100)` | `NOT NULL` | Name |

---

---

### Table: `dim_rider`
**Description**: Domain table for `dim_rider` in `Food_Delivery_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rider_key` | **Rider Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_rider_id` | **Source Rider Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Name |

---

---

### Table: `fact_delivery_orders`
**Description**: Domain table for `fact_delivery_orders` in `Food_Delivery_App_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_key` | **Order Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `restaurant_key` | **Restaurant Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_restaurant |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer |
| `rider_key` | **Rider Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_rider |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Total USD |

---

---

### Table: `dim_driver`
**Description**: Domain table for `dim_driver` in `Ride_Sharing_Transit_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `driver_key` | **Driver Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_driver_id` | **Source Driver Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `dim_passenger`
**Description**: Domain table for `dim_passenger` in `Ride_Sharing_Transit_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `passenger_key` | **Passenger Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_passenger_id` | **Source Passenger Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_driver_earnings`
**Description**: Domain table for `fact_driver_earnings` in `Ride_Sharing_Transit_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payout_key` | **Payout Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `driver_key` | **Driver Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_driver |
| `payout_amount_usd` | **Payout Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Earnings USD |

---

---

### Table: `fact_ride_trips`
**Description**: Domain table for `fact_ride_trips` in `Ride_Sharing_Transit_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `trip_key` | **Trip Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `driver_key` | **Driver Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_driver |
| `passenger_key` | **Passenger Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_passenger |
| `distance_miles` | **Distance Miles** | `NUMERIC(6,2)` | `NOT NULL` | Distance miles |

---

---

### Table: `dim_post`
**Description**: Domain table for `dim_post` in `Social_Media_Platform_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `post_key` | **Post Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_post_id` | **Source Post Id** | `INT` | `NOT NULL` | Natural ID |
| `user_key` | **User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_user |

---

---

### Table: `dim_user`
**Description**: Domain table for `dim_user` in `Social_Media_Platform_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_key` | **User Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_user_id` | **Source User Id** | `INT` | `NOT NULL` | Natural ID |
| `username` | **Username** | `VARCHAR(30)` | `NOT NULL` | Username |

---

---

### Table: `fact_post_engagement`
**Description**: Domain table for `fact_post_engagement` in `Social_Media_Platform_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `engagement_key` | **Engagement Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `post_key` | **Post Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_post |
| `user_key` | **User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_user |

---

---

### Table: `fact_social_graph`
**Description**: Domain table for `fact_social_graph` in `Social_Media_Platform_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `graph_key` | **Graph Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `follower_user_key` | **Follower User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_user |
| `followed_user_key` | **Followed User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_user |

---

---

### Table: `dim_device`
**Description**: Domain table for `dim_device` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `device_key` | **Device Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_device_id` | **Source Device Id** | `INT` | `NOT NULL` | Natural ID |
| `model_name` | **Model Name** | `VARCHAR(50)` | `NOT NULL` | Model name |

---

---

### Table: `dim_user_fitness_fitness`
**Description**: Domain table for `dim_user_fitness` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_key` | **User Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_user_id` | **Source User Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_telemetry_reads`
**Description**: Domain table for `fact_telemetry_reads` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `telemetry_key` | **Telemetry Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `device_key` | **Device Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_device |
| `bpm_value` | **Bpm Value** | `INT` | `NOT NULL` | BPM |

---

---

### Table: `fact_workout_summary`
**Description**: Domain table for `fact_workout_summary` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `workout_key` | **Workout Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `user_key` | **User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_user |
| `calories_burned` | **Calories Burned** | `INT` | `NOT NULL` | Calories burned |

---

---

### Table: `dim_event`
**Description**: Domain table for `dim_event` in `Event_Ticketing_Platform_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `event_key` | **Event Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_event_id` | **Source Event Id** | `INT` | `NOT NULL` | Natural ID |
| `venue_key` | **Venue Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_venue |
| `event_title` | **Event Title** | `VARCHAR(100)` | `NOT NULL` | Event title |

---

---

### Table: `dim_venue`
**Description**: Domain table for `dim_venue` in `Event_Ticketing_Platform_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `venue_key` | **Venue Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_venue_id` | **Source Venue Id** | `INT` | `NOT NULL` | Natural ID |
| `venue_name` | **Venue Name** | `VARCHAR(80)` | `NOT NULL` | Venue name |

---

---

### Table: `fact_ticket_sales`
**Description**: Domain table for `fact_ticket_sales` in `Event_Ticketing_Platform_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sale_key` | **Sale Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `event_key` | **Event Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_event |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Quantity |

---

---

### Table: `dim_creator`
**Description**: Domain table for `dim_creator` in `Digital_Streaming_Media_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `creator_key` | **Creator Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_creator_id` | **Source Creator Id** | `INT` | `NOT NULL` | Natural ID |
| `creator_name` | **Creator Name** | `VARCHAR(100)` | `NOT NULL` | Creator name |

---

---

### Table: `dim_media`
**Description**: Domain table for `dim_media` in `Digital_Streaming_Media_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `media_key` | **Media Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_media_id` | **Source Media Id** | `INT` | `NOT NULL` | Natural ID |
| `creator_key` | **Creator Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_creator |
| `title` | **Title** | `VARCHAR(120)` | `NOT NULL` | Media title |
| `media_type` | **Media Type** | `VARCHAR(20)` | `NOT NULL` | Media type |

---

---

### Table: `dim_subscriber`
**Description**: Domain table for `dim_subscriber` in `Digital_Streaming_Media_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_key` | **User Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_user_id` | **Source User Id** | `INT` | `NOT NULL` | Natural ID |
| `username` | **Username** | `VARCHAR(50)` | `NOT NULL` | Username |

---

---

### Table: `fact_stream_events`
**Description**: Domain table for `fact_stream_events` in `Digital_Streaming_Media_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `stream_key` | **Stream Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `user_key` | **User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_subscriber |
| `media_key` | **Media Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_media |
| `streamed_seconds` | **Streamed Seconds** | `INT` | `NOT NULL` | Streamed seconds |

---

---

### Table: `fact_subscription_revenue`
**Description**: Domain table for `fact_subscription_revenue` in `Digital_Streaming_Media_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `revenue_key` | **Revenue Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `user_key` | **User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_subscriber |
| `amount_usd` | **Amount Usd** | `NUMERIC(8,2)` | `NOT NULL` | Monthly amount USD |

---

---

### Table: `dim_categories`
**Description**: Domain table for `dim_categories` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_cat_key` | **Dim Cat Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_category_id` | **Source Category Id** | `INT` | `NOT NULL` | Natural source ID |
| `category_name` | **Category Name** | `VARCHAR(50)` | `NOT NULL` | Category name |
| `parent_category_name` | **Parent Category Name** | `VARCHAR(50)` | `NULL` | Parent category name |

---

---

### Table: `dim_customer_addresses`
**Description**: Domain table for `dim_customer_addresses` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_addr_key` | **Dim Addr Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `address_type` | **Address Type** | `VARCHAR(20)` | `NOT NULL` | Address classification |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |
| `state_province` | **State Province** | `VARCHAR(50)` | `NOT NULL` | State/Province |
| `country_code_iso2` | **Country Code Iso2** | `VARCHAR(2)` | `NOT NULL` | Country code |

---

---

### Table: `dim_customers`
**Description**: Domain table for `dim_customers` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_cust_key` | **Dim Cust Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Natural source ID |
| `customer_code` | **Customer Code** | `VARCHAR(36)` | `NOT NULL` | Tracking code |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full customer name |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Email contact |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NULL` | Phone number |
| `account_status` | **Account Status** | `VARCHAR(20)` | `NOT NULL` | Status code |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Active indicator |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | DW record timestamp |

---

---

### Table: `dim_product_attributes`
**Description**: Domain table for `dim_product_attributes` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_attr_key` | **Dim Attr Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `attribute_name` | **Attribute Name** | `VARCHAR(50)` | `NOT NULL` | Attribute name |
| `attribute_value` | **Attribute Value** | `VARCHAR(50)` | `NOT NULL` | Attribute value |

---

---

### Table: `dim_products`
**Description**: Domain table for `dim_products` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_prod_key` | **Dim Prod Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_product_id` | **Source Product Id** | `INT` | `NOT NULL` | Natural source ID |
| `sku` | **Sku** | `VARCHAR(30)` | `NOT NULL` | Product SKU |
| `product_name` | **Product Name** | `VARCHAR(100)` | `NOT NULL` | Product title |
| `category_key` | **Category Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_categories |
| `supplier_key` | **Supplier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_suppliers |
| `unit_price_usd` | **Unit Price Usd** | `NUMERIC(10,2)` | `NOT NULL` | Standard unit price |

---

---

### Table: `dim_promotions`
**Description**: Domain table for `dim_promotions` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_promo_key` | **Dim Promo Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_promo_id` | **Source Promo Id** | `INT` | `NOT NULL` | Natural source ID |
| `promo_code` | **Promo Code** | `VARCHAR(20)` | `NOT NULL` | Promo code |
| `discount_percent` | **Discount Percent** | `NUMERIC(5,2)` | `NOT NULL` | Discount rate |

---