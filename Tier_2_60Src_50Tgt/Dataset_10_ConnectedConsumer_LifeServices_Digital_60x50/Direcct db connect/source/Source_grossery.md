# Business Data Glossary - Dataset_10_ConnectedConsumer_LifeServices_Digital_60x50_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_10_ConnectedConsumer_LifeServices_Digital_60x50_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_10_ConnectedConsumer_LifeServices_Digital_60x50
- **Component**: Source Database Schema (Dataset_10_ConnectedConsumer_LifeServices_Digital_60x50_source)
- **Tier Specification**: Tier 2: 60 Source Tables, 50 Target Tables
- **Total Source Tables**: 60
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

---

### Table: `tbl_devices`
**Description**: Domain table for `tbl_devices` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `device_id` | **Device Id** | `INT` | `PRIMARY KEY` | Device primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `device_mac` | **Device Mac** | `VARCHAR(17)` | `NOT NULL` | MAC address |
| `model_name` | **Model Name** | `VARCHAR(50)` | `NOT NULL` | Smartwatch model |

---

---

### Table: `tbl_heartrate_telemetry`
**Description**: Domain table for `tbl_heartrate_telemetry` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `telemetry_id` | **Telemetry Id** | `INT` | `PRIMARY KEY` | Telemetry primary key ID |
| `device_id` | **Device Id** | `INT` | `FOREIGN KEY` | FK to tbl_devices |
| `bpm_value` | **Bpm Value** | `INT` | `NOT NULL` | Beats per minute reading |
| `recorded_at` | **Recorded At** | `TIMESTAMP` | `NOT NULL` | Sensor timestamp |

---

---

### Table: `tbl_sleep_sessions`
**Description**: Domain table for `tbl_sleep_sessions` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sleep_id` | **Sleep Id** | `INT` | `PRIMARY KEY` | Sleep primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `deep_sleep_minutes` | **Deep Sleep Minutes** | `INT` | `NOT NULL` | Deep sleep stage minutes |
| `rem_sleep_minutes` | **Rem Sleep Minutes** | `INT` | `NOT NULL` | REM stage minutes |

---

---

### Table: `tbl_users_fitness_fitness`
**Description**: Domain table for `tbl_users_fitness` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_id` | **User Id** | `INT` | `PRIMARY KEY` | User primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | User full name |
| `weight_kg` | **Weight Kg** | `DECIMAL(5,2)` | `NOT NULL` | Body weight kg |

---

---

### Table: `tbl_workouts`
**Description**: Domain table for `tbl_workouts` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `workout_id` | **Workout Id** | `INT` | `PRIMARY KEY` | Workout primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `workout_type` | **Workout Type** | `VARCHAR(30)` | `NOT NULL` | RUNNING/CYCLING/SWIMMING |
| `duration_minutes` | **Duration Minutes** | `INT` | `NOT NULL` | Active duration |
| `calories_burned` | **Calories Burned** | `INT` | `NOT NULL` | Burned kilocalories |

---

---

### Table: `tbl_event_venues`
**Description**: Domain table for `tbl_event_venues` in `Event_Ticketing_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `venue_id` | **Venue Id** | `INT` | `PRIMARY KEY` | Venue primary key ID |
| `venue_name` | **Venue Name** | `VARCHAR(80)` | `NOT NULL` | Arena or Stadium name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City |
| `seating_capacity` | **Seating Capacity** | `INT` | `NOT NULL` | Capacity seats |

---

---

### Table: `tbl_events`
**Description**: Domain table for `tbl_events` in `Event_Ticketing_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `event_id` | **Event Id** | `INT` | `PRIMARY KEY` | Event primary key ID |
| `venue_id` | **Venue Id** | `INT` | `FOREIGN KEY` | FK to tbl_event_venues |
| `event_title` | **Event Title** | `VARCHAR(100)` | `NOT NULL` | Concert or Game title |
| `event_date` | **Event Date** | `TIMESTAMP` | `NOT NULL` | Event date time |

---

---

### Table: `tbl_ticket_purchases`
**Description**: Domain table for `tbl_ticket_purchases` in `Event_Ticketing_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `purchase_id` | **Purchase Id** | `INT` | `PRIMARY KEY` | Purchase primary key ID |
| `tier_id` | **Tier Id** | `INT` | `FOREIGN KEY` | FK to tbl_ticket_tiers |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Tickets bought |
| `purchase_time` | **Purchase Time** | `TIMESTAMP` | `NOT NULL` | Timestamp |

---

---

### Table: `tbl_ticket_tiers`
**Description**: Domain table for `tbl_ticket_tiers` in `Event_Ticketing_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tier_id` | **Tier Id** | `INT` | `PRIMARY KEY` | Tier primary key ID |
| `event_id` | **Event Id** | `INT` | `FOREIGN KEY` | FK to tbl_events |
| `tier_name` | **Tier Name** | `VARCHAR(30)` | `NOT NULL` | VIP/FLOOR/BALCONY |
| `ticket_price` | **Ticket Price** | `DECIMAL(8,2)` | `NOT NULL` | Price USD |

---

---

### Table: `tbl_content_creators`
**Description**: Domain table for `tbl_content_creators` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `creator_id` | **Creator Id** | `INT` | `PRIMARY KEY` | Creator primary key ID |
| `creator_name` | **Creator Name** | `VARCHAR(100)` | `NOT NULL` | Artist or Studio name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country ISO |

---

---

### Table: `tbl_media_catalog`
**Description**: Domain table for `tbl_media_catalog` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `media_id` | **Media Id** | `INT` | `PRIMARY KEY` | Media item primary key ID |
| `creator_id` | **Creator Id** | `INT` | `FOREIGN KEY` | FK to tbl_content_creators |
| `title` | **Title** | `VARCHAR(120)` | `NOT NULL` | Track or Movie title |
| `media_type` | **Media Type** | `VARCHAR(20)` | `NOT NULL` | AUDIO/VIDEO/PODCAST |
| `duration_seconds` | **Duration Seconds** | `INT` | `NOT NULL` | Play duration in seconds |

---

---

### Table: `tbl_playlists`
**Description**: Domain table for `tbl_playlists` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `playlist_id` | **Playlist Id** | `INT` | `PRIMARY KEY` | Playlist primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `playlist_title` | **Playlist Title** | `VARCHAR(80)` | `NOT NULL` | Title |

---

---

### Table: `tbl_stream_history`
**Description**: Domain table for `tbl_stream_history` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `stream_id` | **Stream Id** | `INT` | `PRIMARY KEY` | Stream primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `media_id` | **Media Id** | `INT` | `FOREIGN KEY` | FK to tbl_media_catalog |
| `streamed_seconds` | **Streamed Seconds** | `INT` | `NOT NULL` | Watched seconds |
| `streamed_at` | **Streamed At** | `TIMESTAMP` | `NOT NULL` | Timestamp |

---

---

### Table: `tbl_subscription_tiers`
**Description**: Domain table for `tbl_subscription_tiers` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tier_id` | **Tier Id** | `INT` | `PRIMARY KEY` | Tier primary key ID |
| `tier_name` | **Tier Name** | `VARCHAR(40)` | `NOT NULL` | FREE/PREMIUM/FAMILY |
| `monthly_price` | **Monthly Price** | `DECIMAL(8,2)` | `NOT NULL` | Price USD |
| `max_streams` | **Max Streams** | `INT` | `NOT NULL` | Simultaneous streams allowed |

---

---

### Table: `tbl_user_ratings`
**Description**: Domain table for `tbl_user_ratings` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rating_id` | **Rating Id** | `INT` | `PRIMARY KEY` | Rating primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `media_id` | **Media Id** | `INT` | `FOREIGN KEY` | FK to tbl_media_catalog |
| `stars` | **Stars** | `INT` | `NOT NULL` | Rating 1-5 |

---

---

### Table: `tbl_user_subscriptions`
**Description**: Domain table for `tbl_user_subscriptions` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `subscription_id` | **Subscription Id** | `INT` | `PRIMARY KEY` | Subscription primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `tier_id` | **Tier Id** | `INT` | `FOREIGN KEY` | FK to tbl_subscription_tiers |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Start date |
| `auto_renew` | **Auto Renew** | `VARCHAR(1)` | `NOT NULL` | Auto-renew Y/N |

---

---

### Table: `tbl_users_digital_digital`
**Description**: Domain table for `tbl_users_digital` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_id` | **User Id** | `INT` | `PRIMARY KEY` | User primary key ID |
| `username` | **Username** | `VARCHAR(50)` | `NOT NULL` | Unique handle |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Contact email |
| `registration_date` | **Registration Date** | `DATE` | `NOT NULL` | Sign up date |

---

---

### Table: `tbl_cart_items`
**Description**: Domain table for `tbl_cart_items` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cart_item_id` | **Cart Item Id** | `INT` | `PRIMARY KEY` | Cart item primary key ID |
| `cart_id` | **Cart Id** | `INT` | `FOREIGN KEY` | FK to tbl_shopping_carts |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Cart item count quantity |

---

---

### Table: `tbl_categories`
**Description**: Domain table for `tbl_categories` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `category_id` | **Category Id** | `INT` | `PRIMARY KEY` | Category primary key ID |
| `category_name` | **Category Name** | `VARCHAR(50)` | `NOT NULL` | Category display name |
| `category_slug` | **Category Slug** | `VARCHAR(60)` | `NOT NULL` | URL friendly slug |
| `parent_category_id` | **Parent Category Id** | `INT` | `FOREIGN KEY` | Self-referencing parent category |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |

---

---

### Table: `tbl_customer_addresses`
**Description**: Domain table for `tbl_customer_addresses` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `address_id` | **Address Id** | `INT` | `PRIMARY KEY` | Address primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `address_type` | **Address Type** | `VARCHAR(20)` | `NOT NULL` | SHIPPING/BILLING |
| `street_address` | **Street Address** | `VARCHAR(100)` | `NOT NULL` | Street address line |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/province code |
| `postal_code` | **Postal Code** | `VARCHAR(10)` | `NOT NULL` | ZIP or Postal code |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_customer_support_tickets`
**Description**: Domain table for `tbl_customer_support_tickets` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `ticket_id` | **Ticket Id** | `INT` | `PRIMARY KEY` | Ticket primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `ticket_subject` | **Ticket Subject** | `VARCHAR(100)` | `NOT NULL` | Issue subject title |
| `ticket_status` | **Ticket Status** | `VARCHAR(20)` | `NOT NULL` | OPEN/RESOLVED/CLOSED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Opened timestamp |

---

---

### Table: `tbl_customers_ecommerce_ecommerce`
**Description**: Domain table for `tbl_customers_ecommerce` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | **Customer Id** | `INT` | `PRIMARY KEY` | Customer primary key ID |
| `customer_code` | **Customer Code** | `VARCHAR(36)` | `NOT NULL` | Unique tracking code |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Given first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Family last name |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Contact email address |
| `phone` | **Phone** | `VARCHAR(20)` | `NULL` | Telephone contact number |
| `account_status` | **Account Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE/SUSPENDED/CLOSED |
| `customer_segment` | **Customer Segment** | `VARCHAR(30)` | `NOT NULL` | RETAIL/WHOLESALE/VIP |
| `total_spent` | **Total Spent** | `DECIMAL(10,2)` | `NOT NULL` | Lifetime spend amount |
| `loyalty_points` | **Loyalty Points** | `INT` | `NOT NULL` | Earned loyalty points |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Account creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Account updated timestamp |

---

---

### Table: `tbl_discounts_promos`
**Description**: Domain table for `tbl_discounts_promos` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `promo_id` | **Promo Id** | `INT` | `PRIMARY KEY` | Promo primary key ID |
| `promo_code` | **Promo Code** | `VARCHAR(20)` | `NOT NULL` | Unique promo code |
| `discount_percent` | **Discount Percent** | `DECIMAL(5,2)` | `NOT NULL` | Discount percentage rate |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Campaign start date |
| `end_date` | **End Date** | `DATE` | `NOT NULL` | Campaign expiry date |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |

---

---

### Table: `tbl_inventory`
**Description**: Domain table for `tbl_inventory` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `inventory_id` | **Inventory Id** | `INT` | `PRIMARY KEY` | Inventory record primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `warehouse_id` | **Warehouse Id** | `INT` | `FOREIGN KEY` | FK to tbl_warehouses |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Available physical stock |
| `reserved_quantity` | **Reserved Quantity** | `INT` | `NOT NULL` | Allocated pending order stock |
| `last_updated` | **Last Updated** | `TIMESTAMP` | `NOT NULL` | Stock check timestamp |

---

---

### Table: `tbl_invoices`
**Description**: Domain table for `tbl_invoices` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `invoice_id` | **Invoice Id** | `INT` | `PRIMARY KEY` | Invoice primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `invoice_number` | **Invoice Number** | `VARCHAR(30)` | `NOT NULL` | Tax invoice document number |
| `invoice_date` | **Invoice Date** | `DATE` | `NOT NULL` | Billing issue date |
| `due_date` | **Due Date** | `DATE` | `NOT NULL` | Payment due date |
| `total_amount` | **Total Amount** | `DECIMAL(10,2)` | `NOT NULL` | Total billed amount |
| `invoice_status` | **Invoice Status** | `VARCHAR(15)` | `NOT NULL` | PAID/UNPAID/OVERDUE |

---

---

### Table: `tbl_order_items`
**Description**: Domain table for `tbl_order_items` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_item_id` | **Order Item Id** | `INT` | `PRIMARY KEY` | Order line item primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `unit_price` | **Unit Price** | `DECIMAL(10,2)` | `NOT NULL` | Sold price per unit |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Purchased item quantity |
| `subtotal` | **Subtotal** | `DECIMAL(10,2)` | `NOT NULL` | Calculated line item subtotal |

---

---

### Table: `tbl_orders`
**Description**: Domain table for `tbl_orders` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | **Order Id** | `INT` | `PRIMARY KEY` | Order primary key ID |
| `order_number` | **Order Number** | `VARCHAR(36)` | `NOT NULL` | Unique transaction order number |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order placement timestamp |
| `order_status` | **Order Status** | `VARCHAR(20)` | `NOT NULL` | PENDING/PROCESSING/SHIPPED/DELIVERED/CANCELLED |
| `total_amount` | **Total Amount** | `DECIMAL(10,2)` | `NOT NULL` | Gross order total |
| `tax_amount` | **Tax Amount** | `DECIMAL(10,2)` | `NOT NULL` | Applied tax amount |
| `shipping_fee` | **Shipping Fee** | `DECIMAL(10,2)` | `NOT NULL` | Shipping charge fee |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |

---

---

### Table: `tbl_payments`
**Description**: Domain table for `tbl_payments` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_id` | **Payment Id** | `INT` | `PRIMARY KEY` | Payment primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `payment_method` | **Payment Method** | `VARCHAR(20)` | `NOT NULL` | CREDIT_CARD/PAYPAL/WIRE |
| `payment_status` | **Payment Status** | `VARCHAR(15)` | `NOT NULL` | COMPLETED/PENDING/FAILED |
| `amount` | **Amount** | `DECIMAL(10,2)` | `NOT NULL` | Processed payment amount |
| `transaction_ref` | **Transaction Ref** | `VARCHAR(36)` | `NOT NULL` | Gateway transaction reference |
| `payment_date` | **Payment Date** | `TIMESTAMP` | `NOT NULL` | Execution timestamp |

---

---

### Table: `tbl_product_attributes`
**Description**: Domain table for `tbl_product_attributes` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `attribute_id` | **Attribute Id** | `INT` | `PRIMARY KEY` | Attribute primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `attribute_name` | **Attribute Name** | `VARCHAR(50)` | `NOT NULL` | Color/Size/Weight |
| `attribute_value` | **Attribute Value** | `VARCHAR(50)` | `NOT NULL` | Attribute value string |

---

---

### Table: `tbl_product_reviews`
**Description**: Domain table for `tbl_product_reviews` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `review_id` | **Review Id** | `INT` | `PRIMARY KEY` | Review primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `rating_score` | **Rating Score** | `INT` | `NOT NULL` | Rating 1-5 stars |
| `review_text` | **Review Text** | `TEXT` | `NULL` | Customer feedback review |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Review submission timestamp |

---

---

### Table: `tbl_products`
**Description**: Domain table for `tbl_products` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `product_id` | **Product Id** | `INT` | `PRIMARY KEY` | Product primary key ID |
| `sku` | **Sku** | `VARCHAR(30)` | `NOT NULL` | Stock Keeping Unit SKU |
| `product_name` | **Product Name** | `VARCHAR(100)` | `NOT NULL` | Product catalog title |
| `category_id` | **Category Id** | `INT` | `FOREIGN KEY` | FK to tbl_categories |
| `supplier_id` | **Supplier Id** | `INT` | `FOREIGN KEY` | FK to tbl_suppliers |
| `unit_price` | **Unit Price** | `DECIMAL(10,2)` | `NOT NULL` | Standard retail price |
| `cost_price` | **Cost Price** | `DECIMAL(10,2)` | `NOT NULL` | Wholesale cost price |
| `product_status` | **Product Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE/DISCONTINUED/OUT_OF_STOCK |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Catalog entry timestamp |

---

---

### Table: `tbl_return_requests`
**Description**: Domain table for `tbl_return_requests` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `return_id` | **Return Id** | `INT` | `PRIMARY KEY` | Return request primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `return_reason` | **Return Reason** | `VARCHAR(100)` | `NOT NULL` | Reason for return |
| `return_status` | **Return Status** | `VARCHAR(20)` | `NOT NULL` | REQUESTED/APPROVED/REJECTED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Request timestamp |

---

---

### Table: `tbl_shipments`
**Description**: Domain table for `tbl_shipments` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_id` | **Shipment Id** | `INT` | `PRIMARY KEY` | Shipment primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Carrier tracking code |
| `carrier_name` | **Carrier Name** | `VARCHAR(30)` | `NOT NULL` | UPS/FEDEX/DHL |
| `shipped_date` | **Shipped Date** | `TIMESTAMP` | `NULL` | Dispatch timestamp |
| `delivery_date` | **Delivery Date** | `TIMESTAMP` | `NULL` | Delivery timestamp |
| `shipment_status` | **Shipment Status** | `VARCHAR(20)` | `NOT NULL` | IN_TRANSIT/DELIVERED/RETURNED |

---

---

### Table: `tbl_shopping_carts`
**Description**: Domain table for `tbl_shopping_carts` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cart_id` | **Cart Id** | `INT` | `PRIMARY KEY` | Cart primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Cart creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Cart modified timestamp |

---

---

### Table: `tbl_suppliers`
**Description**: Domain table for `tbl_suppliers` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `supplier_id` | **Supplier Id** | `INT` | `PRIMARY KEY` | Supplier primary key ID |
| `company_name` | **Company Name** | `VARCHAR(100)` | `NOT NULL` | Supplier corporate name |
| `contact_name` | **Contact Name** | `VARCHAR(60)` | `NOT NULL` | Primary account manager |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Corporate email address |
| `phone` | **Phone** | `VARCHAR(20)` | `NOT NULL` | Corporate contact phone |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_system_audit_logs`
**Description**: Domain table for `tbl_system_audit_logs` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Audit log primary key ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Operator user string ID |
| `action_name` | **Action Name** | `VARCHAR(50)` | `NOT NULL` | Action performed |
| `target_entity` | **Target Entity** | `VARCHAR(50)` | `NOT NULL` | Target table name |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Audit timestamp |

---

---

### Table: `tbl_warehouses`
**Description**: Domain table for `tbl_warehouses` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `warehouse_id` | **Warehouse Id** | `INT` | `PRIMARY KEY` | Warehouse primary key ID |
| `warehouse_code` | **Warehouse Code** | `VARCHAR(20)` | `NOT NULL` | Unique warehouse location code |
| `warehouse_name` | **Warehouse Name** | `VARCHAR(80)` | `NOT NULL` | Facility designation name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | Facility location city |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/Province code |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_wishlists`
**Description**: Domain table for `tbl_wishlists` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `wishlist_id` | **Wishlist Id** | `INT` | `PRIMARY KEY` | Wishlist primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `added_at` | **Added At** | `TIMESTAMP` | `NOT NULL` | Addition timestamp |

---

---

### Table: `src_doctor_physicians`
**Description**: Domain table for `src_doctor_physicians` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `physician_id` | **Physician Id** | `INT` | `PRIMARY KEY` | Physician primary key ID |
| `npi_number` | **Npi Number** | `VARCHAR(10)` | `NOT NULL` | National Provider Identifier NPI |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Physician first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Physician last name |
| `specialty` | **Specialty** | `VARCHAR(60)` | `NOT NULL` | Medical specialty field |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Direct telephone contact |

---

---

### Table: `src_ehr_audit_logs`
**Description**: Domain table for `src_ehr_audit_logs` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Audit log primary key ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Clinician user ID |
| `action_type` | **Action Type** | `VARCHAR(30)` | `NOT NULL` | READ/WRITE/DELETE |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `ip_address` | **Ip Address** | `VARCHAR(45)` | `NOT NULL` | Workstation IP |
| `log_timestamp` | **Log Timestamp** | `TIMESTAMP` | `NOT NULL` | Audit timestamp |

---