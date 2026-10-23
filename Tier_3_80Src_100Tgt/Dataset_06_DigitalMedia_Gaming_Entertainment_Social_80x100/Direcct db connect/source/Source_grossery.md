# Business Data Glossary - Dataset_06_DigitalMedia_Gaming_Entertainment_Social_80x100_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_06_DigitalMedia_Gaming_Entertainment_Social_80x100_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_06_DigitalMedia_Gaming_Entertainment_Social_80x100
- **Component**: Source Database Schema (Dataset_06_DigitalMedia_Gaming_Entertainment_Social_80x100_source)
- **Tier Specification**: Tier 3: 80 Source Tables, 100 Target Tables
- **Total Source Tables**: 80
- **Theme Focus**: Streaming Media, Esports Gaming, Live Event Ticketing & Social Networks
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

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

### Table: `tbl_users`
**Description**: Domain table for `tbl_users` in `Digital_Streaming_Media_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_id` | **User Id** | `INT` | `PRIMARY KEY` | User primary key ID |
| `username` | **Username** | `VARCHAR(50)` | `NOT NULL` | Unique handle |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Contact email |
| `registration_date` | **Registration Date** | `DATE` | `NOT NULL` | Sign up date |

---

---

### Table: `tbl_esports_teams`
**Description**: Domain table for `tbl_esports_teams` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `team_id` | **Team Id** | `INT` | `PRIMARY KEY` | Team primary key ID |
| `team_name` | **Team Name** | `VARCHAR(80)` | `NOT NULL` | Org team name |
| `region_code` | **Region Code** | `VARCHAR(10)` | `NOT NULL` | NA/EU/APAC |

---

---

### Table: `tbl_ingame_store_items`
**Description**: Domain table for `tbl_ingame_store_items` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `item_id` | **Item Id** | `INT` | `PRIMARY KEY` | Item primary key ID |
| `item_name` | **Item Name** | `VARCHAR(80)` | `NOT NULL` | Skin or Cosmetic name |
| `virtual_currency_cost` | **Virtual Currency Cost** | `INT` | `NOT NULL` | Gems or Coins cost |

---

---

### Table: `tbl_match_player_stats`
**Description**: Domain table for `tbl_match_player_stats` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `stat_id` | **Stat Id** | `INT` | `PRIMARY KEY` | Stat primary key ID |
| `match_id` | **Match Id** | `INT` | `FOREIGN KEY` | FK to tbl_matches |
| `player_id` | **Player Id** | `INT` | `FOREIGN KEY` | FK to tbl_players |
| `kills` | **Kills** | `INT` | `NOT NULL` | Eliminations |
| `deaths` | **Deaths** | `INT` | `NOT NULL` | Deaths |
| `assists` | **Assists** | `INT` | `NOT NULL` | Assists |

---

---

### Table: `tbl_matches`
**Description**: Domain table for `tbl_matches` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `match_id` | **Match Id** | `INT` | `PRIMARY KEY` | Match primary key ID |
| `tournament_id` | **Tournament Id** | `INT` | `FOREIGN KEY` | FK to tbl_tournaments |
| `winning_team_id` | **Winning Team Id** | `INT` | `FOREIGN KEY` | FK to tbl_esports_teams |
| `match_date` | **Match Date** | `TIMESTAMP` | `NOT NULL` | Match timestamp |

---

---

### Table: `tbl_player_purchases`
**Description**: Domain table for `tbl_player_purchases` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `purchase_id` | **Purchase Id** | `INT` | `PRIMARY KEY` | Purchase primary key ID |
| `player_id` | **Player Id** | `INT` | `FOREIGN KEY` | FK to tbl_players |
| `item_id` | **Item Id** | `INT` | `FOREIGN KEY` | FK to tbl_ingame_store_items |
| `purchase_date` | **Purchase Date** | `TIMESTAMP` | `NOT NULL` | Transaction timestamp |

---

---

### Table: `tbl_players`
**Description**: Domain table for `tbl_players` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `player_id` | **Player Id** | `INT` | `PRIMARY KEY` | Player primary key ID |
| `team_id` | **Team Id** | `INT` | `FOREIGN KEY` | FK to tbl_esports_teams |
| `gamer_tag` | **Gamer Tag** | `VARCHAR(40)` | `NOT NULL` | In-game handle |
| `rank_title` | **Rank Title** | `VARCHAR(30)` | `NOT NULL` | Competitive rank |

---

---

### Table: `tbl_tournaments`
**Description**: Domain table for `tbl_tournaments` in `Gaming_Esports_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tournament_id` | **Tournament Id** | `INT` | `PRIMARY KEY` | Tournament primary key ID |
| `tournament_name` | **Tournament Name** | `VARCHAR(100)` | `NOT NULL` | Tournament title |
| `prize_pool` | **Prize Pool** | `DECIMAL(12,2)` | `NOT NULL` | Prize money USD |

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

### Table: `tbl_users_social_social`
**Description**: Domain table for `tbl_users_social` in `Social_Media_Platform_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_id` | **User Id** | `INT` | `PRIMARY KEY` | User primary key ID |
| `username` | **Username** | `VARCHAR(30)` | `NOT NULL` | Unique social tag |
| `display_name` | **Display Name** | `VARCHAR(60)` | `NOT NULL` | Profile name |

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

### Table: `tbl_customers`
**Description**: Domain table for `tbl_customers` in `Ecommerce_Dataset` (source).

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

---

### Table: `src_emergency_contacts`
**Description**: Domain table for `src_emergency_contacts` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `contact_id` | **Contact Id** | `INT` | `PRIMARY KEY` | Emergency contact primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `contact_name` | **Contact Name** | `VARCHAR(60)` | `NOT NULL` | Contact person full name |
| `relationship` | **Relationship** | `VARCHAR(30)` | `NOT NULL` | SPOUSE/PARENT/SIBLING |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Emergency phone number |

---

---

### Table: `src_hospital_departments`
**Description**: Domain table for `src_hospital_departments` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `department_id` | **Department Id** | `INT` | `PRIMARY KEY` | Department primary key ID |
| `dept_name` | **Dept Name** | `VARCHAR(60)` | `NOT NULL` | Clinical department designation |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Hospital facility complex |
| `building_location` | **Building Location** | `VARCHAR(40)` | `NOT NULL` | Building or floor wing |
| `phone_extension` | **Phone Extension** | `VARCHAR(10)` | `NOT NULL` | Internal phone extension |

---

---

### Table: `src_hospital_encounters`
**Description**: Domain table for `src_hospital_encounters` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `encounter_id` | **Encounter Id** | `INT` | `PRIMARY KEY` | Encounter primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `attending_physician_id` | **Attending Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `encounter_class` | **Encounter Class** | `VARCHAR(20)` | `NOT NULL` | INPATIENT/OUTPATIENT/EMERGENCY |
| `admission_date` | **Admission Date** | `TIMESTAMP` | `NOT NULL` | Admission timestamp |
| `discharge_date` | **Discharge Date** | `TIMESTAMP` | `NULL` | Discharge timestamp |
| `encounter_status` | **Encounter Status** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/FINISHED/CANCELLED |

---

---

### Table: `src_hospital_staff_roster`
**Description**: Domain table for `src_hospital_staff_roster` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `staff_id` | **Staff Id** | `INT` | `PRIMARY KEY` | Staff primary key ID |
| `employee_number` | **Employee Number** | `VARCHAR(20)` | `NOT NULL` | Staff badge ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Staff full name |
| `role_title` | **Role Title** | `VARCHAR(50)` | `NOT NULL` | NURSE/TECHNICIAN/ADMIN |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `phone_extension` | **Phone Extension** | `VARCHAR(10)` | `NOT NULL` | Internal phone extension |

---

---

### Table: `src_insurance_claims`
**Description**: Domain table for `src_insurance_claims` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `claim_id` | **Claim Id** | `INT` | `PRIMARY KEY` | Insurance claim primary key ID |
| `billing_id` | **Billing Id** | `INT` | `FOREIGN KEY` | FK to src_patient_billing |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `payer_name` | **Payer Name** | `VARCHAR(80)` | `NOT NULL` | Health insurance provider |
| `claim_amount` | **Claim Amount** | `DECIMAL(10,2)` | `NOT NULL` | Claimed reimbursement amount |
| `covered_amount` | **Covered Amount** | `DECIMAL(10,2)` | `NOT NULL` | Approved covered amount |
| `claim_status` | **Claim Status** | `VARCHAR(15)` | `NOT NULL` | SUBMITTED/PAID/DENIED |
| `submission_date` | **Submission Date** | `DATE` | `NOT NULL` | Payer filing date |

---

---

### Table: `src_lab_results`
**Description**: Domain table for `src_lab_results` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lab_result_id` | **Lab Result Id** | `INT` | `PRIMARY KEY` | Lab result primary key ID |
| `lab_order_id` | **Lab Order Id** | `INT` | `FOREIGN KEY` | FK to src_lab_test_orders |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `result_value` | **Result Value** | `DECIMAL(10,2)` | `NOT NULL` | Quantitative lab measurement |
| `unit_of_measure` | **Unit Of Measure** | `VARCHAR(20)` | `NOT NULL` | Measurement unit (mg/dL) |
| `reference_range` | **Reference Range** | `VARCHAR(30)` | `NOT NULL` | Normal reference range |
| `result_status` | **Result Status** | `VARCHAR(15)` | `NOT NULL` | FINAL/PRELIMINARY |
| `result_date` | **Result Date** | `TIMESTAMP` | `NOT NULL` | Result timestamp |

---

---

### Table: `src_lab_test_orders`
**Description**: Domain table for `src_lab_test_orders` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lab_order_id` | **Lab Order Id** | `INT` | `PRIMARY KEY` | Lab order primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `ordering_physician_id` | **Ordering Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `loinc_code` | **Loinc Code** | `VARCHAR(20)` | `NOT NULL` | LOINC lab test concept code |
| `test_name` | **Test Name** | `VARCHAR(100)` | `NOT NULL` | Lab panel test title |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order timestamp |
| `order_status` | **Order Status** | `VARCHAR(15)` | `NOT NULL` | ORDERED/COMPLETED/CANCELLED |

---

---

### Table: `src_medical_diagnoses`
**Description**: Domain table for `src_medical_diagnoses` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `diagnosis_id` | **Diagnosis Id** | `INT` | `PRIMARY KEY` | Diagnosis primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `icd10_code` | **Icd10 Code** | `VARCHAR(20)` | `NOT NULL` | ICD-10 clinical diagnosis code |
| `diagnosis_name` | **Diagnosis Name** | `VARCHAR(100)` | `NOT NULL` | Diagnosis description |
| `diagnosis_date` | **Diagnosis Date** | `DATE` | `NOT NULL` | Onset or diagnosis date |

---

---

### Table: `src_medical_history`
**Description**: Domain table for `src_medical_history` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `history_id` | **History Id** | `INT` | `PRIMARY KEY` | Medical history primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `condition_name` | **Condition Name** | `VARCHAR(100)` | `NOT NULL` | Pre-existing medical condition |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Condition onset date |
| `condition_status` | **Condition Status** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/RESOLVED |

---

---

### Table: `src_medical_prescriptions`
**Description**: Domain table for `src_medical_prescriptions` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `prescription_id` | **Prescription Id** | `INT` | `PRIMARY KEY` | Prescription primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `prescribing_physician_id` | **Prescribing Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `rxnorm_code` | **Rxnorm Code** | `VARCHAR(20)` | `NOT NULL` | RxNorm medication code |
| `medication_name` | **Medication Name** | `VARCHAR(100)` | `NOT NULL` | Medication trade name |
| `dosage_instructions` | **Dosage Instructions** | `VARCHAR(100)` | `NOT NULL` | Dosage and frequency |
| `prescribed_date` | **Prescribed Date** | `DATE` | `NOT NULL` | Prescription order date |

---

---

### Table: `src_patient_appointments`
**Description**: Domain table for `src_patient_appointments` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `appointment_id` | **Appointment Id** | `INT` | `PRIMARY KEY` | Appointment primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `physician_id` | **Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `appointment_time` | **Appointment Time** | `TIMESTAMP` | `NOT NULL` | Scheduled appointment timestamp |
| `appointment_status` | **Appointment Status** | `VARCHAR(15)` | `NOT NULL` | SCHEDULED/COMPLETED/NO_SHOW |

---

---

### Table: `src_patient_billing`
**Description**: Domain table for `src_patient_billing` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `billing_id` | **Billing Id** | `INT` | `PRIMARY KEY` | Patient billing primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `total_charge_amount` | **Total Charge Amount** | `DECIMAL(10,2)` | `NOT NULL` | Gross medical charge |
| `paid_amount` | **Paid Amount** | `DECIMAL(10,2)` | `NOT NULL` | Settled payment amount |
| `balance_due` | **Balance Due** | `DECIMAL(10,2)` | `NOT NULL` | Outstanding invoice balance |
| `billing_date` | **Billing Date** | `DATE` | `NOT NULL` | Statement generation date |
| `billing_status` | **Billing Status** | `VARCHAR(15)` | `NOT NULL` | BILLED/PAID/OVERDUE |

---

---

### Table: `src_patient_immunizations`
**Description**: Domain table for `src_patient_immunizations` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `immunization_id` | **Immunization Id** | `INT` | `PRIMARY KEY` | Immunization primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `vaccine_code` | **Vaccine Code** | `VARCHAR(20)` | `NOT NULL` | CVX vaccine code |
| `vaccine_name` | **Vaccine Name** | `VARCHAR(100)` | `NOT NULL` | Vaccine trade name |
| `administered_date` | **Administered Date** | `DATE` | `NOT NULL` | Vaccination date |
| `dose_number` | **Dose Number** | `INT` | `NOT NULL` | Dose sequence number |

---

---

### Table: `src_patient_master`
**Description**: Domain table for `src_patient_master` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `patient_id` | **Patient Id** | `INT` | `PRIMARY KEY` | Patient primary key ID |
| `mrn_number` | **Mrn Number** | `VARCHAR(30)` | `NOT NULL` | Medical Record Number MRN |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Patient given first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Patient family last name |
| `gender_code` | **Gender Code** | `VARCHAR(1)` | `NOT NULL` | Administrative gender (M/F/U) |
| `date_of_birth` | **Date Of Birth** | `DATE` | `NOT NULL` | Patient birth date |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Primary telephone contact |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/Province code |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | EHR entry timestamp |

---

---

### Table: `src_patient_vitals_signs`
**Description**: Domain table for `src_patient_vitals_signs` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vital_id` | **Vital Id** | `INT` | `PRIMARY KEY` | Vital sign primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `vital_type` | **Vital Type** | `VARCHAR(30)` | `NOT NULL` | HEART_RATE/BP_SYSTOLIC/TEMP |
| `numeric_value` | **Numeric Value** | `DECIMAL(8,2)` | `NOT NULL` | Measurement reading |
| `unit_of_measure` | **Unit Of Measure** | `VARCHAR(20)` | `NOT NULL` | Measurement unit |
| `recorded_time` | **Recorded Time** | `TIMESTAMP` | `NOT NULL` | Observation timestamp |

---

---

### Table: `src_pharmacy_inventory`
**Description**: Domain table for `src_pharmacy_inventory` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `inventory_id` | **Inventory Id** | `INT` | `PRIMARY KEY` | Pharmacy stock primary key ID |
| `ndc_code` | **Ndc Code** | `VARCHAR(20)` | `NOT NULL` | National Drug Code NDC |
| `medication_name` | **Medication Name** | `VARCHAR(100)` | `NOT NULL` | Medication trade name |
| `quantity_in_stock` | **Quantity In Stock** | `INT` | `NOT NULL` | Physical stock on hand |
| `reorder_level` | **Reorder Level** | `INT` | `NOT NULL` | Reorder threshold count |

---

---

### Table: `src_room_bed_allocations`
**Description**: Domain table for `src_room_bed_allocations` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `allocation_id` | **Allocation Id** | `INT` | `PRIMARY KEY` | Bed allocation primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `room_number` | **Room Number** | `VARCHAR(20)` | `NOT NULL` | Hospital room number |
| `bed_number` | **Bed Number** | `VARCHAR(10)` | `NOT NULL` | Bed location designation |
| `start_time` | **Start Time** | `TIMESTAMP` | `NOT NULL` | Bed assignment start |
| `end_time` | **End Time** | `TIMESTAMP` | `NULL` | Bed discharge time |

---

---

### Table: `src_surgical_procedures`
**Description**: Domain table for `src_surgical_procedures` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `procedure_id` | **Procedure Id** | `INT` | `PRIMARY KEY` | Procedure primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `surgeon_id` | **Surgeon Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `cpt_code` | **Cpt Code** | `VARCHAR(20)` | `NOT NULL` | CPT procedure medical code |
| `procedure_name` | **Procedure Name** | `VARCHAR(100)` | `NOT NULL` | Surgical procedure title |
| `procedure_date` | **Procedure Date** | `DATE` | `NOT NULL` | Surgery execution date |

---

---

### Table: `tbl_accounts`
**Description**: Domain table for `tbl_accounts` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `account_id` | **Account Id** | `INT` | `PRIMARY KEY` | Account primary key ID |
| `account_number` | **Account Number** | `VARCHAR(20)` | `NOT NULL` | Unique bank account number |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | Parent customer ID |
| `account_type` | **Account Type** | `VARCHAR(20)` | `NOT NULL` | CHECKING/SAVINGS/MONEY_MARKET |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | ISO currency code USD/EUR |
| `current_balance` | **Current Balance** | `DECIMAL(12,2)` | `NOT NULL` | Current account balance |
| `available_balance` | **Available Balance** | `DECIMAL(12,2)` | `NOT NULL` | Available account balance |
| `status_code` | **Status Code** | `VARCHAR(10)` | `NOT NULL` | ACTIVE/CLOSED/FROZEN |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Account creation timestamp |

---

---

### Table: `tbl_audit_logs`
**Description**: Domain table for `tbl_audit_logs` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Audit log primary key ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Operator user or system ID |
| `action_type` | **Action Type** | `VARCHAR(30)` | `NOT NULL` | LOGIN/TRANSFER/UPDATE_LIMIT |
| `entity_name` | **Entity Name** | `VARCHAR(40)` | `NOT NULL` | Target entity table |
| `entity_id` | **Entity Id** | `INT` | `NOT NULL` | Target entity record ID |
| `ip_address` | **Ip Address** | `VARCHAR(45)` | `NOT NULL` | Client IP address |
| `log_timestamp` | **Log Timestamp** | `TIMESTAMP` | `NOT NULL` | Audit log timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | SUCCESS/DENIED |

---

---

### Table: `tbl_branches`
**Description**: Domain table for `tbl_branches` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `branch_id` | **Branch Id** | `INT` | `PRIMARY KEY` | Branch primary key ID |
| `branch_code` | **Branch Code** | `VARCHAR(10)` | `NOT NULL` | Unique branch location code |
| `branch_name` | **Branch Name** | `VARCHAR(60)` | `NOT NULL` | Branch designation name |
| `address_line` | **Address Line** | `VARCHAR(100)` | `NOT NULL` | Street address line |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State postal code |
| `postal_code` | **Postal Code** | `VARCHAR(10)` | `NOT NULL` | ZIP/Postal code |
| `manager_name` | **Manager Name** | `VARCHAR(60)` | `NOT NULL` | Branch manager name |
| `status_code` | **Status Code** | `VARCHAR(10)` | `NOT NULL` | OPEN/CLOSED/REMODEL |

---

---

### Table: `tbl_credit_cards`
**Description**: Domain table for `tbl_credit_cards` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `card_id` | **Card Id** | `INT` | `PRIMARY KEY` | Credit card primary key ID |
| `account_id` | **Account Id** | `INT` | `FOREIGN KEY` | Associated checking/card account ID |
| `card_number_masked` | **Card Number Masked** | `VARCHAR(19)` | `NOT NULL` | Masked credit card number |
| `card_type` | **Card Type** | `VARCHAR(20)` | `NOT NULL` | VISA/MASTERCARD/AMEX |
| `credit_limit` | **Credit Limit** | `DECIMAL(10,2)` | `NOT NULL` | Approved credit limit |
| `current_balance` | **Current Balance** | `DECIMAL(10,2)` | `NOT NULL` | Current statement balance |
| `expiry_date` | **Expiry Date** | `VARCHAR(7)` | `NOT NULL` | Expiration date MM/YYYY |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | ISSUED/BLOCKED/EXPIRED |

---

---

### Table: `tbl_customers_finance_finance`
**Description**: Domain table for `tbl_customers_finance` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | **Customer Id** | `INT` | `PRIMARY KEY` | Customer primary key ID |
| `tax_identifier` | **Tax Identifier** | `VARCHAR(11)` | `NOT NULL` | SSN or Tax ID number |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Customer given name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Customer family name |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Primary email contact |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Primary phone contact |
| `kyc_status` | **Kyc Status** | `VARCHAR(15)` | `NOT NULL` | VERIFIED/PENDING/REJECTED |
| `risk_rating` | **Risk Rating** | `VARCHAR(10)` | `NOT NULL` | LOW/MEDIUM/HIGH |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Customer onboarding timestamp |

---

---

### Table: `tbl_investment_portfolios`
**Description**: Domain table for `tbl_investment_portfolios` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `portfolio_id` | **Portfolio Id** | `INT` | `PRIMARY KEY` | Portfolio primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | Investor customer ID |
| `portfolio_name` | **Portfolio Name** | `VARCHAR(60)` | `NOT NULL` | Portfolio title |
| `portfolio_type` | **Portfolio Type** | `VARCHAR(25)` | `NOT NULL` | GROWTH/BALANCED/CONSERVATIVE |
| `total_value` | **Total Value** | `DECIMAL(12,2)` | `NOT NULL` | Total asset market value |
| `risk_level` | **Risk Level** | `VARCHAR(15)` | `NOT NULL` | MODERATE/AGGRESSIVE/LOW |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Portfolio creation date |
| `status_code` | **Status Code** | `VARCHAR(10)` | `NOT NULL` | ACTIVE/LIQUIDATED |

---

---

### Table: `tbl_loan_payments`
**Description**: Domain table for `tbl_loan_payments` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_id` | **Payment Id** | `INT` | `PRIMARY KEY` | Loan payment primary key ID |
| `loan_id` | **Loan Id** | `INT` | `FOREIGN KEY` | Associated loan ID |
| `payment_date` | **Payment Date** | `DATE` | `NOT NULL` | Payment execution date |
| `principal_paid` | **Principal Paid** | `DECIMAL(10,2)` | `NOT NULL` | Principal portion paid |
| `interest_paid` | **Interest Paid** | `DECIMAL(10,2)` | `NOT NULL` | Interest portion paid |
| `total_paid` | **Total Paid** | `DECIMAL(10,2)` | `NOT NULL` | Total amount paid |
| `payment_method` | **Payment Method** | `VARCHAR(20)` | `NOT NULL` | AUTOPAY/WIRE/CHECK |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | POSTED/PENDING/REVERSED |

---

---

### Table: `tbl_loans`
**Description**: Domain table for `tbl_loans` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `loan_id` | **Loan Id** | `INT` | `PRIMARY KEY` | Loan primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | Borrower customer ID |
| `loan_type` | **Loan Type** | `VARCHAR(20)` | `NOT NULL` | MORTGAGE/AUTO/PERSONAL/BUSINESS |
| `principal_amount` | **Principal Amount** | `DECIMAL(12,2)` | `NOT NULL` | Original loan principal |
| `interest_rate` | **Interest Rate** | `DECIMAL(5,2)` | `NOT NULL` | Annual percentage interest rate |
| `term_months` | **Term Months** | `INT` | `NOT NULL` | Loan duration in months |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Loan disbursement date |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/PAID_OFF/DEFAULTED |
| `remaining_balance` | **Remaining Balance** | `DECIMAL(12,2)` | `NOT NULL` | Outstanding principal balance |

---

---

### Table: `tbl_transactions`
**Description**: Domain table for `tbl_transactions` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_id` | **Transaction Id** | `INT` | `PRIMARY KEY` | Transaction primary key ID |
| `account_id` | **Account Id** | `INT` | `FOREIGN KEY` | Associated account ID |
| `txn_reference` | **Txn Reference** | `VARCHAR(36)` | `NOT NULL` | Unique transaction reference code |
| `txn_type` | **Txn Type** | `VARCHAR(20)` | `NOT NULL` | DEPOSIT/WITHDRAWAL/TRANSFER/FEE |
| `amount` | **Amount** | `DECIMAL(10,2)` | `NOT NULL` | Transaction amount |
| `txn_date` | **Txn Date** | `TIMESTAMP` | `NOT NULL` | Transaction timestamp |
| `description` | **Description** | `VARCHAR(100)` | `NOT NULL` | Transaction narrative note |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | COMPLETED/PENDING/FAILED |

---

---

### Table: `tbl_wire_transfers`
**Description**: Domain table for `tbl_wire_transfers` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transfer_id` | **Transfer Id** | `INT` | `PRIMARY KEY` | Wire transfer primary key ID |
| `source_account_id` | **Source Account Id** | `INT` | `FOREIGN KEY` | Originating account ID |
| `dest_account_number` | **Dest Account Number** | `VARCHAR(34)` | `NOT NULL` | Destination IBAN or account |
| `swift_code` | **Swift Code** | `VARCHAR(11)` | `NOT NULL` | Destination SWIFT/BIC code |
| `amount` | **Amount** | `DECIMAL(12,2)` | `NOT NULL` | Transfer amount |
| `fee_amount` | **Fee Amount** | `DECIMAL(8,2)` | `NOT NULL` | Service fee charged |
| `transfer_date` | **Transfer Date** | `TIMESTAMP` | `NOT NULL` | Execution timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | SETTLED/PROCESSING/CANCELLED |

---

---

### Table: `tbl_attendances`
**Description**: Domain table for `tbl_attendances` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `attendance_id` | **Attendance Id** | `INT` | `PRIMARY KEY` | Attendance entry primary key ID |
| `employee_id` | **Employee Id** | `INT` | `NOT NULL` | Employee ID |
| `work_date` | **Work Date** | `DATE` | `NOT NULL` | Shift work date |
| `check_in_time` | **Check In Time** | `TIMESTAMP` | `NOT NULL` | Clock in timestamp |
| `check_out_time` | **Check Out Time** | `TIMESTAMP` | `NOT NULL` | Clock out timestamp |
| `hours_worked` | **Hours Worked** | `DECIMAL(4,2)` | `NOT NULL` | Total regular hours worked |
| `overtime_hours` | **Overtime Hours** | `DECIMAL(4,2)` | `NOT NULL` | Total overtime hours worked |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | PRESENT/LATE/ABSENT |

---

---

### Table: `tbl_benefits`
**Description**: Domain table for `tbl_benefits` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `benefit_id` | **Benefit Id** | `INT` | `PRIMARY KEY` | Benefit enrollment primary key ID |
| `employee_id` | **Employee Id** | `INT` | `FOREIGN KEY` | Enrolled employee ID |
| `plan_name` | **Plan Name** | `VARCHAR(50)` | `NOT NULL` | Benefit plan designation |
| `benefit_type` | **Benefit Type** | `VARCHAR(25)` | `NOT NULL` | HEALTH/DENTAL/VISION/401K |
| `employer_cost` | **Employer Cost** | `DECIMAL(8,2)` | `NOT NULL` | Employer monthly contribution |
| `employee_cost` | **Employee Cost** | `DECIMAL(8,2)` | `NOT NULL` | Employee monthly payroll deduction |
| `enrollment_date` | **Enrollment Date** | `DATE` | `NOT NULL` | Benefit plan enrollment date |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | ENROLLED/CANCELLED |

---

---

### Table: `tbl_departments`
**Description**: Domain table for `tbl_departments` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `department_id` | **Department Id** | `INT` | `PRIMARY KEY` | Department primary key ID |
| `dept_code` | **Dept Code** | `VARCHAR(10)` | `NOT NULL` | Unique department code |
| `dept_name` | **Dept Name** | `VARCHAR(50)` | `NOT NULL` | Department title name |
| `manager_id` | **Manager Id** | `INT` | `NOT NULL` | Managing employee ID |
| `location_id` | **Location Id** | `INT` | `NOT NULL` | Office location ID |
| `budget_amount` | **Budget Amount** | `DECIMAL(12,2)` | `NOT NULL` | Annual department budget |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |

---

---

### Table: `tbl_employees`
**Description**: Domain table for `tbl_employees` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `employee_id` | **Employee Id** | `INT` | `PRIMARY KEY` | Employee primary key ID |
| `ssn_number` | **Ssn Number** | `VARCHAR(11)` | `NOT NULL` | Social Security Number |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Employee given first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Employee family last name |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Corporate email address |
| `hire_date` | **Hire Date** | `DATE` | `NOT NULL` | Employment start date |
| `job_title` | **Job Title** | `VARCHAR(50)` | `NOT NULL` | Assigned job title |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | Assigned department ID |
| `employment_status` | **Employment Status** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/TERMINATED/LEAVE |

---