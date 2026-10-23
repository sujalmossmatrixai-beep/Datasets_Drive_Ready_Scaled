# Business Data Glossary - Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30
- **Component**: Target Database Schema (Dataset_06_DigitalMedia_Gaming_Entertainment_Social_20x30_target)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Target Tables**: 30
- **Theme Focus**: Streaming Media, Esports Gaming, Live Event Ticketing & Social Networks
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

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

### Table: `dim_player`
**Description**: Domain table for `dim_player` in `Gaming_Esports_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `player_key` | **Player Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_player_id` | **Source Player Id** | `INT` | `NOT NULL` | Natural ID |
| `gamer_tag` | **Gamer Tag** | `VARCHAR(40)` | `NOT NULL` | Gamer tag |

---

---

### Table: `dim_team`
**Description**: Domain table for `dim_team` in `Gaming_Esports_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `team_key` | **Team Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_team_id` | **Source Team Id** | `INT` | `NOT NULL` | Natural ID |
| `team_name` | **Team Name** | `VARCHAR(80)` | `NOT NULL` | Team name |

---

---

### Table: `fact_match_results`
**Description**: Domain table for `fact_match_results` in `Gaming_Esports_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `match_fact_key` | **Match Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `winning_team_key` | **Winning Team Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_team |
| `match_timestamp` | **Match Timestamp** | `TIMESTAMP` | `NOT NULL` | Timestamp |

---

---

### Table: `fact_player_purchases`
**Description**: Domain table for `fact_player_purchases` in `Gaming_Esports_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `purchase_fact_key` | **Purchase Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `player_key` | **Player Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_player |
| `purchase_timestamp` | **Purchase Timestamp** | `TIMESTAMP` | `NOT NULL` | Timestamp |

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

---

### Table: `dim_suppliers`
**Description**: Domain table for `dim_suppliers` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_supp_key` | **Dim Supp Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_supplier_id` | **Source Supplier Id** | `INT` | `NOT NULL` | Natural source ID |
| `company_name` | **Company Name** | `VARCHAR(100)` | `NOT NULL` | Supplier company name |
| `country_code_iso2` | **Country Code Iso2** | `VARCHAR(2)` | `NOT NULL` | ISO country code |

---

---

### Table: `dim_warehouses`
**Description**: Domain table for `dim_warehouses` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_wh_key` | **Dim Wh Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_warehouse_id` | **Source Warehouse Id** | `INT` | `NOT NULL` | Natural source ID |
| `warehouse_code` | **Warehouse Code** | `VARCHAR(20)` | `NOT NULL` | Warehouse code |
| `warehouse_name` | **Warehouse Name** | `VARCHAR(80)` | `NOT NULL` | Warehouse name |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | Facility city |

---

---

### Table: `fact_audit_events`
**Description**: Domain table for `fact_audit_events` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_audit_key` | **Fact Audit Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | User string |
| `action_name` | **Action Name** | `VARCHAR(50)` | `NOT NULL` | Action performed |
| `target_entity` | **Target Entity** | `VARCHAR(50)` | `NOT NULL` | Target entity |

---

---

### Table: `fact_inventory_snapshot`
**Description**: Domain table for `fact_inventory_snapshot` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_inv_key` | **Fact Inv Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouses |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Physical stock count |
| `reserved_quantity` | **Reserved Quantity** | `INT` | `NOT NULL` | Reserved stock count |

---

---

### Table: `fact_invoices`
**Description**: Domain table for `fact_invoices` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_invoice_key` | **Fact Invoice Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `invoice_number` | **Invoice Number** | `VARCHAR(30)` | `NOT NULL` | Invoice document number |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Billed total USD |

---

---

### Table: `fact_order_line_items`
**Description**: Domain table for `fact_order_line_items` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_item_key` | **Fact Item Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `unit_price_usd` | **Unit Price Usd** | `NUMERIC(10,2)` | `NOT NULL` | Sold price USD |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Unit count |
| `subtotal_usd` | **Subtotal Usd** | `NUMERIC(12,2)` | `NOT NULL` | Subtotal USD |

---

---

### Table: `fact_orders`
**Description**: Domain table for `fact_orders` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_order_id` | **Source Order Id** | `INT` | `NOT NULL` | Natural source ID |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `order_number` | **Order Number** | `VARCHAR(36)` | `NOT NULL` | Order number |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order date |
| `order_status` | **Order Status** | `VARCHAR(20)` | `NOT NULL` | Order status |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Gross order total USD |

---

---

### Table: `fact_payments`
**Description**: Domain table for `fact_payments` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_payment_key` | **Fact Payment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `payment_method` | **Payment Method** | `VARCHAR(20)` | `NOT NULL` | Method name |
| `amount_usd` | **Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Payment amount USD |

---