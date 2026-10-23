# Business Data Glossary - Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30
- **Component**: Target Database Schema (Dataset_05_Hospitality_Mobility_Aviation_Fleet_20x30_target)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Target Tables**: 30
- **Theme Focus**: Global Hospitality, Airline Reservations, Fleet Mobility & Ride Transit
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `dim_aircraft`
**Description**: Domain table for `dim_aircraft` in `Airline_Reservation_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `aircraft_key` | **Aircraft Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_aircraft_id` | **Source Aircraft Id** | `INT` | `NOT NULL` | Natural ID |
| `model_name` | **Model Name** | `VARCHAR(40)` | `NOT NULL` | Model name |

---

---

### Table: `dim_airport`
**Description**: Domain table for `dim_airport` in `Airline_Reservation_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `airport_key` | **Airport Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_airport_id` | **Source Airport Id** | `INT` | `NOT NULL` | Natural ID |
| `iata_code` | **Iata Code** | `VARCHAR(3)` | `NOT NULL` | IATA code |

---

---

### Table: `dim_passenger`
**Description**: Domain table for `dim_passenger` in `Airline_Reservation_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `passenger_key` | **Passenger Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_passenger_id` | **Source Passenger Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_flight_bookings`
**Description**: Domain table for `fact_flight_bookings` in `Airline_Reservation_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `booking_key` | **Booking Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `passenger_key` | **Passenger Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_passenger |
| `ticket_price_usd` | **Ticket Price Usd** | `NUMERIC(8,2)` | `NOT NULL` | Price USD |

---

---

### Table: `dim_guest`
**Description**: Domain table for `dim_guest` in `Hotel_Hospitality_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `guest_key` | **Guest Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_guest_id` | **Source Guest Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `dim_hotel`
**Description**: Domain table for `dim_hotel` in `Hotel_Hospitality_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `hotel_key` | **Hotel Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_hotel_id` | **Source Hotel Id** | `INT` | `NOT NULL` | Natural ID |
| `hotel_name` | **Hotel Name** | `VARCHAR(80)` | `NOT NULL` | Hotel name |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |

---

---

### Table: `dim_room`
**Description**: Domain table for `dim_room` in `Hotel_Hospitality_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `room_key` | **Room Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_room_id` | **Source Room Id** | `INT` | `NOT NULL` | Natural ID |
| `hotel_key` | **Hotel Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_hotel |
| `room_number` | **Room Number** | `VARCHAR(10)` | `NOT NULL` | Room number |

---

---

### Table: `fact_reservations`
**Description**: Domain table for `fact_reservations` in `Hotel_Hospitality_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `reservation_key` | **Reservation Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `room_key` | **Room Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_room |
| `guest_key` | **Guest Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_guest |
| `check_in_date` | **Check In Date** | `DATE` | `NOT NULL` | Check in date |

---

---

### Table: `fact_room_charges`
**Description**: Domain table for `fact_room_charges` in `Hotel_Hospitality_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `charge_key` | **Charge Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `reservation_key` | **Reservation Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_reservations |
| `charge_amount_usd` | **Charge Amount Usd** | `NUMERIC(8,2)` | `NOT NULL` | Amount USD |

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

### Table: `dim_passenger_ride_ride`
**Description**: Domain table for `dim_passenger_ride` in `Ride_Sharing_Transit_Dataset` (target).

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

### Table: `dim_buyer`
**Description**: Domain table for `dim_buyer` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `buyer_key` | **Buyer Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_buyer_id` | **Source Buyer Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `dim_dealer`
**Description**: Domain table for `dim_dealer` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dealer_key` | **Dealer Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_dealer_id` | **Source Dealer Id** | `INT` | `NOT NULL` | Natural ID |
| `dealer_name` | **Dealer Name** | `VARCHAR(80)` | `NOT NULL` | Dealer name |

---

---

### Table: `dim_vehicle`
**Description**: Domain table for `dim_vehicle` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vehicle_key` | **Vehicle Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_vehicle_id` | **Source Vehicle Id** | `INT` | `NOT NULL` | Natural ID |
| `vin` | **Vin** | `VARCHAR(17)` | `NOT NULL` | VIN |
| `make` | **Make** | `VARCHAR(30)` | `NOT NULL` | Make |
| `model` | **Model** | `VARCHAR(40)` | `NOT NULL` | Model |

---

---

### Table: `fact_car_sales`
**Description**: Domain table for `fact_car_sales` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sale_key` | **Sale Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `vehicle_key` | **Vehicle Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_vehicle |
| `buyer_key` | **Buyer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_buyer |
| `dealer_key` | **Dealer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_dealer |
| `sale_price_usd` | **Sale Price Usd** | `NUMERIC(10,2)` | `NOT NULL` | Sale price USD |

---

---

### Table: `fact_service_revenue`
**Description**: Domain table for `fact_service_revenue` in `Automotive_Dealership_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `service_key` | **Service Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `vehicle_key` | **Vehicle Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_vehicle |
| `service_cost_usd` | **Service Cost Usd** | `NUMERIC(8,2)` | `NOT NULL` | Service cost USD |

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