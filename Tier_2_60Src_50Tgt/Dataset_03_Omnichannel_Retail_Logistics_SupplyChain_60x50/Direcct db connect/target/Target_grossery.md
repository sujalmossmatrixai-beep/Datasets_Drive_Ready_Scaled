# Business Data Glossary - Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_60x50_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_60x50_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_60x50
- **Component**: Target Database Schema (Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_60x50_target)
- **Tier Specification**: Tier 2: 60 Source Tables, 50 Target Tables
- **Total Target Tables**: 50
- **Theme Focus**: Omnichannel Retail, Global Logistics, Freight & Food Delivery
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

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

---

### Table: `fact_product_reviews`
**Description**: Domain table for `fact_product_reviews` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_review_key` | **Fact Review Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `rating_score` | **Rating Score** | `INT` | `NOT NULL` | Rating score 1-5 |

---

---

### Table: `fact_return_requests`
**Description**: Domain table for `fact_return_requests` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_return_key` | **Fact Return Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `return_status` | **Return Status** | `VARCHAR(20)` | `NOT NULL` | Return status |

---

---

### Table: `fact_shipments`
**Description**: Domain table for `fact_shipments` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_shipment_key` | **Fact Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `carrier_name` | **Carrier Name** | `VARCHAR(30)` | `NOT NULL` | Carrier name |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Tracking code |
| `shipment_status` | **Shipment Status** | `VARCHAR(20)` | `NOT NULL` | Shipment status |

---

---

### Table: `fact_shopping_carts`
**Description**: Domain table for `fact_shopping_carts` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_cart_key` | **Fact Cart Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |

---

---

### Table: `fact_support_tickets`
**Description**: Domain table for `fact_support_tickets` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_ticket_key` | **Fact Ticket Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `ticket_status` | **Ticket Status** | `VARCHAR(20)` | `NOT NULL` | Ticket status |

---

---

### Table: `fact_wishlists`
**Description**: Domain table for `fact_wishlists` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_wishlist_key` | **Fact Wishlist Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |

---

---

### Table: `dim_carrier`
**Description**: Domain table for `dim_carrier` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `carrier_key` | **Carrier Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_carrier_id` | **Source Carrier Id** | `INT` | `NOT NULL` | Source natural ID |
| `carrier_name` | **Carrier Name** | `VARCHAR(80)` | `NOT NULL` | Provider name |
| `transport_mode` | **Transport Mode** | `VARCHAR(20)` | `NOT NULL` | Transport mode |

---

---

### Table: `dim_supplier`
**Description**: Domain table for `dim_supplier` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `supplier_key` | **Supplier Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_supplier_id` | **Source Supplier Id** | `INT` | `NOT NULL` | Source natural ID |
| `supplier_name` | **Supplier Name** | `VARCHAR(100)` | `NOT NULL` | Vendor legal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO country |

---

---

### Table: `dim_warehouse`
**Description**: Domain table for `dim_warehouse` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_warehouse_id` | **Source Warehouse Id** | `INT` | `NOT NULL` | Source natural ID |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Facility name |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | Location city |

---

---

### Table: `fact_customs_events`
**Description**: Domain table for `fact_customs_events` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customs_key` | **Customs Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_shipment |
| `duty_amount_usd` | **Duty Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Import duty USD |

---

---

### Table: `fact_freight_billing`
**Description**: Domain table for `fact_freight_billing` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `freight_bill_key` | **Freight Bill Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_shipment |
| `freight_charge_usd` | **Freight Charge Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |

---

---

### Table: `fact_inventory_snapshot_supply_supply`
**Description**: Domain table for `fact_inventory_snapshot_supply` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `inventory_key` | **Inventory Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouse |
| `sku_code` | **Sku Code** | `VARCHAR(30)` | `NOT NULL` | Material SKU |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Stock count |

---

---

### Table: `fact_purchase_order`
**Description**: Domain table for `fact_purchase_order` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `po_fact_key` | **Po Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `supplier_key` | **Supplier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_supplier |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouse |
| `po_number` | **Po Number** | `VARCHAR(30)` | `NOT NULL` | Document number |
| `total_cost_usd` | **Total Cost Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total PO cost USD |

---

---

### Table: `fact_shipment`
**Description**: Domain table for `fact_shipment` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_key` | **Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `po_fact_key` | **Po Fact Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_purchase_order |
| `carrier_key` | **Carrier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_carrier |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Tracking ref |

---

---

### Table: `dim_port`
**Description**: Domain table for `dim_port` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `port_key` | **Port Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for port dimension |
| `source_port_id` | **Source Port Id** | `INT` | `NOT NULL` | Natural port ID from source |
| `port_code` | **Port Code** | `VARCHAR(10)` | `NOT NULL` | UN/LOCODE port code |
| `port_name` | **Port Name** | `VARCHAR(80)` | `NOT NULL` | Port terminal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country code ISO-3 |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |
| `terminal_operator` | **Terminal Operator** | `VARCHAR(80)` | `NOT NULL` | Operator name |
| `latitude` | **Latitude** | `NUMERIC(8,4)` | `NOT NULL` | Latitude |
| `longitude` | **Longitude** | `NUMERIC(8,4)` | `NOT NULL` | Longitude |
| `berth_capacity` | **Berth Capacity** | `INT` | `NOT NULL` | Berth count |
| `annual_teu_capacity` | **Annual Teu Capacity** | `INT` | `NOT NULL` | TEU capacity |
| `water_depth_meters` | **Water Depth Meters** | `NUMERIC(4,1)` | `NOT NULL` | Depth meters |
| `is_deepwater_flag` | **Is Deepwater Flag** | `BOOLEAN` | `NOT NULL` | Deepwater flag |
| `customs_office_flag` | **Customs Office Flag** | `BOOLEAN` | `NOT NULL` | Customs office flag |
| `operating_hours` | **Operating Hours** | `VARCHAR(30)` | `NOT NULL` | Operating schedule |
| `security_level` | **Security Level** | `VARCHAR(15)` | `NOT NULL` | Security level code |
| `contact_phone` | **Contact Phone** | `VARCHAR(20)` | `NOT NULL` | Contact phone |
| `contact_email` | **Contact Email** | `VARCHAR(100)` | `NOT NULL` | Contact email |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_shipment`
**Description**: Domain table for `dim_shipment` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_key` | **Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for shipment dimension |
| `source_shipment_id` | **Source Shipment Id** | `INT` | `NOT NULL` | Natural shipment ID from source |
| `tracking_number` | **Tracking Number** | `VARCHAR(25)` | `NOT NULL` | Tracking waybill number |
| `shipper_id` | **Shipper Id** | `INT` | `NOT NULL` | Shipper ID |
| `consignee_id` | **Consignee Id** | `INT` | `NOT NULL` | Consignee ID |
| `origin_port_code` | **Origin Port Code** | `VARCHAR(10)` | `NOT NULL` | Origin port code |
| `destination_port_code` | **Destination Port Code** | `VARCHAR(10)` | `NOT NULL` | Destination port code |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Vessel name |
| `container_number` | **Container Number** | `VARCHAR(20)` | `NOT NULL` | Container number |
| `shipment_status` | **Shipment Status** | `VARCHAR(30)` | `NOT NULL` | Shipment status text |
| `declared_value_usd` | **Declared Value Usd** | `NUMERIC(12,2)` | `NOT NULL` | Declared value USD |
| `freight_cost_usd` | **Freight Cost Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |
| `gross_weight_kg` | **Gross Weight Kg** | `NUMERIC(10,2)` | `NOT NULL` | Gross weight kg |
| `volume_cbm` | **Volume Cbm** | `NUMERIC(8,2)` | `NOT NULL` | Volume CBM |
| `customs_cleared_flag` | **Customs Cleared Flag** | `BOOLEAN` | `NOT NULL` | Customs cleared flag |
| `hazardous_flag` | **Hazardous Flag** | `BOOLEAN` | `NOT NULL` | Hazmat flag |
| `reefer_temp_c` | **Reefer Temp C** | `NUMERIC(4,1)` | `NOT NULL` | Reefer temp C |
| `departure_date` | **Departure Date** | `DATE` | `NOT NULL` | Departure date |
| `estimated_arrival_date` | **Estimated Arrival Date** | `DATE` | `NOT NULL` | ETA date |
| `actual_arrival_date` | **Actual Arrival Date** | `DATE` | `NOT NULL` | ATA date |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current_record` | **Is Current Record** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_vessel`
**Description**: Domain table for `dim_vessel` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vessel_key` | **Vessel Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for vessel dimension |
| `source_vessel_id` | **Source Vessel Id** | `INT` | `NOT NULL` | Natural vessel ID from source |
| `imo_number` | **Imo Number** | `VARCHAR(15)` | `NOT NULL` | IMO ship number |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Vessel name |
| `flag_state` | **Flag State** | `VARCHAR(3)` | `NOT NULL` | Flag state ISO-3 |
| `vessel_type` | **Vessel Type** | `VARCHAR(30)` | `NOT NULL` | Vessel category |
| `build_year` | **Build Year** | `INT` | `NOT NULL` | Build year |
| `dwt_tonnage` | **Dwt Tonnage** | `INT` | `NOT NULL` | DWT tonnage |
| `teu_capacity` | **Teu Capacity** | `INT` | `NOT NULL` | TEU capacity |
| `engine_power_kw` | **Engine Power Kw** | `INT` | `NOT NULL` | Engine power kW |
| `max_speed_knots` | **Max Speed Knots** | `NUMERIC(4,1)` | `NOT NULL` | Max speed knots |
| `owner_company` | **Owner Company** | `VARCHAR(80)` | `NOT NULL` | Owner company |
| `operator_company` | **Operator Company** | `VARCHAR(80)` | `NOT NULL` | Operator company |
| `call_sign` | **Call Sign** | `VARCHAR(10)` | `NOT NULL` | Call sign |
| `mmsi_number` | **Mmsi Number** | `VARCHAR(15)` | `NOT NULL` | MMSI number |
| `safety_cert_expiry` | **Safety Cert Expiry** | `DATE` | `NOT NULL` | Cert expiry date |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | Operational status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_customs_duties`
**Description**: Domain table for `fact_customs_duties` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customs_key` | **Customs Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for customs fact |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_shipment |
| `port_key` | **Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `entry_date` | **Entry Date** | `DATE` | `NOT NULL` | Customs entry date |
| `clearance_date` | **Clearance Date** | `DATE` | `NOT NULL` | Customs clearance date |
| `declared_cargo_value_usd` | **Declared Cargo Value Usd** | `NUMERIC(12,2)` | `NOT NULL` | Declared value USD |
| `assessed_duty_usd` | **Assessed Duty Usd** | `NUMERIC(10,2)` | `NOT NULL` | Customs duty USD |
| `import_vat_usd` | **Import Vat Usd** | `NUMERIC(10,2)` | `NOT NULL` | Import VAT USD |
| `excise_tax_usd` | **Excise Tax Usd** | `NUMERIC(8,2)` | `NOT NULL` | Excise tax USD |
| `total_duties_taxes_usd` | **Total Duties Taxes Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total tax & duties USD |
| `customs_risk_score` | **Customs Risk Score** | `INT` | `NOT NULL` | Automated risk score 1-100 |
| `inspection_required_flag` | **Inspection Required Flag** | `BOOLEAN` | `NOT NULL` | Physical inspection flag |
| `inspection_status` | **Inspection Status** | `VARCHAR(30)` | `NOT NULL` | Inspection status text |
| `exemption_claimed_flag` | **Exemption Claimed Flag** | `BOOLEAN` | `NOT NULL` | Duty exemption flag |
| `customs_status_code` | **Customs Status Code** | `VARCHAR(20)` | `NOT NULL` | Customs status |
| `clearance_days` | **Clearance Days** | `INT` | `NOT NULL` | Days to clear customs |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Customs processing comments |

---

---

### Table: `fact_freight_movements`
**Description**: Domain table for `fact_freight_movements` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `movement_key` | **Movement Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for movement fact |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_shipment |
| `origin_port_key` | **Origin Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `dest_port_key` | **Dest Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `vessel_key` | **Vessel Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_vessel |
| `departure_date` | **Departure Date** | `DATE` | `NOT NULL` | Departure date key |
| `arrival_date` | **Arrival Date** | `DATE` | `NOT NULL` | Arrival date key |
| `transit_days` | **Transit Days** | `INT` | `NOT NULL` | Total transit duration days |
| `freight_cost_usd` | **Freight Cost Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |
| `insurance_cost_usd` | **Insurance Cost Usd** | `NUMERIC(8,2)` | `NOT NULL` | Cargo insurance cost USD |
| `bunker_surcharge_usd` | **Bunker Surcharge Usd** | `NUMERIC(8,2)` | `NOT NULL` | Fuel surcharge USD |
| `port_handling_fee_usd` | **Port Handling Fee Usd** | `NUMERIC(8,2)` | `NOT NULL` | Terminal handling charge USD |
| `total_transport_usd` | **Total Transport Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total transportation cost USD |
| `gross_weight_kg` | **Gross Weight Kg** | `NUMERIC(10,2)` | `NOT NULL` | Weight kg |
| `volume_cbm` | **Volume Cbm** | `NUMERIC(8,2)` | `NOT NULL` | Volume CBM |
| `on_time_delivery_flag` | **On Time Delivery Flag** | `BOOLEAN` | `NOT NULL` | On-time delivery performance flag |
| `delay_reason_code` | **Delay Reason Code** | `VARCHAR(30)` | `NOT NULL` | Delay reason code or NONE |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

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

### Table: `fhir_account_billing`
**Description**: Domain table for `fhir_account_billing` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `billing_account_key` | **Billing Account Key** | `BIGINT` | `PRIMARY KEY` | Billing account surrogate key |
| `source_billing_id` | **Source Billing Id** | `INT` | `NOT NULL` | Source natural billing ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `total_gross_charge_usd` | **Total Gross Charge Usd** | `NUMERIC(10,2)` | `NOT NULL` | Gross medical charge USD |
| `amount_paid_usd` | **Amount Paid Usd** | `NUMERIC(10,2)` | `NOT NULL` | Settled amount USD |
| `balance_usd` | **Balance Usd** | `NUMERIC(10,2)` | `NOT NULL` | Balance due USD |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Account status |

---

---

### Table: `fhir_appointment`
**Description**: Domain table for `fhir_appointment` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `appointment_key` | **Appointment Key** | `BIGINT` | `PRIMARY KEY` | Appointment surrogate key |
| `source_appointment_id` | **Source Appointment Id** | `INT` | `NOT NULL` | Source natural appointment ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |
| `start_timestamp` | **Start Timestamp** | `TIMESTAMP` | `NOT NULL` | Scheduled start timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Appointment status |

---

---

### Table: `fhir_audit_event`
**Description**: Domain table for `fhir_audit_event` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `audit_event_key` | **Audit Event Key** | `BIGINT` | `PRIMARY KEY` | Audit event surrogate key |
| `source_log_id` | **Source Log Id** | `INT` | `NOT NULL` | Source natural log ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Clinician user ID |
| `action_code` | **Action Code** | `VARCHAR(30)` | `NOT NULL` | Action performed |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `event_timestamp` | **Event Timestamp** | `TIMESTAMP` | `NOT NULL` | Event ISO timestamp |

---

---

### Table: `fhir_claim`
**Description**: Domain table for `fhir_claim` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `claim_key` | **Claim Key** | `BIGINT` | `PRIMARY KEY` | Claim surrogate key |
| `source_claim_id` | **Source Claim Id** | `INT` | `NOT NULL` | Source natural claim ID |
| `billing_account_key` | **Billing Account Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_account_billing |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `payer_name` | **Payer Name** | `VARCHAR(80)` | `NOT NULL` | Health insurance payer |
| `total_claimed_usd` | **Total Claimed Usd** | `NUMERIC(10,2)` | `NOT NULL` | Claimed total USD |
| `total_covered_usd` | **Total Covered Usd** | `NUMERIC(10,2)` | `NOT NULL` | Approved covered USD |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Claim status |

---

---

### Table: `fhir_condition_diagnosis`
**Description**: Domain table for `fhir_condition_diagnosis` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `condition_key` | **Condition Key** | `BIGINT` | `PRIMARY KEY` | Condition surrogate key |
| `source_diagnosis_id` | **Source Diagnosis Id** | `INT` | `NOT NULL` | Source natural diagnosis ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `icd10_code` | **Icd10 Code** | `VARCHAR(20)` | `NOT NULL` | ICD-10 clinical code |
| `condition_display` | **Condition Display** | `VARCHAR(100)` | `NOT NULL` | Condition display title |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Condition onset date |

---

---

### Table: `fhir_encounter`
**Description**: Domain table for `fhir_encounter` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `encounter_key` | **Encounter Key** | `BIGINT` | `PRIMARY KEY` | Encounter surrogate key |
| `source_encounter_id` | **Source Encounter Id** | `INT` | `NOT NULL` | Source natural encounter ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |
| `encounter_class` | **Encounter Class** | `VARCHAR(20)` | `NOT NULL` | Encounter classification |
| `period_start` | **Period Start** | `TIMESTAMP` | `NOT NULL` | Encounter period start |
| `period_end` | **Period End** | `TIMESTAMP` | `NULL` | Encounter period end |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | FHIR status code |

---

---

### Table: `fhir_family_member_history`
**Description**: Domain table for `fhir_family_member_history` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fam_hist_key` | **Fam Hist Key** | `BIGINT` | `PRIMARY KEY` | Family history surrogate key |
| `source_history_id` | **Source History Id** | `INT` | `NOT NULL` | Source natural history ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `condition_display` | **Condition Display** | `VARCHAR(100)` | `NOT NULL` | Condition display name |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Onset date |

---

---

### Table: `fhir_immunization`
**Description**: Domain table for `fhir_immunization` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `immunization_key` | **Immunization Key** | `BIGINT` | `PRIMARY KEY` | Immunization surrogate key |
| `source_immunization_id` | **Source Immunization Id** | `INT` | `NOT NULL` | Source natural immunization ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `vaccine_code` | **Vaccine Code** | `VARCHAR(20)` | `NOT NULL` | CVX vaccine code |
| `vaccine_display` | **Vaccine Display** | `VARCHAR(100)` | `NOT NULL` | Vaccine display title |
| `occurrence_date` | **Occurrence Date** | `DATE` | `NOT NULL` | Administered date |

---

---

### Table: `fhir_location_bed`
**Description**: Domain table for `fhir_location_bed` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `location_key` | **Location Key** | `BIGINT` | `PRIMARY KEY` | Location surrogate key |
| `source_allocation_id` | **Source Allocation Id** | `INT` | `NOT NULL` | Source natural allocation ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `room_name` | **Room Name** | `VARCHAR(20)` | `NOT NULL` | Room designation |
| `bed_name` | **Bed Name** | `VARCHAR(10)` | `NOT NULL` | Bed designation |
| `start_timestamp` | **Start Timestamp** | `TIMESTAMP` | `NOT NULL` | Assignment start timestamp |

---

---

### Table: `fhir_medication_inventory`
**Description**: Domain table for `fhir_medication_inventory` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `med_inv_key` | **Med Inv Key** | `BIGINT` | `PRIMARY KEY` | Medication inventory surrogate key |
| `source_inventory_id` | **Source Inventory Id** | `INT` | `NOT NULL` | Source natural inventory ID |
| `ndc_code` | **Ndc Code** | `VARCHAR(20)` | `NOT NULL` | NDC code |
| `medication_display` | **Medication Display** | `VARCHAR(100)` | `NOT NULL` | Medication trade name |
| `stock_quantity` | **Stock Quantity** | `INT` | `NOT NULL` | Stock count |
| `reorder_threshold` | **Reorder Threshold** | `INT` | `NOT NULL` | Reorder threshold |

---

---

### Table: `fhir_medication_request`
**Description**: Domain table for `fhir_medication_request` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `med_req_key` | **Med Req Key** | `BIGINT` | `PRIMARY KEY` | Medication request surrogate key |
| `source_prescription_id` | **Source Prescription Id** | `INT` | `NOT NULL` | Source natural prescription ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `rxnorm_code` | **Rxnorm Code** | `VARCHAR(20)` | `NOT NULL` | RxNorm medication code |
| `medication_display` | **Medication Display** | `VARCHAR(100)` | `NOT NULL` | Medication display name |
| `dosage_instruction` | **Dosage Instruction** | `VARCHAR(100)` | `NOT NULL` | Dosage instruction text |
| `authored_on` | **Authored On** | `DATE` | `NOT NULL` | Prescription order date |

---

---

### Table: `fhir_observation_lab`
**Description**: Domain table for `fhir_observation_lab` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `obs_lab_key` | **Obs Lab Key** | `BIGINT` | `PRIMARY KEY` | Lab observation surrogate key |
| `source_lab_result_id` | **Source Lab Result Id** | `INT` | `NOT NULL` | Source natural lab result ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `loinc_code` | **Loinc Code** | `VARCHAR(20)` | `NOT NULL` | LOINC lab code |
| `observation_display` | **Observation Display** | `VARCHAR(100)` | `NOT NULL` | Lab test display name |
| `value_quantity` | **Value Quantity** | `NUMERIC(10,2)` | `NOT NULL` | Lab reading value |
| `unit_code` | **Unit Code** | `VARCHAR(20)` | `NOT NULL` | Unit of measure |
| `issued_timestamp` | **Issued Timestamp** | `TIMESTAMP` | `NOT NULL` | Issue timestamp |

---

---

### Table: `fhir_observation_vitals`
**Description**: Domain table for `fhir_observation_vitals` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `obs_vital_key` | **Obs Vital Key** | `BIGINT` | `PRIMARY KEY` | Vital sign surrogate key |
| `source_vital_id` | **Source Vital Id** | `INT` | `NOT NULL` | Source natural vital ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `vital_display` | **Vital Display** | `VARCHAR(30)` | `NOT NULL` | Vital display category |
| `value_quantity` | **Value Quantity** | `NUMERIC(8,2)` | `NOT NULL` | Measurement reading |
| `unit_code` | **Unit Code** | `VARCHAR(20)` | `NOT NULL` | Unit code |
| `effective_timestamp` | **Effective Timestamp** | `TIMESTAMP` | `NOT NULL` | Observation timestamp |

---