# Business Data Glossary - Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30
- **Component**: Target Database Schema (Dataset_03_Omnichannel_Retail_Logistics_SupplyChain_20x30_target)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Target Tables**: 30
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