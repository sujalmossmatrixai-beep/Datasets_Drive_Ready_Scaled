# Business Data Glossary - Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30
- **Component**: Target Database Schema (Dataset_08_RealEstate_UrbanProperty_Utility_Dealership_20x30_target)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Target Tables**: 30
- **Theme Focus**: Commercial Real Estate, Automotive Dealerships, Smart Utilities & Hospitality Assets
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `dim_agent`
**Description**: Domain table for `dim_agent` in `Real_Estate_Property_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `agent_key` | **Agent Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_agent_id` | **Source Agent Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |
| `agency_name` | **Agency Name** | `VARCHAR(80)` | `NOT NULL` | Brokerage name |

---

---

### Table: `dim_owner`
**Description**: Domain table for `dim_owner` in `Real_Estate_Property_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `owner_key` | **Owner Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_owner_id` | **Source Owner Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `dim_property`
**Description**: Domain table for `dim_property` in `Real_Estate_Property_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `property_key` | **Property Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_property_id` | **Source Property Id** | `INT` | `NOT NULL` | Natural ID |
| `owner_key` | **Owner Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_owner |
| `property_type` | **Property Type** | `VARCHAR(30)` | `NOT NULL` | Property type |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |

---

---

### Table: `dim_tenant`
**Description**: Domain table for `dim_tenant` in `Real_Estate_Property_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tenant_key` | **Tenant Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_tenant_id` | **Source Tenant Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_leases`
**Description**: Domain table for `fact_leases` in `Real_Estate_Property_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lease_key` | **Lease Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `property_key` | **Property Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_property |
| `tenant_key` | **Tenant Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_tenant |
| `monthly_rent_usd` | **Monthly Rent Usd** | `NUMERIC(10,2)` | `NOT NULL` | Monthly rent USD |

---

---

### Table: `fact_listings`
**Description**: Domain table for `fact_listings` in `Real_Estate_Property_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `listing_key` | **Listing Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `property_key` | **Property Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_property |
| `agent_key` | **Agent Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_agent |
| `listing_price_usd` | **Listing Price Usd** | `NUMERIC(12,2)` | `NOT NULL` | Listing price USD |

---

---

### Table: `fact_rent_payments`
**Description**: Domain table for `fact_rent_payments` in `Real_Estate_Property_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_key` | **Payment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `lease_key` | **Lease Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_leases |
| `payment_amount_usd` | **Payment Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Payment amount USD |

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

### Table: `dim_smart_meter`
**Description**: Domain table for `dim_smart_meter` in `Energy_Smart_Grid_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `meter_key` | **Meter Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_meter_id` | **Source Meter Id** | `INT` | `NOT NULL` | Natural ID |
| `substation_key` | **Substation Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_substation |

---

---

### Table: `dim_substation`
**Description**: Domain table for `dim_substation` in `Energy_Smart_Grid_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `substation_key` | **Substation Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_substation_id` | **Source Substation Id** | `INT` | `NOT NULL` | Natural ID |
| `grid_code` | **Grid Code** | `VARCHAR(20)` | `NOT NULL` | Grid code |

---

---

### Table: `fact_grid_consumption`
**Description**: Domain table for `fact_grid_consumption` in `Energy_Smart_Grid_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `consumption_key` | **Consumption Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `meter_key` | **Meter Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_smart_meter |
| `kwh_consumption` | **Kwh Consumption** | `NUMERIC(10,3)` | `NOT NULL` | kWh |

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